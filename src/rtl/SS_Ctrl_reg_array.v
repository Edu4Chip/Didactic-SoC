//-----------------------------------------------------------------------------
// File          : SS_Ctrl_reg_array.v
// Creation date : 23.02.2024
// Creation time : 12:38:00
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:SS_Ctrl_reg_array:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/ip/SS_Ctrl_reg_array/1.0/SS_Ctrl_reg_array.1.0.xml
//-----------------------------------------------------------------------------

module SS_Ctrl_reg_array #(
    parameter                              IOCELL_CFG_W     = 5,
    parameter                              IOCELL_COUNT     = 28    // update this value manually to match cell numbers
) (
    // Interface: BootSel
    input                               bootsel,

    // Interface: Clock
    input                               clk,

    // Interface: Reset
    input                               reset,

    // Interface: icn_ss_ctrl
    output               [7:0]          ss_ctrl_icn,

    // Interface: io_cfg
    output               [49:0]         cell_cfg,

    // Interface: mem_reg_if
    input  logic         [31:0]         addr_in,
    input  logic         [3:0]          be_in,
    input  logic                        req_in,
    input  logic         [31:0]         wdata_in,
    input  logic                        we_in,
    output logic         [31:0]         rdata_out,

    // Interface: rst_icn
    output                              reset_icn,

    // Interface: rst_ss_0
    output                              reset_ss_0,

    // Interface: rst_ss_1
    output                              reset_ss_1,

    // Interface: rst_ss_2
    output                              reset_ss_2,

    // Interface: rst_ss_3
    output                              reset_ss_3,

    // Interface: ss_ctrl_0
    output                              irq_en_0,
    output               [7:0]          ss_ctrl_0,

    // Interface: ss_ctrl_1
    output                              irq_en_1,
    output               [7:0]          ss_ctrl_1,

    // Interface: ss_ctrl_2
    output                              irq_en_2,
    output               [7:0]          ss_ctrl_2,

    // Interface: ss_ctrl_3
    output                              irq_en_3,
    output               [7:0]          ss_ctrl_3
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!


// this is to be regened by kamel once memory design is finished
endmodule
