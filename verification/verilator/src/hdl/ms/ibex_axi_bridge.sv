`INCREMENT_CYCLE_COUNT(clk_i)

always @ (posedge clk_i) begin
  string name;
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
