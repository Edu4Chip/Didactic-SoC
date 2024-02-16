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
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example "interconnect"
*/
module ICN_SS(
    // Interface: AXI
    input logic             [31:0]         AR_ADDR,
    input logic             [1:0]          AR_BURST,
    input logic             [3:0]          AR_CACHE,
    input logic             [9:0]          AR_ID,
    input logic             [7:0]          AR_LEN,
    input logic                            AR_LOCK,
    input logic             [2:0]          AR_PROT,
    input logic             [3:0]          AR_QOS,
    input logic             [2:0]          AR_REGION,
    input logic             [2:0]          AR_SIZE,
    input logic                            AR_USER,
    input logic                            AR_VALID,
    input logic             [31:0]         AW_ADDR,
    input logic             [5:0]          AW_ATOP,
    input logic             [1:0]          AW_BURST,
    input logic             [3:0]          AW_CACHE,
    input logic             [9:0]          AW_ID,
    input logic             [7:0]          AW_LEN,
    input logic                            AW_LOCK,
    input logic             [2:0]          AW_PROT,
    input logic             [3:0]          AW_QOS,
    input logic             [3:0]          AW_REGION,
    input logic             [2:0]          AW_SIZE,
    input logic                            AW_USER,
    input logic                            AW_VALID,
    input logic                            B_READY,
    input logic                            R_READY,
    input logic             [31:0]         W_DATA,
    input logic                            W_LAST,
    input logic             [3:0]          W_STROBE,
    input logic                            W_USER,
    input logic                            W_VALID,
    output logic                              AR_READY,
    output logic                              AW_READY,
    output logic               [10:0]         B_ID,
    output logic               [1:0]          B_RESP,
    output logic                              B_USER,
    output logic                              B_VALID,
    output logic               [31:0]         R_DATA,
    output logic               [10:0]         R_ID,
    output logic                              R_LAST,
    output logic               [1:0]          R_RESP,
    output logic                              R_USER,
    output logic                              R_VALID,
    output logic                              W_READY,

    // Interface: Clock
    input logic                            clk,

    // Interface: Reset
    input logic                            reset_int,

    // Interface: SS_Ctrl
    input logic             [7:0]          ss_ctrl_icn,

    // There ports are contained in many interfaces
    input logic             [32*4-1:0]     PRDATA,
    input logic             [3:0]          PREADY,
    input logic             [3:0]          PSELERR,
    output logic               [31:0]         PADDR,
    output logic                              PENABLE,
    output logic               [3:0]          PSEL,
    output logic               [31:0]         PWDATA,
    output logic                              PWRITE
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
endmodule
