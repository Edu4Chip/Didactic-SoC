######################################
# Didactic SoC
# FPGA flow makefile
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
######################################

SHELL = bash
VIVADO ?= vivado

TEST ?= blinky

export FPGADIR=$(PWD)
export BUILD_DIR ?= $(FPGADIR)/../build/fpga
export PROJECT ?= z1


check_env:
	mkdir -p $(BUILD_DIR)

all_xilinx: check_env
	$(VIVADO) -mode batch -notrace -source $(FPGADIR)/scripts/run_xilinx.tcl

all_xilinx_gui: check_env
	$(VIVADO) -mode gui -source $(FPGADIR)/scripts/run_xilinx.tcl &

build_sw: check_env
	$(MAKE) -C sw test BUILD_DIR=$(BUILD_DIR) TESTCASE=$(TEST)

load_elf: check_env build_sw
	riscv32-unknown-elf-gdb $(BUILD_DIR)/sw/$(TEST).elf -x $(FPGADIR)/utils/connect-and-load.gdb

run_elf: check_env build_sw
	riscv32-unknown-elf-gdb -batch $(BUILD_DIR)/sw/$(TEST).elf -x $(FPGADIR)/utils/connect-and-run.gdb

openocd:
	openocd -f utils/openocd-didactic.cfg &
