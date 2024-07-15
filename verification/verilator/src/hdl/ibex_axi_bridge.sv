`include "verification/verilator/src/common.v"
`INCREMENT_CYCLE_COUNT(clk_i)

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

string name;
always @ (posedge clk_i) begin
  StatusIbexAxiBridge status_ibex_axi_bridge;
  status_ibex_axi_bridge.clk_i = clk_i;
  status_ibex_axi_bridge.rst_ni = rst_ni;
  status_ibex_axi_bridge.req_i = req_i;
  status_ibex_axi_bridge.gnt_o = gnt_o;
  status_ibex_axi_bridge.rvalid_o = rvalid_o;
  status_ibex_axi_bridge.we_i = we_i;
  status_ibex_axi_bridge.be_i = be_i;
  status_ibex_axi_bridge.addr_i = addr_i;
  status_ibex_axi_bridge.wdata_i = wdata_i;
  status_ibex_axi_bridge.rdata_o = rdata_o;
  status_ibex_axi_bridge.err_o = err_o;
  status_ibex_axi_bridge.aw_addr_o = aw_addr_o;
  status_ibex_axi_bridge.aw_valid_o = aw_valid_o;
  status_ibex_axi_bridge.aw_ready_i = aw_ready_i;
  status_ibex_axi_bridge.w_data_o = w_data_o;
  status_ibex_axi_bridge.w_strb_o = w_strb_o;
  status_ibex_axi_bridge.w_valid_o = w_valid_o;
  status_ibex_axi_bridge.w_ready_i = w_ready_i;
  status_ibex_axi_bridge.b_resp_i = b_resp_i;
  status_ibex_axi_bridge.b_valid_i = b_valid_i;
  status_ibex_axi_bridge.b_ready_o = b_ready_o;
  status_ibex_axi_bridge.ar_addr_o = ar_addr_o;
  status_ibex_axi_bridge.ar_valid_o = ar_valid_o;
  status_ibex_axi_bridge.ar_ready_i = ar_ready_i;
  status_ibex_axi_bridge.r_data_i = r_data_i;
  status_ibex_axi_bridge.r_resp_i = r_resp_i;
  status_ibex_axi_bridge.r_valid_i = r_valid_i;
  status_ibex_axi_bridge.r_ready_o = r_ready_o;
  $sformat(name, "%m");
  track_ibex_axi_bridge($realtime, name, status_ibex_axi_bridge);
end
