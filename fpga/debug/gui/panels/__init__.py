# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gui/panels/__init__.py
# Description  : Package initializer; exports all panel widgets:
#                ConnectionPanel, UartTerminalPanel, ElfLoaderPanel,
#                ExecutionPanel, MemoryPanel, GdbConsolePanel,
#                RegisterMapPanel, GdbSnippetsPanel.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from .connection import ConnectionPanel
from .uart_terminal import UartTerminalPanel
from .elf_loader import ElfLoaderPanel
from .execution import ExecutionPanel
from .memory import MemoryPanel
from .gdb_console import GdbConsolePanel
from .register_map_panel import RegisterMapPanel
from .gdb_snippets_panel import GdbSnippetsPanel
from .disassembly_panel import DisassemblyPanel

__all__ = [
    "ConnectionPanel", "UartTerminalPanel",
    "ElfLoaderPanel", "ExecutionPanel", "MemoryPanel",
    "GdbConsolePanel", "RegisterMapPanel", "GdbSnippetsPanel",
    "DisassemblyPanel",
]
