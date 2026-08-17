# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/debugger/gdb.py
# Description  : GdbClient — thin wrapper around pygdbmi.GdbController that
#                speaks GDB MI3 protocol over a RISC-V GDB subprocess; uses
#                OpenOCD monitor commands for execution control to avoid
#                blocking GDB on infinite-loop targets.
#                Single-step is implemented in software (breakpoint + resume)
#                because hardware dcsr.step is not wired in SystemControl_SS.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import re
import socket
import shutil
import subprocess
from pathlib import Path
from pygdbmi.gdbcontroller import GdbController


def _sext(val: int, bits: int) -> int:
    """Sign-extend a bits-wide unsigned integer to a Python int."""
    if val & (1 << (bits - 1)):
        val -= 1 << bits
    return val


def _parse_int(val: str) -> "int | None":
    """Parse an integer from a GDB value string.

    GDB can return values in several formats:
      "0x0000001c"          plain hex
      "28"                  plain decimal
      "(void *) 0x0000001c" type-decorated pointer
    We extract the first 0x… token, falling back to the first digit run.
    """
    val = val.strip()
    m = re.search(r'0x([0-9a-fA-F]+)', val)
    if m:
        try:
            return int(m.group(1), 16)
        except ValueError:
            pass
    m = re.search(r'\d+', val)
    if m:
        try:
            return int(m.group())
        except ValueError:
            pass
    return None

_DEFAULT_GDB = "riscv32-unknown-elf-gdb"
_DEFAULT_PORT = 3333


def is_openocd_running(host: str = "localhost", port: int = _DEFAULT_PORT,
                       timeout: float = 0.5) -> bool:
    """Return True if OpenOCD is listening on the GDB port.

    Uses `ss` to check the LISTEN state without opening a connection —
    avoids the 'attempted gdb connection rejected' noise in OpenOCD logs.
    Falls back to a socket probe on platforms where ss is unavailable.
    """
    try:
        result = subprocess.run(
            ["ss", "-tln", f"sport = :{port}"],
            capture_output=True, text=True, timeout=1.0,
        )
        return f":{port}" in result.stdout
    except Exception:
        pass
    # Fallback (causes OpenOCD rejection log entries)
    try:
        s = socket.create_connection((host, port), timeout=timeout)
        s.close()
        return True
    except OSError:
        return False


def find_gdb() -> str:
    """Return the first riscv32-unknown-elf-gdb found on PATH or in ~/Toolchains."""
    candidates = [
        Path.home() / "Toolchains" / "DidacticSoC" / "bin" / _DEFAULT_GDB,
        Path.home() / "riscv32" / "riscv" / "bin" / _DEFAULT_GDB,
    ]
    for c in candidates:
        if c.exists():
            return str(c)
    found = shutil.which(_DEFAULT_GDB)
    return found or _DEFAULT_GDB


class GdbClient:
    """Thin wrapper around pygdbmi that speaks to an OpenOCD GDB server."""

    def __init__(self, gdb_path: str = "", port: int = _DEFAULT_PORT):
        self._gdb_path = gdb_path or find_gdb()
        self._port = port
        self._ctrl: GdbController | None = None
        self._breakpoints: dict[int, tuple[int, int]] = {}  # addr -> (word_addr, orig)

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    def connect(self) -> None:
        self._ctrl = GdbController(
            command=[self._gdb_path, "--quiet", "--interpreter=mi3"]
        )
        self._mi(f"-target-select extended-remote :{self._port}")

    def disconnect(self) -> None:
        if self._ctrl:
            try:
                self._ctrl.exit()
            except Exception:
                pass
            self._ctrl = None

    @property
    def is_connected(self) -> bool:
        return self._ctrl is not None

    # ------------------------------------------------------------------
    # ELF loading
    # ------------------------------------------------------------------

    def load_elf(self, path: str) -> None:
        self._mi('-interpreter-exec console "monitor halt"', timeout=10)
        self._mi(f"-file-exec-and-symbols {path}", timeout=30)
        self._mi("-target-download", timeout=120)

    # ------------------------------------------------------------------
    # Execution control
    # ------------------------------------------------------------------

    def run(self) -> None:
        # Only pay the get_pc() round-trip when breakpoints are active.
        # Without breakpoints this reduces back to a single monitor resume.
        if self._breakpoints:
            pc = self.get_pc()
            if pc is not None and pc in self._breakpoints:
                # At a BP address: restore original, step past it, then re-arm.
                word_addr, orig = self._breakpoints.pop(pc)
                self.send_console(f"monitor mww {word_addr:#x} {orig:#x}")
                try:
                    self.step()
                finally:
                    self.add_breakpoint(pc)
        self.send_console("monitor resume")

    def halt(self) -> None:
        self.send_console("monitor halt")

    def _monitor_mdw(self, addr: int) -> "int | None":
        """Read one aligned word via OpenOCD's monitor mdw command.

        Bypasses GDB's -data-read-memory-bytes path.  GDB's path can use the
        program buffer, which on this target leaves abstractcs.cmderr set.
        A latched cmderr causes the very next abstract command (our mww) to
        return ERROR_FAIL without executing, so no C.EBREAK ever reaches IMEM.
        OpenOCD's monitor mdw uses a different access path that does not leave
        cmderr latched.
        """
        aligned = addr & ~3
        resp = self.send_console(f"monitor mdw {aligned:#x}")
        for r in resp:
            payload = r.get("payload") or ""
            if isinstance(payload, str):
                m = re.search(r'[0-9a-fA-F]+:\s+([0-9a-fA-F]{8})', payload)
                if m:
                    return int(m.group(1), 16)
        return None

    def step(self) -> "int | None":
        """Software single-step by patching C.EBREAK into instruction memory.

        Uses only OpenOCD monitor commands for every read and write so the
        access path matches the working manual test exactly:
          monitor reg pc / monitor mdw / monitor mww / -exec-continue

        dcsr.ebreakm=1 → EBREAK in M-mode enters debug mode.
        C.EBREAK (0x9002) is a 16-bit instruction: bits[1:0]=0b10 forces the
        CPU to decode it as compressed, which triggers the ebreakm halt.

        Returns the new PC after the step.
        """
        # Read PC via OpenOCD to avoid any GDB→DM abstract-command round-trip.
        pc = self._monitor_reg_pc()
        if pc is None:
            pc = self.get_pc()
        if pc is None:
            raise RuntimeError("step: cannot read PC")

        # Read the aligned word(s) containing the current instruction.
        pc_aligned = pc & ~3
        aw0 = self._monitor_mdw(pc_aligned)
        if aw0 is None:
            raise RuntimeError(f"step: cannot read at {pc_aligned:#010x}")
        if pc & 2:
            # Instruction starts in the upper halfword — may cross into next word.
            aw1 = self._monitor_mdw(pc_aligned + 4) or 0
            word = (aw0 >> 16) | ((aw1 & 0xFFFF) << 16)
        else:
            word = aw0

        next_pcs = self._next_pcs(pc, word)

        # Build per-word patches.  Two next-PCs can share a word (rare but
        # possible for compressed branches), so accumulate before writing.
        # Skip addresses that already carry a user breakpoint — they already
        # have C.EBREAK and will halt naturally; restoring them would remove
        # the user's breakpoint.
        originals: dict[int, int] = {}  # word_addr -> original word
        pending:   dict[int, int] = {}  # word_addr -> patched word

        for addr in next_pcs:
            if addr in self._breakpoints:
                continue  # already has C.EBREAK from a user BP
            word_addr = addr & ~3
            offset    = addr &  2   # 0 or 2
            if word_addr not in originals:
                w = self._monitor_mdw(word_addr)
                if w is None:
                    raise RuntimeError(f"step: cannot read at {word_addr:#010x}")
                originals[word_addr] = w
                pending[word_addr]   = w
            if offset == 0:
                pending[word_addr] = (pending[word_addr] & 0xFFFF0000) | 0x9002
            else:
                pending[word_addr] = (pending[word_addr] & 0x0000FFFF) | (0x9002 << 16)

        for word_addr, pw in pending.items():
            self.send_console(f"monitor mww {word_addr:#x} {pw:#x}")
            # Verify the write took effect — a silent mww failure (cmderr latch)
            # would leave the original instruction in place and step times out.
            actual = self._monitor_mdw(word_addr)
            if actual != pw:
                raise RuntimeError(
                    f"step: mww verify failed at {word_addr:#x}: "
                    f"wrote {pw:#010x}, read back {actual!r:#010x}"
                )

        msgs = self._mi("-exec-continue")

        def _has_stopped(batch: list) -> bool:
            return any(
                m.get("type") == "notify" and m.get("message") == "stopped"
                for m in batch
            )

        # Fast path: *stopped often arrives in the same -exec-continue burst.
        if not _has_stopped(msgs):
            for _ in range(100):  # 5-second timeout, 50 ms per poll
                if _has_stopped(self.poll_notifications(timeout=0.05)):
                    break
            else:
                # In all-stop mode, after -exec-continue only -exec-interrupt is
                # accepted while the target is running.  send_console("monitor halt")
                # is rejected by GDB, causing a 10-second timeout that kills the MI
                # connection.  Interrupt first, then restore the patched words.
                try:
                    self._mi("-exec-interrupt")
                    for _ in range(40):   # 2-second grace period
                        if _has_stopped(self.poll_notifications(timeout=0.05)):
                            break
                except Exception:
                    pass
                for word_addr, orig in originals.items():
                    try:
                        self.send_console(f"monitor mww {word_addr:#x} {orig:#x}")
                    except Exception:
                        pass
                raise RuntimeError("step: timeout — C.EBREAK did not halt the target")

        for word_addr, orig in originals.items():
            self.send_console(f"monitor mww {word_addr:#x} {orig:#x}")

        return self.get_pc()

    # ------------------------------------------------------------------
    # Disassembly and stack
    # ------------------------------------------------------------------

    def disassemble(self, start: int, end: int) -> list[dict]:
        resp = self._mi(f"-data-disassemble -s {start:#x} -e {end:#x} -- 0")
        for r in resp:
            if r.get("type") == "result" and r.get("message") == "done":
                return r.get("payload", {}).get("asm_insns", [])
        return []

    def disassemble_elf(self, elf_path: str) -> list[dict]:
        """Disassemble an ELF file via objdump — no target memory access, no GDB I/O.

        Uses the objdump from the same toolchain as the configured GDB binary.
        Returns a list of dicts in GDB MI asm_insns format so the disassembly
        panel can consume it without change.
        """
        objdump = self._gdb_path.replace("-gdb", "-objdump")
        if not Path(objdump).exists():
            objdump = shutil.which("riscv32-unknown-elf-objdump") or ""
        if not objdump:
            return []
        try:
            result = subprocess.run(
                [objdump, "-d", "--no-show-raw-insn", elf_path],
                capture_output=True, text=True, timeout=30,
            )
        except Exception:
            return []

        insns: list[dict] = []
        current_func = ""
        for line in result.stdout.splitlines():
            m = re.match(r'^([0-9a-fA-F]+)\s+<([^>]+)>:', line)
            if m:
                current_func = m.group(2)
                continue
            m = re.match(r'^\s+([0-9a-fA-F]+):\s+(.*)', line)
            if m:
                try:
                    addr = int(m.group(1), 16)
                except ValueError:
                    continue
                insns.append({
                    "address": f"0x{addr:08x}",
                    "func-name": current_func,
                    "offset": "",
                    "inst": m.group(2).strip(),
                })
        return insns

    def get_stack_frames(self) -> list[dict]:
        resp = self._mi("-stack-list-frames")
        for r in resp:
            if r.get("type") == "result" and r.get("message") == "done":
                return r.get("payload", {}).get("stack", [])
        return []

    # ------------------------------------------------------------------
    # Breakpoints (C.EBREAK patch via monitor mww)
    # ------------------------------------------------------------------

    def add_breakpoint(self, addr: int) -> None:
        if addr in self._breakpoints:
            return
        word_addr = addr & ~3
        orig = self.read_word(word_addr)
        if orig is None:
            raise RuntimeError(f"add_breakpoint: cannot read at {word_addr:#010x}")
        offset = addr & 2
        if offset == 0:
            patched = (orig & 0xFFFF0000) | 0x9002
        else:
            patched = (orig & 0x0000FFFF) | (0x9002 << 16)
        self._breakpoints[addr] = (word_addr, orig)
        self.send_console(f"monitor mww {word_addr:#x} {patched:#x}")

    def remove_breakpoint(self, addr: int) -> None:
        if addr not in self._breakpoints:
            return
        word_addr, orig = self._breakpoints.pop(addr)
        self.send_console(f"monitor mww {word_addr:#x} {orig:#x}")

    def has_breakpoint(self, addr: int) -> bool:
        return addr in self._breakpoints

    @property
    def breakpoint_addrs(self) -> set[int]:
        return set(self._breakpoints.keys())

    def get_register(self, reg: int) -> "int | None":
        """Read integer register x<reg> (0–31) from GDB."""
        resp = self._mi(f"-data-evaluate-expression $x{reg}")
        for r in resp:
            if r.get("type") == "result" and r.get("message") == "done":
                val = str(r.get("payload", {}).get("value", ""))
                return _parse_int(val)
        return None

    def _next_pcs(self, pc: int, word: int) -> "list[int]":
        """Decode the RV32IMC instruction at pc and return all reachable next PCs."""
        lo = word & 0xFFFF

        # 16-bit compressed instruction: bits[1:0] != 0b11
        if (lo & 0x3) != 0x3:
            q  = lo & 0x3
            f3 = (lo >> 13) & 0x7
            if q == 1:
                # C.J (f3=101) and C.JAL (f3=001, RV32 only) — unconditional
                if f3 in (0b101, 0b001):
                    raw = ((lo >> 12 & 1) << 11 | (lo >> 8 & 1) << 10 |
                           (lo >> 9 & 3) << 8  | (lo >> 6 & 1) << 7  |
                           (lo >> 7 & 1) << 6  | (lo >> 2 & 1) << 5  |
                           (lo >> 11 & 1) << 4 | (lo >> 3 & 7) << 1)
                    return [(pc + _sext(raw, 12)) & 0xFFFFFFFF]
                # C.BEQZ (f3=110) and C.BNEZ (f3=111) — conditional
                if f3 in (0b110, 0b111):
                    raw = ((lo >> 12 & 1) << 8 | (lo >> 5 & 3) << 6 |
                           (lo >> 2 & 1) << 5  | (lo >> 10 & 3) << 3 |
                           (lo >> 3 & 3) << 1)
                    taken = (pc + _sext(raw, 9)) & 0xFFFFFFFF
                    return sorted({pc + 2, taken})
            if q == 2 and f3 == 0b100:
                # C.JR / C.JALR: target = rs1
                rs1 = (lo >> 7) & 0x1F
                rs2 = (lo >> 2) & 0x1F
                if rs2 == 0 and rs1 != 0:
                    val = self.get_register(rs1) or (pc + 2)
                    return [val & 0xFFFFFFFF]
            return [pc + 2]

        # 32-bit instruction
        opcode = word & 0x7F

        # JAL — unconditional, target = PC + imm20
        if opcode == 0x6F:
            raw = ((word >> 31 & 1) << 20 | (word >> 12 & 0xFF) << 12 |
                   (word >> 20 & 1) << 11 | (word >> 21 & 0x3FF) << 1)
            return [(pc + _sext(raw, 21)) & 0xFFFFFFFF]

        # JALR — target = (rs1 + imm12) & ~1
        if opcode == 0x67:
            rs1 = (word >> 15) & 0x1F
            imm = _sext(word >> 20, 12)
            val = self.get_register(rs1) or 0
            return [((val + imm) & ~1) & 0xFFFFFFFF]

        # Conditional branches — both taken and not-taken paths
        if opcode == 0x63:
            raw = ((word >> 31 & 1) << 12 | (word >> 7 & 1) << 11 |
                   (word >> 25 & 0x3F) << 5 | (word >> 8 & 0xF) << 1)
            taken = (pc + _sext(raw, 13)) & 0xFFFFFFFF
            return sorted({pc + 4, taken})

        return [pc + 4]

    def _monitor_reg_pc(self) -> "int | None":
        """Read PC via OpenOCD's monitor reg pc — no GDB abstract-command path."""
        resp = self.send_console("monitor reg pc")
        for r in resp:
            payload = r.get("payload") or ""
            if isinstance(payload, str):
                m = re.search(r'0x([0-9a-fA-F]+)', payload)
                if m:
                    try:
                        return int(m.group(1), 16)
                    except ValueError:
                        pass
        return None

    def reset_halt(self) -> None:
        self._mi('-interpreter-exec console "monitor halt"')

    def get_pc(self) -> int | None:
        # Primary path: GDB expression (value may be decorated, e.g. "(void *) 0x42")
        resp = self._mi("-data-evaluate-expression $pc")
        for r in resp:
            if r.get("type") == "result" and r.get("message") == "done":
                val = str(r.get("payload", {}).get("value", ""))
                result = _parse_int(val)
                if result is not None:
                    return result
        # Fallback: ask OpenOCD directly ("pc (/32): 0x00000042")
        resp = self._mi('-interpreter-exec console "monitor reg pc"')
        for r in resp:
            payload = r.get("payload") or ""
            if isinstance(payload, str):
                m = re.search(r'0x([0-9a-fA-F]+)', payload)
                if m:
                    try:
                        return int(m.group(1), 16)
                    except ValueError:
                        pass
        return None

    # ------------------------------------------------------------------
    # Memory access
    # ------------------------------------------------------------------

    def read_word(self, addr: int) -> int | None:
        resp = self._mi(f"-data-read-memory-bytes {addr:#x} 4")
        for r in resp:
            if r.get("type") == "result":
                if r.get("message") == "done":
                    mem = r.get("payload", {}).get("memory", [{}])
                    if mem:
                        contents = mem[0].get("contents", "")
                        if len(contents) == 8:
                            return int.from_bytes(bytes.fromhex(contents), "little")
                elif r.get("message") == "error":
                    msg = r.get("payload", {}).get("msg", "unknown error")
                    raise RuntimeError(f"GDB read {addr:#x}: {msg}")
        return None

    def write_word(self, addr: int, value: int) -> None:
        data = value.to_bytes(4, "little").hex()
        self._mi(f"-data-write-memory-bytes {addr:#x} {data}")

    # ------------------------------------------------------------------
    # Async polling (call from worker thread without a pending command)
    # ------------------------------------------------------------------

    def poll_notifications(self, timeout: float = 0.05) -> list:
        if not self._ctrl:
            return []
        try:
            return self._ctrl.get_gdb_response(
                timeout_sec=timeout, raise_error_on_timeout=False
            ) or []
        except Exception:
            return []

    # ------------------------------------------------------------------

    def send_mi(self, cmd: str) -> list:
        return self._mi(cmd)

    def send_console(self, cmd: str) -> list:
        escaped = cmd.replace("\\", "\\\\").replace('"', '\\"')
        return self._mi(f'-interpreter-exec console "{escaped}"')

    def _mi(self, cmd: str, timeout: int = 10) -> list:
        if not self._ctrl:
            raise RuntimeError("GDB not connected")
        return self._ctrl.write(cmd, timeout_sec=timeout)
