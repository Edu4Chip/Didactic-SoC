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


# Fetch submodule revisions and 
# save work in submodules to stashes - avoid data loss by accidents
repository_init:
	git fetch
	git submodule foreach 'git stash'
	git submodule update --init --recursive

check-env:
	mkdir -p $(BUILD_DIR)/logs/compile
	mkdir -p $(BUILD_DIR)/logs/opt
	mkdir -p $(BUILD_DIR)/logs/sim

######################################################################
# hw targets
######################################################################

# compile hw library with chosen tools
compile: check-env
	$(MAKE) -C sim compile BUILD_DIR=$(BUILD_DIR)

# potentionally elaborate hw library with chosen tools
elaborate: check-env
	$(MAKE) -C sim elaborate BUILD_DIR=$(BUILD_DIR)

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
## compile sw binary with chosen tools
#run_sim: check-env
#	$(MAKE) -C sw build_sw BUILD_DIR=$(BUILD_DIR) TEST_CASE=$(HELLO)
#
######################################################################
# verilator targets
######################################################################

# generate sw model for hw
.PHONY: verilator-generate
verilator-generate:
	./verification/verilator/run.sh

# build sw model with sw testbench
.PHONY: verilator-build
verilator-build:
	make -C obj_dir -f VDidactic.mk

# run sw testbench
.PHONY: verilator-run
verilator-run: verilator-build
	./obj_dir/VDidactic

# run sw testbench with tracing
.PHONY: verilator-run-traced
verilator-run-traced: verilator-build
	./obj_dir/VDidactic +trace
