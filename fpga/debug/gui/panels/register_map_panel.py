# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/register_map_panel.py
# Description  : RegisterMapPanel — tree view of all SoC peripheral registers
#                from register_map.json; supports inline value editing,
#                right-click read, alternating row colours, and CSV export.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import csv
import json
import sys
from pathlib import Path

from PySide6.QtCore import QEvent, Signal, Qt
from PySide6.QtGui import QFont
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QFrame,
    QTreeWidget, QTreeWidgetItem,
    QHeaderView, QAbstractItemView, QMenu, QFileDialog,
    QToolButton,
)

_MAP_FILE = Path(__file__).resolve().parents[2] / "register_map.json"

# Main tree column indices (no # column — gutter widget handles numbering)
_COL_NAME = 0   # tree column: owns expand arrow + child indentation
_COL_ADDR = 1
_COL_ACC  = 2
_COL_VAL  = 3   # inline-edit target for W / R/W registers
_COL_DESC = 4

_ROLE_ADDR   = Qt.ItemDataRole.UserRole
_ROLE_ACCESS = Qt.ItemDataRole.UserRole + 1
_ROLE_ROWNUM = Qt.ItemDataRole.UserRole + 2   # stored on main item for CSV

# Fixed pixel width of the line-number gutter (fits up to 3-digit numbers at 9 pt mono)
_GUTTER_W = 44


def _value_tooltip(value: int) -> str:
    bits   = f"{value:032b}"
    binary = " ".join(bits[i:i+8] for i in range(0, 32, 8))
    ascii_chars = ""
    for shift in (24, 16, 8, 0):
        byte = (value >> shift) & 0xFF
        ascii_chars += chr(byte) if 0x20 <= byte <= 0x7E else "."
    return (f"Hex:     0x{value:08x}\n"
            f"Dec:     {value}\n"
            f"Bin:     {binary}\n"
            f"ASCII:   {ascii_chars}")


def _tool_btn(label: str, tooltip: str = "") -> QToolButton:
    btn = QToolButton()
    btn.setText(label)
    btn.setToolTip(tooltip or label)
    btn.setAutoRaise(True)
    return btn


class RegisterMapPanel(QWidget):
    """Tree view of all SoC registers, populated from register_map.json.

    Layout: a narrow line-number gutter (QTreeWidget) sits flush to the left
    of the main tree.  Both widgets share the same row structure; the gutter
    follows collapse/expand and scrolling of the main tree so they always look
    like a single widget.

    Main tree columns: Name | Address | Access | Value | Description
    Gutter column:     #

    Behaviour:
    - Selecting a register row auto-reads its value from the target.
    - Double-click a R/W or W register → inline value editor in the Value cell.
    - Double-click a R register → explicit read.
    - Right-click → context menu with Read / Edit value.
    - Writes auto-halt the CPU first if it is currently running.
    - Toolbar: Refresh | Read Selected | Read All | Export CSV.
    """

    read_requested  = Signal(int)        # addr
    write_requested = Signal(int, int)   # addr, value
    halt_requested  = Signal()           # emitted before a write when CPU is running

    def __init__(self, parent=None):
        super().__init__(parent)
        self._addr_to_item: dict[int, QTreeWidgetItem] = {}
        self._main_to_num:  dict[QTreeWidgetItem, QTreeWidgetItem] = {}
        self._selected_addr: int | None = None
        self._is_halted: bool = True
        self._build_ui()
        self._load()

    # ------------------------------------------------------------------
    # UI
    # ------------------------------------------------------------------

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setContentsMargins(4, 4, 4, 4)
        root.setSpacing(4)

        # ── Toolbar ──────────────────────────────────────────────────────
        tb_frame = QFrame()
        tb_frame.setFrameShape(QFrame.Shape.StyledPanel)
        tb_frame.setFrameShadow(QFrame.Shadow.Raised)
        tb_layout = QHBoxLayout(tb_frame)
        tb_layout.setContentsMargins(4, 2, 4, 2)
        tb_layout.setSpacing(2)

        self._btn_refresh  = _tool_btn("↺ Refresh", "Regenerate register map from C headers")
        self._btn_read_sel = _tool_btn("Read",      "Read selected register from target")
        self._btn_read_all = _tool_btn("Read All",  "Read every register from target")
        self._btn_export   = _tool_btn("Export CSV","Export current view to CSV file")

        self._btn_refresh.clicked.connect(self._regenerate)
        self._btn_read_sel.clicked.connect(self._read_selected)
        self._btn_read_all.clicked.connect(self._read_all)
        self._btn_export.clicked.connect(self._export_csv)

        def sep():
            s = QFrame()
            s.setFrameShape(QFrame.Shape.VLine)
            s.setFrameShadow(QFrame.Shadow.Sunken)
            return s

        tb_layout.addWidget(self._btn_refresh)
        tb_layout.addWidget(sep())
        tb_layout.addWidget(self._btn_read_sel)
        tb_layout.addWidget(self._btn_read_all)
        tb_layout.addWidget(sep())
        tb_layout.addWidget(self._btn_export)
        tb_layout.addStretch()

        self._status_label = QLabel("")
        self._status_label.setFont(QFont("Monospace", 8))
        self._status_label.setStyleSheet("color: #64748b;")
        tb_layout.addWidget(self._status_label)

        root.addWidget(tb_frame)

        # ── Gutter + main tree inside a single framed container ──────────
        frame = QFrame()
        frame.setFrameShape(QFrame.Shape.StyledPanel)
        frame.setFrameShadow(QFrame.Shadow.Sunken)
        tree_row = QHBoxLayout(frame)
        tree_row.setSpacing(0)
        tree_row.setContentsMargins(0, 0, 0, 0)

        # ── Gutter (line numbers) ─────────────────────────────────────────
        self._num_tree = QTreeWidget()
        self._num_tree.setColumnCount(1)
        self._num_tree.setHeaderLabels(["#"])
        self._num_tree.setFont(QFont("Monospace", 9))
        self._num_tree.setAlternatingRowColors(True)
        self._num_tree.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self._num_tree.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self._num_tree.setSelectionMode(QAbstractItemView.SelectionMode.NoSelection)
        self._num_tree.setFocusPolicy(Qt.FocusPolicy.NoFocus)
        self._num_tree.setIndentation(0)
        self._num_tree.setRootIsDecorated(False)
        self._num_tree.setItemsExpandable(False)  # fully flat, no expand at all
        self._num_tree.setFrameShape(QFrame.Shape.NoFrame)
        self._num_tree.setFixedWidth(_GUTTER_W)
        # Fix the single column to exactly _GUTTER_W; AlignRight then puts
        # text near the right edge (x ≈ 36) which is inside the viewport.
        gutter_hdr = self._num_tree.header()
        gutter_hdr.setStretchLastSection(False)
        gutter_hdr.setSectionResizeMode(0, QHeaderView.ResizeMode.Fixed)
        self._num_tree.setColumnWidth(0, _GUTTER_W)

        # ── Main tree ─────────────────────────────────────────────────────
        self._tree = QTreeWidget()
        self._tree.setColumnCount(5)
        self._tree.setHeaderLabels(["Name", "Address", "Access", "Value", "Description"])
        self._tree.setFont(QFont("Monospace", 9))
        self._tree.setAlternatingRowColors(True)
        self._tree.setEditTriggers(QAbstractItemView.EditTrigger.NoEditTriggers)
        self._tree.setContextMenuPolicy(Qt.ContextMenuPolicy.CustomContextMenu)
        self._tree.setFrameShape(QFrame.Shape.NoFrame)

        hdr = self._tree.header()
        hdr.setSectionResizeMode(QHeaderView.ResizeMode.Interactive)
        hdr.setStretchLastSection(True)
        self._tree.setColumnWidth(_COL_NAME, 160)
        self._tree.setColumnWidth(_COL_ADDR, 100)
        self._tree.setColumnWidth(_COL_ACC,   50)
        self._tree.setColumnWidth(_COL_VAL,  110)

        # Scroll sync: main drives the gutter (one-directional, no loop risk)
        self._tree.verticalScrollBar().valueChanged.connect(
            self._num_tree.verticalScrollBar().setValue
        )

        # Collapse / expand sync
        self._tree.itemExpanded.connect(self._sync_expand)
        self._tree.itemCollapsed.connect(self._sync_collapse)

        self._tree.itemSelectionChanged.connect(self._on_selection)
        self._tree.itemDoubleClicked.connect(self._on_double_click)
        self._tree.customContextMenuRequested.connect(self._on_context_menu)
        self._tree.itemChanged.connect(self._on_item_changed)

        # Forward wheel events on the gutter to the main tree so they scroll together
        self._num_tree.viewport().installEventFilter(self)

        tree_row.addWidget(self._num_tree)
        tree_row.addWidget(self._tree, stretch=1)
        root.addWidget(frame)

    # ------------------------------------------------------------------
    # Event filter — redirect gutter wheel events to the main tree
    # ------------------------------------------------------------------

    def eventFilter(self, obj, event) -> bool:
        if obj is self._num_tree.viewport() and event.type() == QEvent.Type.Wheel:
            from PySide6.QtWidgets import QApplication
            QApplication.sendEvent(self._tree.viewport(), event)
            return True
        return super().eventFilter(obj, event)

    # ------------------------------------------------------------------
    # Gutter sync helpers
    # ------------------------------------------------------------------

    def _sync_expand(self, item: QTreeWidgetItem) -> None:
        for i in range(item.childCount()):
            num_item = self._main_to_num.get(item.child(i))
            if num_item:
                num_item.setHidden(False)

    def _sync_collapse(self, item: QTreeWidgetItem) -> None:
        for i in range(item.childCount()):
            num_item = self._main_to_num.get(item.child(i))
            if num_item:
                num_item.setHidden(True)

    # ------------------------------------------------------------------
    # Load / regenerate
    # ------------------------------------------------------------------

    def _load(self) -> None:
        if not _MAP_FILE.exists():
            self._regenerate()
            return
        try:
            data = json.loads(_MAP_FILE.read_text())
            self._populate(data)
        except Exception as exc:
            self._status_label.setText(f"Load failed: {exc}")

    def _regenerate(self) -> None:
        try:
            sys.path.insert(0, str(_MAP_FILE.parent))
            import gen_register_map
            import importlib
            importlib.reload(gen_register_map)
            data = gen_register_map.generate()
            self._populate(data)
        except Exception as exc:
            self._status_label.setText(f"Generation failed: {exc}")

    def _populate(self, data: dict) -> None:
        self._tree.blockSignals(True)
        self._num_tree.blockSignals(True)
        self._tree.clear()
        self._num_tree.clear()
        self._addr_to_item.clear()
        self._main_to_num.clear()

        bold = QFont("Monospace", 9)
        bold.setBold(True)

        row_num = 0
        for periph in data.get("peripherals", []):
            base = int(periph["base"], 0)

            # Peripheral header — main tree
            p_item = QTreeWidgetItem(self._tree)
            p_item.setText(_COL_NAME, periph["name"])
            p_item.setText(_COL_ADDR, periph["base"])
            p_item.setText(_COL_DESC, periph.get("description", ""))
            p_item.setFont(_COL_NAME, bold)

            # Peripheral header — gutter: one flat top-level item, no text.
            # Flat structure avoids all expand/collapse visibility problems.
            np_item = QTreeWidgetItem(self._num_tree)
            self._main_to_num[p_item] = np_item

            for reg in periph.get("registers", []):
                row_num += 1
                addr   = base + int(reg["offset"], 0)
                access = reg.get("access", "R/W")

                # Register row — main tree
                r_item = QTreeWidgetItem(p_item)
                r_item.setText(_COL_NAME, reg["name"])
                r_item.setText(_COL_ADDR, f"0x{addr:08x}")
                r_item.setText(_COL_ACC,  access)
                r_item.setText(_COL_VAL,  "—")
                r_item.setText(_COL_DESC, reg.get("description", ""))
                r_item.setData(_COL_NAME, _ROLE_ADDR,   addr)
                r_item.setData(_COL_NAME, _ROLE_ACCESS, access)
                r_item.setData(_COL_NAME, _ROLE_ROWNUM, row_num)
                if "W" in access:
                    r_item.setFlags(r_item.flags() | Qt.ItemFlag.ItemIsEditable)
                self._addr_to_item[addr] = r_item

                # Register row — gutter: also a flat top-level item
                nr_item = QTreeWidgetItem(self._num_tree)
                nr_item.setText(0, str(row_num))
                nr_item.setTextAlignment(0, Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
                self._main_to_num[r_item] = nr_item

            p_item.setExpanded(True)

        self._tree.blockSignals(False)
        self._num_tree.blockSignals(False)

    # ------------------------------------------------------------------
    # Selection / interaction
    # ------------------------------------------------------------------

    def _on_selection(self) -> None:
        items = self._tree.selectedItems()
        if not items:
            return
        item = items[0]
        addr = item.data(_COL_NAME, _ROLE_ADDR)
        if addr is None:
            return
        self._selected_addr = addr
        self.read_requested.emit(addr)

    def _on_double_click(self, item: QTreeWidgetItem, _col: int) -> None:
        addr = item.data(_COL_NAME, _ROLE_ADDR)
        if addr is None:
            return
        self._selected_addr = addr
        access = item.data(_COL_NAME, _ROLE_ACCESS) or "R/W"
        if "W" in access:
            self._tree.editItem(item, _COL_VAL)
        else:
            self.read_requested.emit(addr)

    def _on_context_menu(self, pos) -> None:
        item = self._tree.itemAt(pos)
        if item is None:
            return
        addr = item.data(_COL_NAME, _ROLE_ADDR)
        if addr is None:
            return
        access = item.data(_COL_NAME, _ROLE_ACCESS) or "R/W"

        menu = QMenu(self)
        act_read = menu.addAction("Read")
        act_read.triggered.connect(lambda checked=False, a=addr: self._read_addr(a))
        if "W" in access:
            act_edit = menu.addAction("Edit value…")
            act_edit.triggered.connect(lambda checked=False, i=item: self._tree.editItem(i, _COL_VAL))
        menu.exec(self._tree.viewport().mapToGlobal(pos))

    def _on_item_changed(self, item: QTreeWidgetItem, col: int) -> None:
        if col != _COL_VAL:
            return
        addr = item.data(_COL_NAME, _ROLE_ADDR)
        if addr is None:
            return
        try:
            val = int(item.text(_COL_VAL), 0)
        except ValueError:
            return
        if not self._is_halted:
            self.halt_requested.emit()
        self.write_requested.emit(addr, val)

    # ------------------------------------------------------------------
    # Read helpers
    # ------------------------------------------------------------------

    def _read_addr(self, addr: int) -> None:
        self._selected_addr = addr
        self.read_requested.emit(addr)

    def _read_selected(self) -> None:
        if self._selected_addr is not None:
            self.read_requested.emit(self._selected_addr)

    def _read_all(self) -> None:
        for addr in self._addr_to_item:
            self.read_requested.emit(addr)

    # ------------------------------------------------------------------
    # CSV export
    # ------------------------------------------------------------------

    def _export_csv(self) -> None:
        path, _ = QFileDialog.getSaveFileName(
            self, "Export Register Map", "registers.csv", "CSV files (*.csv)"
        )
        if not path:
            return
        try:
            with open(path, "w", newline="", encoding="utf-8") as f:
                w = csv.writer(f)
                w.writerow(["#", "Peripheral", "Name", "Address", "Access", "Value", "Description"])
                for i in range(self._tree.topLevelItemCount()):
                    p = self._tree.topLevelItem(i)
                    for j in range(p.childCount()):
                        r = p.child(j)
                        w.writerow([
                            r.data(_COL_NAME, _ROLE_ROWNUM),
                            p.text(_COL_NAME),
                            r.text(_COL_NAME),
                            r.text(_COL_ADDR),
                            r.text(_COL_ACC),
                            r.text(_COL_VAL),
                            r.text(_COL_DESC),
                        ])
            self._status_label.setText(f"Exported → {Path(path).name}")
        except OSError as exc:
            self._status_label.setText(f"Export failed: {exc}")

    # ------------------------------------------------------------------
    # Slots (CPU state + memory read-back from GdbWorker)
    # ------------------------------------------------------------------

    def on_target_halted(self, _pc: int = 0) -> None:
        self._is_halted = True

    def on_target_running(self) -> None:
        self._is_halted = False

    def on_memory_read(self, addr: int, value: int) -> None:
        item = self._addr_to_item.get(addr)
        if item:
            self._tree.blockSignals(True)
            item.setText(_COL_VAL, f"0x{value:08x}")
            self._tree.blockSignals(False)
            item.setToolTip(_COL_VAL, _value_tooltip(value))

    def on_memory_written(self, addr: int) -> None:
        self.read_requested.emit(addr)
