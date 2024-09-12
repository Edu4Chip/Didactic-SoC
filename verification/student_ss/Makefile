# -------------------------------------------------------------------------------
# NOT COCOTB ARGS
# -------------------------------------------------------------------------------

ROOT_DIR = $(shell pwd)

# Defining paths
RTL_DIR = $(ROOT_DIR)/../../src/rtl
COMMON_DIR = $(ROOT_DIR)/common

export PYTHONPATH := $(ROOT_DIR)

# ------------------------------------------------------------------------------
# COCOTB ARGS
# ------------------------------------------------------------------------------

# Defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Verilog source files to include
VERILOG_SOURCES := $(COMMON_DIR)/toplevel_rtl/toplevel.sv
VERILOG_SOURCES += $(RTL_DIR)/student_ss_1.sv

# TOPLEVEL is the DUT instance
TOPLEVEL := toplevel

# RTL APB WIDTH Parameters
APB_AW       ?= 32
APB_DW       ?= 32

COMPILE_ARGS += -P$(TOPLEVEL).APB_AW=$(APB_AW)
COMPILE_ARGS += -P$(TOPLEVEL).APB_DW=$(APB_DW)

# MODULE is the basename of the Python test file
MODULE   := example.cl_student_example_test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
