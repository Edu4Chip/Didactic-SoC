############################################
# Sim makefile for questa/modelsim
# Project: Edu4chip
# SoC: Didactic
# Contributors: 
# * Matti Käyrä (Matti.kayra@tuni.fi)
# * Antti Nurmi (Antti.nurmi@tuni.fi)
# Notes:
# * 
###############################################

BUILD_DIR ?= $(realpath $(CURDIR))/../build
START_TIME=`date +%F_%H:%M`
SHELL = bash

DUT = tb_didactic

TB_DEFINES = \
	+define+USE_UART \
	+define+USE_SPI 

DUT_DEFINES = \
	+define+INC_ASSERT \
	+define+SYNTHESIS \
	+define+RVFI

DUT_LIBS = \
	-L $(BUILD_DIR)/didactic_lib \
	-L $(BUILD_DIR)/tb_lib \

# vsim-8386: suppress bit-to-reg assignment errors
VSIM_OPTS = \
	-suppress vsim-3009 \
	-voptargs=+acc=npr \
	-suppress vsim-8386 \

VOPT_OPTS = \
	-sv \
	-suppress vopt-2577 \
	+acc=npr \

# vlog-2244: tracer Variable implicitly static
VLOG_OPTS = \
	-svinputport=compat \
	-override_timescale="1ns/1ps" \
	-suppress vlog-2583 \
	-suppress vlog-2244 \

BENDER ?= bender

COMMON_CELLS_DIR ?= $(shell $(BENDER) path common_cells)
AXI_DIR          ?= $(shell $(BENDER) path axi)
APB_DIR          ?= $(shell $(BENDER) path apb)
REGIF_DIR        ?= $(shell $(BENDER) path register_interface)
IBEX_DIR         ?= $(BUILD_DIR)/../vendor_ips/ibex

SIM_FLIST        ?= $(shell $(BENDER) script flist -t didactic_top -t vendor -t simulation)

INCLUDES ?= \
	+incdir+$(COMMON_CELLS_DIR)/include \
	+incdir+$(AXI_DIR)/include \
	+incdir+$(APB_DIR)/include \
	+incdir+$(REGIF_DIR)/include \
	+incdir+$(IBEX_DIR)/vendor/lowrisc_ip/dv/sv/dv_utils \
	+incdir+$(IBEX_DIR)/vendor/lowrisc_ip/ip/prim/rtl \
	+incdir+$(IBEX_DIR)/rtl


env:
	mkdir -p $(BUILD_DIR)/logs/compile
	mkdir -p $(BUILD_DIR)/logs/opt
	mkdir -p $(BUILD_DIR)/logs/sim

library_mapping: 
	cd $(BUILD_DIR)
	vmap didactic_lib $(BUILD_DIR)/didactic_lib
	vmap tb_lib $(BUILD_DIR)/tb_lib

compile: env compile_didactic compile_tb 

compile_didactic:
	vlib $(BUILD_DIR)/didactic_lib
	vmap didactic_lib $(BUILD_DIR)/didactic_lib
	vlog -sv -work didactic_lib $(DUT_DEFINES) $(INCLUDES) $(DUT_LIBS) \
	$(VLOG_OPTS) $(SIM_FLIST) -l $(BUILD_DIR)/logs/compile/$(START_TIME)_didactic.log

compile_tb:
	vlib $(BUILD_DIR)/tb_lib
	vmap tb_lib $(BUILD_DIR)/tb_lib
	vlog -sv -work tb_lib $(TB_DEFINES) $(DUT_LIBS) $(INCLUDES) \
	$(SIM_FLIST) -l $(BUILD_DIR)/logs/compile/$(START_TIME)_tb.log

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
