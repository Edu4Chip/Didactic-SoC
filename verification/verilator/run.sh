#!/bin/bash

which verilator
verilator --version
echo ""

# Start with the easy task first.
# Attempt to just process the input files.
# No compilation is performed.
# When this succeeds, implement more complex script.
verilator \
    --lint-only \
    --top-module Didactic \
    -I./src/generated \
    -I./src/reuse \
    -I./src/tb \
    -I./src/tech_generic \
    -I./ips/riscv-dbg/src \
    -I./ips/riscv-dbg/debug_rom \
    -I./ips/common_cells \
    -I./ips/common_cells/include \
    -I./ips/common_cells/src \
    -I./ips/common_cells/src/deprecated \
    src/generated/Didactic.v
verilator_exit_code=$?
echo ""

if [ ${verilator_exit_code} -eq 0 ]; then
    echo "OK"
    exit 0
else
    echo "FAIL"
    exit ${verilator_exit_code}
fi
