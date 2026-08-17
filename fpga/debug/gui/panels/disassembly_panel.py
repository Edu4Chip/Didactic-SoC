# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/disassembly_panel.py
# Description  : DisassemblyPanel — shows disassembled instructions around the
#                current PC with a click-to-toggle-breakpoint gutter, and an
#                integrated call-stack list above.  Click a stack frame to
#                navigate the disassembly to that frame's address.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from __future__ import annotations

from PySide6.QtCore import Signal, Qt
from PySide6.QtGui import QColor, QFont, QBrush
from PySide6.QtWidgets import (
    QGroupBox, QVBoxLayout, QSplitter,
    QListWidget, QListWidgetItem,
    QTableWidget, QTableWidgetItem, QHeaderView, QAbstractItemView,
)

_FONT = QFont("Monospace", 9)

_FN_BG  = QColor("#f1f5f9")  # function-header row background
_FN_FG  = QColor("#475569")  # function-header row text
_PC_BG  = QColor("#dbeafe")  # current-PC row background
_BP_FG  = QColor("#dc2626")  # breakpoint marker colour
_PC_FG  = QColor("#16a34a")  # current-PC marker colour


class DisassemblyPanel(QGroupBox):
    """Disassembly view with integrated call stack and click-to-breakpoint gutter."""

    breakpoint_toggled = Signal(int)  # addr — caller decides add vs. remove
    frame_selected     = Signal(int)  # pc of the clicked stack frame

    def __init__(self, parent=None):
        super().__init__("Disassembly", parent)
        self._current_pc:  int       = 0
        self._bp_addrs:    set[int]  = set()
        self._addr_to_row: dict[int, int] = {}
        self._build_ui()

    # ------------------------------------------------------------------
    # Build
    # ------------------------------------------------------------------

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setContentsMargins(4, 4, 4, 4)

        split = QSplitter(Qt.Orientation.Vertical)

        # ── Call stack ────────────────────────────────────────────────
        self._stack = QListWidget()
        self._stack.setFont(_FONT)
        self._stack.setMaximumHeight(88)
        self._stack.itemClicked.connect(
            lambda item: self.frame_selected.emit(
                item.data(Qt.ItemDataRole.UserRole) or 0
            )
        )
        split.addWidget(self._stack)

        # ── Disassembly table ─────────────────────────────────────────
        self._tbl = QTableWidget(0, 3)
        self._tbl.setHorizontalHeaderLabels(["", "Address", "Instruction"])
        hdr = self._tbl.horizontalHeader()
        hdr.setSectionResizeMode(0, QHeaderView.ResizeMode.Fixed)
        hdr.setSectionResizeMode(1, QHeaderView.ResizeMode.Fixed)
        hdr.setSectionResizeMode(2, QHeaderView.ResizeMode.Stretch)
        self._tbl.setColumnWidth(0, 22)
        self._tbl.setColumnWidth(1, 108)
        self._tbl.verticalHeader().setVisible(False)
        self._tbl.setFont(_FONT)
        self._tbl.setEditTriggers(QAbstractItemView.EditTrigger.NoEditTriggers)
        self._tbl.setSelectionMode(QAbstractItemView.SelectionMode.NoSelection)
        self._tbl.setShowGrid(False)
        self._tbl.cellClicked.connect(self._on_cell_clicked)
        split.addWidget(self._tbl)

        split.setSizes([70, 500])
        root.addWidget(split)

    # ------------------------------------------------------------------
    # Public — driven by GdbWorker signals
    # ------------------------------------------------------------------

    def update_disassembly(self, insns: list, current_pc: int,
                           bp_addrs: list, scroll: bool = True) -> None:
        self._current_pc = current_pc
        self._bp_addrs   = set(bp_addrs)
        self._addr_to_row.clear()

        self._tbl.setUpdatesEnabled(False)
        self._tbl.setRowCount(0)

        cur_func: str | None = None
        row = 0

        for insn in insns:
            try:
                addr = int(insn.get("address", "0"), 0)
            except (ValueError, TypeError):
                continue
            func = insn.get("func-name", "")
            text = insn.get("inst", "").replace("\t", "  ")

            if func != cur_func:
                self._tbl.insertRow(row)
                fn_item = QTableWidgetItem(f"  {func}")
                fn_item.setBackground(QBrush(_FN_BG))
                fn_item.setForeground(QBrush(_FN_FG))
                fn_item.setFont(QFont("Monospace", 9, QFont.Weight.Bold))
                self._tbl.setItem(row, 0, fn_item)
                self._tbl.setSpan(row, 0, 1, 3)
                self._tbl.setRowHeight(row, 18)
                row += 1
                cur_func = func

            self._tbl.insertRow(row)
            self._addr_to_row[addr] = row
            self._tbl.setRowHeight(row, 20)

            is_bp = addr in self._bp_addrs
            is_pc = addr == current_pc

            marker = ("⊙" if is_bp and is_pc else
                      "●" if is_bp else
                      "▶" if is_pc else "")

            bp_cell   = QTableWidgetItem(marker)
            addr_cell = QTableWidgetItem(f"0x{addr:08x}")
            inst_cell = QTableWidgetItem(f"  {text}")

            bp_cell.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            bp_cell.setData(Qt.ItemDataRole.UserRole, addr)

            if is_pc:
                for cell in (bp_cell, addr_cell, inst_cell):
                    cell.setBackground(QBrush(_PC_BG))
            if is_bp:
                bp_cell.setForeground(QBrush(_BP_FG))
            elif is_pc:
                bp_cell.setForeground(QBrush(_PC_FG))

            self._tbl.setItem(row, 0, bp_cell)
            self._tbl.setItem(row, 1, addr_cell)
            self._tbl.setItem(row, 2, inst_cell)
            row += 1

        self._tbl.setUpdatesEnabled(True)

        if scroll and current_pc in self._addr_to_row:
            self._tbl.scrollTo(
                self._tbl.model().index(self._addr_to_row[current_pc], 0),
                QAbstractItemView.ScrollHint.PositionAtCenter,
            )

    def update_stack(self, frames: list) -> None:
        self._stack.clear()
        for frame in frames:
            level = frame.get("level", "?")
            func  = frame.get("func", "??")
            file_ = frame.get("file", "")
            line  = frame.get("line", "")
            addr  = frame.get("addr", "0x0")
            loc   = f"{file_}:{line}" if file_ else addr
            item  = QListWidgetItem(f"#{level}  {func}  —  {loc}")
            try:
                item.setData(Qt.ItemDataRole.UserRole, int(addr, 0))
            except (ValueError, TypeError):
                item.setData(Qt.ItemDataRole.UserRole, 0)
            self._stack.addItem(item)

    def on_breakpoint_changed(self, addr: int, added: bool) -> None:
        """Incremental marker refresh when a BP is added or removed."""
        if added:
            self._bp_addrs.add(addr)
        else:
            self._bp_addrs.discard(addr)
        row = self._addr_to_row.get(addr)
        if row is None:
            return
        cell = self._tbl.item(row, 0)
        if cell is None:
            return
        is_pc = addr == self._current_pc
        cell.setText("⊙" if (added and is_pc) else
                     "●" if added else
                     "▶" if is_pc else "")
        cell.setForeground(QBrush(_BP_FG if added else
                                   _PC_FG if is_pc else QColor()))

    # ------------------------------------------------------------------
    # Interaction
    # ------------------------------------------------------------------

    def _on_cell_clicked(self, row: int, col: int) -> None:
        if col != 0:
            return
        cell = self._tbl.item(row, 0)
        if cell is None:
            return
        addr = cell.data(Qt.ItemDataRole.UserRole)
        if isinstance(addr, int):
            self.breakpoint_toggled.emit(addr)
