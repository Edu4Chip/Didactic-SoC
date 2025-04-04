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
    /// The OBI configuration.
  parameter obi_pkg::obi_cfg_t ObiCfg       = obi_pkg::ObiDefaultConfig,
  /// The obi A channel struct.  /// The OBI configuration for the subordinate ports (input ports).
  parameter obi_pkg::obi_cfg_t SbrPortObiCfg      = ObiCfg,
  /// The OBI configuration for the manager ports (ouput ports).
  parameter obi_pkg::obi_cfg_t MgrPortObiCfg      = ObiCfg,
//  /// The request struct for the subordinate ports (input ports)
//  parameter type               obi_a_chan_t = logic,
//  /// The obi R channel struct.
//  parameter type               obi_r_chan_t = logic,
//  /// The request struct.
//  parameter type               obi_req_t    = logic,
//  /// The response struct.
//  parameter type               obi_rsp_t    = logic,
  /// Bypass enable, can be individually overridden!
  parameter bit                Bypass       = 1'b0,
  /// Bypass enable for Request side.
  parameter bit                BypassReq    = Bypass,
  /// Bypass enable for Response side.
  parameter bit                BypassRsp    = Bypass
  )(

  input logic         clk_i,
  input logic         rst_ni,
  OBI_BUS.Manager     obi_m,
  OBI_BUS.Subordinate obi_s
);

`OBI_TYPEDEF_ALL(sbr_port_obi, ObiCfg)
`OBI_TYPEDEF_ALL(mgr_port_obi, ObiCfg)

sbr_port_obi_req_t sbr_ports_req;
sbr_port_obi_rsp_t sbr_ports_rsp;
mgr_port_obi_req_t mgr_ports_req;
mgr_port_obi_rsp_t mgr_ports_rsp;

`OBI_ASSIGN_TO_REQ(sbr_ports_req, obi_s, ObiCfg)
`OBI_ASSIGN_FROM_RSP(obi_s, sbr_ports_rsp, ObiCfg)

`OBI_ASSIGN_FROM_REQ(obi_m, mgr_ports_req, ObiCfg)
`OBI_ASSIGN_TO_RSP(mgr_ports_rsp, obi_m, ObiCfg)

obi_cut #(
  .ObiCfg      (ObiCfg),
  .obi_a_chan_t(sbr_port_obi_a_chan_t),
  .obi_r_chan_t(sbr_port_obi_r_chan_t),
  .obi_req_t   (sbr_port_obi_req_t),
  .obi_rsp_t   (sbr_port_obi_rsp_t),
  .Bypass      (Bypass),
  .BypassReq   (BypassReq),
  .BypassRsp   (BypassRsp)
) i_obi_cut (
  .clk_i         (clk_i),
  .rst_ni        (rst_ni),
  .sbr_port_req_i(sbr_ports_req),
  .sbr_port_rsp_o(sbr_ports_rsp),
  .mgr_port_req_o(mgr_ports_req),
  .mgr_port_rsp_i(mgr_ports_rsp)
);

endmodule
