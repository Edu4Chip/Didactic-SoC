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

set PROJECT $::env(PROJECT)
set BUILD_DIR $::env(BUILD_DIR)
set FPGADIR=$(PWD)
echo $FPGADIR
exit 0

if { $PROJECT eq "z1" } {
  set XILINX_PART xc7z020clg400-1
} elseif { $PROJECT eq "vcu118" } {
  set XILINX_PART xvup9p-flga2104-2L-e
  puts "ERROR: VCU118 constraints are empty"
} elseif { $PROJECT eq "basys3" } {
  set XILINX_PART xc7a35tcpg236-1
} else {
  puts "PROJECT variable contains unsupported board!"
  break
}

set DIR [exec pwd]

create_project didactic-$PROJECT $BUILD_DIR/$PROJECT -force -part $XILINX_PART

# add include paths of RTL
set COMMON_CELLS_DIR [exec bender path common_cells]
set AXI_DIR          [exec bender path axi]
set APB_DIR          [exec bender path apb]
set OBI_DIR          [exec bender path obi]
set REGIF_DIR        [exec bender path register_interface]
set IBEX_PATH        vendor_ips/ibex

set INCLUDE_DIRS [list  \
                   $COMMON_CELLS_DIR/include \
                   $AXI_DIR/include \
                   $APB_DIR/include \
                   $REGIF_DIR/include \
                   $OBI_DIR/include \
	                 $DIR/../$IBEX_PATH/vendor/lowrisc_ip/dv/sv/dv_utils \
	                 $DIR/../$IBEX_PATH/vendor/lowrisc_ip/ip/prim/rtl \
	                 $DIR/../$IBEX_PATH/rtl \
                 ]

set_property include_dirs $INCLUDE_DIRS [current_fileset]

# File read
add_files -norecurse -scan_for_includes [exec bender script flist -t fpga -t xilinx -t rtl -t vendor -t synthesis -t didactic_obi]

if { $PROJECT eq "z1" } {
  add_files -norecurse $DIR/rtl/DidacticZ1.v
}
if { $PROJECT eq "basys3" } {
  add_files -norecurse $DIR/rtl/DidacticBasys3.v
}

set_property file_type SystemVerilog [get_files *.v]

# 
set_property is_global_include true [get_files prim_assert_dummy_macros.svh]

# Use xilinx specific cg          
set_property verilog_define { SYNTHESIS=1 FPGA=1 PRIM_DEFAULT_IMPL=prim_pkg::ImplXilinx} [current_fileset]

set_property source_mgmt_mode None [current_project]
if { $PROJECT eq "z1" } {
  set_property top DidacticZ1 [current_fileset]
} elseif { $PROJECT eq "basys3" } {
  set_property top DidacticBasys3 [current_fileset]
} else {
  set_property top Didactic [current_fileset]
}

update_compile_order -fileset sources_1

add_files -fileset constrs_1 -norecurse constraints/$PROJECT.xdc

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
# default strategy creates issues with hold. we trade runtime to get timing correct.

set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]

launch_runs impl_1 -jobs $CPUS 
wait_on_run impl_1
launch_runs impl_1 -jobs $CPUS -to_step write_bitstream
wait_on_run impl_1

open_run impl_1

# Generate reports
exec mkdir -p $BUILD_DIR/logs/

check_timing                                                          -file $BUILD_DIR/logs/$PROJECT.check_timing.rpt
report_timing -max_paths 50 -nworst 50 -delay_type max -sort_by slack -file $BUILD_DIR/logs/$PROJECT.timing_WORST_50.rpt
report_timing -nworst 1 -delay_type max -sort_by group                -file $BUILD_DIR/logs/$PROJECT.timing.rpt
report_utilization -hierarchical                                      -file $BUILD_DIR/logs/$PROJECT.utilization.rpt
