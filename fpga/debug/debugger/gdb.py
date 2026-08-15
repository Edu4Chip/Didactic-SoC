# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/debugger/gdb.py
# Description  : GdbClient — thin wrapper around pygdbmi.GdbController that
#                speaks GDB MI3 protocol over a RISC-V GDB subprocess; uses
#                OpenOCD monitor commands for execution control to avoid
#                blocking GDB on infinite-loop targets.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import socket
import shutil
from pathlib import Path
from pygdbmi.gdbcontroller import GdbController

_DEFAULT_GDB = "riscv32-unknown-elf-gdb"
_DEFAULT_PORT = 3333


def is_openocd_running(host: str = "localhost", port: int = _DEFAULT_PORT,
                       timeout: float = 0.5) -> bool:
    """Return True if OpenOCD is listening on the GDB port.

    Uses `ss` to check the LISTEN state without opening a connection —
    avoids the 'attempted gdb connection rejected' noise in OpenOCD logs.
    Falls back to a socket probe on platforms where ss is unavailable.
    """
    import subprocess
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
        self.send_console("monitor resume")

    def halt(self) -> None:
        self.send_console("monitor halt")

    def step(self) -> None:
        self.send_console("monitor step")

    def reset_halt(self) -> None:
        self._mi('-interpreter-exec console "monitor halt"')

    def get_pc(self) -> int | None:
        resp = self._mi("-data-evaluate-expression $pc")
        for r in resp:
            if r.get("type") == "result" and r.get("message") == "done":
                val = r.get("payload", {}).get("value", "")
                try:
                    return int(val, 0)
                except (ValueError, TypeError):
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
