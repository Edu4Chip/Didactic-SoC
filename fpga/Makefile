######################################
# Didactic SoC 
# FPGA flow makefile
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
######################################

SHELL = bash
VIVADO ?= vivado

TEST ?= blink

export BUILD_DIR ?= ../build
export PROJECT ?= z1

vivado_sim:
	cd $(BUILD_DIR)
	$(VIVADO) -mode batch -source ../fpga/xilinx/sim.tcl \
	-log $(BUILD_DIR)/fpga/logs/vivado.log \
	-nojournal

all_xilinx:
	cd $(BUILD_DIR)
	$(VIVADO) -mode batch -notrace -source ../fpga/xilinx/run.tcl \
	-log $(BUILD_DIR)/fpga/logs/vivado.log \
	-nojournal 

all_xilinx_gui:
	cd $(BUILD_DIR)
	$(VIVADO) -mode gui -source ../fpga/xilinx/run.tcl &

load_elf:
	riscv32-unknown-elf-gdb ../build/sw/$(TEST).elf -x ../fpga/xilinx/connect-and-load.gdb