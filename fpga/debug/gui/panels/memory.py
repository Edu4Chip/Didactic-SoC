# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/memory.py
# Description  : MemoryPanel — single 32-bit word read/write panel using GDB
#                MI memory access commands that go through the system bus.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from PySide6.QtCore import Signal
from PySide6.QtWidgets import (
    QGroupBox, QVBoxLayout, QHBoxLayout, QGridLayout,
    QLabel, QLineEdit, QPushButton,
)


class MemoryPanel(QGroupBox):
    """Single-word memory read/write."""

    read_requested  = Signal(int)          # addr
    write_requested = Signal(int, int)     # addr, value

    def __init__(self, parent=None):
        super().__init__("Memory", parent)
        self._build_ui()

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        grid = QGridLayout()
        grid.setSpacing(4)

        # Address
        grid.addWidget(QLabel("Address"), 0, 0)
        self._addr_edit = QLineEdit("0x01030000")
        self._addr_edit.setPlaceholderText("0x…")
        grid.addWidget(self._addr_edit, 0, 1)

        # Read
        btn_read = QPushButton("Read")
        btn_read.clicked.connect(self._read)
        grid.addWidget(btn_read, 0, 2)
        self._read_result = QLabel("—")
        grid.addWidget(self._read_result, 0, 3)

        # Write
        grid.addWidget(QLabel("Value"), 1, 0)
        self._val_edit = QLineEdit()
        self._val_edit.setPlaceholderText("0x… or decimal")
        grid.addWidget(self._val_edit, 1, 1)
        btn_write = QPushButton("Write")
        btn_write.clicked.connect(self._write)
        grid.addWidget(btn_write, 1, 2)

        root.addLayout(grid)

    def _addr(self) -> int | None:
        try:
            return int(self._addr_edit.text().strip(), 0)
        except ValueError:
            self._read_result.setText("bad address")
            return None

    def _read(self) -> None:
        addr = self._addr()
        if addr is not None:
            self._read_result.setText("…")
            self.read_requested.emit(addr)

    def _write(self) -> None:
        addr = self._addr()
        try:
            val = int(self._val_edit.text().strip(), 0)
        except ValueError:
            return
        if addr is not None:
            self.write_requested.emit(addr, val)

    def on_memory_read(self, addr: int, value: int) -> None:
        if addr == self._addr():
            self._read_result.setText(f"{value:#010x}  ({value})")

    def on_memory_written(self, addr: int) -> None:
        if addr == self._addr():
            self._read_result.setText("written ✓")
