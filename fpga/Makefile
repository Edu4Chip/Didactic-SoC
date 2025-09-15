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

check_env:
	mkdir -p $(BUILD_DIR)

all_xilinx: check_env
	cd $(BUILD_DIR)
	$(VIVADO) -mode batch -notrace -source ../fpga/xilinx/run.tcl  

all_xilinx_gui: check_env
	cd $(BUILD_DIR)
	$(VIVADO) -mode gui -source ../fpga/xilinx/run.tcl &

load_elf: check_env
	riscv32-unknown-elf-gdb $(BUILD_DIR)/sw/$(TEST).elf -x ../fpga/xilinx/connect-and-load.gdb