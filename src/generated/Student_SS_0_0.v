//-----------------------------------------------------------------------------
// File          : Student_SS_0_0.v
// Creation date : 23.04.2024
// Creation time : 13:42:21
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_0:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/subsystem.wrapper/Student_SS_0/1.0/Student_SS_0.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_0_0 #(
    parameter                              APB_DW           = 32,
    parameter                              APB_AW           = 32
) (
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
    // SS_cg_clk_out_to_Student_area_0_clk wires:
    wire       SS_cg_clk_out_to_Student_area_0_clk_clk;
    // Student_area_0_APB_to_APB wires:
    wire [31:0] Student_area_0_APB_to_APB_PADDR;
    wire       Student_area_0_APB_to_APB_PENABLE;
    wire [31:0] Student_area_0_APB_to_APB_PRDATA;
    wire       Student_area_0_APB_to_APB_PREADY;
    wire       Student_area_0_APB_to_APB_PSEL;
    wire       Student_area_0_APB_to_APB_PSLVERR;
    wire [31:0] Student_area_0_APB_to_APB_PWDATA;
    wire       Student_area_0_APB_to_APB_PWRITE;
    // Student_area_0_reset_to_Reset wires:
    wire       Student_area_0_reset_to_Reset_reset;
    // Student_area_0_IRQ_to_IRQ wires:
    wire       Student_area_0_IRQ_to_IRQ_irq;
    // Student_area_0_SS_Ctrl_to_SS_Ctrl wires:
    wire [7:0] Student_area_0_SS_Ctrl_to_SS_Ctrl_clk_ctrl;
    wire       Student_area_0_SS_Ctrl_to_SS_Ctrl_irq_en;

    // Ad-hoc wires:
    wire       SS_cg_en_to_clk_ctrl;

    // SS_cg port wires:
    wire       SS_cg_clk;
    wire       SS_cg_clk_out;
    wire       SS_cg_en;
    // Student_area_0 port wires:
    wire [31:0] Student_area_0_PADDR;
    wire       Student_area_0_PENABLE;
    wire [31:0] Student_area_0_PRDATA;
    wire       Student_area_0_PREADY;
    wire       Student_area_0_PSEL;
    wire       Student_area_0_PSLVERR;
    wire [31:0] Student_area_0_PWDATA;
    wire       Student_area_0_PWRITE;
    wire [7:0] Student_area_0_clk_ctrl;
    wire       Student_area_0_clk_in;
    wire       Student_area_0_irq;
    wire       Student_area_0_irq_en;
    wire       Student_area_0_rst;

    // Assignments for the ports of the encompassing component:
    assign Student_area_0_APB_to_APB_PADDR = PADDR;
    assign Student_area_0_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = Student_area_0_APB_to_APB_PRDATA;
    assign PREADY = Student_area_0_APB_to_APB_PREADY;
    assign Student_area_0_APB_to_APB_PSEL = PSEL;
    assign PSELERR = Student_area_0_APB_to_APB_PSLVERR;
    assign Student_area_0_APB_to_APB_PWDATA = PWDATA;
    assign Student_area_0_APB_to_APB_PWRITE = PWRITE;
    assign SS_cg_clk_in_to_Clock_clk = clk;
    assign SS_cg_en_to_clk_ctrl = clk_ctrl[0];
    assign Student_area_0_SS_Ctrl_to_SS_Ctrl_clk_ctrl = clk_ctrl;
    assign irq = Student_area_0_IRQ_to_IRQ_irq;
    assign Student_area_0_SS_Ctrl_to_SS_Ctrl_irq_en = irq_en;
    assign Student_area_0_reset_to_Reset_reset = rst;

    // SS_cg assignments:
    assign SS_cg_clk = SS_cg_clk_in_to_Clock_clk;
    assign SS_cg_clk_out_to_Student_area_0_clk_clk = SS_cg_clk_out;
    assign SS_cg_en = SS_cg_en_to_clk_ctrl;
    // Student_area_0 assignments:
    assign Student_area_0_PADDR = Student_area_0_APB_to_APB_PADDR;
    assign Student_area_0_PENABLE = Student_area_0_APB_to_APB_PENABLE;
    assign Student_area_0_APB_to_APB_PRDATA = Student_area_0_PRDATA;
    assign Student_area_0_APB_to_APB_PREADY = Student_area_0_PREADY;
    assign Student_area_0_PSEL = Student_area_0_APB_to_APB_PSEL;
    assign Student_area_0_APB_to_APB_PSLVERR = Student_area_0_PSLVERR;
    assign Student_area_0_PWDATA = Student_area_0_APB_to_APB_PWDATA;
    assign Student_area_0_PWRITE = Student_area_0_APB_to_APB_PWRITE;
    assign Student_area_0_clk_ctrl = Student_area_0_SS_Ctrl_to_SS_Ctrl_clk_ctrl;
    assign Student_area_0_clk_in = SS_cg_clk_out_to_Student_area_0_clk_clk;
    assign Student_area_0_IRQ_to_IRQ_irq = Student_area_0_irq;
    assign Student_area_0_irq_en = Student_area_0_SS_Ctrl_to_SS_Ctrl_irq_en;
    assign Student_area_0_rst = Student_area_0_reset_to_Reset_reset;

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg SS_cg(
        // Interface: clk_in
        .clk                 (SS_cg_clk),
        // Interface: clk_out
        .clk_out             (SS_cg_clk_out),
        // These ports are not in any interface
        .en                  (SS_cg_en));

    // IP-XACT VLNV: tuni.fi:subsystem:Student_area_0:1.0
    Student_area_0 #(
        .APB_AW              (32),
        .APB_DW              (32))
    Student_area_0(
        // Interface: APB
        .PADDR               (Student_area_0_PADDR),
        .PENABLE             (Student_area_0_PENABLE),
        .PSEL                (Student_area_0_PSEL),
        .PWDATA              (Student_area_0_PWDATA),
        .PWRITE              (Student_area_0_PWRITE),
        .PRDATA              (Student_area_0_PRDATA),
        .PREADY              (Student_area_0_PREADY),
        .PSLVERR             (Student_area_0_PSLVERR),
        // Interface: IRQ
        .irq                 (Student_area_0_irq),
        // Interface: SS_Ctrl
        .clk_ctrl            (Student_area_0_clk_ctrl),
        .irq_en              (Student_area_0_irq_en),
        // Interface: clk
        .clk_in              (Student_area_0_clk_in),
        // Interface: reset
        .rst                 (Student_area_0_rst));


endmodule
