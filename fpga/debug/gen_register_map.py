#!/usr/bin/env python3
# =============================================================================
# Project      : DidacticSoC
# File         : fpga/debug/gen_register_map.py
# Description  : Parses sw/common/*.h C headers to extract memory-mapped
#                register definitions and writes register_map.json; can be run
#                standalone or imported and called from the GUI.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================

import re
import json
from pathlib import Path
from collections import defaultdict

_THIS        = Path(__file__).resolve()
_HEADERS_DIR = _THIS.parents[2] / "sw" / "common"
_OUTPUT      = _THIS.parent / "register_map.json"

# Human-readable names for known base addresses
_PERIPHERAL_NAMES = {
    0x01000000: "IMEM",
    0x01010000: "DMEM",
    0x01030000: "GPIO",
    0x01030100: "UART",
    0x01030200: "SPI",
    0x01040000: "SoC Control",
}

# Each peripheral occupies at most this many bytes (used for range matching)
_PERIPHERAL_SPAN = 0x1000

# Override access type for registers whose names contain these substrings
_ACCESS_OVERRIDES = {
    "LSR":    "R",
    "MSR":    "R",
    "IIR":    "R",
    "PAD_IN": "R",
    "RXFIFO": "R",
    "INTSTA": "R",
    "TXFIFO": "W",
}


# ---------------------------------------------------------------------------
# Header parser
# ---------------------------------------------------------------------------

def _parse_header(path: Path) -> list[tuple[str, int]]:
    """Return [(reg_name, absolute_address), ...] found in a single header."""
    text = path.read_text(errors="replace")

    # Pass 1: collect simple numeric #defines (constants and base addresses)
    constants: dict[str, int] = {}
    for m in re.finditer(
        r'^\s*#define\s+(\w+)\s+(0x[0-9a-fA-F]+[uUlL]*|\d+[uUlL]*)\s*(?://.*)?$',
        text, re.MULTILINE
    ):
        try:
            val_str = re.sub(r'[uUlL]+$', '', m.group(2))
            constants[m.group(1)] = int(val_str, 0)
        except ValueError:
            pass

    # Pass 2: collect memory-mapped register #defines
    #   #define NAME *( [volatile] uint32_t* )(expr)
    reg_re = re.compile(
        r'^\s*#define\s+(\w+)\s+\*\s*\(\s*(?:volatile\s+)?uint32_t\s*\*\s*\)\s*\(([^)\n]+)\)',
        re.MULTILINE,
    )
    registers: list[tuple[str, int]] = []
    for m in reg_re.finditer(text):
        addr = _eval_expr(m.group(2).strip(), constants)
        if addr is not None:
            registers.append((m.group(1), addr))

    return registers


def _eval_expr(expr: str, constants: dict[str, int]) -> int | None:
    """Evaluate a simple C address expression to an integer."""
    # strip C integer suffixes (u, U, l, L) and whitespace
    expr = re.sub(r'[uUlL]+$', '', expr.strip()).strip()

    # bare hex / decimal literal
    try:
        return int(expr, 0)
    except ValueError:
        pass

    # CONST + literal  (e.g. SPI_BASE + 0x04u)
    m = re.fullmatch(r'(\w+)\s*\+\s*(0x[0-9a-fA-F]+[uUlL]*|\d+[uUlL]*)', expr)
    if m:
        base = constants.get(m.group(1))
        if base is not None:
            offset_str = re.sub(r'[uUlL]+$', '', m.group(2))
            return base + int(offset_str, 0)

    # CONST1 + CONST2  (e.g. CTRL_BASE + RST_OFFSET)
    m = re.fullmatch(r'(\w+)\s*\+\s*(\w+)', expr)
    if m:
        a = constants.get(m.group(1))
        b = constants.get(m.group(2))
        if a is not None and b is not None:
            return a + b

    # bare constant name
    return constants.get(expr)


# ---------------------------------------------------------------------------
# Grouping
# ---------------------------------------------------------------------------

def _peripheral_base(addr: int) -> int | None:
    bases = sorted(_PERIPHERAL_NAMES.keys(), reverse=True)
    for base in bases:
        if base <= addr < base + _PERIPHERAL_SPAN:
            return base
    return None


def _access_for(name: str) -> str:
    for fragment, access in _ACCESS_OVERRIDES.items():
        if fragment in name:
            return access
    return "R/W"


# ---------------------------------------------------------------------------
# Main generator
# ---------------------------------------------------------------------------

def generate(
    headers_dir: Path = _HEADERS_DIR,
    output: Path = _OUTPUT,
) -> dict:
    """Parse headers, build register map, write JSON, return the dict."""

    # Collect all registers from all headers; deduplicate by address
    addr_to_name: dict[int, str] = {}
    for h in sorted(headers_dir.glob("*.h")):
        for name, addr in _parse_header(h):
            addr_to_name[addr] = name  # last definition per address wins

    # Group by peripheral base address
    groups: dict[int, list[tuple[str, int]]] = defaultdict(list)
    for addr, name in addr_to_name.items():
        base = _peripheral_base(addr)
        if base is not None:
            groups[base].append((name, addr))

    # Build output structure
    peripherals = []
    for base in sorted(groups.keys()):
        regs = sorted(groups[base], key=lambda r: r[1])
        peripherals.append({
            "name":        _PERIPHERAL_NAMES.get(base, f"0x{base:08x}"),
            "base":        f"0x{base:08x}",
            "description": "",
            "registers": [
                {
                    "name":        name,
                    "offset":      f"0x{addr - base:02x}",
                    "access":      _access_for(name),
                    "description": "",
                }
                for name, addr in regs
            ],
        })

    data = {"peripherals": peripherals}
    output.write_text(json.dumps(data, indent=2))

    n_regs = sum(len(p["registers"]) for p in peripherals)
    print(f"register_map.json: {len(peripherals)} peripherals, {n_regs} registers → {output}")
    return data


if __name__ == "__main__":
    generate()
