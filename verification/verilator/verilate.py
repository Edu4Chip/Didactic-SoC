import subprocess as sp
from copy import deepcopy
from typing import List
from pathlib import Path

from colorama import Fore, Style


class Testcase:
    def __init__(self, path: str) -> None:
        self.path = Path(path)


VERILATOR_DIR = Path(__file__).parent
TESTCASES_DIR = VERILATOR_DIR / "src"
TESTCASES: List[Testcase] = [
    Testcase("example"),
]
VERILATOR_CONFIG_PATH = VERILATOR_DIR / "verilate.vlt"
VERILATOR_ARGS = [
    "verilator",
    "--trace-vcd",
    "--cc",
    "--exe",
    "--top-module",
    "Didactic",
    "+define+RVFI",
    "+define+COMMON_CELLS_ASSERTS_OFF",
    str(VERILATOR_CONFIG_PATH),
]
MANUAL_FILES = [
    # This has to be selected explicitely, otherwise verilator crashes...
    "./src/rtl/sp_sram.sv",
    "-I./src/reuse/",
    "./.bender/git/checkouts/obi-cbdec09f22f66762/src/obi_xbar.sv",
    "-I./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim_generic/rtl/",
    "-I./vendor_ips/ibex/dv/uvm/core_ibex/common/prim/",
    "-I./vendor_ips/ibex/syn/rtl/",
    "./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_secded_pkg.sv",
    "./vendor_ips/ibex/rtl/ibex_pkg.sv",
    "./vendor_ips/ibex/rtl/ibex_dummy_instr.sv",
    "-I./vendor_ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils/",
    "-I./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/",
    "-I./vendor_ips/ibex/rtl/",
    "./src/tech_generic/io_cell.sv",
    "-I./src/tech_generic/",
    "./.bender/git/checkouts/tech_cells_generic-c6f7639ae8d3c67d/src/rtl/tc_clk.sv",
    "-I./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/deprecated/",
    "-I./.bender/git/checkouts/riscv-dbg-0a8f5dd79750e659/debug_rom/",
    "./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/cdc_4phase.sv",
    "./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/cdc_reset_ctrlr_pkg.sv",
    "-I./.bender/git/checkouts/riscv-dbg-0a8f5dd79750e659/src/",
    "-I./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/include/",
    "-I./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/",
    "-I./.bender/git/checkouts/obi-cbdec09f22f66762/src/",
    "./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_ram_1p_pkg.sv",
    "./.bender/git/checkouts/riscv-dbg-0a8f5dd79750e659/src/dm_pkg.sv",
    "./.bender/git/checkouts/apb-e4460f86c75afc6a/src/apb_pkg.sv",
    "./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/cf_math_pkg.sv",
    "./.bender/git/checkouts/apb-e4460f86c75afc6a/src/apb_intf.sv",
    "./.bender/git/checkouts/obi-cbdec09f22f66762/src/obi_pkg.sv",
    "./.bender/git/checkouts/obi-cbdec09f22f66762/src/obi_intf.sv",
    "-I./.bender/git/checkouts/obi-cbdec09f22f66762/include/",
    "-I./src/rtl/",
    "-I./.bender/git/checkouts/apb_uart-82e60c3a7ada9dd1/src/",
    "-I./vendor_ips/axi_spi_master/",
    "-I./vendor_ips/apb_spi_master/",
    "-I./.bender/git/checkouts/apb_gpio-f882c1c8a370562e/rtl/",
    "-I./src/generated/",
    "./src/generated/Didactic.v",
]


def main():
    succeeded: List[int] = list()
    for i, tc in enumerate(TESTCASES):
        path_full = TESTCASES_DIR / tc.path / "main.cpp"
        p1 = deepcopy(VERILATOR_ARGS)
        p1.extend(MANUAL_FILES)
        p1.append(str(path_full))
        p2 = "make --directory=./obj_dir --makefile=VDidactic.mk".split(" ")
        p3 = "./obj_dir/VDidactic +trace".split(" ")
        r1 = sp.run(p1)
        if r1.returncode == 0:
            r2 = sp.run(p2)
            if r2.returncode == 0:
                r3 = sp.run(p3)
                if r3.returncode == 0:
                    print(Fore.GREEN + f"[test {i + 1}] OK" + Style.RESET_ALL)
                    succeeded.append(i)
                else:
                    print(Fore.RED + f"[test {i + 1}] FAIL" + Style.RESET_ALL)
            else:
                print(Fore.RED + f"[test {i + 1}] FAIL" + Style.RESET_ALL)
        else:
            print(Fore.RED + f"[test {i + 1}] FAIL" + Style.RESET_ALL)
    if len(succeeded) == len(TESTCASES):
        print(Fore.GREEN + f"{len(succeeded)}/{len(TESTCASES)} succeeded" + Style.RESET_ALL)
    else:
        print(Fore.RED + f"{len(succeeded)}/{len(TESTCASES)} succeeded" + Style.RESET_ALL)


if __name__ == "__main__":
    main()
