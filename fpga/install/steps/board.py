# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/board.py
# Description  : BoardStep — prints JTAG wiring tables and board-specific
#                connection notes for PYNQ-Z1, PYNQ-Z2, and Basys3 as the
#                final step of the installation.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
from .base import Step, ProgressCallback

# Signal | FPGA Pin | Z1 connector | Z2 connector
_JTAG = [
    ("TDI", "T14", "CK_IO_0",  "ARI_00"),
    ("TDO", "U12", "CK_IO_1",  "ARI_01"),
    ("TMS", "V13", "CK_IO_3",  "ARI_03"),
    ("TCK", "Y7",  "CK_IO_37", "RPI_024"),
]

_UART = [
    ("RX", "V15", "CK_IO_4", "ARI_04"),
    ("TX", "T15", "CK_IO_5", "ARI_05"),
]

# Board-specific Vivado project name and OpenOCD config path
_BOARD_CFG = {
    "z1":     {"project": "z1",     "openocd": "fpga/utils/openocd-didactic.cfg"},
    "z2":     {"project": "z2",     "openocd": "fpga/utils/openocd-didactic.cfg"},
    "basys3": {"project": "basys3", "openocd": "fpga/utils/openocd-didactic-vjtag.cfg"},
}


class BoardStep(Step):
    title = "Board Summary"
    description = "Show wiring and usage commands for the selected board"

    def __init__(self, board: str):
        self.board = board.lower()

    def check(self) -> bool:
        return False  # always display the summary

    def run(self, log: ProgressCallback) -> bool:
        cfg = _BOARD_CFG.get(self.board, _BOARD_CFG["z1"])

        log("info", f"Board : {self.board.upper()}")
        log("info", "")
        log("info", f"{'Signal':<8} {'FPGA Pin':<10} {'Z1 (CK_IO)':<14} {'Z2 (ARI/RPI)'}")
        log("info", "-" * 50)
        log("info", "JTAG")
        for sig, pin, z1, z2 in _JTAG:
            log("info", f"  {sig:<6} {pin:<10} {z1:<14} {z2}")
        log("info", "UART")
        for sig, pin, z1, z2 in _UART:
            log("info", f"  {sig:<6} {pin:<10} {z1:<14} {z2}")

        log("info", "")
        log("info", "Build bitstream:")
        log("info", f"  make -C fpga all_xilinx PROJECT={cfg['project']}")
        log("info", "")
        log("info", "Start OpenOCD (run in a separate terminal):")
        log("info", f"  openocd -f {cfg['openocd']}")
        log("info", "")
        log("info", "Load a program onto the board:")
        log("info", "  make -C fpga load_elf TEST=blinky")

        return True
