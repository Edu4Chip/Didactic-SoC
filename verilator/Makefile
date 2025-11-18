ROOT            = $(realpath $(CURDIR))/..
BUILD_DIR       = $(ROOT)/build
VERIL_DIR       = $(ROOT)/verilator
VERIL_BUILD_DIR = $(BUILD_DIR)/verilator_build

DUT_TOP         = didactic_vtop
CPP_TOP         = $(VERIL_DIR)/TbDidactic.cpp
WAIVER          = $(VERIL_DIR)/didactic.vlt

IMEM_WORDS = 16384
DMEM_START = 16385

BENDER_TARGETS  = \
  -t tech_cells_generic_exclude_deprecated \
  -t rtl \
  -t vendor \
  -t verilator \
  -t tracer \
  -t didactic_obi

VBENCH = $(shell bender path vbench)

SRC_FILES       = $(shell bender script flist $(BENDER_TARGETS))

VERIL_DEFINES ?= \
	+define+VERILATOR=1 \
	+define+ROOT=$(ROOT) \
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

VERIL_COMMON = \
	$(VERIL_DEFINES) \
	$(VERIL_INCLUDES) \
	$(WAIVER) \
	$(SRC_FILES) \
	--top-module $(DUT_TOP) \

.PHONY: init clean vlint vbuild simv

init:
	@mkdir -p $(VERIL_BUILD_DIR)

vlint:
	verilator --lint-only \
	$(VERIL_COMMON)
	@echo "Lint [OK]"


.PHONY: $(TEST)
$(TEST):
	@cp $(BUILD_DIR)/sw/$(TEST).hex $(VERIL_BUILD_DIR)/verilator_stim.hex
	@head -$(IMEM_WORDS)    $(VERIL_BUILD_DIR)/verilator_stim.hex > $(VERIL_BUILD_DIR)/imem_stim.hex
	@tail -n +$(DMEM_START) $(VERIL_BUILD_DIR)/verilator_stim.hex > $(VERIL_BUILD_DIR)/dmem_stim.hex

vbuild: init
	verilator \
	$(VERIL_COMMON) \
	--timing \
	--trace-fst \
	--trace-structs \
	--trace-params \
	--hierarchical \
	--exe $(CPP_TOP) \
	--cc \
	-CFLAGS "-I$(VBENCH)/src -DROOT=$(ROOT)" \
	--unroll-count 256 \
	--build \
	--Mdir $(VERIL_BUILD_DIR)/obj_dir \
	-j `nproc`

simv: $(TEST)
	$(VERIL_BUILD_DIR)/obj_dir/V$(DUT_TOP) $(TEST)

clean:
	@rm -fr $(VERIL_BUILD_DIR)
