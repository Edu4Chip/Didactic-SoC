#!/bin/bash

which verilator
verilator --version
echo ""

# Assume that first positional argument is the name of the executable
if [ -z ${1} ]; then
    EXECUTABLE="example"
    tput setaf 3; echo "warning: executable not given, defaulting to \"${EXECUTABLE}\""; tput sgr0
else
    EXECUTABLE=${1}
    tput setaf 2; echo "info: executable given: \"${EXECUTABLE}\""; tput sgr0
fi

if [ ! -f verification/verilator/src/sw/${EXECUTABLE}.cpp ]; then
    tput setaf 1; echo "error: given file \"${EXECUTABLE}.cpp\" doest not exist"; tput sgr0
    exit 1
fi

# Generate HDL and SW bindings
python3 verification/verilator/scripts/generate_bindings.py

# Apply fixes to verilog files
verification/verilator/scripts/do_fix.sh

# FIXME: "FIX_SIGNAL_PROPAGATION" is a temporary solution to fix signal propagation, remove when fixed in HDL

verilator \
    --cc \
    --exe \
    --top-module Didactic \
    --no-timing \
    --trace \
    -Wno-context \
    -Wno-fatal \
    -Wno-lint \
    -Wno-style \
    -Wno-BLKANDNBLK \
    -I./ips/common_cells/include \
    -I./ips/axi/include \
    -I./ips/ibex/rtl \
    -I./ips/ibex/vendor/lowrisc_ip/ip/prim/rtl \
    -I./ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils \
    -F src/pulp-reused-files.list \
    -F src/riscv_dbg-reused-files.list \
    -F src/ibex-reused-files.list \
    -F src/sv-files.list \
    -F src/sim-files.list \
    -DFIX_SIGNAL_PROPAGATION \
    verification/verilator/src/sw/${EXECUTABLE}.cpp
verilator_exit_code=$?
echo ""

# Remove fixes to verilog files
verification/verilator/scripts/undo_fix.sh

if [ ${verilator_exit_code} -eq 0 ]; then
    echo "OK"
    exit 0
else
    echo "FAIL"
    exit ${verilator_exit_code}
fi
