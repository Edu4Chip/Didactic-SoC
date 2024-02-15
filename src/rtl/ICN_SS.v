//-----------------------------------------------------------------------------
// File          : ICN_SS.v
// Creation date : 14.02.2024
// Creation time : 09:30:15
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:interconnect:ICN_SS:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/interconnect/ICN_SS/1.0/ICN_SS.1.0.xml
//-----------------------------------------------------------------------------

module ICN_SS(
    // Interface: AXI
    input                [31:0]         AR_ADDR,
    input                [1:0]          AR_BURST,
    input                [3:0]          AR_CACHE,
    input                [9:0]          AR_ID,
    input                [7:0]          AR_LEN,
    input                               AR_LOCK,
    input                [2:0]          AR_PROT,
    input                [3:0]          AR_QOS,
    input                [2:0]          AR_REGION,
    input                [2:0]          AR_SIZE,
    input                               AR_USER,
    input                               AR_VALID,
    input                [31:0]         AW_ADDR,
    input                [5:0]          AW_ATOP,
    input                [1:0]          AW_BURST,
    input                [3:0]          AW_CACHE,
    input                [9:0]          AW_ID,
    input                [7:0]          AW_LEN,
    input                               AW_LOCK,
    input                [2:0]          AW_PROT,
    input                [3:0]          AW_QOS,
    input                [3:0]          AW_REGION,
    input                [2:0]          AW_SIZE,
    input                               AW_USER,
    input                               AW_VALID,
    input                               B_READY,
    input                               R_READY,
    input                [31:0]         W_DATA,
    input                               W_LAST,
    input                [3:0]          W_STROBE,
    input                               W_USER,
    input                               W_VALID,
    output                              AR_READY,
    output                              AW_READY,
    output               [10:0]         B_ID,
    output               [1:0]          B_RESP,
    output                              B_USER,
    output                              B_VALID,
    output               [31:0]         R_DATA,
    output               [10:0]         R_ID,
    output                              R_LAST,
    output               [1:0]          R_RESP,
    output                              R_USER,
    output                              R_VALID,
    output                              W_READY,

    // Interface: Clock
    input                               clk,

    // Interface: Reset
    input                               reset_int,

    // Interface: SS_Ctrl
    input                [7:0]          ss_ctrl_icn,

    // There ports are contained in many interfaces
    input                [32*4-1:0]     PRDATA,
    input                [3:0]          PREADY,
    input                [3:0]          PSELERR,
    output               [31:0]         PADDR,
    output                              PENABLE,
    output               [3:0]          PSEL,
    output               [31:0]         PWDATA,
    output                              PWRITE
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
endmodule
