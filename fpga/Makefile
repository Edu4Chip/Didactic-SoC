####
# Didactic SoC 
# FPGA flow makefile
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
###

START_TIME=`date +%F_%H:%M`
SHELL = bash
BUILD_DIR ?= ../build
PROJECT:=Didactic
VIVADO?=vivado

all_xilinx:
	$(VIVADO) -mode batch -notrace -source xilinx/run.tcl

all_xilinx_gui:
	$(VIVADO) -mode gui -source xilinx/run.tcl &
