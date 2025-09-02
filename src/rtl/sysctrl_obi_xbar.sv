//-----------------------------------------------------------------------------
// File          : sysctrl_obi_xbar.v
// Creation date : 24.03.2025
// Creation time : 11:37:27
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:interconnect:sysctrl_obi_xbar:1.0
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * OBI xbar for didactic SoC

*/
module sysctrl_obi_xbar #(
    parameter                              OBI_AW           = 32,
    parameter                              OBI_CHKW         = 1,
    parameter                              OBI_DW           = 32,
    parameter                              OBI_IDW          = 1,
    parameter                              OBI_USERW        = 1
) (
    // Interface: clock
    input  logic                        clk,

    // Interface: obi_chip_top
    input  logic                         top_err,
//    input  logic                         top_exokay,
    input  logic                         top_gnt,
    input  logic                         top_gntpar,
//    input  logic         [OBI_CHKW-1:0]  top_rchk,
    input  logic         [OBI_DW-1:0]    top_rdata,
    input  logic         [OBI_IDW-1:0]   top_rid,
//    input  logic         [OBI_USERW-1:0] top_ruser,
    input  logic                         top_rvalid,
    input  logic                         top_rvalidpar,
//    output logic         [OBI_CHKW-1:0]  top_achk,
    output logic         [OBI_AW-1:0]    top_addr,
    output logic         [OBI_IDW-1:0]   top_aid,
 //   output logic         [5:0]           top_atop,
//    output logic         [OBI_USERW-1:0] top_auser,
    output logic         [OBI_DW/8-1:0]  top_be,
//    output logic                         top_dbg,
//    output logic         [1:0]           top_memtype,
//    output logic         [OBI_IDW-1:0]   top_mid,
//    output logic         [2:0]           top_prot,
    output logic                         top_req,
    output logic                         top_reqpar,
    output logic                         top_rready,
    output logic                         top_rreadypar,
    output logic         [OBI_DW-1:0]    top_wdata,
    output logic                         top_we,
//    output logic         [OBI_USERW-1:0] top_wuser,

    // Interface: obi_core_dmem
//    input  logic         [OBI_CHKW-1:0]  data_achk,
    input  logic         [OBI_AW-1:0]    data_addr,
    input  logic         [OBI_IDW-1:0]   data_aid,
//    input  logic         [5:0]           data_atop,
//    input  logic         [OBI_USERW-1:0] data_auser,
    input  logic         [OBI_DW/8-1:0]  data_be,
//    input  logic                         data_dbg,
//    input  logic         [1:0]           data_memtype,
//    input  logic         [OBI_IDW-1:0]   data_mid,
//    input  logic         [2:0]           data_prot,
    input  logic                         data_req,
    input  logic                         data_reqpar,
    input  logic                         data_rready,
    input  logic                         data_rreadypar,
    input  logic         [OBI_DW-1:0]    data_wdata,
    input  logic                         data_we,
//    input  logic         [OBI_USERW-1:0] data_wuser,
    output logic                         data_err,
//    output logic                         data_exokay,
    output logic                         data_gnt,
    output logic                         data_gntpar,
//    output logic         [OBI_CHKW-1:0]  data_rchk,
    output logic         [OBI_DW-1:0]    data_rdata,
    output logic         [OBI_IDW-1:0]   data_rid,
//    output logic         [OBI_USERW-1:0] data_ruser,
    output logic                         data_rvalid,
    output logic                         data_rvalidpar,

    // Interface: obi_core_imem
//    input  logic         [OBI_CHKW-1:0]  instr_achk,
    input  logic         [OBI_AW-1:0]    instr_addr,
    input  logic         [OBI_IDW-1:0]   instr_aid,
//    input  logic         [5:0]           instr_atop,
//    input  logic         [OBI_USERW-1:0] instr_auser,
    input  logic         [OBI_DW/8-1:0]  instr_be,
//    input  logic                         instr_dbg,
//    input  logic         [1:0]           instr_memtype,
//    input  logic         [OBI_IDW-1:0]   instr_mid,
//    input  logic         [2:0]           instr_prot,
    input  logic                         instr_req,
    input  logic                         instr_reqpar,
    input  logic                         instr_rready,
    input  logic                         instr_rreadypar,
    input  logic         [OBI_DW-1:0]    instr_wdata,
    input  logic                         instr_we,
//    input  logic         [OBI_USERW-1:0] instr_wuser,
    output logic                         instr_err,
//    output logic                         instr_exokay,
    output logic                         instr_gnt,
    output logic                         instr_gntpar,
//    output logic         [OBI_CHKW-1:0]  instr_rchk,
    output logic         [OBI_DW-1:0]    instr_rdata,
    output logic         [OBI_IDW-1:0]   instr_rid,
//    output logic         [OBI_USERW-1:0] instr_ruser,
    output logic                         instr_rvalid,
    output logic                         instr_rvalidpar,

    // Interface: obi_dmem
    input  logic                         dmem_err,
//    input  logic                         dmem_exokay,
    input  logic                         dmem_gnt,
    input  logic                         dmem_gntpar,
//    input  logic         [OBI_CHKW-1:0]  dmem_rchk,
    input  logic         [OBI_DW-1:0]    dmem_rdata,
    input  logic         [OBI_IDW-1:0]   dmem_rid,
//    input  logic         [OBI_USERW-1:0] dmem_ruser,
    input  logic                         dmem_rvalid,
    input  logic                         dmem_rvalidpar,
//    output logic         [OBI_CHKW-1:0]  dmem_achk,
    output logic         [OBI_AW-1:0]    dmem_addr,
    output logic         [OBI_IDW-1:0]   dmem_aid,
//    output logic         [5:0]           dmem_atop,
//    output logic         [OBI_USERW-1:0] dmem_auser,
    output logic         [OBI_DW/8-1:0]  dmem_be,
//    output logic                         dmem_dbg,
//    output logic         [1:0]           dmem_memtype,
//    output logic         [OBI_IDW-1:0]   dmem_mid,
//    output logic         [2:0]           dmem_prot,
    output logic                         dmem_req,
    output logic                         dmem_reqpar,
    output logic                         dmem_rready,
    output logic                         dmem_rreadypar,
    output logic         [OBI_DW-1:0]    dmem_wdata,
    output logic                         dmem_we,
//    output logic         [OBI_USERW-1:0] dmem_wuser,

    // Interface: obi_imem
    input  logic                         imem_err,
//    input  logic                         imem_exokay,
    input  logic                         imem_gnt,
    input  logic                         imem_gntpar,
//    input  logic         [OBI_CHKW-1:0]  imem_rchk,
    input  logic         [OBI_DW-1:0]    imem_rdata,
    input  logic         [OBI_IDW-1:0]   imem_rid,
//    input  logic         [OBI_USERW-1:0] imem_ruser,
    input  logic                         imem_rvalid,
    input  logic                         imem_rvalidpar,
//    output logic         [OBI_CHKW-1:0]  imem_achk,
    output logic         [OBI_AW-1:0]    imem_addr,
    output logic         [OBI_IDW-1:0]   imem_aid,
//    output logic         [5:0]           imem_atop,
//    output logic         [OBI_USERW-1:0] imem_auser,
    output logic         [OBI_DW/8-1:0]  imem_be,
//    output logic                         imem_dbg,
//    output logic         [1:0]           imem_memtype,
//    output logic         [OBI_IDW-1:0]   imem_mid,
//    output logic         [2:0]           imem_prot,
    output logic                         imem_req,
    output logic                         imem_reqpar,
    output logic                         imem_rready,
    output logic                         imem_rreadypar,
    output logic         [OBI_DW-1:0]    imem_wdata,
    output logic                         imem_we,
//    output logic         [OBI_USERW-1:0] imem_wuser,

    // Interface: obi_jtag_dm_init
//    input  logic         [OBI_CHKW-1:0]  dm_init_achk,
    input  logic         [OBI_AW-1:0]    dm_init_addr,
    input  logic         [OBI_IDW-1:0]   dm_init_aid,
//    input  logic         [5:0]           dm_init_atop,
//    input  logic         [OBI_USERW-1:0] dm_init_auser,
    input  logic         [OBI_DW/8-1:0]  dm_init_be,
//    input  logic                         dm_init_dbg,
//    input  logic         [1:0]           dm_init_memtype,
//    input  logic         [OBI_IDW-1:0]   dm_init_mid,
//    input  logic         [2:0]           dm_init_prot,
    input  logic                         dm_init_req,
    input  logic                         dm_init_reqpar,
    input  logic                         dm_init_rready,
    input  logic                         dm_init_rreadypar,
    input  logic         [OBI_DW-1:0]    dm_init_wdata,
    input  logic                         dm_init_we,
//    input  logic         [OBI_USERW-1:0] dm_init_wuser,
    output logic                         dm_init_err,
//    output logic                         dm_init_exokay,
    output logic                         dm_init_gnt,
    output logic                         dm_init_gntpar,
//    output logic         [OBI_CHKW-1:0]  dm_init_rchk,
    output logic         [OBI_DW-1:0]    dm_init_rdata,
    output logic         [OBI_IDW-1:0]   dm_init_rid,
//    output logic         [OBI_USERW-1:0] dm_init_ruser,
    output logic                         dm_init_rvalid,
    output logic                         dm_init_rvalidpar,

    // Interface: obi_jtag_dm_target
    input  logic                         dm_target_err,
//    input  logic                         dm_target_exokay,
    input  logic                         dm_target_gnt,
    input  logic                         dm_target_gntpar,
//    input  logic         [OBI_CHKW-1:0]  dm_target_rchk,
    input  logic         [OBI_DW-1:0]    dm_target_rdata,
    input  logic         [OBI_IDW-1:0]   dm_target_rid,
//    input  logic         [OBI_USERW-1:0] dm_target_ruser,
    input  logic                         dm_target_rvalid,
    input  logic                         dm_target_rvalidpar,
//    output logic         [OBI_CHKW-1:0]  dm_target_achk,
    output logic         [OBI_AW-1:0]    dm_target_addr,
    output logic         [OBI_IDW-1:0]   dm_target_aid,
//    output logic         [5:0]           dm_target_atop,
//    output logic         [OBI_USERW-1:0] dm_target_auser,
    output logic         [OBI_DW/8-1:0]  dm_target_be,
//    output logic                         dm_target_dbg,
//    output logic         [1:0]           dm_target_memtype,
//    output logic         [OBI_IDW-1:0]   dm_target_mid,
//    output logic         [2:0]           dm_target_prot,
    output logic                         dm_target_req,
    output logic                         dm_target_reqpar,
    output logic                         dm_target_rready,
    output logic                         dm_target_rreadypar,
    output logic         [OBI_DW-1:0]    dm_target_wdata,
    output logic                         dm_target_we,
//    output logic         [OBI_USERW-1:0] dm_target_wuser,

    // Interface: obi_peripherals
    input  logic                         periph_err,
//    input  logic                         periph_exokay,
    input  logic                         periph_gnt,
    input  logic                         periph_gntpar,
//    input  logic         [OBI_CHKW-1:0]  periph_rchk,
    input  logic         [OBI_DW-1:0]    periph_rdata,
    input  logic         [OBI_IDW-1:0]   periph_rid,
//    input  logic         [OBI_USERW-1:0] periph_ruser,
    input  logic                         periph_rvalid,
    input  logic                         periph_rvalidpar,
//    output logic         [OBI_CHKW-1:0]  periph_achk,
    output logic         [OBI_AW-1:0]    periph_addr,
    output logic         [OBI_IDW-1:0]   periph_aid,
//    output logic         [5:0]           periph_atop,
//    output logic         [OBI_USERW-1:0] periph_auser,
    output logic         [OBI_DW/8-1:0]  periph_be,
//    output logic                         periph_dbg,
//    output logic         [1:0]           periph_memtype,
//    output logic         [OBI_IDW-1:0]   periph_mid,
//    output logic         [2:0]           periph_prot,
    output logic                         periph_req,
    output logic                         periph_reqpar,
    output logic                         periph_rready,
    output logic                         periph_rreadypar,
    output logic         [OBI_DW-1:0]    periph_wdata,
    output logic                         periph_we,
//    output logic         [OBI_USERW-1:0] periph_wuser,

    // Interface: obi_ctrl
    input  logic                         ctrl_err,
//    input  logic                         ctrl_exokay,
    input  logic                         ctrl_gnt,
    input  logic                         ctrl_gntpar,
//    input  logic         [OBI_CHKW-1:0]  ctrl_rchk,
    input  logic         [OBI_DW-1:0]    ctrl_rdata,
    input  logic         [OBI_IDW-1:0]   ctrl_rid,
//    input  logic         [OBI_USERW-1:0] ctrl_ruser,
    input  logic                         ctrl_rvalid,
    input  logic                         ctrl_rvalidpar,
//  output logic         [OBI_CHKW-1:0]  ctrl_achk,
    output logic         [OBI_AW-1:0]    ctrl_addr,
    output logic         [OBI_IDW-1:0]   ctrl_aid,
//    output logic         [5:0]           ctrl_atop,
//    output logic         [OBI_USERW-1:0] ctrl_auser,
    output logic         [OBI_DW/8-1:0]  ctrl_be,
//    output logic                         ctrl_dbg,
//    output logic         [1:0]           ctrl_memtype,
//    output logic         [OBI_IDW-1:0]   ctrl_mid,
//    output logic         [2:0]           ctrl_prot,
    output logic                         ctrl_req,
    output logic                         ctrl_reqpar,
    output logic                         ctrl_rready,
    output logic                         ctrl_rreadypar,
    output logic         [OBI_DW-1:0]    ctrl_wdata,
    output logic                         ctrl_we,
//    output logic         [OBI_USERW-1:0] ctrl_wuser,

    // Interface: reset
    input  logic                         reset_n
);

  localparam TARGETS = 6;
  localparam INITIATORS = 3;
  localparam XBAR_INITIATOR_CUTS =0;
  localparam XBAR_TARGET_CUTS =0;
  
  OBI_BUS #(.OBI_CFG(obi_pkg::ObiDefaultConfig)) target_bus [TARGETS-1:0]();
  OBI_BUS #(.OBI_CFG(obi_pkg::ObiDefaultConfig)) target_bus_cut [TARGETS-1:0]();
  OBI_BUS #(.OBI_CFG(obi_pkg::ObiDefaultConfig)) initiator_bus [INITIATORS-1:0] ();
  OBI_BUS #(.OBI_CFG(obi_pkg::ObiDefaultConfig)) initiator_bus_cut [INITIATORS-1:0] ();

  if(XBAR_INITIATOR_CUTS) begin
    for (genvar i = 0; i < INITIATORS; i++) begin : initiator_cuts
      obi_cut_intf #(
        .Bypass(1'b0)
      ) i_initiator_cut(
        .clk_i(clk),
        .rst_ni(reset_n),
        .obi_s(initiator_bus[i]),
        .obi_m(initiator_bus_cut[i])
      );
    end
  end
  else begin
    for (genvar i = 0; i < INITIATORS; i++) begin : initiator_no_cut
      obi_cut_intf #(
        .Bypass(1'b1)
      ) i_initiator_bypass_cut(
        .clk_i(clk),
        .rst_ni(reset_n),
        .obi_s(initiator_bus[i]),
        .obi_m(initiator_bus_cut[i])
      );

    end
  end
  if(XBAR_TARGET_CUTS) begin
    for (genvar i = 0; i < TARGETS; i++) begin : target_cuts
      obi_cut_intf #(
        .Bypass(1'b0)
      ) i_target_cut(
        .clk_i(clk),
        .rst_ni(reset_n),
        .obi_s(target_bus[i]),
        .obi_m(target_bus_cut[i])
      );
    end
  end
  else begin
    for (genvar i = 0; i < TARGETS; i++) begin : target_cuts
      obi_cut_intf #(
        .Bypass(1'b1)
      ) i_target_bypass_cut(
        .clk_i(clk),
        .rst_ni(reset_n),
        .obi_s(target_bus[i]),
        .obi_m(target_bus_cut[i])
      );
    end
  end

  localparam ADDR_BASE   = 32'h0100_0000;
  localparam TARGET_SIZE = 'h1_0000;

  typedef struct packed {
    int unsigned idx;
    int unsigned start_addr;
    int unsigned end_addr;
  } addr_rule_t;

  addr_rule_t [TARGETS-1:0] AddrMapXBAR;

  assign AddrMapXBAR = 
    '{
      '{idx: 32'd0, start_addr: ADDR_BASE+TARGET_SIZE*5, end_addr: ADDR_BASE+TARGET_SIZE*6},//icn. 
      '{idx: 32'd1, start_addr: ADDR_BASE+TARGET_SIZE*4, end_addr: ADDR_BASE+TARGET_SIZE*5},//ctrl
      '{idx: 32'd2, start_addr: ADDR_BASE+TARGET_SIZE*3, end_addr: ADDR_BASE+TARGET_SIZE*4},//periph
      '{idx: 32'd3, start_addr: ADDR_BASE+TARGET_SIZE*2, end_addr: ADDR_BASE+TARGET_SIZE*3},//dbg
      '{idx: 32'd4, start_addr: ADDR_BASE+TARGET_SIZE*1, end_addr: ADDR_BASE+TARGET_SIZE*2},//dmem
      '{idx: 32'd5, start_addr: ADDR_BASE+TARGET_SIZE*0, end_addr: ADDR_BASE+TARGET_SIZE*1} //imem
    };

  obi_xbar_intf #(
      .NumSbrPorts       (INITIATORS),
      .NumMgrPorts       (TARGETS),
      .NumMaxTrans       (1),
      .NumAddrRules      (TARGETS),
      .addr_map_rule_t   (addr_rule_t),
      .UseIdForRouting   (0)
  ) i_sysctrl_main_obi_xbar (
      .clk_i            (clk),
      .rst_ni           (reset_n),
      .testmode_i       (1'b0),
      .sbr_ports        (initiator_bus_cut),
      .mgr_ports        (target_bus),
      .addr_map_i       (AddrMapXBAR),
      .en_default_idx_i ('0),
      .default_idx_i    ('0)
  );

  // obi xbar is passing through only minimal signals with default so tieoff rready
  for (genvar i=0; i<TARGETS;i++) begin : tieoff_optionals
    //assign target_bus[i].rready    = 1'b1;
    //assign target_bus[i].rreadypar = 1'b0;
    //assign target_bus_cut[i].rready    = 1'b1;
    //assign target_bus_cut[i].rreadypar = 1'b0;
  end

  // Interface: obi_imem
  assign target_bus_cut[0].err = imem_err;
//  assign target_bus_cut[0].exokay = imem_exokay;
  assign target_bus_cut[0].gnt = imem_gnt;
  assign target_bus_cut[0].gntpar = imem_gntpar;
//  assign target_bus_cut[0].rchk = imem_rchk;
  assign target_bus_cut[0].rdata = imem_rdata;
  assign target_bus_cut[0].rid = imem_rid;
//  assign target_bus_cut[0].ruser = imem_ruser;
  assign target_bus_cut[0].rvalid = imem_rvalid;
  assign target_bus_cut[0].rvalidpar = imem_rvalidpar;
//  assign imem_achk = target_bus_cut[0].achk;
  assign imem_addr = target_bus_cut[0].addr;
  assign imem_aid = target_bus_cut[0].aid;
//  assign imem_atop = target_bus_cut[0].atop;
//  assign imem_auser = target_bus_cut[0].auser;
  assign imem_be = target_bus_cut[0].be;
//  assign imem_dbg = target_bus_cut[0].dbg;
//  assign imem_memtype = target_bus_cut[0].memtype;
//  assign imem_mid = target_bus_cut[0].mid;
//  assign imem_prot = target_bus_cut[0].prot;
  assign imem_req = target_bus_cut[0].req;
  assign imem_reqpar = target_bus_cut[0].reqpar;
  assign imem_rready = target_bus_cut[0].rready;
  assign imem_rreadypar = target_bus_cut[0].rreadypar;
  assign imem_wdata = target_bus_cut[0].wdata;
  assign imem_we = target_bus_cut[0].we;
//  assign imem_wuser = target_bus_cut[0].wuser;

    // Interface: obi_dmem
  assign target_bus_cut[1].err = dmem_err;
//  assign target_bus_cut[1].exokay = dmem_exokay;
  assign target_bus_cut[1].gnt = dmem_gnt;
  assign target_bus_cut[1].gntpar = dmem_gntpar;
//  assign target_bus_cut[1].rchk = dmem_rchk;
  assign target_bus_cut[1].rdata = dmem_rdata;
  assign target_bus_cut[1].rid = dmem_rid;
//  assign target_bus_cut[1].ruser = dmem_ruser;
  assign target_bus_cut[1].rvalid = dmem_rvalid;
  assign target_bus_cut[1].rvalidpar = dmem_rvalidpar;
//  assign dmem_achk = target_bus_cut[1].achk;
  assign dmem_addr = target_bus_cut[1].addr;
  assign dmem_aid = target_bus_cut[1].aid;
//  assign dmem_atop = target_bus_cut[1].atop;
//  assign dmem_auser = target_bus_cut[1].auser;
  assign dmem_be = target_bus_cut[1].be;
//  assign dmem_dbg = target_bus_cut[1].dbg;
//  assign dmem_memtype = target_bus_cut[1].memtype;
//  assign dmem_mid = target_bus_cut[1].mid;
 // assign dmem_prot = target_bus_cut[1].prot;
  assign dmem_req = target_bus_cut[1].req;
  assign dmem_reqpar = target_bus_cut[1].reqpar;
  assign dmem_rready = target_bus_cut[1].rready;
  assign dmem_rreadypar = target_bus_cut[1].rreadypar;
  assign dmem_wdata = target_bus_cut[1].wdata;
  assign dmem_we = target_bus_cut[1].we;
//  assign dmem_wuser = target_bus_cut[1].wuser;

  // Interface: obi_jtag_dm_target
  assign target_bus_cut[2].err = dm_target_err;
//  assign target_bus_cut[2].exokay = dm_target_exokay;
  assign target_bus_cut[2].gnt = dm_target_gnt;
  assign target_bus_cut[2].gntpar = dm_target_gntpar;
//  assign target_bus_cut[2].rchk = dm_target_rchk;
  assign target_bus_cut[2].rdata = dm_target_rdata;
  assign target_bus_cut[2].rid = dm_target_rid;
//  assign target_bus_cut[2].ruser = dm_target_ruser;
  assign target_bus_cut[2].rvalid = dm_target_rvalid;
  assign target_bus_cut[2].rvalidpar = dm_target_rvalidpar;
//  assign dm_target_achk = target_bus_cut[2].achk;
  assign dm_target_addr = target_bus_cut[2].addr;
  assign dm_target_aid = target_bus_cut[2].aid;
//  assign dm_target_atop = target_bus_cut[2].atop;
 // assign dm_target_auser = target_bus_cut[2].auser;
  assign dm_target_be = target_bus_cut[2].be;
 // assign dm_target_dbg = target_bus_cut[2].dbg;
 // assign dm_target_memtype = target_bus_cut[2].memtype;
 // assign dm_target_mid = target_bus_cut[2].mid;
 // assign dm_target_prot = target_bus_cut[2].prot;
  assign dm_target_req = target_bus_cut[2].req;
  assign dm_target_reqpar = target_bus_cut[2].reqpar;
  assign dm_target_rready = target_bus_cut[2].rready;
  assign dm_target_rreadypar = target_bus_cut[2].rreadypar;
  assign dm_target_wdata = target_bus_cut[2].wdata;
  assign dm_target_we = target_bus_cut[2].we;
 // assign dm_target_wuser = target_bus_cut[2].wuser;

  // Interface: obi_peripherals
  assign target_bus_cut[3].err = periph_err;
//  assign target_bus_cut[3].exokay = periph_exokay;
  assign target_bus_cut[3].gnt = periph_gnt;
  assign target_bus_cut[3].gntpar = periph_gntpar;
//  assign target_bus_cut[3].rchk = periph_rchk;
  assign target_bus_cut[3].rdata = periph_rdata;
  assign target_bus_cut[3].rid = periph_rid;
//  assign target_bus_cut[3].ruser = periph_ruser;
  assign target_bus_cut[3].rvalid = periph_rvalid;
  assign target_bus_cut[3].rvalidpar = periph_rvalidpar;
 // assign periph_achk = target_bus_cut[3].achk;
  assign periph_addr = target_bus_cut[3].addr;
  assign periph_aid = target_bus_cut[3].aid;
//  assign periph_atop = target_bus_cut[3].atop;
 // assign periph_auser = target_bus_cut[3].auser;
  assign periph_be = target_bus_cut[3].be;
//  assign periph_dbg = target_bus_cut[3].dbg;
 // assign periph_memtype = target_bus_cut[3].memtype;
//  assign periph_mid = target_bus_cut[3].mid;
//  assign periph_prot = target_bus_cut[3].prot;
  assign periph_req = target_bus_cut[3].req;
  assign periph_reqpar = target_bus_cut[3].reqpar;
  assign periph_rready = target_bus_cut[3].rready;
  assign periph_rreadypar = target_bus_cut[3].rreadypar;
  assign periph_wdata = target_bus_cut[3].wdata;
  assign periph_we = target_bus_cut[3].we;
//  assign periph_wuser = target_bus_cut[3].wuser;

  // Interface: obi_ctrl
  assign target_bus_cut[4].err = ctrl_err;
 // assign target_bus_cut[4].exokay = ctrl_exokay;
  assign target_bus_cut[4].gnt = ctrl_gnt;
  assign target_bus_cut[4].gntpar = ctrl_gntpar;
//  assign target_bus_cut[4].rchk = ctrl_rchk;
  assign target_bus_cut[4].rdata = ctrl_rdata;
  assign target_bus_cut[4].rid = ctrl_rid;
//  assign target_bus_cut[4].ruser = ctrl_ruser;
  assign target_bus_cut[4].rvalid = ctrl_rvalid;
  assign target_bus_cut[4].rvalidpar = ctrl_rvalidpar;
//  assign ctrl_achk = target_bus_cut[4].achk;
  assign ctrl_addr = target_bus_cut[4].addr;
  assign ctrl_aid = target_bus_cut[4].aid;
//  assign ctrl_atop = target_bus_cut[4].atop;
//  assign ctrl_auser = target_bus_cut[4].auser;
  assign ctrl_be = target_bus_cut[4].be;
//  assign ctrl_dbg = target_bus_cut[4].dbg;
//  assign ctrl_memtype = target_bus_cut[4].memtype;
//  assign ctrl_mid = target_bus_cut[4].mid;
//  assign ctrl_prot = target_bus_cut[4].prot;
  assign ctrl_req = target_bus_cut[4].req;
  assign ctrl_reqpar = target_bus_cut[4].reqpar;
  assign ctrl_rready = target_bus_cut[4].rready;
  assign ctrl_rreadypar = target_bus_cut[4].rreadypar;
  assign ctrl_wdata = target_bus_cut[4].wdata;
  assign ctrl_we = target_bus_cut[4].we;
//  assign ctrl_wuser = target_bus_cut[4].wuser;

  // Interface: obi_chip_top
  assign target_bus_cut[5].err = top_err;
//  assign target_bus_cut[5].exokay = top_exokay;
  assign target_bus_cut[5].gnt = top_gnt;
  assign target_bus_cut[5].gntpar = top_gntpar;
//  assign target_bus_cut[5].rchk = top_rchk;
  assign target_bus_cut[5].rdata = top_rdata;
  assign target_bus_cut[5].rid = top_rid;
//  assign target_bus_cut[5].ruser = top_ruser;
  assign target_bus_cut[5].rvalid = top_rvalid;
  assign target_bus_cut[5].rvalidpar = top_rvalidpar;
//  assign top_achk = target_bus_cut[5].achk;
  assign top_addr = target_bus_cut[5].addr;
  assign top_aid = target_bus_cut[5].aid;
//  assign top_atop = target_bus_cut[5].atop;
 // assign top_auser = target_bus_cut[5].auser;
  assign top_be = target_bus_cut[5].be;
//  assign top_dbg = target_bus_cut[5].dbg;
//  assign top_memtype = target_bus_cut[5].memtype;
//  assign top_mid = target_bus_cut[5].mid;
//  assign top_prot = target_bus_cut[5].prot;
  assign top_req = target_bus_cut[5].req;
  assign top_reqpar = target_bus_cut[5].reqpar;
  assign top_rready = target_bus_cut[5].rready;
  assign top_rreadypar = target_bus_cut[5].rreadypar;
  assign top_wdata = target_bus_cut[5].wdata;
  assign top_we = target_bus_cut[5].we;
//  assign top_wuser = target_bus_cut[5].wuser;

  // Interface: obi_core_imem
//  assign initiator_bus[0].achk = instr_achk;
  assign initiator_bus[0].addr = instr_addr;
  assign initiator_bus[0].aid = instr_aid;
//  assign initiator_bus[0].atop = instr_atop;
//  assign initiator_bus[0].auser = instr_auser;
  assign initiator_bus[0].be = instr_be;
//  assign initiator_bus[0].dbg = instr_dbg;
//  assign initiator_bus[0].memtype = instr_memtype;
//  assign initiator_bus[0].mie = instr_mid;
//  assign initiator_bus[0].prot = instr_prot;
  assign initiator_bus[0].req = instr_req;
  assign initiator_bus[0].reqpar = instr_reqpar;
  assign initiator_bus[0].rready = instr_rready;
  assign initiator_bus[0].rreadypar = instr_rreadypar;
  assign initiator_bus[0].wdata = instr_wdata;
  assign initiator_bus[0].we = instr_we;
//  assign initiator_bus[0].wuser = instr_wuser;
  assign instr_err = initiator_bus[0].err;
//  assign instr_exokay = initiator_bus[0].exokay;
  assign instr_gnt = initiator_bus[0].gnt;
  assign instr_gntpar = initiator_bus[0].gntpar;
//  assign instr_rchk = initiator_bus[0].rchk;
  assign instr_rdata = initiator_bus[0].rdata;
  assign instr_rid = initiator_bus[0].rid;
//  assign instr_ruser = initiator_bus[0].ruser;
  assign instr_rvalid = initiator_bus[0].rvalid;
  assign instr_rvalidpar = initiator_bus[0].rvalidpar;

  // Interface: obi_core_dmem
//  assign initiator_bus[1].achk = data_achk;
  assign initiator_bus[1].addr = data_addr;
  assign initiator_bus[1].aid = data_aid;
//  assign initiator_bus[1].atop = data_atop;
//  assign initiator_bus[1].auser = data_auser;
  assign initiator_bus[1].be = data_be;
//  assign initiator_bus[1].dbg = data_dbg;
//  assign initiator_bus[1].memtype = data_memtype;
//  assign initiator_bus[1].mid = data_mid;
 // assign initiator_bus[1].prot = data_prot;
  assign initiator_bus[1].req = data_req;
  assign initiator_bus[1].reqpar = data_reqpar;
  assign initiator_bus[1].rready = data_rready;
  assign initiator_bus[1].rreadypar = data_rreadypar;
  assign initiator_bus[1].wdata = data_wdata;
  assign initiator_bus[1].we = data_we;
//  assign initiator_bus[1].wuser = data_wuser;
  assign data_err = initiator_bus[1].err;
//  assign data_exokay = initiator_bus[1].exokay;
  assign data_gnt = initiator_bus[1].gnt;
  assign data_gntpar = initiator_bus[1].gntpar;
//  assign data_rchk = initiator_bus[1].rchk;
  assign data_rdata = initiator_bus[1].rdata;
  assign data_rid = initiator_bus[1].rid;
//  assign data_ruser = initiator_bus[1].ruser;
  assign data_rvalid = initiator_bus[1].rvalid;
  assign data_rvalidpar = initiator_bus[1].rvalidpar;

  // Interface: obi_jtag_dm_init
//  assign initiator_bus[2].achk = dm_init_achk;
  assign initiator_bus[2].addr = dm_init_addr;
  assign initiator_bus[2].aid = dm_init_aid;
//  assign initiator_bus[2].atop = dm_init_atop;
//  assign initiator_bus[2].auser = dm_init_auser;
  assign initiator_bus[2].be = dm_init_be;
 // assign initiator_bus[2].dbg = dm_init_dbg;
 // assign initiator_bus[2].memtype = dm_init_memtype;
 // assign initiator_bus[2].mid = dm_init_mid;
 // assign initiator_bus[2].prot = dm_init_prot;
  assign initiator_bus[2].req = dm_init_req;
  assign initiator_bus[2].reqpar = dm_init_reqpar;
  assign initiator_bus[2].rready = dm_init_rready;
  assign initiator_bus[2].rreadypar = dm_init_rreadypar;
  assign initiator_bus[2].wdata = dm_init_wdata;
  assign initiator_bus[2].we = dm_init_we;
//  assign initiator_bus[2].wuser = dm_init_wuser;
  assign dm_init_err = initiator_bus[2].err;
//  assign dm_init_exokay = initiator_bus[2].exokay;
  assign dm_init_gnt = initiator_bus[2].gnt;
  assign dm_init_gntpar = initiator_bus[2].gntpar;
//  assign dm_init_rchk = initiator_bus[2].rchk;
  assign dm_init_rdata = initiator_bus[2].rdata;
  assign dm_init_rid = initiator_bus[2].rid;
//  assign dm_init_ruser = initiator_bus[2].ruser;
  assign dm_init_rvalid = initiator_bus[2].rvalid;
  assign dm_init_rvalidpar = initiator_bus[2].rvalidpar;

endmodule
