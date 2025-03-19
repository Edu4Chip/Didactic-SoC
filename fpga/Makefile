######################################
# Didactic SoC 
# FPGA flow makefile
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
######################################

SHELL = bash
VIVADO ?= vivado

export BUILD_DIR ?= ../build
export PROJECT ?= z1

all_xilinx:
	cd $(BUILD_DIR)
	$(VIVADO) -mode batch -notrace -source ../fpga/xilinx/run.tcl  

all_xilinx_gui:
	cd $(BUILD_DIR)
	$(VIVADO) -mode gui -source ../fpga/xilinx/run.tcl &
