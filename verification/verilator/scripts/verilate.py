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
]

# TODO: maybe add explicit clock?
VERILATOR_OTHER_ARGUMENTS = [
    "--top-module", "Didactic",
    "+define+RVFI",
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
    executable = arguments["executable"]
    if executable is None or len(executable) == 0:
        executable = "example"
        print(f"executable not given, selecting default: {executable}", color=Fore.YELLOW)
    else:
        print(f"executable given: {executable}", color=Fore.GREEN)
    executable = Path(f"./verification/verilator/src/sw/{executable}.cpp").resolve()
    if not executable.exists():
        print(f"path to executable does not exist: {executable}", color=Fore.RED)
        return False
    if not executable.is_file():
        print(f"path to executable is not a file: {executable}", color=Fore.RED)
        return False

    verilator_arguments.extend([
        "--cc",
        "--exe",
        "--trace",
        str(executable),
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
        help="translate HDL into SW and combine with executable",
    )
    parser_verilate.add_argument("executable", nargs="?")
    arguments = vars(parser.parse_args())

    files_from_bender = get_files_from_bender()
    if files_from_bender is None:
        exit(-1)

    verilator_arguments = [
        "verilator",
    ]
    verilator_arguments.extend(files_from_bender)
    verilator_arguments.extend(VERILATOR_INCLUDES)
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
