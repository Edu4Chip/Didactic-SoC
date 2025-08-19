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

FLIST = $(shell $(BENDER) script flist $(BENDER_TARGETS))

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


vlint:
	@echo "Verilator compilation"
	verilator \
	--lint-only \
	-O3 -sv \
	$(VERIL_INCLUDES) \
	$(VERIL_DEFINES) \
	$(VERIL_DIR)/$(TOP_MODULE).vlt \
	$(FLIST) \
	--top-module $(TOP_MODULE)


verilate:
	@echo "Verilator compilation"
	verilator $(FLIST)
	

simv:
	@echo "Verilator simulation"
