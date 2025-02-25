####
# Didactic SoC 
# FPGA prototyping flow for Xilinx PYNQ-Z1 board.
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
#   -Thomas Szymkoviak
####
set CPUS [exec getconf _NPROCESSORS_ONLN]
if { ![info exists CPUS] } {
  set CPUS 24
}

set XILINX_PART xc7z020clg400-1

set DIR ../../../src

create_project $PROJECT $BUILD_DIR/z1 -force -part $XILINX_PART

# add include paths of RTL
set COMMON_CELLS_DIR [exec bender path common_cells]
set AXI_DIR          [exec bender path axi]
set APB_DIR          [exec bender path apb]
set REGIF_DIR        [exec bender path register_interface]
set IBEX_PATH        ../../../vedor_ips/ibex

set INCLUDE_DIRS { $COMMON_CELLS_DIR/include \
                   $AXI_DIR/include \
                   $APB_DIR/include \
                   $REGIF_DIR/include \
	               $IBEX_DIR/vendor/lowrisc_ip/dv/sv/dv_utils \
	               $IBEX_DIR/vendor/lowrisc_ip/ip/prim/rtl \
	               $IBEX_DIR/rtl \
                   $INCLUDE_DIRS}

set_property include_dirs $INCLUDE_DIRS [current_fileset]

# TODO: ADD file read here
add_files -norecurse -scan_for_includes [exec bender script flist -t didactic_top -t vendor -t synthesis]

set DEFINES "FPGA=1 SYNTHESIS=1"

set property verilog_define $DEFINES [current_fileset]

set_property top didatic [current_fileset]

update_compile_order -fileset sources_1

add_files -fileset constrs_1 -norecurse z1.xdc

#Elaborate design
synth_design -rtl -name rtl_1 -sfcu;
# sfcu -> run synthesis in single file compilation unit mode

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value -sfcu -objects [get_runs synth_1]
# Use single file compilation unit mode to prevent issues with import pkg::* statements in the codebase
launch_runs synth_1 -jobs $CPUS
wait_on_run synth_1
open_run synth_1 -name netlist_1
set_property needs_refresh false [get_runs synth_1]

# Launch Implementation

set_property STEPS.OPT_DESIGN.IS_ENABLED false [get_runs impl_1]


set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]

launch_runs impl_1 -jobs $CPUS 
wait_on_run impl_1
launch_runs impl_1 -jobs $CPUS -to_step write_bitstream
wait_on_run impl_1

open_run impl_1

# Generate reports
exec mkdir -p $BUILD_DIR/fpga_reports/
#exec rm -rf $BUILD_DIR/fpga_reports/*

check_timing                                                          -file $BUILD_DIR/fpga_reports/$PROJECT.check_timing.rpt
report_timing -max_paths 50 -nworst 50 -delay_type max -sort_by slack -file $BUILD_DIR/fpga_reports/$PROJECT.timing_WORST_50.rpt
report_timing -nworst 1 -delay_type max -sort_by group                -file $BUILD_DIR/fpga_reports/$PROJECT.timing.rpt
report_utilization -hierarchical                                      -file $BUILD_DIR/fpga_reports/$PROJECT.utilization.rpt

