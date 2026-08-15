# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/execution.py
# Description  : ExecutionPanel — run/halt/step/reset controls with CPU state
#                indicator and live PC display; all execution commands use
#                OpenOCD monitor commands to avoid blocking GDB.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from PySide6.QtCore import Signal
from PySide6.QtWidgets import (
    QGroupBox, QVBoxLayout, QHBoxLayout,
    QLabel, QPushButton,
)

_STATUS_RUNNING = ("▶  Running",  "color: #22c55e;")
_STATUS_HALTED  = ("⏸  Halted",   "color: #f59e0b;")
_STATUS_UNKNOWN = ("—  Unknown",  "color: #94a3b8;")


class ExecutionPanel(QGroupBox):
    """Run / Halt / Step / Reset controls and PC display."""

    run_requested   = Signal()
    halt_requested  = Signal()
    step_requested  = Signal()
    reset_requested = Signal()

    def __init__(self, parent=None):
        super().__init__("Execution", parent)
        self._build_ui()

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setSpacing(6)

        # Status + PC
        status_row = QHBoxLayout()
        self._status_label = QLabel(_STATUS_UNKNOWN[0])
        self._status_label.setStyleSheet(_STATUS_UNKNOWN[1])
        self._pc_label = QLabel("PC: —")
        status_row.addWidget(self._status_label)
        status_row.addStretch()
        status_row.addWidget(self._pc_label)
        root.addLayout(status_row)

        # Buttons
        btn_row = QHBoxLayout()
        self._btn_run   = QPushButton("▶  Run")
        self._btn_halt  = QPushButton("⏸  Halt")
        self._btn_step  = QPushButton("⤵  Step")
        self._btn_reset = QPushButton("↺  Reset")

        self._btn_run.clicked.connect(self.run_requested)
        self._btn_halt.clicked.connect(self.halt_requested)
        self._btn_step.clicked.connect(self.step_requested)
        self._btn_reset.clicked.connect(self.reset_requested)

        for btn in (self._btn_run, self._btn_halt, self._btn_step, self._btn_reset):
            btn_row.addWidget(btn)
        root.addLayout(btn_row)

        self.set_enabled(False)

    # ------------------------------------------------------------------
    # State updates (called from main window via GDB worker signals)
    # ------------------------------------------------------------------

    def on_target_halted(self, pc: int) -> None:
        self._status_label.setText(_STATUS_HALTED[0])
        self._status_label.setStyleSheet(_STATUS_HALTED[1])
        self._pc_label.setText(f"PC: {pc:#010x}")
        self._btn_run.setEnabled(True)
        self._btn_halt.setEnabled(False)
        self._btn_step.setEnabled(True)

    def on_target_running(self) -> None:
        self._status_label.setText(_STATUS_RUNNING[0])
        self._status_label.setStyleSheet(_STATUS_RUNNING[1])
        self._btn_run.setEnabled(False)
        self._btn_halt.setEnabled(True)
        self._btn_step.setEnabled(False)

    def on_pc_updated(self, pc: int) -> None:
        self._pc_label.setText(f"PC: {pc:#010x}")

    def set_enabled(self, enabled: bool) -> None:
        for btn in (self._btn_run, self._btn_halt, self._btn_step, self._btn_reset):
            btn.setEnabled(enabled)
        if not enabled:
            self._status_label.setText(_STATUS_UNKNOWN[0])
            self._status_label.setStyleSheet(_STATUS_UNKNOWN[1])
            self._pc_label.setText("PC: —")
