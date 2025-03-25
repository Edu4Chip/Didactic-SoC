
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * split OBI Bus to 4x APB

*/

module obi_icn_ss #(
    parameter                   OBI_AW    = 32,
    parameter                   OBI_CHKW  = 1,
    parameter                   OBI_DW    = 32,
    parameter                   OBI_IDW   = 1,
    parameter                   OBI_USERW = 1,
    parameter                   APB_DW    = 32,
    parameter                   APB_AW    = 32,
    parameter                   SS_CTRL_W = 7
  )(
    // Interface: apb_0
    input  logic   [APB_DW-1:0] APB_0_PRDATA,
    input  logic                APB_0_PREADY,
    input  logic                APB_0_PSLVERR,
    output logic   [APB_AW-1:0] APB_0_PADDR,
    output logic                APB_0_PENABLE,
    output logic                APB_0_PSEL,
    output logic   [APB_DW-1:0] APB_0_PWDATA,
    output logic                APB_0_PWRITE,
    output logic [APB_DW/8-1:0] APB_0_PSTRB,

    // Interface: apb_1
    input  logic   [APB_DW-1:0] APB_1_PRDATA,
    input  logic                APB_1_PREADY,
    input  logic                APB_1_PSLVERR,
    output logic   [APB_AW-1:0] APB_1_PADDR,
    output logic                APB_1_PENABLE,
    output logic                APB_1_PSEL,
    output logic   [APB_DW-1:0] APB_1_PWDATA,
    output logic                APB_1_PWRITE,
    output logic [APB_DW/8-1:0] APB_1_PSTRB,

    // Interface: apb_2
    input  logic   [APB_DW-1:0] APB_2_PRDATA,
    input  logic                APB_2_PREADY,
    input  logic                APB_2_PSLVERR,
    output logic   [APB_AW-1:0] APB_2_PADDR,
    output logic                APB_2_PENABLE,
    output logic                APB_2_PSEL,
    output logic   [APB_DW-1:0] APB_2_PWDATA,
    output logic                APB_2_PWRITE,
    output logic [APB_DW/8-1:0] APB_2_PSTRB,

    // Interface: apb_3
    input  logic   [APB_DW-1:0] APB_3_PRDATA,
    input  logic                APB_3_PREADY,
    input  logic                APB_3_PSLVERR,
    output logic   [APB_AW-1:0] APB_3_PADDR,
    output logic                APB_3_PENABLE,
    output logic                APB_3_PSEL,
    output logic   [APB_DW-1:0] APB_3_PWDATA,
    output logic                APB_3_PWRITE,
    output logic [APB_DW/8-1:0] APB_3_PSTRB,

    // Interface: clock
    input  logic                  clk,

    // Interface: obi_sysctrl
    input   logic [OBI_CHKW-1:0]  obi_achk,
    input   logic [OBI_AW-1:0]    obi_addr,
    input   logic [OBI_IDW-1:0]   obi_aid,
    input   logic [5:0]           obi_atop,
    input   logic [OBI_USERW-1:0] obi_auser,
    input   logic [OBI_DW/8-1:0]  obi_be,
    input   logic                 obi_dbg,
    input   logic [1:0]           obi_memtype,
    input   logic [OBI_IDW-1:0]   obi_mid,
    input   logic [2:0]           obi_prot,
    input   logic                 obi_req,
    input   logic                 obi_reqpar,
    input   logic                 obi_rready,
    input   logic                 obi_rreadypar,
    input   logic [OBI_DW-1:0]    obi_wdata,
    input   logic                 obi_we,
    input   logic [OBI_USERW-1:0] obi_wuser,
    output  logic                 obi_err,
    output  logic                 obi_exokay,
    output  logic                 obi_gnt,
    output  logic                 obi_gntpar,
    output  logic [OBI_CHKW-1:0]  obi_rchk,
    output  logic [OBI_DW-1:0]    obi_rdata,
    output  logic [OBI_IDW-1:0]   obi_rid,
    output  logic [OBI_USERW-1:0] obi_ruser,
    output  logic                 obi_rvalid,
    output  logic                 obi_rvalidpar,

    // Interface: SS_Ctrl
    input  logic [SS_CTRL_W-1:0]            ss_ctrl_icn,


    // Interface: reset
    input  logic                  reset_n
  );

  localparam TARGETS = 4;
  localparam INITIATORS = 1;

  // bus defaults 32 
  OBI_BUS #() target_bus [TARGETS-1:0]();
  OBI_BUS #() initiator_bus [INITIATORS-1:0] ();
  APB #() icn_bus [TARGETS-1:0] ();

  typedef struct packed {
    int unsigned idx;
    int unsigned start_addr;
    int unsigned end_addr;
  } addr_rule_t;

  localparam ADDR_BASE   = 32'h0103_0000;
  localparam SS_SIZE    = 'h100;

  addr_rule_t [TARGETS-1:0] icn_addr_map;

  assign icn_addr_map =
    '{
      '{idx: 32'd3, start_addr: ADDR_BASE+SS_SIZE*3, end_addr: ADDR_BASE+SS_SIZE*4-1},//
      '{idx: 32'd2, start_addr: ADDR_BASE+SS_SIZE*2, end_addr: ADDR_BASE+SS_SIZE*3-1},//
      '{idx: 32'd1, start_addr: ADDR_BASE+SS_SIZE*1, end_addr: ADDR_BASE+SS_SIZE*2-1},//
      '{idx: 32'd0, start_addr: ADDR_BASE+SS_SIZE*0, end_addr: ADDR_BASE+SS_SIZE*1-1} //
     };

  obi_xbar_intf #(
    .NumSbrPorts       (INITIATORS),
    .NumMgrPorts       (TARGETS),
    .NumMaxTrans       (1),
    .NumAddrRules      (INITIATORS),
    .addr_map_rule_t   (addr_rule_t),
    .UseIdForRouting   (0)
  ) i_peripheral_obi_xbar (
    .clk_i            (clk),
    .rst_ni           (reset_n),
    .testmode_i       (1'b0),
    .sbr_ports        (initiator_bus),
    .mgr_ports        (target_bus),
    .addr_map_i       (icn_addr_map),
    .en_default_idx_i ('0),
    .default_idx_i    ('0)
  );
  
  obi_to_apb_intf #() i_obi_to_apb_0 (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus[0]),
    .apb_o (icn_bus[0])
  );

  obi_to_apb_intf #() i_obi_to_apb_1 (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus[1]),
    .apb_o (icn_bus[1])
  );

  obi_to_apb_intf #() i_obi_to_apb_2 (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus[2]),
    .apb_o (icn_bus[2])
  );

  obi_to_apb_intf #() i_obi_to_apb_3 (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus[3]),
    .apb_o (icn_bus[3])
  );

   // Interface: apb_gpio
   assign icn_bus[0].prdata = APB_0_PRDATA;
   assign icn_bus[0].pready = APB_0_PREADY;
   assign icn_bus[0].pslverr = APB_0_PSLVERR;
   assign APB_0_PADDR = icn_bus[0].paddr;
   assign APB_0_PENABLE = icn_bus[0].penable;
   assign APB_0_PSEL = icn_bus[0].psel;
   assign APB_0_PWDATA = icn_bus[0].pwdata;
   assign APB_0_PWRITE = icn_bus[0].pwrite;
   assign APB_0_PSTRB = icn_bus[0].pstrb;

  // Interface: apb_uart
   assign icn_bus[1].prdata =  APB_1_PRDATA;
   assign icn_bus[1].pready =  APB_1_PREADY;
   assign icn_bus[1].pslverr = APB_1_PSLVERR;
   assign APB_1_PADDR = icn_bus[1].paddr;
   assign APB_1_PENABLE = icn_bus[1].penable;
   assign APB_1_PSEL = icn_bus[1].psel;
   assign APB_1_PWDATA = icn_bus[1].pwdata;
   assign APB_1_PWRITE = icn_bus[1].pwrite;
   assign APB_1_PSTRB = icn_bus[1].pstrb;
 
  // Interface: apb_spi
  assign icn_bus[2].prdata = APB_2_PRDATA;
  assign icn_bus[2].pready = APB_2_PREADY;
  assign icn_bus[2].pslverr = APB_2_PSLVERR;
  assign APB_2_PADDR = icn_bus[2].paddr;
  assign APB_2_PENABLE = icn_bus[2].penable;
  assign APB_2_PSEL = icn_bus[2].psel;
  assign APB_2_PWDATA = icn_bus[2].pwdata;
  assign APB_2_PWRITE = icn_bus[2].pwrite;
  assign APB_2_PSTRB = icn_bus[2].pstrb;

  // Interface: apb_spi
  assign icn_bus[2].prdata = APB_3_PRDATA;
  assign icn_bus[2].pready = APB_3_PREADY;
  assign icn_bus[2].pslverr = APB_3_PSLVERR;
  assign APB_3_PADDR = icn_bus[2].paddr;
  assign APB_3_PENABLE = icn_bus[2].penable;
  assign APB_3_PSEL = icn_bus[2].psel;
  assign APB_3_PWDATA = icn_bus[2].pwdata;
  assign APB_3_PWRITE = icn_bus[2].pwrite;
  assign APB_3_PSTRB = icn_bus[2].pstrb;

  // Interface: obi
  assign initiator_bus.achk = obi_achk;
  assign initiator_bus.addr = obi_addr;
  assign initiator_bus.aid = obi_aid;
  assign initiator_bus.atop = obi_atop;
  assign initiator_bus.auser = obi_auser;
  assign initiator_bus.be = obi_be;
  assign initiator_bus.dbg = obi_dbg;
  assign initiator_bus.memtype = obi_memtype;
  assign initiator_bus.mid = obi_mid;
  assign initiator_bus.prot = obi_prot;
  assign initiator_bus.req = obi_req;
  assign initiator_bus.reqpar = obi_reqpar;
  assign initiator_bus.rready = obi_rready;
  assign initiator_bus.rreadypar = obi_rreadypar;
  assign initiator_bus.wdata = obi_wdata;
  assign initiator_bus.we = obi_we;
  assign initiator_bus.wuser = obi_wuser;

  // a optional signals such as achk etc
  // assign initiator_bus.a_optional = 'h0;
  // r opional sigans such as ruser
  // initiator_bus.r_optional

  assign obi_err = initiator_bus.err;
  assign obi_exokay = initiator_bus.exokay;
  assign obi_gnt = initiator_bus.gnt;
  assign obi_gntpar = initiator_bus.gntpar;
  assign obi_rchk = initiator_bus.rchk;
  assign obi_rdata = initiator_bus.rdata;
  assign obi_rid = initiator_bus.rid;
  assign obi_ruser = initiator_bus.ruser;
  assign obi_rvalid = initiator_bus.rvalid;
  assign obi_rvalidpar = initiator_bus.rvalidpar;

endmodule
