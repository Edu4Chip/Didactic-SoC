//-----------------------------------------------------------------------------
// File          : Student_SS_0_0.v
// Creation date : 13.02.2024
// Creation time : 11:05:42
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.0 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_0:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/subsystem.wrapper/Student_SS_0/1.0/Student_SS_0.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_0_0(
    // Interface: APB
    input                [31:0]         PADDR,
    input                               PENABLE,
    input                               PSEL,
    input                [31:0]         PWDATA,
    input                               PWRITE,
    output               [31:0]         PRDATA,
    output                              PREADY,
    output                              PSELERR,

    // Interface: Clock
    input                               clk,

    // Interface: IRQ
    output                              irq,

    // Interface: Reset
    input                               rst,

    // Interface: SS_Ctrl
    input                [7:0]          clk_ctrl,
    input                               irq_en
);

    // SS_cg_clk_in_to_Clock wires:
    wire       SS_cg_clk_in_to_Clock_clk;

    // Ad-hoc wires:
    wire [7:0] SS_cg_en_to_clk_ctrl;

    // SS_cg port wires:
    wire       SS_cg_clk;
    wire       SS_cg_en;

    // Assignments for the ports of the encompassing component:
    assign SS_cg_clk_in_to_Clock_clk = clk;
    assign SS_cg_en_to_clk_ctrl = clk_ctrl;


    // SS_cg assignments:
    assign SS_cg_clk = SS_cg_clk_in_to_Clock_clk;
    assign SS_cg_en = SS_cg_en_to_clk_ctrl[0];

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg SS_cg(
        // Interface: clk_in
        .clk                 (SS_cg_clk),
        // Interface: clk_out
        .clk_out             (),
        // These ports are not in any interface
        .en                  (SS_cg_en));


endmodule
