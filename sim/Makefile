####
# Didactic SoC 
# Sim makefile for questa/modelsim
# 
###

BUILD_DIR ?= $(realpath $(CURDIR))/../build
START_TIME=`date +%F_%H:%M`
SHELL = bash

DUT = tb_didactic

TB_DEFINES = \
	+define+USE_UART \

DUT_LIBS = \
	-L $(BUILD_DIR)/pulp_lib \
	-L $(BUILD_DIR)/ibex_lib \
	-L $(BUILD_DIR)/riscv_dbg_lib \
	-L $(BUILD_DIR)/tech_generic_lib \
	-L $(BUILD_DIR)/didactic_lib \
	-L $(BUILD_DIR)/tb_lib \

VSIM_OPTS = \
	-suppress vsim-3009 \
	-voptargs=+acc=npr \

VOPT_OPTS = \
	-sv \
	-suppress vopt-2577 \
	+acc=npr \

VLOG_OPTS = \
	-svinputport=compat \
	-override_timescale="1ns/1ps" \
	-suppress vlog-2583

COMMON_CELLS_DIR ?= $(shell bender path common_cells)
AXI_DIR          ?= $(shell bender path axi)
IBEX_DIR         ?= $(BUILD_DIR)/../vendor_ips/ibex

env:
	mkdir -p $(BUILD_DIR)/logs/compile
	mkdir -p $(BUILD_DIR)/logs/opt
	mkdir -p $(BUILD_DIR)/logs/sim

library_mapping: 
	cd $(BUILD_DIR)
	vmap pulp_lib $(BUILD_DIR)/pulp_lib
	vmap ibex_lib $(BUILD_DIR)/ibex_lib
	vmap riscv_dbg_lib $(BUILD_DIR)/riscv_dbg_lib
	vmap tech_generic_lib $(BUILD_DIR)/tech_generic_lib
	vmap didactic_lib $(BUILD_DIR)/didactic_lib
	vmap tb_lib $(BUILD_DIR)/tb_lib

compile: env compile_didactic compile_tb 

compile_didactic:
	vlib $(BUILD_DIR)/didactic_lib
	vmap didactic_lib $(BUILD_DIR)/didactic_lib
	vlog -sv -work didactic_lib +incdir+$(COMMON_CELLS_DIR)/include/ +incdir+$(AXI_DIR)/include/ $(DUT_LIBS) \
	-F ../src/sv-files.list -l $(BUILD_DIR)/logs/compile/$(START_TIME)_didactic.log

compile_tb:
	vlib $(BUILD_DIR)/tb_lib
	vmap tb_lib $(BUILD_DIR)/tb_lib
	vlog -sv -work tb_lib $(TB_DEFINES) $(DUT_LIBS)  \
	-F ../src/tb-files.list -l $(BUILD_DIR)/logs/compile/$(START_TIME)_tb.log
#+define+USE_UART

# once regurarly running programs instead sanity, reverse this condition 
SANITY_CHECK ?= 0
TESTCASE ?= blink
GUI ?= "-c"
elaborate: library_mapping
	cd $(BUILD_DIR)
	vopt \
	$(DUT_LIBS) $(VOPT_OPTS) \
	-gDM_SANITY_TESTCASES=$(SANITY_CHECK) \
	-gTESTCASE=$(TESTCASE) \
	-work $(BUILD_DIR)/tb_lib \
	$(DUT) \
	-o $(DUT)_opt \
	-l $(BUILD_DIR)/logs/opt/$(START_TIME)_vopt.log

run_sim: library_mapping
	mkdir -p stdout &&	touch stdout/uart
	cd $(BUILD_DIR)
	vsim $(GUI) \
	$(DUT_LIBS) $(VSIM_OPTS) \
	-work $(BUILD_DIR)/tb_lib \
	$(DUT)_opt \
	-do "run 0ms;" \
	-l $(BUILD_DIR)/logs/sim/$(START_TIME)_sim.log
