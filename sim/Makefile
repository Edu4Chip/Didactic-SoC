####
# Didactic SoC 
# Sim makefile for questa/modelsim
# 
###

BUILD_DIR ?= $(realpath $(CURDIR))/../build
START_TIME=`date +%F_%H:%M`
SHELL = bash

DUT = tb_didactic

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

env:
	mkdir -p $(BUILD_DIR)/compile
	mkdir -p $(BUILD_DIR)/opt
	mkdir -p $(BUILD_DIR)/sim

library_mapping: 
	cd $(BUILD_DIR)
	vmap pulp_lib $(BUILD_DIR)/pulp_lib
	vmap ibex_lib $(BUILD_DIR)/ibex_lib
	vmap riscv_dbg_lib $(BUILD_DIR)/riscv_dbg_lib
	vmap tech_generic_lib $(BUILD_DIR)/tech_generic_lib
	vmap didactic_lib $(BUILD_DIR)/didactic_lib
	vmap tb_lib $(BUILD_DIR)/tb_lib

compile: env compile_pulp compile_ibex compile_riscv_dbg compile_tech_generic compile_didactic compile_tb 

compile_pulp:
	vlib $(BUILD_DIR)/pulp_lib
	vmap pulp_lib $(BUILD_DIR)/pulp_lib
	vlog -sv -work pulp_lib $(VLOG_OPTS) +incdir+../ips/common_cells/include/ +incdir+../ips/axi/include/ \
	-F ../src/pulp-reused-files.list -l $(BUILD_DIR)/compile/$(START_TIME)_pulp.log

compile_ibex:
	vlib $(BUILD_DIR)/ibex_lib
	vmap ibex_lib $(BUILD_DIR)/ibex_lib
	vlog -sv -work ibex_lib +incdir+../ips/ibex/vendor/lowrisc_ip/ip/prim/rtl +incdir+../ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils \
	-F ../src/ibex-reused-files.list -l $(BUILD_DIR)/compile/$(START_TIME)_ibex.log

compile_riscv_dbg:
	vlib $(BUILD_DIR)/riscv_dbg_lib
	vmap riscv_dbg_lib $(BUILD_DIR)/riscv_dbg_lib
	vlog -sv -work riscv_dbg_lib  \
	-F ../src/riscv_dbg-reused-files.list -l $(BUILD_DIR)/compile/$(START_TIME)_riscv_dbg.log

compile_tech_generic:
	vlib $(BUILD_DIR)/tech_generic_lib
	vmap tech_generic_lib $(BUILD_DIR)/tech_generic_lib
	vlog -sv -work tech_generic_lib  \
	-F ../src/sim-files.list -l $(BUILD_DIR)/compile/$(START_TIME)_tech_generic.log

compile_didactic:
	vlib $(BUILD_DIR)/didactic_lib
	vmap didactic_lib $(BUILD_DIR)/didactic_lib
	vlog -sv -work didactic_lib +incdir+../ips/common_cells/include/ +incdir+../ips/axi/include/ $(DUT_LIBS) \
	-F ../src/sv-files.list -l $(BUILD_DIR)/compile/$(START_TIME)_didactic.log

compile_tb:
	vlib $(BUILD_DIR)/tb_lib
	vmap tb_lib $(BUILD_DIR)/tb_lib
	vlog -sv -work tb_lib $(DUT_LIBS)  \
	-F ../src/tb-files.list -l $(BUILD_DIR)/compile/$(START_TIME)_tb.log
#+define+USE_UART

# once regurarly running programs instead sanity, reverse this condition 
SANITY_CHECK ?= 0
TESTCASE ?= blink
GUI ?= ""
elaborate: library_mapping
	cd $(BUILD_DIR)
	vopt \
	$(DUT_LIBS) $(VOPT_OPTS) \
	-gDM_SANITY_TESTCASES=$(SANITY_CHECK) \
	-gTESTCASE=$(TESTCASE) \
	-work $(BUILD_DIR)/tb_lib \
	$(DUT) \
	-o $(DUT)_opt \
	-l $(BUILD_DIR)/opt/$(START_TIME)_vopt.log

run_sim: library_mapping
	cd $(BUILD_DIR)
	vsim $(GUI) \
	$(DUT_LIBS) $(VSIM_OPTS) \
	-work $(BUILD_DIR)/tb_lib \
	$(DUT)_opt \
	-do "run 0ms;" \
	-l $(BUILD_DIR)/sim/$(START_TIME)_sim.log
