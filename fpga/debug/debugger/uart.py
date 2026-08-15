# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/debugger/uart.py
# Description  : UartMonitor — wraps pyserial for serial port enumeration with
#                FTDI device filtering and line-oriented reads for the SoC UART.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import serial
import serial.tools.list_ports
from typing import Iterator

# Baud rate matches the divisor in sw/common/uart.h:
#   25 MHz / (16 * 27) ≈ 57 870 → nearest standard = 57 600  (FPGA, 25 MHz PLL)
#   100 MHz / (16 * 27) ≈ 231 481 → nearest standard = 230 400 (ASIC)
_DEFAULT_BAUD = 57_600


class UartMonitor:
    """Serial port wrapper for the SoC UART (FTDI adapter, serial channel)."""

    def __init__(self):
        self._serial: serial.Serial | None = None

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    def connect(self, port: str, baudrate: int = _DEFAULT_BAUD) -> None:
        self._serial = serial.Serial(port, baudrate=baudrate, timeout=1.0)

    def disconnect(self) -> None:
        if self._serial and self._serial.is_open:
            self._serial.close()
        self._serial = None

    @property
    def is_connected(self) -> bool:
        return self._serial is not None and self._serial.is_open

    # ------------------------------------------------------------------
    # I/O (call from a worker thread — blocking)
    # ------------------------------------------------------------------

    def read_line(self) -> str | None:
        """Block up to the serial timeout, return a decoded line or None."""
        if not self.is_connected:
            return None
        try:
            raw = self._serial.readline()
            return raw.decode("utf-8", errors="replace") if raw else None
        except serial.SerialException:
            return None

    def write(self, text: str) -> None:
        if self.is_connected:
            self._serial.write(text.encode("utf-8"))

    def write_raw(self, data: bytes) -> None:
        if self.is_connected:
            self._serial.write(data)

    # ------------------------------------------------------------------
    # Port discovery
    # ------------------------------------------------------------------

    @staticmethod
    def list_ports() -> list[tuple[str, str]]:
        """Return (device, description) pairs for all available serial ports."""
        return [(p.device, p.description)
                for p in serial.tools.list_ports.comports()]

    @staticmethod
    def ftdi_ports() -> list[tuple[str, str]]:
        """Return only ports from FTDI adapters (VID 0x0403)."""
        return [(p.device, p.description)
                for p in serial.tools.list_ports.comports()
                if p.vid == 0x0403]
