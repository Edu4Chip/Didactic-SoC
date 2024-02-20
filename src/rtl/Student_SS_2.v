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
    input                [31:0]         PADDR,
    input                               PENABLE,
    input                [3:0]          PSEL,
    input                [31:0]         PWDATA,
    input                               PWRITE,
    output               [127:0]        PRDATA,
    output               [3:0]          PREADY,
    output               [3:0]          PSELERR,

    // Interface: Clock
    input                               clk,

    // Interface: IRQ
    output                              irq_2,

    // Interface: Reset
    input                               reset_int,

    // Interface: SS_Ctrl
    input                               irq_en_2,
    input                [7:0]          ss_ctrl_2
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
endmodule
