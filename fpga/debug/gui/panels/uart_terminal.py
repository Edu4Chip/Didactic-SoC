# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/uart_terminal.py
# Description  : UartTerminalPanel — scrolling UART output display with TX
#                input field, configurable newline append, and clear control;
#                spans the full window width at the bottom of the layout.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from PySide6.QtCore import Qt, Signal
from PySide6.QtGui import QFont, QTextCursor
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout,
    QTextEdit, QLineEdit, QPushButton, QGroupBox, QCheckBox,
)


class UartTerminalPanel(QGroupBox):
    """Scrolling UART output + send input."""

    send_requested = Signal(str)

    def __init__(self, parent=None):
        super().__init__("UART Terminal", parent)
        self._build_ui()

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)

        self._output = QTextEdit()
        self._output.setReadOnly(True)
        self._output.setFont(QFont("Monospace", 10))
        self._output.setLineWrapMode(QTextEdit.LineWrapMode.NoWrap)
        root.addWidget(self._output)

        send_row = QHBoxLayout()
        self._input = QLineEdit()
        self._input.setPlaceholderText("Send text… (Enter to send)")
        self._input.setFont(QFont("Monospace", 10))
        self._input.returnPressed.connect(self._send)
        btn_send = QPushButton("Send")
        btn_send.clicked.connect(self._send)
        btn_clear = QPushButton("Clear")
        btn_clear.clicked.connect(self._output.clear)
        self._chk_newline = QCheckBox("\\n")
        self._chk_newline.setToolTip("Append newline (\\n) to each sent message")
        self._chk_newline.setChecked(False)
        send_row.addWidget(self._input, stretch=1)
        send_row.addWidget(self._chk_newline)
        send_row.addWidget(btn_send)
        send_row.addWidget(btn_clear)
        root.addLayout(send_row)

    def terminal_text(self) -> str:
        """Return the full current terminal content as a plain-text string."""
        return self._output.toPlainText()

    def append_line(self, text: str) -> None:
        """Append a line from the UART worker (called via signal from any thread)."""
        cursor = self._output.textCursor()
        cursor.movePosition(QTextCursor.MoveOperation.End)
        self._output.setTextCursor(cursor)
        self._output.insertPlainText(text)
        self._output.ensureCursorVisible()

    def _send(self) -> None:
        text = self._input.text()
        if text:
            if self._chk_newline.isChecked():
                text += "\n"
            self.send_requested.emit(text)
            self._input.clear()
