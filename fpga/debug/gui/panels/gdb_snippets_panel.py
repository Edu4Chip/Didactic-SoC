# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/gdb_snippets_panel.py
# Description  : GdbSnippetsPanel — editor and runner for reusable GDB script
#                files (.gdb) stored in gdb_snippets/; supports create, edit,
#                save, delete, and execute via GDB source command.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from pathlib import Path

from PySide6.QtCore import Signal, Qt
from PySide6.QtGui import QColor, QFont, QSyntaxHighlighter, QTextCharFormat
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QSplitter,
    QListWidget, QListWidgetItem, QPlainTextEdit,
    QPushButton, QLabel, QInputDialog, QMessageBox,
)

_SNIPPETS_DIR = Path(__file__).resolve().parents[2] / "gdb_snippets"

_COMMENT_COLOR = QColor("#1a6e1a")   # dark green for # comment lines


class _GdbHighlighter(QSyntaxHighlighter):
    """Highlights lines that start with # as comments (dark green)."""

    def __init__(self, document):
        super().__init__(document)
        self._fmt = QTextCharFormat()
        self._fmt.setForeground(_COMMENT_COLOR)

    def highlightBlock(self, text: str) -> None:
        if text.lstrip().startswith("#"):
            self.setFormat(0, len(text), self._fmt)


class GdbSnippetsPanel(QWidget):
    """Browse, edit, and run .gdb snippet files."""

    command_requested = Signal(str)   # forwarded to GdbWorker.request_raw_command

    def __init__(self, parent=None):
        super().__init__(parent)
        _SNIPPETS_DIR.mkdir(parents=True, exist_ok=True)
        self._current_path: Path | None = None
        self._build_ui()
        self._refresh()

    # ------------------------------------------------------------------
    # UI
    # ------------------------------------------------------------------

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setContentsMargins(4, 4, 4, 4)
        root.setSpacing(4)

        splitter = QSplitter(Qt.Orientation.Horizontal)

        # ── Left: file list ──────────────────────────────────────────────
        left = QWidget()
        ll = QVBoxLayout(left)
        ll.setContentsMargins(0, 0, 0, 0)
        ll.setSpacing(4)

        self._list = QListWidget()
        self._list.setFont(QFont("Monospace", 9))
        self._list.currentItemChanged.connect(self._on_select)
        ll.addWidget(self._list)

        list_btns = QHBoxLayout()
        btn_new     = QPushButton("+")
        btn_new.setToolTip("New snippet")
        btn_new.setFixedWidth(28)
        btn_delete  = QPushButton("−")
        btn_delete.setToolTip("Delete selected snippet")
        btn_delete.setFixedWidth(28)
        btn_refresh = QPushButton("↺")
        btn_refresh.setToolTip("Refresh file list")
        btn_refresh.setFixedWidth(28)
        btn_new.clicked.connect(self._new)
        btn_delete.clicked.connect(self._delete)
        btn_refresh.clicked.connect(self._refresh)
        list_btns.addWidget(btn_new)
        list_btns.addWidget(btn_delete)
        list_btns.addWidget(btn_refresh)
        list_btns.addStretch()
        ll.addLayout(list_btns)

        # ── Right: editor ────────────────────────────────────────────────
        right = QWidget()
        rl = QVBoxLayout(right)
        rl.setContentsMargins(0, 0, 0, 0)
        rl.setSpacing(4)

        self._editor = QPlainTextEdit()
        self._editor.setFont(QFont("Monospace", 10))
        self._editor.setPlaceholderText("Select a snippet to edit…")
        self._editor.textChanged.connect(self._on_edit)
        self._highlighter = _GdbHighlighter(self._editor.document())
        rl.addWidget(self._editor)

        editor_btns = QHBoxLayout()
        self._btn_save = QPushButton("Save")
        self._btn_save.setEnabled(False)
        self._btn_save.clicked.connect(self._save)
        self._btn_run = QPushButton("▶  Run")
        self._btn_run.setEnabled(False)
        self._btn_run.clicked.connect(self._run)
        self._status = QLabel("")
        self._status.setFont(QFont("Monospace", 9))
        editor_btns.addWidget(self._btn_save)
        editor_btns.addWidget(self._btn_run)
        editor_btns.addStretch()
        editor_btns.addWidget(self._status)
        rl.addLayout(editor_btns)

        splitter.addWidget(left)
        splitter.addWidget(right)
        splitter.setSizes([160, 540])
        splitter.setStretchFactor(0, 0)
        splitter.setStretchFactor(1, 1)

        root.addWidget(splitter)

    # ------------------------------------------------------------------
    # File list
    # ------------------------------------------------------------------

    def _refresh(self) -> None:
        current_name = self._current_path.name if self._current_path else None
        self._list.clear()
        for f in sorted(_SNIPPETS_DIR.glob("*.gdb")):
            item = QListWidgetItem(f.stem)
            item.setData(Qt.ItemDataRole.UserRole, f)
            self._list.addItem(item)
            if f.name == current_name:
                self._list.setCurrentItem(item)

    def _on_select(self, item: QListWidgetItem | None, _prev=None) -> None:
        if item is None:
            return
        path: Path = item.data(Qt.ItemDataRole.UserRole)
        self._current_path = path
        try:
            text = path.read_text()
        except OSError as exc:
            self._status.setText(str(exc))
            return
        self._editor.blockSignals(True)
        self._editor.setPlainText(text)
        self._editor.blockSignals(False)
        self._btn_run.setEnabled(True)
        self._btn_save.setEnabled(False)
        self._status.setText(f"{path.name}")

    # ------------------------------------------------------------------
    # CRUD
    # ------------------------------------------------------------------

    def _new(self) -> None:
        name, ok = QInputDialog.getText(self, "New Snippet", "Snippet name (no extension):")
        if not ok or not name.strip():
            return
        path = _SNIPPETS_DIR / f"{name.strip()}.gdb"
        if path.exists():
            QMessageBox.warning(self, "Exists", f"{path.name} already exists.")
            return
        path.write_text(f"# {name.strip()}\n")
        self._refresh()
        # select the new item
        for i in range(self._list.count()):
            if self._list.item(i).data(Qt.ItemDataRole.UserRole) == path:
                self._list.setCurrentRow(i)
                break

    def _delete(self) -> None:
        item = self._list.currentItem()
        if not item:
            return
        path: Path = item.data(Qt.ItemDataRole.UserRole)
        reply = QMessageBox.question(
            self, "Delete", f"Delete {path.name}?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
        )
        if reply == QMessageBox.StandardButton.Yes:
            path.unlink(missing_ok=True)
            self._current_path = None
            self._editor.clear()
            self._btn_run.setEnabled(False)
            self._btn_save.setEnabled(False)
            self._status.setText("")
            self._refresh()

    def _on_edit(self) -> None:
        if self._current_path:
            self._btn_save.setEnabled(True)

    def _save(self) -> None:
        if not self._current_path:
            return
        try:
            self._current_path.write_text(self._editor.toPlainText())
            self._btn_save.setEnabled(False)
            self._status.setText(f"Saved {self._current_path.name}")
        except OSError as exc:
            self._status.setText(f"Save failed: {exc}")

    # ------------------------------------------------------------------
    # Run
    # ------------------------------------------------------------------

    def _run(self) -> None:
        if not self._current_path:
            return
        if self._btn_save.isEnabled():
            self._save()
        # Use GDB's source command — runs the file as a GDB script
        self.command_requested.emit(f"source {self._current_path}")
        self._status.setText(f"Running {self._current_path.name}…")
