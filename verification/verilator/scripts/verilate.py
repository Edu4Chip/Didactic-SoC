#!/usr/bin/env python3

"""Run Verilator with given task

# How to use?

`verilate.py --help`
"""

import argparse
import subprocess
from typing import List, Optional, Dict, Any
from pathlib import Path

from colorama import Fore

from print import print

# FIXME: make bender filelists work
MANUAL_FILES = [
    "-I./.bender/git/checkouts/riscv-dbg-0a8f5dd79750e659/src/",
    "-I./.bender/git/checkouts/riscv-dbg-0a8f5dd79750e659/debug_rom/",
    "./.bender/git/checkouts/riscv-dbg-0a8f5dd79750e659/src/dm_pkg.sv",

    "-I./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/",
    "-I./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/include/",
    "-I./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/deprecated/",
    "./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/cf_math_pkg.sv",
    # File name does not correspond to module name
    "./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/cdc_4phase.sv",
    "./.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/cdc_reset_ctrlr_pkg.sv",

    "-I./.bender/git/checkouts/obi-cbdec09f22f66762/src/",
    "-I./.bender/git/checkouts/obi-cbdec09f22f66762/include/",
    "./.bender/git/checkouts/obi-cbdec09f22f66762/src/obi_pkg.sv",
    "./.bender/git/checkouts/obi-cbdec09f22f66762/src/obi_intf.sv",
    # File name does not correspond to module name
    "./.bender/git/checkouts/obi-cbdec09f22f66762/src/obi_xbar.sv",

    "./.bender/git/checkouts/apb-e4460f86c75afc6a/src/apb_pkg.sv",
    "./.bender/git/checkouts/apb-e4460f86c75afc6a/src/apb_intf.sv",

    # File name does not correspond to module name
    "./.bender/git/checkouts/tech_cells_generic-c6f7639ae8d3c67d/src/rtl/tc_clk.sv",

    "-I./.bender/git/checkouts/apb_uart-82e60c3a7ada9dd1/src/",

    "-I./.bender/git/checkouts/apb_gpio-f882c1c8a370562e/rtl/",

    "-I./vendor_ips/ibex/rtl/",
    "-I./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/",
    "-I./vendor_ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils/",
    "-I./vendor_ips/ibex/dv/uvm/core_ibex/common/prim/",
    "-I./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim_generic/rtl/",
    "./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_cipher_pkg.sv",
    "./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_util_pkg.sv",
    "./vendor_ips/ibex/rtl/ibex_pkg.sv",
    "./vendor_ips/ibex/rtl/ibex_tracer_pkg.sv",
    "./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_secded_pkg.sv",
    "./vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_ram_1p_pkg.sv",
    "./vendor_ips/ibex/dv/uvm/core_ibex/common/prim/prim_pkg.sv",

    "-I./vendor_ips/apb_spi_master/",
    "-I./vendor_ips/axi_spi_master/",

    "-I./src/generated/",
    "-I./src/rtl/",
    "-I./src/reuse/",
    "-I./src/tech_generic/",
    "./src/generated/Didactic.v",
    # File name does not correspond to module name
    "./src/tech_generic/io_cell.sv",
]

# FIXME: make bender filelists work
BENDER_ARGUMENTS = [
    "bender",
    "script",
    "verilator",
    "--target", "rtl",
    "--target", "synthesis",
    "--target", "vendor",
    "--target", "didactic_obi",
    "--target", "tracer",
]

VERILATOR_INCLUDES = [
    "-Ivendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/",
    "-Ivendor_ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils/",
    "-Ivendor_ips/ibex/rtl/",
    "-Ivendor_ips/ibex/syn/rtl/",
]

VERILATOR_SUPPRESSIONS = [
    "-Wno-REDEFMACRO",
    "-Wno-PINMISSING",
    "-Wno-WIDTHEXPAND",
    "-Wno-WIDTHTRUNC",
    "-Wno-ASCRANGE",
    "-Wno-IMPLICIT",
    "-Wno-MODDUP",
    "-Wno-UNOPTFLAT",
    "-Wno-NOLATCH",
    "-Wno-COMBDLY",
    "-Wno-CASEINCOMPLETE",
    "-Wno-UNSIGNED",
    "-Wno-CMPCONST",
    "-Wno-MULTIDRIVEN",
    # TODO: this error might be important to fix
    "-Wno-BLKANDNBLK",
    # TODO: following file fails without this option: .bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/addr_decode_dync.sv
    "-Wno-STMTDLY",
]

# TODO: maybe add explicit clock?
VERILATOR_OTHER_ARGUMENTS = [
    "--top-module", "Didactic",
    "+define+RVFI",
    # TODO: following file fails without this option: .bender/git/checkouts/common_cells-3bd5b2d671aaec0e/src/addr_decode_dync.sv
    "--no-timing",
]

def get_files_from_bender() -> Optional[List[str]]:
    result = subprocess.run(BENDER_ARGUMENTS, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"{result.stderr}")
        return None
    files = result.stdout.splitlines()
    return files

def execute_lint(arguments: Dict[str, Any], verilator_arguments: List[str]) -> bool:
    verilator_arguments.extend([
        "--lint-only",
        "-Wall",
    ])
    result = subprocess.run(verilator_arguments, capture_output=True, text=True)
    print(result.stdout)
    print(result.stderr)
    if result.returncode == 0:
        print(f"ok")
        return True
    else:
        print(f"fail")
        return False

def execute_json(arguments: Dict[str, Any], verilator_arguments: List[str]) -> bool:
    verilator_arguments.extend([
        "--json-only",
    ])
    verilator_arguments.extend(VERILATOR_SUPPRESSIONS)
    result = subprocess.run(verilator_arguments, capture_output=True, text=True)
    print(result.stdout)
    print(result.stderr)
    if result.returncode == 0:
        print(f"ok")
        return True
    else:
        print(f"fail")
        return False

def execute_verilate(arguments: Dict[str, Any], verilator_arguments: List[str]) -> bool:
    testcase = arguments["testcase"]
    if testcase is None or len(testcase) == 0:
        testcase = "example"
        print(f"testcase not given, selecting default: {testcase}", color=Fore.YELLOW)
    else:
        print(f"testcase given: {testcase}", color=Fore.GREEN)
    testcase_root = Path(f"./verification/verilator/testcases/{testcase}").resolve()
    testcase_main = testcase_root / "main.cpp"
    testcase_patches = testcase_root / "patches.patch"
    if not testcase_main.exists():
        print(f"path to testcase does not exist: {testcase_main}", color=Fore.RED)
        return False
    if not testcase_main.is_file():
        print(f"path to testcase is not a file: {testcase_main}", color=Fore.RED)
        return False
    if testcase_patches.exists():
        if not testcase_patches.is_file():
            print(f"path to testcase patches is not a file: {testcase_patches}", color=Fore.RED)
            return False
        patch_arguments = [
            "patch",
            "--strip=0",
            f"--input={testcase_patches}",
        ]
        result = subprocess.run(patch_arguments, capture_output=True, text=True)
        if result.stdout.strip():
            print(result.stdout)
        if result.stderr.strip():
            print(result.stderr)
        if result.returncode == 0:
            print(f"patch ok")
        else:
            print(f"patch failed")
            return False
    else:
        print(f"path to testcase patches does not exist: {testcase_patches}", color=Fore.YELLOW)
        print(f"patching is not executed", color=Fore.YELLOW)
    verilator_arguments.extend([
        "--cc",
        "--exe",
        "--trace",
        str(testcase_main),
    ])
    verilator_arguments.extend(VERILATOR_SUPPRESSIONS)
    result = subprocess.run(verilator_arguments, capture_output=True, text=True)
    print(result.stdout)
    print(result.stderr)
    if result.returncode == 0:
        print(f"ok")
        return True
    else:
        print(f"fail")
        return False

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="run verilator with given task",
    )
    subparsers = parser.add_subparsers(dest="action", required=True)
    parser_lint = subparsers.add_parser(
        "lint",
        help="run linter and print warnings and errors",
    )
    parser_json = subparsers.add_parser(
        "json",
        help="output abstract syntax tree in json",
    )
    parser_verilate = subparsers.add_parser(
        "verilate",
        help="apply patches, translate HDL into SW and combine with testcase executable",
    )
    parser_verilate.add_argument("testcase", nargs="?")
    arguments = vars(parser.parse_args())

    # FIXME: make bender filelists work
    #files_from_bender = get_files_from_bender()
    #if files_from_bender is None:
    #    exit(-1)

    verilator_arguments = [
        "verilator",
    ]
    verilator_arguments.extend(MANUAL_FILES)
    # FIXME: make bender filelists work
    #verilator_arguments.extend(files_from_bender)
    #verilator_arguments.extend(VERILATOR_INCLUDES)
    verilator_arguments.extend(VERILATOR_OTHER_ARGUMENTS)
    match arguments["action"]:
        case "lint":
            ok = execute_lint(arguments, verilator_arguments)
        case "json":
            ok = execute_json(arguments, verilator_arguments)
        case "verilate":
            ok = execute_verilate(arguments, verilator_arguments)
        case other:
            print(f"unknown action: {other}", color=Fore.RED)
            ok = False
    if not ok:
        exit(-1)
