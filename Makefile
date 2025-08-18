########################################
# Top repository makefile
# Project: Edu4chip
# SoC: Didactic
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
#	git submodule update --init --recursive

check-env:
	mkdir -p $(BUILD_DIR)/logs/compile
	mkdir -p $(BUILD_DIR)/logs/opt
	mkdir -p $(BUILD_DIR)/logs/sim

clean_build:
	rm -rf $(BUILD_DIR)

clean_ips:
	rm -fr ./bender

clean_all: clean_build clean_ips

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
# fpga targets
######################################################################

fpga: check-env
	$(MAKE) -C fpga all_xilinx BUILD_DIR=$(BUILD_DIR)

######################################################################
# verilator targets
######################################################################

testcase ?= ""
files = \
	./src/generated/*.*v \
	./src/reuse/*.*v \
	./src/rtl/*.*v
hdl_bindings_ms = ./verification/verilator/src/hdl/ms
hdl_bindings_nms = ./verification/verilator/src/hdl/nms
hdl_bindings_pickle = ./verification/verilator/hdl_bindings.pickle

.PHONY: verilator-initialize
verilator-initialize:
	cp verification/verilator/bender/Bender.local Bender.local
	patch Bender.yml verification/verilator/patches/Bender.yml.patch
	make repository_init
	patch -p0 < verification/verilator/patches/vendor_ips.patch

# backup hdl files
.PHONY: verilator-backup-hdls
verilator-backup-hdls:
	./verification/verilator/scripts/backups.py backup ${files} 

# restore backupped hdl files
.PHONY: verilator-restore-hdls
verilator-restore-hdls:
	./verification/verilator/scripts/backups.py restore ${files}

# generate hdl and sw bindings
.PHONY: verilator-generate-bindings
verilator-generate-bindings:
	make verilator-restore-hdls
	./verification/verilator/scripts/generate.py \
		bindings \
		--input-hdl-ms ${hdl_bindings_ms} \
		--input-hdl-nms ${hdl_bindings_nms} \
		--output-hdl ${hdl_bindings_pickle} \
		${files}

# inject hdl bindings to hdl files
.PHONY: verilator-inject-bindings
verilator-inject-bindings:
	make verilator-restore-hdls
	make verilator-backup-hdls
	./verification/verilator/scripts/inject.py --input-hdl ${hdl_bindings_pickle} ${files}

# generate sw model for hw
.PHONY: verilator-generate-model
verilator-generate-model:
	./verification/verilator/scripts/verilate.py verilate $(testcase)

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
