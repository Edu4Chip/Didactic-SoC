# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/workers/gdb_worker.py
# Description  : GdbWorker — QThread that owns GdbClient, serializes GDB
#                commands through an internal queue, and emits Qt signals for
#                CPU state changes, data read-back, and console output.
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

    def __init__(self, gdb_path: str = "", port: int = 3333, parent=None):
        super().__init__(parent)
        self._client = GdbClient(gdb_path=gdb_path, port=port)
        self._queue: queue.Queue = queue.Queue()
        self._running = False

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
            # Process one pending command if available
            try:
                cmd, args = self._queue.get(timeout=0.05)
                self._dispatch(cmd, args)
            except queue.Empty:
                pass

            # Poll for async GDB notifications (target stopped, etc.)
            for msg in self._client.poll_notifications():
                self._handle_async(msg)

        self._client.disconnect()
        self.disconnected.emit()

    def stop(self) -> None:
        self._running = False

    # ------------------------------------------------------------------
    # Public slots — called from GUI thread, put work on the queue
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

    # ------------------------------------------------------------------
    # Internal dispatch
    # ------------------------------------------------------------------

    def _dispatch(self, cmd: str, args: tuple) -> None:
        try:
            if cmd == "load_elf":
                self._client.load_elf(args[0])
                self.elf_loaded.emit()
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
                self.target_halted.emit(pc or 0)

            elif cmd == "step":
                self._client.step()
                pc = self._client.get_pc()
                self.target_halted.emit(pc or 0)

            elif cmd == "reset":
                self._client.reset_halt()
                pc = self._client.get_pc()
                self.target_halted.emit(pc or 0)

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
                    self.target_halted.emit(pc)
                    return
                if "running" in text:
                    self.target_running.emit()
                    return
        except Exception:
            pass  # leave state as unknown; first async notification will correct it

    @staticmethod
    def _extract_text(msg: dict) -> str:
        payload = msg.get("payload") or ""
        if isinstance(payload, str):
            return payload
        if isinstance(payload, dict):
            return payload.get("msg", "") or str(payload)
        return ""
