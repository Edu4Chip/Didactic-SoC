# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/workers/__init__.py
# Description  : Package initializer; exports GdbWorker and UartWorker.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from .gdb_worker import GdbWorker
from .uart_worker import UartWorker

__all__ = ["GdbWorker", "UartWorker"]
