//-----------------------------------------------------------------------------
// File          : AX4LITE_APB_converter_wrapper.v
// Creation date : 19.02.2024
// Creation time : 10:07:18
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:communication:AX4LITE_APB_converter_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/communication/AX4LITE_APB_converter_wrapper/1.0/AX4LITE_APB_converter_wrapper.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example wrapper code for instantiating pulp axi converter module
*/
module AX4LITE_APB_converter_wrapper #(
    parameter                              APB_AW           = 32,
    parameter                              APB_DW           = 32,
    parameter                              APB_TARGETS      = 4,
    parameter                              AXI_AW           = 32,
    parameter                              AXI_DW           = 32
) (
    // Interface: AXI4LITE
    input  logic         [AXI_AW-1:0]   ar_addr,
    input  logic         [2:0]          ar_prot,
    input  logic                        ar_valid,
    input  logic         [AXI_AW-1:0]   aw_addr,
    input  logic         [2:0]          aw_prot,
    input  logic                        aw_valid,
    input  logic                        b_ready,
    input  logic                        r_ready,
    input  logic         [AXI_DW-1:0]   w_data,
    input  logic         [(AXI_DW/8)-1:0] w_strb,
    input  logic                        w_valid,
    output logic                        ar_ready,
    output logic                        aw_ready,
    output logic         [1:0]          b_resp,
    output logic                        b_valid,
    output logic         [AXI_DW-1:0]   r_data,
    output logic         [1:0]          r_resp,
    output logic                        r_valid,
    output logic                        w_ready,

    // Interface: Clock
    input  logic                        clk,

    // Interface: Reset_n
    input  logic                        rst_n,

    // There ports are contained in many interfaces
    input  logic         [(APB_DW*APB_TARGETS)-1:0] PRDATA,
    input  logic         [APB_TARGETS-1:0] PREADY,
    input  logic         [APB_TARGETS-1:0] PSLVERR,
    output logic         [APB_AW-1:0]   PADDR,
    output logic                        PENABLE,
    output logic         [APB_TARGETS-1:0] PSEL,
    output logic         [APB_DW-1:0]   PWDATA,
    output logic                        PWRITE
);


  AXI_LITE #(
   .AXI_ADDR_WIDTH(),
   .AXI_DATA_WIDTH()
  ) axi4lite_bus ();


  // todo assign axi4lite to interface


  // TODO: APB addr configs
  localparam APB_TARGETS=4;
  localparam NoAddrRules =4;
  localparam ADDR_BASE=32'h1300_0000
  localparam APB_SIZE='h1000;

  typedef axi_pkg::xbar_rule_32_t rule_t;

  rule_t [NoAddrRules-1:0] AddrMapAPB;
  // TODO: finalize Address table based on APB Subsystems
  assign AddrMapAPB = '{
                         '{idx: 32'd3, start_addr: ADDR_BASE+APB_SIZE*3, end_addr: ADDR_BASE+APB_SIZE*4-1},
                         '{idx: 32'd2, start_addr: ADDR_BASE+APB_SIZE*2, end_addr: ADDR_BASE+APB_SIZE*3-1},
                         '{idx: 32'd1, start_addr: ADDR_BASE+APB_SIZE*1, end_addr: ADDR_BASE+APB_SIZE*2-1},
                         '{idx: 32'd0, start_addr: ADDR_BASE+APB_SIZE*0, end_addr: ADDR_BASE+APB_SIZE*1-1}
                         };

  // TODO: fill parameters
  axi_lite_to_apb_intf #(
    .NoApbSlaves(),
    .NoRules(),
    .AddrWidth(),
    .DataWidth(),
    .rule_t(rule_t)
    )
  i_axi_lite_to_apb_intf(
    .clk_i(clk),
    .rst_ni(rst_n),

    .slv(axi4lite_bus),

    .paddr_o(PADDR),
    .pprot_o(),
    .pselx_o(PSEL),
    .penable_o(PENABLE),
    .pwrite_o(PWRITE),
    .pwdata_o(PWDATA),
    .pstrb_o(),
    .pready_i(PREADY),
    .prdata_i(PRDATA),
    .pslverr_i(PSLVERR),

    .addr_map_i(AddrMapAPB)
  );


endmodule
