# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/workers/gdb_worker.py
# Description  : GdbWorker — QThread that owns GdbClient, serializes GDB
#                commands through an internal queue, and emits Qt signals for
#                CPU state changes, data read-back, and console output.
#
#  Disassembly update policy (three cases only):
#    1. ELF load  — target is halted after download; fetch PC + disassembly
#                   once and populate the panel before resuming.
#    2. Halt/Step/Reset — _emit_halted() fetches disassembly + stack.
#    3. Frame nav — "disassemble" queue entry, target must already be halted.
#
#  Async *stopped notifications update only the UI toolbar state (target_halted
#  signal). They NEVER trigger GDB I/O — doing so while the target may still be
#  running causes the "Ignoring packet error" feedback loop.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import queue
from PySide6.QtCore import QThread, Signal
from debugger.gdb import GdbClient


class GdbWorker(QThread):
    """Runs GDB/MI in a background thread.

    Commands arrive via request_*() slots (queued, thread-safe).
    Results are delivered back to the GUI via signals.
    """

    # Status
    connected    = Signal()
    disconnected = Signal()
    error        = Signal(str)

    # Command results
    elf_loaded      = Signal()
    memory_read     = Signal(int, int)   # addr, value
    memory_written  = Signal(int)        # addr
    target_halted   = Signal(int)        # PC
    target_running  = Signal()
    pc_updated      = Signal(int)        # PC value
    console_output  = Signal(str)        # raw GDB console / log text

    # Disassembly / stack
    disassembly_ready  = Signal(list, int, list, bool)  # insns, pc, bp_addrs, scroll_to_pc
    stack_ready        = Signal(list)                   # stack frames
    breakpoint_added   = Signal(int)                    # addr
    breakpoint_removed = Signal(int)                    # addr

    def __init__(self, gdb_path: str = "", port: int = 3333, parent=None):
        super().__init__(parent)
        self._client  = GdbClient(gdb_path=gdb_path, port=port)
        self._queue: queue.Queue = queue.Queue()
        self._running = False
        self._disasm_cache: list[dict] = []  # pre-built at ELF load; reused on halt/step

    # ------------------------------------------------------------------
    # Thread body
    # ------------------------------------------------------------------

    def run(self) -> None:
        self._running = True
        try:
            self._client.connect()
            self.connected.emit()
            self._query_target_state()
        except Exception as exc:
            self.error.emit(f"GDB connect failed: {exc}")
            return

        while self._running:
            try:
                cmd, args = self._queue.get(timeout=0.05)
                self._dispatch(cmd, args)
            except queue.Empty:
                pass

            for msg in self._client.poll_notifications():
                self._handle_async(msg)

        self._client.disconnect()
        self.disconnected.emit()

    def stop(self) -> None:
        self._running = False

    # ------------------------------------------------------------------
    # Public slots — put work on the queue (called from GUI thread)
    # ------------------------------------------------------------------

    def request_load_elf(self, path: str) -> None:
        self._queue.put(("load_elf", (path,)))

    def request_read_mem(self, addr: int) -> None:
        self._queue.put(("read_mem", (addr,)))

    def request_write_mem(self, addr: int, value: int) -> None:
        self._queue.put(("write_mem", (addr, value)))

    def request_run(self) -> None:
        self._queue.put(("run", ()))

    def request_halt(self) -> None:
        self._queue.put(("halt", ()))

    def request_step(self) -> None:
        self._queue.put(("step", ()))

    def request_reset(self) -> None:
        self._queue.put(("reset", ()))

    def request_pc(self) -> None:
        self._queue.put(("get_pc", ()))

    def request_raw_command(self, cmd: str) -> None:
        self._queue.put(("raw", (cmd,)))

    def request_toggle_breakpoint(self, addr: int) -> None:
        self._queue.put(("toggle_breakpoint", (addr,)))

    def request_disassemble(self, addr: int) -> None:
        """Navigate the disassembly view to addr (frame navigation, no scroll)."""
        self._queue.put(("disassemble", (addr, False)))

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _emit_halted(self, pc: int, scroll: bool = True) -> None:
        """Emit target_halted and refresh the disassembly panel from the cache.

        Zero GDB I/O.  Calling -data-disassemble between halt and a following
        step corrupts something in the debug-module or GDB-MI state such that
        the C.EBREAK single-step mechanism stops working.  The disassembly is
        pre-built once (at ELF-load time) and reused here; the panel just
        moves the PC marker.
        """
        self.target_halted.emit(pc)
        if pc and self._disasm_cache:
            self.disassembly_ready.emit(
                self._disasm_cache, pc, list(self._client.breakpoint_addrs), scroll
            )

    # ------------------------------------------------------------------
    # Internal dispatch
    # ------------------------------------------------------------------

    def _dispatch(self, cmd: str, args: tuple) -> None:
        try:
            if cmd == "load_elf":
                self._disasm_cache = []
                self._client.load_elf(args[0])
                self.elf_loaded.emit()
                # Disassemble via objdump on the ELF file — no GDB I/O, no JTAG
                # reads, no debug-module interaction.  Calling GDB's own
                # -data-disassemble here reads IMEM through the debug module and
                # latches abstractcs.cmderr; a subsequent monitor mww in step()
                # then silently fails (OpenOCD clears cmderr and returns ERROR_FAIL
                # before executing the write), so no C.EBREAK ever reaches IMEM.
                try:
                    pc = self._client.get_pc() or 0
                    insns = self._client.disassemble_elf(args[0])
                    if insns:
                        self._disasm_cache = insns
                        self.disassembly_ready.emit(
                            insns, pc, list(self._client.breakpoint_addrs), False
                        )
                except Exception:
                    pass
                self._client.run()
                self.target_running.emit()

            elif cmd == "read_mem":
                val = self._client.read_word(args[0])
                if val is not None:
                    self.memory_read.emit(args[0], val)

            elif cmd == "write_mem":
                self._client.write_word(args[0], args[1])
                self.memory_written.emit(args[0])

            elif cmd == "run":
                self._client.run()
                self.target_running.emit()

            elif cmd == "halt":
                self._client.halt()
                pc = self._client.get_pc()
                self._emit_halted(pc or 0)

            elif cmd == "step":
                self.target_running.emit()
                pc = self._client.step()
                self._emit_halted(pc or 0)

            elif cmd == "reset":
                self._client.reset_halt()
                pc = self._client.get_pc()
                self._emit_halted(pc or 0)

            elif cmd == "toggle_breakpoint":
                addr, = args
                if self._client.has_breakpoint(addr):
                    self._client.remove_breakpoint(addr)
                    self.breakpoint_removed.emit(addr)
                else:
                    self._client.add_breakpoint(addr)
                    self.breakpoint_added.emit(addr)

            elif cmd == "disassemble":
                # Frame navigation only — target must already be halted.
                addr, scroll = args
                try:
                    insns  = self._client.disassemble(max(0, addr - 0x100), addr + 0x100)
                    frames = self._client.get_stack_frames()
                    self.disassembly_ready.emit(
                        insns, addr, list(self._client.breakpoint_addrs), scroll
                    )
                    self.stack_ready.emit(frames)
                except Exception:
                    pass

            elif cmd == "get_pc":
                pc = self._client.get_pc()
                if pc is not None:
                    self.pc_updated.emit(pc)

            elif cmd == "raw":
                raw_cmd = args[0]
                if raw_cmd.startswith("-"):
                    msgs = self._client.send_mi(raw_cmd)
                else:
                    msgs = self._client.send_console(raw_cmd)
                for m in msgs:
                    text = self._extract_text(m)
                    if text:
                        self.console_output.emit(text)

        except Exception as exc:
            self.error.emit(str(exc))

    def _handle_async(self, msg: dict) -> None:
        msg_type = msg.get("type")

        if msg_type in ("console", "log", "output"):
            text = self._extract_text(msg)
            if text:
                self.console_output.emit(text)
            return

        if msg_type == "notify":
            payload = msg.get("payload") or {}
            if msg.get("message") == "stopped":
                pc_info = payload.get("frame", {}).get("addr", "0")
                try:
                    pc = int(pc_info, 0)
                except (ValueError, TypeError):
                    pc = 0
                # Update UI toolbar state only.  No GDB I/O here — the target
                # may still be running (stale notification) and sending RSP
                # packets then causes the "Ignoring packet error" loop.
                self.target_halted.emit(pc)
            elif msg.get("message") == "running":
                self.target_running.emit()

    def _query_target_state(self) -> None:
        """Detect initial halt/run state via 'monitor targets' after connect."""
        try:
            msgs = self._client.send_console("monitor targets")
            for m in msgs:
                text = self._extract_text(m)
                if "halted" in text:
                    pc = self._client.get_pc() or 0
                    self.target_halted.emit(pc)   # UI state only; no ELF loaded yet
                    return
                if "running" in text:
                    self.target_running.emit()
                    return
        except Exception:
            pass

    @staticmethod
    def _extract_text(msg: dict) -> str:
        payload = msg.get("payload") or ""
        if isinstance(payload, str):
            return payload
        if isinstance(payload, dict):
            return payload.get("msg", "") or str(payload)
        return ""
