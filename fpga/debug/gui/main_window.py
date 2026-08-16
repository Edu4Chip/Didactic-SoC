# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/main_window.py
# Description  : MainWindow — QMainWindow subclass that assembles all panels,
#                creates GDB and UART workers, wires all Qt signals to slots,
#                and provides a menu bar, application toolbar, and About dialog.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from pathlib import Path

from PySide6.QtCore import Qt, QSettings
from PySide6.QtGui import QAction, QKeySequence, QPixmap
from PySide6.QtWidgets import (
    QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QSplitter,
    QTabWidget, QLabel, QMessageBox, QDialog, QDialogButtonBox,
    QFrame, QFileDialog,
)

_ASSETS = Path(__file__).resolve().parents[1] / "assets"
from gui.panels import (
    ConnectionPanel, UartTerminalPanel,
    ElfLoaderPanel, ExecutionPanel, MemoryPanel,
    GdbConsolePanel, RegisterMapPanel, GdbSnippetsPanel,
)
from gui.workers import GdbWorker, UartWorker


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Didactic SoC — Debug GUI")
        self.resize(1100, 700)

        self._gdb_worker  = GdbWorker()
        self._uart_worker = UartWorker()

        self._build_menu()
        self._build_toolbar()
        self._build_ui()
        self._connect_signals()
        self._restore_settings()

    # ------------------------------------------------------------------
    # Menu bar
    # ------------------------------------------------------------------

    def _build_menu(self) -> None:
        mb = self.menuBar()

        file_menu = mb.addMenu("&File")

        # Export submenu
        export_menu = file_menu.addMenu("&Export")
        act_exp_text = QAction("UART Data as &text…", self)
        act_exp_text.setStatusTip("Save the UART terminal content to a text file")
        act_exp_text.triggered.connect(self._export_uart_text)
        export_menu.addAction(act_exp_text)

        act_exp_bin = QAction("UART Data as &binary…", self)
        act_exp_bin.setStatusTip("Save the UART terminal content to a binary file")
        act_exp_bin.triggered.connect(self._export_uart_binary)
        export_menu.addAction(act_exp_bin)

        # Import submenu
        import_menu = file_menu.addMenu("&Import")
        self._act_imp_text = QAction("UART Data as te&xt… (send to FPGA)", self)
        self._act_imp_text.setStatusTip("Read a text file and send it byte-by-byte via UART")
        self._act_imp_text.setEnabled(False)
        self._act_imp_text.triggered.connect(self._import_uart_text)
        import_menu.addAction(self._act_imp_text)

        self._act_imp_bin = QAction("UART Data as b&inary… (send to FPGA)", self)
        self._act_imp_bin.setStatusTip("Read a binary file and send it byte-by-byte via UART")
        self._act_imp_bin.setEnabled(False)
        self._act_imp_bin.triggered.connect(self._import_uart_binary)
        import_menu.addAction(self._act_imp_bin)

        file_menu.addSeparator()
        act_exit = QAction("E&xit", self)
        act_exit.setShortcut(QKeySequence.StandardKey.Quit)
        act_exit.setStatusTip("Exit the application")
        act_exit.triggered.connect(self.close)
        file_menu.addAction(act_exit)

        help_menu = mb.addMenu("&Help")
        act_about = QAction("&About", self)
        act_about.setStatusTip("About this application")
        act_about.triggered.connect(self._show_about)
        help_menu.addAction(act_about)

    # ------------------------------------------------------------------
    # Application toolbar
    # ------------------------------------------------------------------

    def _build_toolbar(self) -> None:
        tb = self.addToolBar("Main")
        tb.setMovable(False)
        tb.setObjectName("main_toolbar")

        def act(label: str, tip: str, shortcut: str | None = None) -> QAction:
            a = QAction(label, self)
            a.setToolTip(tip)
            a.setStatusTip(tip)
            if shortcut:
                a.setShortcut(QKeySequence(shortcut))
            return a

        self._act_run   = act("▶  Run",   "Resume CPU execution",    "F5")
        self._act_halt  = act("⏸  Halt",  "Halt CPU",                "F6")
        self._act_step  = act("⤵  Step",  "Execute one instruction",  "F7")
        self._act_reset = act("↺  Reset", "Reset and halt CPU",       "F8")

        for a in (self._act_run, self._act_halt, self._act_step, self._act_reset):
            a.setEnabled(False)
            tb.addAction(a)

        self._act_run.triggered.connect(self._gdb_worker.request_run)
        self._act_halt.triggered.connect(self._gdb_worker.request_halt)
        self._act_step.triggered.connect(self._gdb_worker.request_step)
        self._act_reset.triggered.connect(self._gdb_worker.request_reset)

    # ------------------------------------------------------------------
    # UI
    # ------------------------------------------------------------------

    def _build_ui(self) -> None:
        # Outer vertical splitter: top = controls+tabs, bottom = UART terminal
        v_splitter = QSplitter(Qt.Orientation.Vertical)
        self.setCentralWidget(v_splitter)

        # ── Top pane: horizontal splitter ────────────────────────────────
        h_splitter = QSplitter(Qt.Orientation.Horizontal)

        # Left column
        left = QWidget()
        left_layout = QVBoxLayout(left)
        left_layout.setContentsMargins(4, 4, 4, 4)
        left_layout.setSpacing(6)

        self._conn_panel  = ConnectionPanel()
        self._elf_panel   = ElfLoaderPanel()
        self._exec_panel  = ExecutionPanel()
        self._mem_panel   = MemoryPanel()

        left_layout.addWidget(self._conn_panel)
        left_layout.addWidget(self._elf_panel)
        left_layout.addWidget(self._exec_panel)
        left_layout.addWidget(self._mem_panel)
        left_layout.addStretch()

        # Right column — GDB console + Register map + Snippets
        self._gdb_console    = GdbConsolePanel()
        self._reg_map_panel  = RegisterMapPanel()
        self._snippets_panel = GdbSnippetsPanel()

        tabs = QTabWidget()
        tabs.addTab(self._gdb_console,    "GDB Console")
        tabs.addTab(self._reg_map_panel,  "Register Map")
        tabs.addTab(self._snippets_panel, "GDB Snippets")

        h_splitter.addWidget(left)
        h_splitter.addWidget(tabs)
        h_splitter.setStretchFactor(0, 0)
        h_splitter.setStretchFactor(1, 1)
        h_splitter.setSizes([380, 720])
        self._h_splitter = h_splitter

        # ── Bottom pane: UART terminal spanning full width ────────────────
        self._uart_panel = UartTerminalPanel()

        v_splitter.addWidget(h_splitter)
        v_splitter.addWidget(self._uart_panel)
        v_splitter.setStretchFactor(0, 1)
        v_splitter.setStretchFactor(1, 0)
        v_splitter.setSizes([500, 200])

        # Status bar
        self._status = QLabel("Ready")
        self.statusBar().addWidget(self._status)

    # ------------------------------------------------------------------
    # Signal wiring
    # ------------------------------------------------------------------

    def _connect_signals(self) -> None:
        cp = self._conn_panel

        # Connection panel → workers
        cp.gdb_connect_requested.connect(self._start_gdb)
        cp.gdb_disconnect_requested.connect(self._stop_gdb)
        cp.uart_connect_requested.connect(self._start_uart)
        cp.uart_disconnect_requested.connect(self._stop_uart)

        # GDB worker → panels
        gw = self._gdb_worker
        gw.connected.connect(cp.on_gdb_connected)
        gw.connected.connect(lambda: self._exec_panel.set_enabled(True))
        gw.connected.connect(lambda: self._elf_panel.set_enabled(True))
        gw.connected.connect(lambda: gw.request_pc())
        gw.connected.connect(self._on_gdb_connected)
        gw.disconnected.connect(cp.on_gdb_disconnected)
        gw.disconnected.connect(lambda: self._exec_panel.set_enabled(False))
        gw.disconnected.connect(lambda: self._elf_panel.set_enabled(False))
        gw.disconnected.connect(self._on_gdb_disconnected)
        gw.error.connect(self._on_error)
        gw.target_halted.connect(self._exec_panel.on_target_halted)
        gw.target_halted.connect(self._on_target_halted)
        gw.target_running.connect(self._exec_panel.on_target_running)
        gw.target_running.connect(self._on_target_running)
        gw.pc_updated.connect(self._exec_panel.on_pc_updated)
        gw.memory_read.connect(self._mem_panel.on_memory_read)
        gw.memory_written.connect(self._mem_panel.on_memory_written)
        gw.elf_loaded.connect(self._elf_panel.on_loaded)
        gw.elf_loaded.connect(lambda: gw.request_pc())

        # Execution panel → GDB worker
        ep = self._exec_panel
        ep.run_requested.connect(gw.request_run)
        ep.halt_requested.connect(gw.request_halt)
        ep.step_requested.connect(gw.request_step)
        ep.reset_requested.connect(gw.request_reset)

        # ELF panel → GDB worker
        self._elf_panel.load_requested.connect(gw.request_load_elf)

        # Memory panel → GDB worker
        self._mem_panel.read_requested.connect(gw.request_read_mem)
        self._mem_panel.write_requested.connect(gw.request_write_mem)

        # UART worker → terminal panel
        uw = self._uart_worker
        uw.line_received.connect(self._uart_panel.append_line)
        uw.connected.connect(cp.on_uart_connected)
        uw.connected.connect(lambda _port: self._on_uart_connected())
        uw.disconnected.connect(cp.on_uart_disconnected)
        uw.disconnected.connect(self._on_uart_disconnected)
        uw.error.connect(self._on_error)

        # Terminal panel → UART worker
        self._uart_panel.send_requested.connect(self._uart_worker.send)

        # GDB console panel ↔ GDB worker
        gw.console_output.connect(self._gdb_console.append)
        self._gdb_console.command_requested.connect(gw.request_raw_command)

        # Snippets panel → GDB worker (output appears in GDB Console)
        self._snippets_panel.command_requested.connect(gw.request_raw_command)

        # Register map panel ↔ GDB worker
        rp = self._reg_map_panel
        rp.read_requested.connect(gw.request_read_mem)
        rp.write_requested.connect(gw.request_write_mem)
        rp.halt_requested.connect(gw.request_halt)
        gw.memory_read.connect(rp.on_memory_read)
        gw.memory_written.connect(rp.on_memory_written)
        gw.target_halted.connect(rp.on_target_halted)
        gw.target_running.connect(rp.on_target_running)

    # ------------------------------------------------------------------
    # Worker lifecycle
    # ------------------------------------------------------------------

    def _start_gdb(self) -> None:
        if not self._gdb_worker.isRunning():
            self._gdb_worker.start()

    def _stop_gdb(self) -> None:
        if self._gdb_worker.isRunning():
            self._gdb_worker.stop()
            self._gdb_worker.wait(2000)

    def _start_uart(self, port: str, baudrate: int) -> None:
        if not self._uart_worker.isRunning():
            self._uart_worker.set_port(port, baudrate)
            self._uart_worker.start()

    def _stop_uart(self) -> None:
        if self._uart_worker.isRunning():
            self._uart_worker.stop()
            self._uart_worker.wait(2000)

    def _on_error(self, msg: str) -> None:
        self._status.setText(f"Error: {msg}")

    def _on_gdb_connected(self) -> None:
        for a in (self._act_run, self._act_halt, self._act_step, self._act_reset):
            a.setEnabled(True)
        self._act_halt.setEnabled(False)   # nothing running yet

    def _on_gdb_disconnected(self) -> None:
        for a in (self._act_run, self._act_halt, self._act_step, self._act_reset):
            a.setEnabled(False)

    def _on_target_running(self) -> None:
        self._act_run.setEnabled(False)
        self._act_halt.setEnabled(True)
        self._act_step.setEnabled(False)

    def _on_target_halted(self, _pc: int) -> None:
        self._act_run.setEnabled(True)
        self._act_halt.setEnabled(False)
        self._act_step.setEnabled(True)

    # ------------------------------------------------------------------
    # UART import / export
    # ------------------------------------------------------------------

    def _export_uart_text(self) -> None:
        content = self._uart_panel.terminal_text()
        path, _ = QFileDialog.getSaveFileName(
            self, "Export UART Data as text", "uart_data.txt",
            "Text files (*.txt);;All files (*)"
        )
        if not path:
            return
        try:
            Path(path).write_text(content, encoding="utf-8")
            self._status.setText(f"Exported UART text → {Path(path).name}")
        except OSError as exc:
            QMessageBox.critical(self, "Export failed", str(exc))

    def _export_uart_binary(self) -> None:
        content = self._uart_panel.terminal_text()
        path, _ = QFileDialog.getSaveFileName(
            self, "Export UART Data as binary", "uart_data.bin",
            "Binary files (*.bin);;All files (*)"
        )
        if not path:
            return
        try:
            Path(path).write_bytes(content.encode("latin-1", errors="replace"))
            self._status.setText(f"Exported UART binary → {Path(path).name}")
        except OSError as exc:
            QMessageBox.critical(self, "Export failed", str(exc))

    def _import_uart_text(self) -> None:
        path, _ = QFileDialog.getOpenFileName(
            self, "Import text file — send via UART", "",
            "Text files (*.txt *.log *.gdb);;All files (*)"
        )
        if not path:
            return
        try:
            data = Path(path).read_bytes()
            self._status.setText(f"Sending {len(data)} B via UART…")
            self._uart_worker.send_raw(data)
            self._status.setText(f"Sent {Path(path).name} ({len(data)} B) via UART")
        except OSError as exc:
            QMessageBox.critical(self, "Import failed", str(exc))

    def _import_uart_binary(self) -> None:
        path, _ = QFileDialog.getOpenFileName(
            self, "Import binary file — send via UART", "",
            "Binary files (*.bin *.hex *.raw);;All files (*)"
        )
        if not path:
            return
        try:
            data = Path(path).read_bytes()
            self._status.setText(f"Sending {len(data)} B via UART…")
            self._uart_worker.send_raw(data)
            self._status.setText(f"Sent {Path(path).name} ({len(data)} B) via UART")
        except OSError as exc:
            QMessageBox.critical(self, "Import failed", str(exc))

    def _on_uart_connected(self) -> None:
        self._act_imp_text.setEnabled(True)
        self._act_imp_bin.setEnabled(True)

    def _on_uart_disconnected(self) -> None:
        self._act_imp_text.setEnabled(False)
        self._act_imp_bin.setEnabled(False)

    def _show_about(self) -> None:
        AboutDialog(self).exec()

    # ------------------------------------------------------------------
    # Settings persistence
    # ------------------------------------------------------------------

    def _settings(self) -> QSettings:
        return QSettings("DidacticSoC", "SoCDebugger")

    def _save_settings(self) -> None:
        s = self._settings()
        s.setValue("window/geometry",      self.saveGeometry())
        s.setValue("window/h_splitter",    self._h_splitter.saveState())
        s.setValue("uart/port",            self._conn_panel.uart_port())
        s.setValue("uart/baud_index",      self._conn_panel.uart_baud_index())
        s.setValue("uart/custom_baud",     self._conn_panel.uart_custom_baud())

    def _restore_settings(self) -> None:
        s = self._settings()
        geom = s.value("window/geometry")
        if geom:
            self.restoreGeometry(geom)
        h_split = s.value("window/h_splitter")
        if h_split:
            self._h_splitter.restoreState(h_split)
        port = s.value("uart/port", "")
        if port:
            self._conn_panel.set_uart_port(port)
        baud_idx = s.value("uart/baud_index", 0, type=int)
        self._conn_panel.set_uart_baud_index(baud_idx)
        custom_baud = s.value("uart/custom_baud", "")
        if custom_baud:
            self._conn_panel.set_uart_custom_baud(custom_baud)

    # ------------------------------------------------------------------
    # Cleanup
    # ------------------------------------------------------------------

    def closeEvent(self, event) -> None:
        self._save_settings()
        self._stop_gdb()
        self._stop_uart()
        super().closeEvent(event)


# ──────────────────────────────────────────────────────────────────────────────

class AboutDialog(QDialog):
    """Polished About dialog with optional logo images from fpga/debug/assets/."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("About — Didactic SoC Debug GUI")
        self.setMinimumWidth(480)
        self.setModal(True)
        self._build_ui()

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setSpacing(0)
        root.setContentsMargins(0, 0, 0, 0)

        # ── Logo banner ───────────────────────────────────────────────────
        banner = QFrame()
        banner.setStyleSheet("background-color: #ffffff; border-bottom: 1px solid #e2e8f0;")
        banner_layout = QHBoxLayout(banner)
        banner_layout.setContentsMargins(20, 16, 20, 16)
        banner_layout.setSpacing(16)

        for filename in ("E4C_Logo_LARGE_WHITE_BKG_JPG.jpg", "logo.png", "logo.svg"):
            pix = QPixmap(str(_ASSETS / filename))
            if not pix.isNull():
                logo_label = QLabel()
                logo_label.setPixmap(pix.scaledToHeight(64, Qt.TransformationMode.SmoothTransformation))
                banner_layout.addWidget(logo_label)
                break

        title = QLabel("Didactic SoC\nDebug GUI")
        title.setStyleSheet("color: #1e293b; font-size: 20px; font-weight: bold;")
        title.setAlignment(Qt.AlignmentFlag.AlignVCenter | Qt.AlignmentFlag.AlignLeft)
        banner_layout.addWidget(title, stretch=1)

        # Second logo (e.g. university / project partner)
        for filename in ("logo2.png", "logo2.svg"):
            pix = QPixmap(str(_ASSETS / filename))
            if not pix.isNull():
                logo2_label = QLabel()
                logo2_label.setPixmap(pix.scaledToHeight(64, Qt.TransformationMode.SmoothTransformation))
                banner_layout.addWidget(logo2_label)
                break

        root.addWidget(banner)

        # ── Body ─────────────────────────────────────────────────────────
        body = QWidget()
        body.setStyleSheet("background-color: #1e293b;")
        body_layout = QVBoxLayout(body)
        body_layout.setContentsMargins(24, 16, 24, 8)
        body_layout.setSpacing(12)

        def section(title: str, rows: list[tuple[str, str]]) -> QWidget:
            w   = QWidget()
            lay = QVBoxLayout(w)
            lay.setContentsMargins(0, 0, 0, 0)
            lay.setSpacing(4)
            hdr = QLabel(title)
            hdr.setStyleSheet("font-weight: bold; font-size: 11px; color: #64748b; background: transparent;")
            lay.addWidget(hdr)
            for label, value in rows:
                row     = QHBoxLayout()
                lbl_key = QLabel(label)
                lbl_key.setStyleSheet("color: #94a3b8; background: transparent;")
                lbl_key.setFixedWidth(130)
                lbl_val = QLabel(value)
                lbl_val.setStyleSheet("color: #f1f5f9; background: transparent;")
                lbl_val.setWordWrap(True)
                row.addWidget(lbl_key)
                row.addWidget(lbl_val, stretch=1)
                lay.addLayout(row)
            return w

        body_layout.addWidget(section("PROJECT", [
            ("Platform",    "PYNQ-Z1 / PYNQ-Z2 (Zynq-7020)"),
            ("Target CPU",  "RISC-V RV32IMC"),
            ("Debug",       "OpenOCD + GDB/MI over JTAG (FT4232H)"),
        ]))

        sep = QFrame()
        sep.setFrameShape(QFrame.Shape.HLine)
        sep.setStyleSheet("color: #334155;")
        body_layout.addWidget(sep)

        body_layout.addWidget(section("CLOCK & UART", [
            ("FPGA clock",  "25 MHz  (PLL: 125 MHz ÷ 5 × 33 ÷ 33)"),
            ("FPGA baud",   "57 600  (divisor = 27)"),
            ("ASIC clock",  "100 MHz"),
            ("ASIC baud",   "230 400  (divisor = 27)"),
        ]))

        sep2 = QFrame()
        sep2.setFrameShape(QFrame.Shape.HLine)
        sep2.setStyleSheet("color: #334155;")
        body_layout.addWidget(sep2)

        body_layout.addWidget(section("MEMORY MAP", [
            ("IMEM",        "0x01000000  (4 KB, instruction memory)"),
            ("DMEM",        "0x01010000  (4 KB, data memory)"),
            ("GPIO",        "0x01030000"),
            ("UART",        "0x01030100"),
            ("SPI",         "0x01030200"),
            ("SoC Control", "0x01040000"),
        ]))

        root.addWidget(body)

        # ── Button box ───────────────────────────────────────────────────
        btn_area = QWidget()
        btn_area.setStyleSheet("background-color: #1e293b;")
        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok)
        buttons.accepted.connect(self.accept)
        btn_root = QHBoxLayout(btn_area)
        btn_root.setContentsMargins(24, 8, 24, 16)
        btn_root.addStretch()
        btn_root.addWidget(buttons)
        root.addWidget(btn_area)
