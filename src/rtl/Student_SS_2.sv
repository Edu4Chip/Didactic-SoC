//-----------------------------------------------------------------------------
// File          : Student_SS_2.v
// Creation date : 20.02.2024
// Creation time : 09:44:58
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_2:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/subsystem.wrapper/Student_SS_2/1.0/Student_SS_2.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_2(
    // Interface: APB
    input  logic [31:0] PADDR,
    input  logic        PENABLE,
    input  logic        PSEL,
    input  logic [31:0] PWDATA,
    input  logic        PWRITE,
    output logic [31:0] PRDATA,
    output logic        PREADY,
    output logic        PSLVERR,

    // Interface: Clock
    input  logic        clk,

    // Interface: IRQ
    output logic        irq,

    // Interface: Reset
    input  logic        reset_int,

    // Interface: SS_Ctrl
    input logic        irq_en_2,
    input logic [7:0]  ss_ctrl_2
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!

// this file contains minimal functionality to avoid breaking anything in other ends of the chip.

assign PSELERR = 'd0;
assign PSREADY = 'd0;
assign PRDATA  = 'd0;
assign irq     = 'd0;

endmodule
