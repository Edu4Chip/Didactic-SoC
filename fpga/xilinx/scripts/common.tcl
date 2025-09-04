puts "#### Running common.tcl ####"

set PROJECT $::env(PROJECT)
set BUILD_DIR $::env(BUILD_DIR)
set DUT "didactic"

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

puts "Setting up project $DUT\_$PROJECT on Xilinx part $XILINX_PART"

create_project $DUT\_$PROJECT ../build/fpga/$PROJECT -force -part $XILINX_PART

source $DIR/xilinx/scripts/src_files.tcl