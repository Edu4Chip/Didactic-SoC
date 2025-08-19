ROOT            ?= $(realpath $(CURDIR))/../
BUILD_DIR       ?= $(realpath $(CURDIR))/../build
VERIL_DIR       ?= $(realpath $(CURDIR))/../verilator
VERIL_BUILD_DIR ?= $(BUILD_DIR)/verilator_build

BENDER         ?= bender
BENDER_TARGETS  = \
                  -t tech_cells_generic_exclude_deprecated \
                  -t rtl \
                  -t vendor \
                  -t verilator \
                  -t tracer \
                  -t didactic_obi

TOP_MODULE     = Didactic
CPP_TOP        = $(VERIL_DIR)/Tb$(TOP_MODULE).cpp

FLIST  = $(shell $(BENDER) script flist $(BENDER_TARGETS))
VBENCH = $(shell $(BENDER) path vbench)

VERIL_DEFINES ?= \
	+define+VERILATOR=1 \
	+define+RVFI \
	+define+DV_FCOV_DISABLE \
	+define+COMMON_CELLS_ASSERTS_OFF

VERIL_INCLUDES ?= \
	+incdir+$(ROOT)/vendor_ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils \
	+incdir+$(ROOT)/vendor_ips/ibex/vendor/lowrisc_ip/ip/prim/rtl \
	+incdir+$(shell $(BENDER) path common_cells)/include \
	+incdir+$(shell $(BENDER) path apb)/include \
	+incdir+$(shell $(BENDER) path axi)/include \
	+incdir+$(shell $(BENDER) path obi)/include \
	+incdir+$(shell $(BENDER) path register_interface)/include

VERIL_FLAGS ?= \
	-O3 -sv \
	$(VERIL_INCLUDES) \
	$(VERIL_DEFINES) \
	$(VERIL_DIR)/$(TOP_MODULE).vlt \
	$(FLIST) \
	--top-module $(TOP_MODULE)

init:
	mkdir -p $(VERIL_BUILD_DIR)

vlint:
	verilator --lint-only $(VERIL_FLAGS)

verilate: init
	verilator \
	$(VERIL_FLAGS) \
	--timing \
	--trace-fst \
	--trace-structs \
	--trace-params \
	--hierarchical \
	-CFLAGS "-I$(VBENCH)/src" \
	--exe $(CPP_TOP) \
	--cc \
	--build \
	--Mdir $(VERIL_BUILD_DIR)/obj_dir \
	-j `nproc`
	

simv:
	@echo "Verilator simulation"
