puts "#### Running sim.tcl ####"
set DIR [exec pwd]

source $DIR/xilinx/scripts/common.tcl

set_property top tb_didactic_fpga [get_filesets sim_1]

set_property verilog_define { \
                        COMMON_CELLS_ASSERTS_OFF=1 \
                        SYNTHESIS=1 \
                        FPGA=1 \
                        PRIM_DEFAULT_IMPL=prim_pkg::ImplXilinx \
                        } [get_filesets [list sim_1 sources_1]]

set_property file_type SystemVerilog [get_files *.v]

launch_simulation