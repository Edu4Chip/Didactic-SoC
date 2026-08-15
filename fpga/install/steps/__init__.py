# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/__init__.py
# Description  : Package re-exports for all Step subclasses; the single import
#                point used by install.py and any GUI wizard front-end.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from .base import Step, ProgressCallback
from .links import (
    OPENOCD_REPO, OPENOCD_COMMIT, OPENOCD_RULES_URL,
    TOOLCHAIN_URL_TEMPLATE, TOOLCHAIN_DEFAULT_RELEASE,
    PYNQ_BOARDS,
)
from .prerequisites import PrerequisitesStep
from .openocd import OpenOCDStep
from .openocd_config import OpenOCDConfigStep
from .toolchain import ToolchainStep
from .udev_rules import UdevRulesStep
from .path import PathStep
from .board import BoardStep
from .debugger import DebuggerStep
from .vivado_boards import VivadoBoardsStep

__all__ = [
    "Step",
    "ProgressCallback",
    "PrerequisitesStep",
    "OpenOCDStep",
    "OpenOCDConfigStep",
    "ToolchainStep",
    "UdevRulesStep",
    "PathStep",
    "BoardStep",
    "DebuggerStep",
    "VivadoBoardsStep",
]
