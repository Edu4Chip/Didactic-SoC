//-----------------------------------------------------------------------------
// File          : Student_SS_3_0.v
// Creation date : 22.04.2024
// Creation time : 15:04:14
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:Student_SS_3:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/subsystem/Student_SS_3/1.0/Student_SS_3.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_3_0(
    // Interface: APB
    input  logic         [31:0]         PADDR,
    input  logic                        PENABLE,
    input  logic                        PSEL,
    input  logic         [31:0]         PWDATA,
    input  logic                        PWRITE,
    output logic         [31:0]         PRDATA,
    output logic                        PREADY,
    output logic                        PSLVERR,

    // Interface: Clock
    input  logic                        clk_in,

    // Interface: IRQ
    output logic                        irq_3,

    // Interface: Reset
    input  logic                        reset_int,

    // Interface: SS_Ctrl
    input  logic                        irq_en_3,
    input  logic         [7:0]          ss_ctrl_3
);

    // SS_cg_clk_in_to_Clock wires:
    wire       SS_cg_clk_in_to_Clock_clk;

    // Ad-hoc wires:
    wire [7:0] SS_cg_en_to_ss_ctrl_3;

    // SS_cg port wires:
    wire       SS_cg_clk;
    wire       SS_cg_en;

    // Assignments for the ports of the encompassing component:
    assign SS_cg_clk_in_to_Clock_clk = clk_in;
    assign SS_cg_en_to_ss_ctrl_3 = ss_ctrl_3;


    // SS_cg assignments:
    assign SS_cg_clk = SS_cg_clk_in_to_Clock_clk;
    assign SS_cg_en = SS_cg_en_to_ss_ctrl_3[0];

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg SS_cg(
        // Interface: clk_in
        .clk                 (SS_cg_clk),
        // Interface: clk_out
        .clk_out             (),
        // These ports are not in any interface
        .en                  (SS_cg_en));


endmodule
