//-----------------------------------------------------------------------------
// File          : peripherals_obi_to_apb.v
// Creation date : 21.03.2025
// Creation time : 15:10:01
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:interconnect:peripherals_obi_to_apb:1.0
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * split OBI Bus to 3x APB

*/

module peripherals_obi_to_apb #(
    parameter                              OBI_AW           = 32,
    parameter                              OBI_CHKW         = 1,
    parameter                              OBI_DW           = 32,
    parameter                              OBI_IDW          = 1,
    parameter                              OBI_USERW        = 1
) (
    // Interface: apb_gpio
    input  logic         [31:0]         APB_GPIO_PRDATA,
    input  logic                        APB_GPIO_PREADY,
    input  logic                        APB_GPIO_PSLVERR,
    output logic         [11:0]          APB_GPIO_PADDR,
    output logic                        APB_GPIO_PENABLE,
    output logic                        APB_GPIO_PSEL,
    output logic         [31:0]         APB_GPIO_PWDATA,
    output logic                        APB_GPIO_PWRITE,

    // Interface: apb_spi
    input  logic         [31:0]         APB_SPI_PRDATA,
    input  logic                        APB_SPI_PREADY,
    input  logic                        APB_SPI_PSLVERR,
    output logic         [11:0]         APB_SPI_PADDR,
    output logic                        APB_SPI_PENABLE,
    output logic                        APB_SPI_PSEL,
    output logic         [31:0]         APB_SPI_PWDATA,
    output logic                        APB_SPI_PWRITE,

    // Interface: apb_uart
    input  logic         [31:0]         APB_UART_PRDATA,
    input  logic                        APB_UART_PREADY,
    input  logic                        APB_UART_PSLVERR,
    output logic         [11:0]         APB_UART_PADDR,
    output logic                        APB_UART_PENABLE,
    output logic                        APB_UART_PSEL,
    output logic         [31:0]         APB_UART_PWDATA,
    output logic                        APB_UART_PWRITE,

    // Interface: clock
    input  logic                        clk,

    // Interface: obi
//    input   logic        [OBI_CHKW-1:0] achk,
    input   logic        [OBI_AW-1:0]   addr,
    input   logic        [OBI_IDW-1:0]  aid,
//    input   logic        [5:0]          atop,
//    input   logic        [OBI_USERW-1:0] auser,
    input   logic        [OBI_DW/8-1:0] be,
//    input   logic                       dbg,
//    input   logic        [1:0]          memtype,
//    input   logic        [OBI_IDW-1:0]  mid,
//    input   logic        [2:0]          prot,
    input   logic                       req,
    input   logic                       reqpar,
    input   logic                       rready,
    input   logic                       rreadypar,
    input   logic        [OBI_DW-1:0]   wdata,
    input   logic                       we,
//    input   logic        [OBI_USERW-1:0] wuser,
    output  logic                       err,
//    output  logic                       exokay,
    output  logic                       gnt,
    output  logic                       gntpar,
//    output  logic        [OBI_CHKW-1:0] rchk,
    output  logic        [OBI_DW-1:0]   rdata,
    output  logic        [OBI_IDW-1:0]  rid,
//    output  logic        [OBI_USERW-1:0] ruser,
    output  logic                       rvalid,
    output  logic                       rvalidpar,

    // Interface: reset
    input  logic                        reset_n
);
  localparam TARGETS = 3;
  localparam INITIATORS = 1+1;// connection + tieoff initiator
  localparam PERIPH_INITIATOR_CUTS =0;
  localparam PERIPH_TARGET_CUTS =0;


  typedef struct packed {
    int unsigned idx;
    int unsigned start_addr;
    int unsigned end_addr;
  } addr_rule_t;

  localparam ADDR_BASE   = 32'h0103_0000;
  localparam APB_SIZE    = 'h100;

  addr_rule_t [TARGETS-1:0] peripheral_addr_map;

  assign peripheral_addr_map =
    '{
      '{idx: 32'd0, start_addr: ADDR_BASE+APB_SIZE*2, end_addr: ADDR_BASE+APB_SIZE*3},//spi
      '{idx: 32'd1, start_addr: ADDR_BASE+APB_SIZE*1, end_addr: ADDR_BASE+APB_SIZE*2},//uart
      '{idx: 32'd2, start_addr: ADDR_BASE+APB_SIZE*0, end_addr: ADDR_BASE+APB_SIZE*1} //gpio
     };
/*
  // bus defaults 32 
  OBI_BUS #() target_bus [TARGETS-1:0]();
  OBI_BUS #() target_bus_cut [TARGETS-1:0]();
  OBI_BUS #() initiator_bus [INITIATORS-1-1:0] ();//no tieoff
  OBI_BUS #() initiator_bus_cut [INITIATORS-1:0] ();
  APB #() peripheral_bus [TARGETS-1:0] ();

  if(PERIPH_INITIATOR_CUTS) begin
    obi_cut_intf #(
      .Bypass(1'b0)
    ) i_initiator_cut(
      .clk_i(clk),
      .rst_ni(reset_n),
      .obi_s(initiator_bus[0]),
      .obi_m(initiator_bus_cut[0])
    );
  end
  else begin
    obi_cut_intf #(
      .Bypass(1'b1)
    ) i_initiator_bypass_cut(
      .clk_i(clk),
      .rst_ni(reset_n),
      .obi_s(initiator_bus[0]),
      .obi_m(initiator_bus_cut[0])
    );
  end

  if(PERIPH_TARGET_CUTS) begin
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
    for (genvar i = 0; i < TARGETS; i++) begin : target_no_cuts
      obi_cut_intf #(
        .Bypass(1'b1)
      ) i_target_cut(
        .clk_i(clk),
        .rst_ni(reset_n),
        .obi_s(target_bus[i]),
        .obi_m(target_bus_cut[i])
      );
    end
  end

  obi_xbar_intf #(
    .NumSbrPorts       (INITIATORS),
    .NumMgrPorts       (TARGETS),
    .NumMaxTrans       (1),
    .NumAddrRules      (TARGETS),
    .addr_map_rule_t   (addr_rule_t),
    .UseIdForRouting   (0)
  ) i_peripheral_obi_xbar (
    .clk_i            (clk),
    .rst_ni           (reset_n),
    .testmode_i       (1'b0),
    .sbr_ports        (initiator_bus_cut),
    .mgr_ports        (target_bus),
    .addr_map_i       (peripheral_addr_map),
    .en_default_idx_i ('0),
    .default_idx_i    ('0)
  );
  
  obi_to_apb_intf #() i_obi_to_apb_gpio (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus_cut[0]),
    .apb_o (peripheral_bus[0])
  );

  obi_to_apb_intf #() i_obi_to_apb_uart (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus_cut[1]),
    .apb_o (peripheral_bus[1])
  );

  obi_to_apb_intf #() i_obi_to_apb_spi (
    .clk_i (clk),
    .rst_ni(reset_n),
    .obi_i (target_bus_cut[2]),
    .apb_o (peripheral_bus[2])
  );

  // tieoff master connection for utilizing xbar as splitter
  assign initiator_bus_cut[1].addr = 'h0;
  assign initiator_bus_cut[1].aid = 'h0;
  assign initiator_bus_cut[1].be = 4'b1111;
  assign initiator_bus_cut[1].req = 1'b0;
  assign initiator_bus_cut[1].reqpar = 1'b1;
  assign initiator_bus_cut[1].rready = 1'b0;
  assign initiator_bus_cut[1].rreadypar = 1'b1;
  assign initiator_bus_cut[1].wdata = 'h0;
  assign initiator_bus_cut[1].we = 1'b0;

  // Interface: apb_gpio
  assign peripheral_bus[0].prdata = APB_GPIO_PRDATA;
  assign peripheral_bus[0].pready = APB_GPIO_PREADY;
  assign peripheral_bus[0].pslverr = APB_GPIO_PSLVERR;
  assign APB_GPIO_PADDR = peripheral_bus[0].paddr[11:0];
  assign APB_GPIO_PENABLE = peripheral_bus[0].penable;
  assign APB_GPIO_PSEL = peripheral_bus[0].psel;
  assign APB_GPIO_PWDATA = peripheral_bus[0].pwdata;
  assign APB_GPIO_PWRITE = peripheral_bus[0].pwrite;

  // Interface: apb_uart
  assign peripheral_bus[1].prdata =  APB_UART_PRDATA;
  assign peripheral_bus[1].pready =  APB_UART_PREADY;
  assign peripheral_bus[1].pslverr = APB_UART_PSLVERR;
  assign APB_UART_PADDR = peripheral_bus[1].paddr[11:0];
  assign APB_UART_PENABLE = peripheral_bus[1].penable;
  assign APB_UART_PSEL = peripheral_bus[1].psel;
  assign APB_UART_PWDATA = peripheral_bus[1].pwdata;
  assign APB_UART_PWRITE = peripheral_bus[1].pwrite;
 
  // Interface: apb_spi
  assign peripheral_bus[2].prdata = APB_SPI_PRDATA;
  assign peripheral_bus[2].pready = APB_SPI_PREADY;
  assign peripheral_bus[2].pslverr = APB_SPI_PSLVERR;
  assign APB_SPI_PADDR = peripheral_bus[2].paddr[11:0];
  assign APB_SPI_PENABLE = peripheral_bus[2].penable;
  assign APB_SPI_PSEL = peripheral_bus[2].psel;
  assign APB_SPI_PWDATA = peripheral_bus[2].pwdata;
  assign APB_SPI_PWRITE = peripheral_bus[2].pwrite;

  // Interface: obi
//  assign initiator_bus[0].achk = achk;
  assign initiator_bus[0].addr = addr;
  assign initiator_bus[0].aid = aid;
//  assign initiator_bus[0].atop = atop;
//  assign initiator_bus[0].auser = auser;
  assign initiator_bus[0].be = be;
//  assign initiator_bus[0].dbg = dbg;
//  assign initiator_bus[0].memtype = memtype;
//  assign initiator_bus[0].mid = mid;
//  assign initiator_bus[0].prot = prot;
  assign initiator_bus[0].req = req;
  assign initiator_bus[0].reqpar = reqpar;
  assign initiator_bus[0].rready = rready;
  assign initiator_bus[0].rreadypar = rreadypar;
  assign initiator_bus[0].wdata = wdata;
  assign initiator_bus[0].we = we;
//  assign initiator_bus[0].wuser = wuser;

  // a optional signals such as achk etc
  // assign initiator_bus[0].a_optional = 'h0;
  // r opional sigans such as ruser
  // initiator_bus[0].r_optional

  assign err = initiator_bus[0].err;
//  assign exokay = initiator_bus[0].exokay;
  assign gnt = initiator_bus[0].gnt;
  assign gntpar = initiator_bus[0].gntpar;
//  assign rchk = initiator_bus[0].rchk;
  assign rdata = initiator_bus[0].rdata;
  assign rid = initiator_bus[0].rid;
//  assign ruser = initiator_bus[0].ruser;
  assign rvalid = initiator_bus[0].rvalid;
  assign rvalidpar = initiator_bus[0].rvalidpar;
*/
endmodule
