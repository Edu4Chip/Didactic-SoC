`include "verification/verilator/src/common.v"

import "DPI-C" function void check_signal_propagation(input string path, input real itime, input string name1, input int value1, input string name2, input int value2);
