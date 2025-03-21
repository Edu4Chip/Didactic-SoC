//-----------------------------------------------------------------------------
// File          : peripherals_obi_to_apb.v
// Creation date : 21.03.2025
// Creation time : 15:10:01
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:interconnect:peripherals_obi_to_apb:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/interconnect/peripherals_obi_to_apb/1.0/peripherals_obi_to_apb.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:


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
    output logic         [2:0]          APB_GPIO_PADDR,
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
    input  logic                        clk_internal,

    // Interface: obi
    input                [OBI_CHKW-1:0] achk,
    input                [OBI_AW-1:0]   addr,
    input                [OBI_IDW-1:0]  aid,
    input                [5:0]          atop,
    input                [OBI_USERW-1:0] auser,
    input                [OBI_DW/8-1:0] be,
    input                               dbg,
    input                [1:0]          memtype,
    input                [OBI_IDW-1:0]  mid,
    input                [2:0]          prot,
    input                               regpar,
    input                               req,
    input                               rready,
    input                [OBI_DW-1:0]   wdata,
    input                               we,
    input                [OBI_USERW-1:0] wuser,
    output                              err,
    output                              exokay,
    output                              gnt,
    output                              gntpar,
    output               [OBI_CHKW-1:0] rchk,
    output               [OBI_DW-1:0]   rdata,
    output               [OBI_IDW-1:0]  rid,
    output                              rreadypar,
    output               [OBI_USERW-1:0] ruser,
    output                              rvalid,
    output                              rvalidpar,

    // Interface: reset
    input  logic                        reset_internal
);

endmodule
