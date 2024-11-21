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

# Apply fixes to verilog files
verification/verilator/scripts/do_fix.sh

# FIXME: "FIX_SIGNAL_PROPAGATION" is a temporary solution to fix signal propagation, remove when fixed in HDL

BUILD_DIR=$PWD/build
COMMON_CELLS_DIR=$(bender path common_cells)
AXI_DIR=$(bender path axi)
APB_DIR=$(bender path apb)
REGIF_DIR=$(bender path register_interface)
IBEX_DIR=$BUILD_DIR/../vendor_ips/ibex

SIM_FLIST=$(bender script flist -t didactic_top -t vendor -t tech_cells_generic_exclude_deprecated)

DEFINES="\
	+define+SYNTHESIS \
	"

INCLUDES="\
	-I$COMMON_CELLS_DIR/include/ \
	-I$AXI_DIR/include/ \
	-I$APB_DIR/include/ \
	-I$REGIF_DIR/include/ \
	-I$IBEX_DIR/vendor/lowrisc_ip/dv/sv/dv_utils/ \
	-I$IBEX_DIR/vendor/lowrisc_ip/ip/prim/rtl/ \
	-I$IBEX_DIR/rtl/"

WARN_SUPPRESS="\
    -Wno-context \
    -Wno-fatal \
    -Wno-lint \
    -Wno-style \
    -Wno-BLKANDNBLK \
    -Wno-WIDTHCONCAT \
    -Wno-STMTDLY \
    -Wno-TIMESCALEMOD \
    -Wno-REDEFMACRO"

verilator \
    --cc \
    --exe \
    --top-module Didactic \
    --no-timing \
    --trace \
    $DEFINES \
    $WARN_SUPPRESS \
    $INCLUDES \
    $SIM_FLIST \
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
