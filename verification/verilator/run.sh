#!/bin/bash

which verilator
verilator --version
echo ""

# Apply fixes to verilog files
verification/verilator/do_fix.sh

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
    verification/verilator/sim_main.cpp
verilator_exit_code=$?
echo ""

# Remove fixes to verilog files
verification/verilator/undo_fix.sh

if [ ${verilator_exit_code} -eq 0 ]; then
    echo "OK"
    exit 0
else
    echo "FAIL"
    exit ${verilator_exit_code}
fi
