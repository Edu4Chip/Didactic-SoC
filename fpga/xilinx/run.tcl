####
# Didactic SoC 
# FPGA prototyping flow for Xilinx PYNQ-Z1 board.
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
#   -Thomas Szymkoviak
####
set CPUS [exec getconf _NPROCESSORS_ONLN]
if { ![info exists CPUS] } {
  set CPUS 4
}
#
set PROJECT $::env(PROJECT)
set START $::env(START_TIME)

if { $PROJECT eq "z1" } {
  set XILINX_PART xc7z020clg400-1
} elseif { $PROJECT eq "vcu118" } {
  set XILINX_PART xvup9p-flga2104-2L-e
  puts "ERROR: VCU118 constraints are empty"
} else {
  puts "PROJECT variable contains unsupported board!"
  break
}

set DIR [exec pwd]

create_project didactic-z1 ../build/fpga/$PROJECT -force -part $XILINX_PART

# add include paths of RTL
set COMMON_CELLS_DIR [exec bender path common_cells]
set AXI_DIR          [exec bender path axi]
set APB_DIR          [exec bender path apb]
set REGIF_DIR        [exec bender path register_interface]
set IBEX_PATH        vendor_ips/ibex

set INCLUDE_DIRS [list  \
                   $COMMON_CELLS_DIR/include \
                   $AXI_DIR/include \
                   $APB_DIR/include \
                   $REGIF_DIR/include \
	               $DIR/../$IBEX_PATH/vendor/lowrisc_ip/dv/sv/dv_utils \
	               $DIR/../$IBEX_PATH/vendor/lowrisc_ip/ip/prim/rtl \
	               $DIR/../$IBEX_PATH/rtl \
                 ]

set_property include_dirs $INCLUDE_DIRS [current_fileset]

#set_property include_dirs $INCLUDE_DIRS [current_fileset -simset]
#set_property is_global_include true [get_files $DIR/../$IBEX_PATH/vendor/lowrisc_ip/ip/prim/rtl/prim_assert_dummy_macros.svh]
#set_property include_dirs {{$COMMON_CELLS_DIR/include} {$AXI_DIR/include} {$APB_DIR/include} {$REGIF_DIR/include} {$IBEX_PATH/vendor/lowrisc_ip/dv/sv/dv_utils} {$IBEX_PATH/vendor/lowrisc_ip/ip/prim/rtl} {$IBEX_PATH/rtl}} [current_fileset]

#set_property include_dirs {{/$COMMON_CELLS_DIR/include} {/$AXI_DIR/include} {/$APB_DIR/include} {/$REGIF_DIR/include} {/$IBEX_PATH/vendor/lowrisc_ip/dv/sv/dv_utils} {/$IBEX_PATH/vendor/lowrisc_ip/ip/prim/rtl} {/$IBEX_PATH/rtl} /home/kayra/Didactic-SoC/.bender/git/checkouts/apb-1e206aeb3ca38a11/include /home/kayra/Didactic-SoC/.bender/git/checkouts/axi-aae2d6c181d6f97b/include /home/kayra/Didactic-SoC/.bender/git/checkouts/common_cells-3bd5b2d671aaec0e/include /home/kayra/Didactic-SoC/.bender/git/checkouts/register_interface-26afcadbe8460c5f/include} [current_fileset]

# File read
add_files -norecurse -scan_for_includes [exec bender script flist -t rtl -t vendor -t synthesis]

set_property file_type SystemVerilog [get_files *.v]

#set_property is_global_include true [get_files $IBEX_PATH/vendor/lowrisc_ip/ip/prim/rtl/prim_assert_dummy_macros.svh]
set_property is_global_include true [get_files prim_assert_dummy_macros.svh]

set DEFINES "FPGA=1 SYNTHESIS=1"
            
set_property verilog_define { SYNTHESIS=1 FPGA=1 } [current_fileset]

set_property source_mgmt_mode None [current_project]

set_property top Didactic [current_fileset]
#set_property top Didactic [get_filesets sim_1]

update_compile_order -fileset sources_1

add_files -fileset constrs_1 -norecurse xilinx/$PROJECT.xdc

#Elaborate design
synth_design -rtl -name rtl_1 -sfcu
# sfcu -> run synthesis in single file compilation unit mode

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value -sfcu -objects [get_runs synth_1]
# Use single file compilation unit mode to prevent issues with import pkg::* statements in the codebase
launch_runs synth_1 -jobs $CPUS
wait_on_run synth_1
open_run synth_1 -name netlist_1
set_property needs_refresh false [get_runs synth_1]

# Launch Implementation

set_property STEPS.OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE ExploreWithAggressiveHoldFix [get_runs impl_1]

set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]

launch_runs impl_1 -jobs $CPUS 
wait_on_run impl_1
launch_runs impl_1 -jobs $CPUS -to_step write_bitstream
wait_on_run impl_1

open_run impl_1

# Generate reports
exec mkdir -p $BUILD_DIR/fpga
#exec rm -rf $BUILD_DIR/fpga_reports/*

check_timing                                                          -file $BUILD_DIR/fpga/$START_$PROJECT.check_timing.rpt
report_timing -max_paths 50 -nworst 50 -delay_type max -sort_by slack -file $BUILD_DIR/fpga/$START_$PROJECT.timing_WORST_50.rpt
report_timing -nworst 1 -delay_type max -sort_by group                -file $BUILD_DIR/fpga/$START_$PROJECT.timing.rpt
report_utilization -hierarchical                                      -file $BUILD_DIR/fpga/$START_$PROJECT.utilization.rpt

