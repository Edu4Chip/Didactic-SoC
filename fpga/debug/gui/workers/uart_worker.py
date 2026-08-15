# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/workers/uart_worker.py
# Description  : UartWorker — QThread that reads UART lines from UartMonitor
#                and emits them to the GUI via the line_received signal.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import time
from PySide6.QtCore import QThread, Signal
from debugger.uart import UartMonitor


class UartWorker(QThread):
    """Reads the serial port continuously in a background thread."""

    line_received = Signal(str)
    connected     = Signal(str)   # port name
    disconnected  = Signal()
    error         = Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._monitor = UartMonitor()
        self._port = ""
        self._baudrate = 230_400
        self._running = False

    def set_port(self, port: str, baudrate: int = 230_400) -> None:
        self._port = port
        self._baudrate = baudrate

    def run(self) -> None:
        self._running = True
        try:
            self._monitor.connect(self._port, self._baudrate)
            self.connected.emit(self._port)
        except Exception as exc:
            self.error.emit(f"UART connect failed: {exc}")
            return

        while self._running:
            line = self._monitor.read_line()
            if line:
                self.line_received.emit(line)

        self._monitor.disconnect()
        self.disconnected.emit()

    def stop(self) -> None:
        self._running = False

    def send(self, text: str) -> None:
        """Thread-safe: serial.write() is safe to call from any thread."""
        try:
            self._monitor.write(text)
        except Exception as exc:
            self.error.emit(str(exc))

    def send_raw(self, data: bytes) -> None:
        """Send raw bytes with per-chunk pacing so the FPGA FIFO never overflows.

        Sends 16 bytes at a time, sleeping long enough for each chunk to drain
        from the transmit FIFO at the configured baud rate (8N1 = 10 bits/byte).
        At 57 600 baud a 16-byte chunk takes ≈ 2.8 ms; a 1 KB payload ≈ 180 ms.
        """
        _CHUNK = 16
        pace = _CHUNK * 10 / self._baudrate   # seconds to drain one chunk
        try:
            for i in range(0, len(data), _CHUNK):
                self._monitor.write_raw(data[i:i + _CHUNK])
                time.sleep(pace)
        except Exception as exc:
            self.error.emit(str(exc))
