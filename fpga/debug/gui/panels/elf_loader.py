# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/elf_loader.py
# Description  : ElfLoaderPanel — file browser and load-and-run workflow for
#                RISC-V ELF binaries; halts the CPU, downloads the ELF via
#                GDB -target-download, then resumes execution.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from pathlib import Path

from PySide6.QtCore import Signal, QSettings
from PySide6.QtGui import QFont
from PySide6.QtWidgets import (
    QGroupBox, QVBoxLayout, QHBoxLayout,
    QLineEdit, QPushButton, QFileDialog, QTextEdit,
)


class ElfLoaderPanel(QGroupBox):
    """File picker + load button for ELF programs."""

    load_requested = Signal(str)

    def __init__(self, parent=None):
        super().__init__("ELF Loader", parent)
        self._build_ui()

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setSpacing(4)

        file_row = QHBoxLayout()
        self._path_edit = QLineEdit()
        self._path_edit.setPlaceholderText("Path to .elf file…")
        btn_browse = QPushButton("Browse…")
        btn_browse.clicked.connect(self._browse)
        file_row.addWidget(self._path_edit, stretch=1)
        file_row.addWidget(btn_browse)
        root.addLayout(file_row)

        btn_row = QHBoxLayout()
        self._btn_load = QPushButton("Load && Run")
        self._btn_load.clicked.connect(self._load)
        btn_row.addWidget(self._btn_load)
        btn_row.addStretch()
        root.addLayout(btn_row)

        self._log = QTextEdit()
        self._log.setReadOnly(True)
        self._log.setFont(QFont("Monospace", 9))
        self._log.setFixedHeight(60)
        root.addWidget(self._log)

    def _browse(self) -> None:
        s = QSettings("DidacticSoC", "SoCDebugger")
        last_dir = s.value("elf/last_dir", "")
        path, _ = QFileDialog.getOpenFileName(
            self, "Select ELF", last_dir, "ELF files (*.elf);;All files (*)"
        )
        if path:
            self._path_edit.setText(path)
            s.setValue("elf/last_dir", str(Path(path).parent))

    def _load(self) -> None:
        path = self._path_edit.text().strip()
        if path:
            self.log(f"Loading {path} …")
            self.load_requested.emit(path)

    def on_loaded(self) -> None:
        self.log("Load complete.")

    def log(self, msg: str) -> None:
        self._log.append(msg)

    def set_enabled(self, enabled: bool) -> None:
        self._btn_load.setEnabled(enabled)
