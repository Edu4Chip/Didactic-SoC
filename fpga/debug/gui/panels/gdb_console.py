# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/gdb_console.py
# Description  : GdbConsolePanel — streams live GDB console and log output and
#                accepts raw GDB or OpenOCD monitor commands from the user.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from PySide6.QtCore import Signal
from PySide6.QtGui import QFont, QTextCursor
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout,
    QTextEdit, QLineEdit, QPushButton, QGroupBox,
)


class GdbConsolePanel(QGroupBox):
    """Raw GDB console: shows all GDB output, accepts free-form commands."""

    command_requested = Signal(str)

    def __init__(self, parent=None):
        super().__init__("GDB Console", parent)
        self._build_ui()

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)

        self._output = QTextEdit()
        self._output.setReadOnly(True)
        self._output.setFont(QFont("Monospace", 10))
        self._output.setLineWrapMode(QTextEdit.LineWrapMode.NoWrap)
        root.addWidget(self._output)

        input_row = QHBoxLayout()
        self._input = QLineEdit()
        self._input.setFont(QFont("Monospace", 10))
        self._input.setPlaceholderText("GDB command (e.g. monitor mdw 0x01030114)")
        self._input.returnPressed.connect(self._send)
        btn_send = QPushButton("Send")
        btn_send.clicked.connect(self._send)
        btn_clear = QPushButton("Clear")
        btn_clear.clicked.connect(self._output.clear)
        input_row.addWidget(self._input, stretch=1)
        input_row.addWidget(btn_send)
        input_row.addWidget(btn_clear)
        root.addLayout(input_row)

    def _send(self) -> None:
        cmd = self._input.text().strip()
        if not cmd:
            return
        self.append(f"(gdb) {cmd}")
        self.command_requested.emit(cmd)
        self._input.clear()

    def append(self, text: str) -> None:
        cursor = self._output.textCursor()
        cursor.movePosition(QTextCursor.MoveOperation.End)
        self._output.setTextCursor(cursor)
        self._output.insertPlainText(text if text.endswith("\n") else text + "\n")
        self._output.ensureCursorVisible()
