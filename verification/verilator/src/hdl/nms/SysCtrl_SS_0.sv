`include "verification/verilator/src/common.v"

typedef struct packed {
    int unsigned err_i;
    int unsigned gnt_i;
    int unsigned rdata_i;
    int unsigned rdata_intg_i;
    int unsigned rvalid_i;
    int unsigned addr_o;
    int unsigned req_o;
} StatusImem;

typedef struct packed {
    int unsigned err_i;
    int unsigned gnt_i;
    int unsigned rdata_i;
    int unsigned rdata_intg_i;
    int unsigned rvalid_i;
    int unsigned addr_o;
    int unsigned be_o;
    int unsigned req_o;
    int unsigned wdata_intg_o;
    int unsigned wdata_o;
    int unsigned we_o;
} StatusDmem;

import "DPI-C" function void print_core_state(input real itime, input StatusImem status_imem, input StatusDmem status_dmem);
