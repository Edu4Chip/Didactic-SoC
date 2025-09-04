puts "#### Running src_files.tcl ####"

set BENDER_TARGETS "-t fpga \
                    -t xilinx \
                    -t rtl \
                    -t vendor \
                    -t didactic_obi \
                    -t synthesis"

set BENDER_CMD "bender script flist $BENDER_TARGETS"

#set filelist [exec bender script flist -t fpga -t xilinx -t rtl -t vendor -t didactic_obi -t synthesis]
set filelist [exec sh -c $BENDER_CMD]
puts $filelist

exit
add_files $filelist

add_files -fileset sim_1 $DIR/hdl/tb_didactic_fpga.sv