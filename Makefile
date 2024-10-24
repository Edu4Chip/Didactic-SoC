########################################
# Top repository makefile
# Project: Edu4chip
# SoC:
#
# Description:
# * Top level commands to enable "make <command>"
# -style automated workflows.
#
# Contributors: 
# * Matti Käyrä (Matti.kayra@tuni.fi)
# * Roni Hämäläinen (roni.hamalainen@tuni.fi)
#######################################

# Common shell variables
SHELL=bash
BUILD_DIR ?= $(realpath $(CURDIR))/build/
TEST ?= blink


# Fetch submodule revisions and 
# save work in submodules to stashes - avoid data loss by accidents
repository_init:
	bender update
	bender vendor init

check-env:
	mkdir -p $(BUILD_DIR)/logs/compile
	mkdir -p $(BUILD_DIR)/logs/opt
	mkdir -p $(BUILD_DIR)/logs/sim

######################################################################
#
######################################################################
soc-rtl:
	echo "Generating SoC RTL. Check variables from scripts/run_kactus2_script.sh to be able to run Kactus2."
	source scripts/run_kactus2_script.sh -f scripts/kactus2_generate_soc_rtl.py

######################################################################
# hw targets
######################################################################

# compile hw library with chosen tools
compile: check-env
	$(MAKE) -C sim compile BUILD_DIR=$(BUILD_DIR)

# potentionally elaborate hw library with chosen tools
elaborate: check-env
	$(MAKE) -C sim elaborate BUILD_DIR=$(BUILD_DIR) TESTCASE=$(TEST)

# Potentionally split this to multiple subtasks
syn: check-env
	$(MAKE) -C syn synthesize BUILD_DIR=$(BUILD_DIR)

######################################################################
# sim targets
######################################################################

# compile hw library with chosen tools
run_sim: check-env
	$(MAKE) -C sim run_sim BUILD_DIR=$(BUILD_DIR)

######################################################################
# sw targets
######################################################################
#
build_test: check-env
	$(MAKE) -C sw test BUILD_DIR=$(BUILD_DIR) TESTCASE=$(TEST)

######################################################################
# full flow targets
######################################################################

test_all: check-env compile elaborate build_test run_sim

######################################################################
# verilator targets
######################################################################

executable ?= ""

# generate hdl and sw bindings
.PHONY: verilator-generate-bindings
verilator-generate-bindings:
	python3 ./verification/verilator/scripts/generate_bindings.py

# generate sw model for hw
.PHONY: verilator-generate-model
verilator-generate-model:
	./verification/verilator/scripts/run.sh $(executable)

# build sw model with sw testbench
.PHONY: verilator-build
verilator-build:
	make --directory=obj_dir --makefile=VDidactic.mk

# run sw testbench
.PHONY: verilator-run
verilator-run: verilator-build
	./obj_dir/VDidactic

# run sw testbench with tracing
.PHONY: verilator-run-traced
verilator-run-traced: verilator-build
	./obj_dir/VDidactic +trace
