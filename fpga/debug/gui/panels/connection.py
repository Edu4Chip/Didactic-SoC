# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/connection.py
# Description  : ConnectionPanel — monitors OpenOCD process state, manages GDB
#                and UART connection lifecycle, and provides baud rate selection
#                with FTDI port auto-detection.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import subprocess
from pathlib import Path
from PySide6.QtCore import Qt, QTimer, Signal
from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QLabel, QPushButton,
    QLineEdit, QGroupBox, QComboBox, QFileDialog,
)
from debugger.gdb import is_openocd_running
from debugger.uart import UartMonitor

# (label, baud) — None baud means "Custom"
_BAUD_PRESETS = [
    ("57600  — FPGA 25 MHz",    57_600),
    ("230400 — ASIC 100 MHz",  230_400),
    ("115200",                 115_200),
    ("460800",                 460_800),
    ("921600",                 921_600),
    ("9600",                     9_600),
    ("Custom",                    None),
]

_OPENOCD_BIN  = str(Path.home() / ".local" / "bin" / "openocd")
_OPENOCD_CFG  = str(Path(__file__).resolve().parents[3] / "utils" / "openocd-didactic.cfg")

_DOT_GREEN = "color: #22c55e; font-size: 18px;"
_DOT_RED   = "color: #ef4444; font-size: 18px;"


class ConnectionPanel(QGroupBox):
    """Monitors OpenOCD, GDB, and UART connection state.

    Emits:
        gdb_connect_requested()
        gdb_disconnect_requested()
        uart_connect_requested(port, baudrate)
        uart_disconnect_requested()
    """

    gdb_connect_requested    = Signal()
    gdb_disconnect_requested = Signal()
    uart_connect_requested   = Signal(str, int)
    uart_disconnect_requested = Signal()

    def __init__(self, parent=None):
        super().__init__("Connection", parent)
        self._openocd_proc = None
        self._gdb_connected  = False
        self._uart_connected = False
        self._build_ui()
        self._start_openocd_poll()

    # ------------------------------------------------------------------
    # Build UI
    # ------------------------------------------------------------------

    def _build_ui(self) -> None:
        root = QVBoxLayout(self)
        root.setSpacing(6)

        # OpenOCD row
        ocd_row = QHBoxLayout()
        self._ocd_dot = QLabel("●")
        self._ocd_dot.setStyleSheet(_DOT_RED)
        self._ocd_label = QLabel("OpenOCD — not running")
        self._btn_start_ocd = QPushButton("Start OpenOCD")
        self._btn_start_ocd.clicked.connect(self._start_openocd)
        ocd_row.addWidget(self._ocd_dot)
        ocd_row.addWidget(self._ocd_label, stretch=1)
        ocd_row.addWidget(self._btn_start_ocd)
        root.addLayout(ocd_row)

        # OpenOCD binary / config (shown when starting manually)
        self._ocd_cfg_edit = QLineEdit(_OPENOCD_CFG)
        self._ocd_cfg_edit.setPlaceholderText("OpenOCD config file…")
        self._ocd_bin_edit = QLineEdit(_OPENOCD_BIN)
        self._ocd_bin_edit.setPlaceholderText("openocd binary…")
        cfg_row = QHBoxLayout()
        cfg_row.addWidget(QLabel("Cfg:"))
        cfg_row.addWidget(self._ocd_cfg_edit, stretch=1)
        btn_cfg = QPushButton("…")
        btn_cfg.setFixedWidth(28)
        btn_cfg.clicked.connect(self._browse_cfg)
        cfg_row.addWidget(btn_cfg)
        root.addLayout(cfg_row)

        # GDB row
        gdb_row = QHBoxLayout()
        self._gdb_dot = QLabel("●")
        self._gdb_dot.setStyleSheet(_DOT_RED)
        self._gdb_label = QLabel("GDB — disconnected")
        self._btn_gdb = QPushButton("Connect GDB")
        self._btn_gdb.setEnabled(False)
        self._btn_gdb.clicked.connect(self._toggle_gdb)
        gdb_row.addWidget(self._gdb_dot)
        gdb_row.addWidget(self._gdb_label, stretch=1)
        gdb_row.addWidget(self._btn_gdb)
        root.addLayout(gdb_row)

        # UART row
        uart_row = QHBoxLayout()
        self._uart_dot = QLabel("●")
        self._uart_dot.setStyleSheet(_DOT_RED)
        self._port_combo = QComboBox()
        self._port_combo.setMinimumWidth(120)
        self._btn_refresh_ports = QPushButton("↺")
        self._btn_refresh_ports.setFixedWidth(28)
        self._btn_refresh_ports.clicked.connect(self._refresh_ports)
        self._btn_uart = QPushButton("Connect")
        self._btn_uart.clicked.connect(self._toggle_uart)
        uart_row.addWidget(self._uart_dot)
        uart_row.addWidget(self._port_combo, stretch=1)
        uart_row.addWidget(self._btn_refresh_ports)
        uart_row.addWidget(self._btn_uart)
        root.addLayout(uart_row)

        # Baud rate row
        baud_row = QHBoxLayout()
        baud_row.addWidget(QLabel("Baud:"))
        self._baud_combo = QComboBox()
        for label, baud in _BAUD_PRESETS:
            self._baud_combo.addItem(label, userData=baud)
        self._baud_combo.currentIndexChanged.connect(self._on_baud_changed)
        self._baud_custom = QLineEdit()
        self._baud_custom.setPlaceholderText("baud rate")
        self._baud_custom.setFixedWidth(90)
        self._baud_custom.setVisible(False)
        baud_row.addWidget(self._baud_combo, stretch=1)
        baud_row.addWidget(self._baud_custom)
        root.addLayout(baud_row)

        self._refresh_ports()

    # ------------------------------------------------------------------
    # OpenOCD polling
    # ------------------------------------------------------------------

    def _start_openocd_poll(self) -> None:
        self._poll_timer = QTimer(self)
        self._poll_timer.timeout.connect(self._check_openocd)
        self._poll_timer.start(1000)

    def _check_openocd(self) -> None:
        running = is_openocd_running()
        if running:
            self._ocd_dot.setStyleSheet(_DOT_GREEN)
            self._ocd_label.setText("OpenOCD — running (port 3333)")
            self._btn_start_ocd.setEnabled(False)
            self._btn_gdb.setEnabled(True)
        else:
            self._ocd_dot.setStyleSheet(_DOT_RED)
            self._ocd_label.setText("OpenOCD — not running")
            self._btn_start_ocd.setEnabled(True)
            self._btn_gdb.setEnabled(False)

    def _start_openocd(self) -> None:
        binary = self._ocd_bin_edit.text().strip()
        cfg    = self._ocd_cfg_edit.text().strip()
        try:
            self._openocd_proc = subprocess.Popen(
                [binary, "-f", cfg],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            self._btn_start_ocd.setEnabled(False)
            self._ocd_label.setText("OpenOCD — starting…")
        except Exception as exc:
            self._ocd_label.setText(f"Failed to start: {exc}")

    def _browse_cfg(self) -> None:
        path, _ = QFileDialog.getOpenFileName(
            self, "OpenOCD config", "", "Config files (*.cfg);;All files (*)"
        )
        if path:
            self._ocd_cfg_edit.setText(path)

    # ------------------------------------------------------------------
    # GDB toggle
    # ------------------------------------------------------------------

    def _toggle_gdb(self) -> None:
        if self._gdb_connected:
            self.gdb_disconnect_requested.emit()
        else:
            self.gdb_connect_requested.emit()

    def on_gdb_connected(self) -> None:
        self._gdb_connected = True
        self._gdb_dot.setStyleSheet(_DOT_GREEN)
        self._gdb_label.setText("GDB — connected")
        self._btn_gdb.setText("Disconnect GDB")

    def on_gdb_disconnected(self) -> None:
        self._gdb_connected = False
        self._gdb_dot.setStyleSheet(_DOT_RED)
        self._gdb_label.setText("GDB — disconnected")
        self._btn_gdb.setText("Connect GDB")

    # ------------------------------------------------------------------
    # UART toggle
    # ------------------------------------------------------------------

    def _refresh_ports(self) -> None:
        self._port_combo.clear()
        ports = UartMonitor.ftdi_ports() or UartMonitor.list_ports()
        for device, desc in ports:
            self._port_combo.addItem(f"{device}  —  {desc}", userData=device)

    def _on_baud_changed(self) -> None:
        is_custom = self._baud_combo.currentData() is None
        self._baud_custom.setVisible(is_custom)

    def _selected_baud(self) -> int:
        baud = self._baud_combo.currentData()
        if baud is None:
            try:
                return int(self._baud_custom.text().strip())
            except ValueError:
                return 57_600
        return baud

    def _toggle_uart(self) -> None:
        if self._uart_connected:
            self.uart_disconnect_requested.emit()
        else:
            port = self._port_combo.currentData() or self._port_combo.currentText()
            if port:
                self.uart_connect_requested.emit(port.strip(), self._selected_baud())

    def on_uart_connected(self, port: str) -> None:
        self._uart_connected = True
        self._uart_dot.setStyleSheet(_DOT_GREEN)
        self._btn_uart.setText("Disconnect")

    def on_uart_disconnected(self) -> None:
        self._uart_connected = False
        self._uart_dot.setStyleSheet(_DOT_RED)
        self._btn_uart.setText("Connect")

    # ------------------------------------------------------------------
    # Settings helpers (used by MainWindow / QSettings)
    # ------------------------------------------------------------------

    def uart_port(self) -> str:
        return self._port_combo.currentData() or self._port_combo.currentText()

    def uart_baud_index(self) -> int:
        return self._baud_combo.currentIndex()

    def uart_custom_baud(self) -> str:
        return self._baud_custom.text()

    def set_uart_port(self, port: str) -> None:
        for i in range(self._port_combo.count()):
            if self._port_combo.itemData(i) == port:
                self._port_combo.setCurrentIndex(i)
                return
        # Device not in current list — add a placeholder so it is pre-selected
        # if the device appears after a port refresh.
        self._port_combo.insertItem(0, port, userData=port)
        self._port_combo.setCurrentIndex(0)

    def set_uart_baud_index(self, index: int) -> None:
        if 0 <= index < self._baud_combo.count():
            self._baud_combo.setCurrentIndex(index)

    def set_uart_custom_baud(self, text: str) -> None:
        self._baud_custom.setText(text)
