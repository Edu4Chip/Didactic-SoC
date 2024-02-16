//-----------------------------------------------------------------------------
// File          : AX4LITE_APB_converter_wrapper.v
// Creation date : 08.02.2024
// Creation time : 15:39:29
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.0 64-bit
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
module AX4LITE_APB_converter_wrapper(
    // Interface: APB_GPIO
    input     logic           [31:0]         PRDATA,
    input      logic                         PREADY,
    input     logic                          PSLVERR,
    output    logic           [31:0]         PADDR,
    output    logic                          PENABLE,
    output    logic                          PSEL,
    output    logic           [31:0]         PWDATA,
    output     logic                         PWRITE,

    // Interface: APB_SDIO
    input      logic          [31:0]         PRDATA_1,
    input      logic                         PREADY_1,
    input     logic                          PSLVERR_1,
    output    logic           [31:0]         PADDR_1,
    output    logic                          PENABLE_1,
    output   logic                           PSEL_1,
    output   logic            [31:0]         PWDATA_1,
    output   logic                           PWRITE_1,

    // Interface: APB_SPI
    input  logic         [31:0]         PRDATA_2,
    input  logic                        PREADY_2,
    input  logic                        PSLVERR_2,
    output logic         [31:0]         PADDR_2,
    output logic                        PENABLE_2,
    output logic                        PSEL_2,
    output logic         [31:0]         PWDATA_2,
    output logic                        PWRITE_2,

    // Interface: APB_UART
    input    logic            [31:0]         PRDATA_3,
    input    logic                           PREADY_3,
    input    logic                           PSLVERR_3,
    output   logic            [31:0]         PADDR_3,
    output   logic                           PENABLE_3,
    output    logic                          PSEL_3,
    output    logic           [31:0]         PWDATA_3,
    output   logic                           PWRITE_3,

    // Interface: AXI4LITE
    input     logic           [31:0]         ar_addr,
    input   logic           [2:0]          ar_prot,
    input    logic                           ar_valid,
    input   logic             [31:0]         aw_addr,
    input    logic            [2:0]          aw_prot,
    input    logic                           aw_valid,
    input    logic                           b_ready,
    input    logic                           r_ready,
    input    logic            [31:0]         w_data,
    input    logic            [3:0]          w_strb,
    input    logic                           w_valid,
    output   logic                           ar_ready,
    output   logic                           aw_ready,
    output   logic            [1:0]          b_resp,
    output   logic                           b_valid,
    output    logic           [31:0]         r_data,
    output    logic           [1:0]          r_resp,
    output    logic                          r_valid,
    output    logic                          w_ready,

    // Interface: Clock
    input     logic                          clk,

    // Interface: Reset_n
    input      logic                         rst_n
);


endmodule
