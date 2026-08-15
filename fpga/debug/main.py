#!/usr/bin/env python3
# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/main.py
# Description  : Application entry point; creates QApplication, instantiates
#                MainWindow, and starts the Qt event loop.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import sys
from PySide6.QtWidgets import QApplication
from gui.main_window import MainWindow


def main() -> None:
    app = QApplication(sys.argv)
    app.setApplicationName("Didactic SoC Debugger")
    window = MainWindow()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
