#!/bin/bash

AXI_PATH="$(bender path axi)"

# Comment out the failing code
sed -i '125 i /*' $AXI_PATH/src/axi_lite_mux.sv
sed -i '128 i */' $AXI_PATH/src/axi_lite_mux.sv

# Add working code
sed -i '129 i // FIXME: previous does not work: see verilator problem 1' $AXI_PATH/src/axi_lite_mux.sv
sed -i '130 i // This value is derived from file SysCtrl_xbar.sv parameter AXI4LITE_INITIATORS' $AXI_PATH/src/axi_lite_mux.sv
sed -i '131 i localparam NoSlvPorts_fix_clog2_minus1 = 1;' $AXI_PATH/src/axi_lite_mux.sv
sed -i '132 i typedef logic [NoSlvPorts_fix_clog2_minus1:0] select_t;' $AXI_PATH/src/axi_lite_mux.sv
