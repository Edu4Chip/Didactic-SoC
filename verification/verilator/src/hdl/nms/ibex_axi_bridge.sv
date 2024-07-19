`include "verification/verilator/src/hdl/common.v"
`include "verification/verilator/src/generated/hdl/nms/ibex_axi_bridge.sv"

/*
typedef struct packed {
  int unsigned clk_i;
  int unsigned rst_ni;
  // IBEX side
  int unsigned req_i;
  int unsigned gnt_o;
  int unsigned rvalid_o;
  int unsigned we_i;
  int unsigned be_i;
  int unsigned addr_i;
  int unsigned wdata_i;
  int unsigned rdata_o;
  int unsigned err_o;
  // AXI side
  int unsigned aw_addr_o;
  int unsigned aw_valid_o;
  int unsigned aw_ready_i;
  int unsigned w_data_o;
  int unsigned w_strb_o;
  int unsigned w_valid_o;
  int unsigned w_ready_i;
  int unsigned b_resp_i;
  int unsigned b_valid_i;
  int unsigned b_ready_o;
  int unsigned ar_addr_o;
  int unsigned ar_valid_o;
  int unsigned ar_ready_i;
  int unsigned r_data_i;
  int unsigned r_resp_i;
  int unsigned r_valid_i;
  int unsigned r_ready_o;
} StatusIbexAxiBridge;

import "DPI-C" function void track_ibex_axi_bridge(input real itime, input string name, input StatusIbexAxiBridge status_ibex_axi_bridge);
*/
