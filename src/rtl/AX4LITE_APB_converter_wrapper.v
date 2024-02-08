//-----------------------------------------------------------------------------
// File          : AX4LITE_APB_converter_wrapper.v
// Creation date : 08.02.2024
// Creation time : 15:32:25
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.0 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:communication:AX4LITE_APB_converter_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/communication/AX4LITE_APB_converter_wrapper/1.0/AX4LITE_APB_converter_wrapper.1.0.xml
//-----------------------------------------------------------------------------

module AX4LITE_APB_converter_wrapper(
    // Interface: APB_GPIO
    input                [31:0]         PRDATA,
    input                               PREADY,
    input                               PSLVERR,
    output               [31:0]         PADDR,
    output                              PENABLE,
    output                              PSEL,
    output               [31:0]         PWDATA,
    output                              PWRITE,

    // Interface: APB_SDIO
    input                [31:0]         PRDATA_1,
    input                               PREADY_1,
    input                               PSLVERR_1,
    output               [31:0]         PADDR_1,
    output                              PENABLE_1,
    output                              PSEL_1,
    output               [31:0]         PWDATA_1,
    output                              PWRITE_1,

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
    input                [31:0]         PRDATA_3,
    input                               PREADY_3,
    input                               PSLVERR_3,
    output               [31:0]         PADDR_3,
    output                              PENABLE_3,
    output                              PSEL_3,
    output               [31:0]         PWDATA_3,
    output                              PWRITE_3,

    // Interface: AXI4LITE
    input                [31:0]         ar_addr,
    input                [2:0]          ar_prot,
    input                               ar_valid,
    input                [31:0]         aw_addr,
    input                [2:0]          aw_prot,
    input                               aw_valid,
    input                               b_ready,
    input                               r_ready,
    input                [31:0]         w_data,
    input                [3:0]          w_strb,
    input                               w_valid,
    output                              ar_ready,
    output                              aw_ready,
    output               [1:0]          b_resp,
    output                              b_valid,
    output               [31:0]         r_data,
    output               [1:0]          r_resp,
    output                              r_valid,
    output                              w_ready,

    // Interface: Clock
    input                               clk,

    // Interface: Reset_n
    input                               rst_n
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
endmodule
