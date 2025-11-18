ROOT            = $(realpath $(CURDIR))/../
BUILD_DIR       = $(ROOT)/build
VERIL_DIR       = $(ROOT)/verilator
VERIL_BUILD_DIR = $(BUILD_DIR)/verilator_build

DUT_TOP         = didactic_vtop
CPP_TOP         = $(VERIL_DIR)/tb/TbDidactic.cpp

BENDER_TARGETS  = \
  -t tech_cells_generic_exclude_deprecated \
  -t rtl \
  -t vendor \
  -t verilator \
  -t tracer \
  -t didactic_obi

SRC_FILES       = $(shell bender script flist $(BENDER_TARGETS))

VERIL_DEFINES ?= \
	+define+VERILATOR=1 \
	+define+RVFI \
	+define+DV_FCOV_DISABLE \
	+define+COMMON_CELLS_ASSERTS_OFF

VERIL_INCLUDES ?= \
	+incdir+$(ROOT)/vendor_ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils \
	+incdir+$(ROOT)/vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl \
	+incdir+$(shell bender path common_cells)/include \
	+incdir+$(shell bender path apb)/include \
	+incdir+$(shell bender path axi)/include \
	+incdir+$(shell bender path obi)/include \
	+incdir+$(shell bender path register_interface)/include

.PHONY: init clean vlint verilate vsim

init:
	@mkdir -p $(VERIL_BUILD_DIR)

vlint:
	verilator --lint-only \
	$(VERIL_DEFINES) \
	$(VERIL_INCLUDES) \
	$(SRC_FILES) \
	--top-module $(DUT_TOP)


clean:
	@rm -fr $(VERIL_BUILD_DIR)
