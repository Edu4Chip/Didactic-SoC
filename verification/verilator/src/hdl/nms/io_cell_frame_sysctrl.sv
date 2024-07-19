`include "verification/verilator/src/hdl/common.v"
`include "verification/verilator/src/generated/hdl/nms/io_cell_frame_sysctrl.sv"

import "DPI-C" function void check_signal_propagation(input string path, input real itime, input string name1, input int value1, input string name2, input int value2);
