puts "#### Running sim.tcl ####"
set DIR [exec pwd]

source $DIR/xilinx/scripts/common.tcl

set_property top tb_didactic_fpga [get_filesets sim_1]
#update_compile_order -fileset sources_1
launch_simulation