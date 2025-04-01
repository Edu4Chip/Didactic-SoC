// Copyright 2023 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// Michael Rogenmoser <michaero@iis.ee.ethz.ch>

// Adapted by Antti Nurmi <antti.nurmi@tuni.fi> - add interface wrapper
// copied from https://github.com/soc-hub-fi/Atalanta/blob/main/src/ip/rt_interconnect.sv
// Modified locally to full obi standard
// contributor: Matti Käyrä (matti.kayra@tuni.fi)


`include "obi/typedef.svh"
`include "obi/assign.svh"

module obi_cut_intf #(
)(
  input logic         clk_i,
  input logic         rst_ni,
  OBI_BUS.Manager     obi_m,
  OBI_BUS.Subordinate obi_s
);

`OBI_TYPEDEF_ALL(sbr_port_obi, obi_pkg::ObiDefaultConfig)
`OBI_TYPEDEF_ALL(mgr_port_obi, obi_pkg::ObiDefaultConfig)

sbr_port_obi_req_t sbr_ports_req;
sbr_port_obi_rsp_t sbr_ports_rsp;
mgr_port_obi_req_t mgr_ports_req;
mgr_port_obi_rsp_t mgr_ports_rsp;

`OBI_ASSIGN_TO_REQ(sbr_ports_req, obi_s, obi_pkg::ObiDefaultConfig)
`OBI_ASSIGN_FROM_RSP(obi_s, sbr_ports_rsp, obi_pkg::ObiDefaultConfig)

`OBI_ASSIGN_FROM_REQ(obi_m, mgr_ports_req, obi_pkg::ObiDefaultConfig)
`OBI_ASSIGN_TO_RSP(mgr_ports_rsp, obi_m, obi_pkg::ObiDefaultConfig)

obi_cut #(
  .obi_a_chan_t (sbr_port_obi_a_chan_t),
  .obi_r_chan_t (sbr_port_obi_r_chan_t),
  .obi_req_t    (sbr_port_obi_req_t),
  .obi_rsp_t    (sbr_port_obi_rsp_t)
) i_obi_cut (
  .clk_i,
  .rst_ni,
  .sbr_port_req_i (sbr_ports_req),
  .sbr_port_rsp_o (sbr_ports_rsp),
  .mgr_port_req_o (mgr_ports_req),
  .mgr_port_rsp_i (mgr_ports_rsp)
);

endmodule
