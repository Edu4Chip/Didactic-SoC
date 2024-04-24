//-----------------------------------------------------------------------------
// File          : Student_SS_3_0.v
// Creation date : 24.04.2024
// Creation time : 10:52:33
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_3:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/subsystem.wrapper/Student_SS_3/1.0/Student_SS_3.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_3_0(
    // Interface: APB
    input                [31:0]         PADDR,
    input                               PENABLE,
    input                               PSEL,
    input                [31:0]         PWDATA,
    input                               PWRITE,
    output               [31:0]         PRDATA,
    output                              PREADY,
    output                              PSLVERR,

    // Interface: Clock
    input                               clk_in,

    // Interface: IRQ
    output                              irq_3,

    // Interface: Reset
    input                               reset_int,

    // Interface: SS_Ctrl
    input                               irq_en_3,
    input                [7:0]          ss_ctrl_3
);

    // SS_cg_clk_in_to_Clock wires:
    wire       SS_cg_clk_in_to_Clock_clk;
    // Student_SS_3_IRQ_to_IRQ wires:
    wire       Student_SS_3_IRQ_to_IRQ_irq;
    // Student_SS_3_APB_to_APB wires:
    wire [31:0] Student_SS_3_APB_to_APB_PADDR;
    wire       Student_SS_3_APB_to_APB_PENABLE;
    wire [31:0] Student_SS_3_APB_to_APB_PRDATA;
    wire       Student_SS_3_APB_to_APB_PREADY;
    wire       Student_SS_3_APB_to_APB_PSEL;
    wire       Student_SS_3_APB_to_APB_PSLVERR;
    wire [31:0] Student_SS_3_APB_to_APB_PWDATA;
    wire       Student_SS_3_APB_to_APB_PWRITE;
    // Student_SS_3_SS_CTRL_to_SS_Ctrl wires:
    wire [7:0] Student_SS_3_SS_CTRL_to_SS_Ctrl_clk_ctrl;
    wire       Student_SS_3_SS_CTRL_to_SS_Ctrl_irq_en;
    // Student_SS_3_Reset_to_Reset wires:
    wire       Student_SS_3_Reset_to_Reset_reset;
    // SS_cg_clk_out_to_Student_SS_3_Clock wires:
    wire       SS_cg_clk_out_to_Student_SS_3_Clock_clk;

    // Ad-hoc wires:
    wire [7:0] SS_cg_en_to_ss_ctrl_3;

    // SS_cg port wires:
    wire       SS_cg_clk;
    wire       SS_cg_clk_out;
    wire       SS_cg_en;
    // Student_SS_3 port wires:
    wire [31:0] Student_SS_3_PADDR;
    wire       Student_SS_3_PENABLE;
    wire [31:0] Student_SS_3_PRDATA;
    wire       Student_SS_3_PREADY;
    wire       Student_SS_3_PSEL;
    wire       Student_SS_3_PSLVERR;
    wire [31:0] Student_SS_3_PWDATA;
    wire       Student_SS_3_PWRITE;
    wire       Student_SS_3_clk_in;
    wire       Student_SS_3_irq_3;
    wire       Student_SS_3_irq_en_3;
    wire       Student_SS_3_reset_int;
    wire [7:0] Student_SS_3_ss_ctrl_3;

    // Assignments for the ports of the encompassing component:
    assign Student_SS_3_APB_to_APB_PADDR = PADDR;
    assign Student_SS_3_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = Student_SS_3_APB_to_APB_PRDATA;
    assign PREADY = Student_SS_3_APB_to_APB_PREADY;
    assign Student_SS_3_APB_to_APB_PSEL = PSEL;
    assign PSLVERR = Student_SS_3_APB_to_APB_PSLVERR;
    assign Student_SS_3_APB_to_APB_PWDATA = PWDATA;
    assign Student_SS_3_APB_to_APB_PWRITE = PWRITE;
    assign SS_cg_clk_in_to_Clock_clk = clk_in;
    assign irq_3 = Student_SS_3_IRQ_to_IRQ_irq;
    assign Student_SS_3_SS_CTRL_to_SS_Ctrl_irq_en = irq_en_3;
    assign Student_SS_3_Reset_to_Reset_reset = reset_int;
    assign SS_cg_en_to_ss_ctrl_3 = ss_ctrl_3;
    assign Student_SS_3_SS_CTRL_to_SS_Ctrl_clk_ctrl = ss_ctrl_3;

    // SS_cg assignments:
    assign SS_cg_clk = SS_cg_clk_in_to_Clock_clk;
    assign SS_cg_clk_out_to_Student_SS_3_Clock_clk = SS_cg_clk_out;
    assign SS_cg_en = SS_cg_en_to_ss_ctrl_3[0];
    // Student_SS_3 assignments:
    assign Student_SS_3_PADDR = Student_SS_3_APB_to_APB_PADDR;
    assign Student_SS_3_PENABLE = Student_SS_3_APB_to_APB_PENABLE;
    assign Student_SS_3_APB_to_APB_PRDATA = Student_SS_3_PRDATA;
    assign Student_SS_3_APB_to_APB_PREADY = Student_SS_3_PREADY;
    assign Student_SS_3_PSEL = Student_SS_3_APB_to_APB_PSEL;
    assign Student_SS_3_APB_to_APB_PSLVERR = Student_SS_3_PSLVERR;
    assign Student_SS_3_PWDATA = Student_SS_3_APB_to_APB_PWDATA;
    assign Student_SS_3_PWRITE = Student_SS_3_APB_to_APB_PWRITE;
    assign Student_SS_3_clk_in = SS_cg_clk_out_to_Student_SS_3_Clock_clk;
    assign Student_SS_3_IRQ_to_IRQ_irq = Student_SS_3_irq_3;
    assign Student_SS_3_irq_en_3 = Student_SS_3_SS_CTRL_to_SS_Ctrl_irq_en;
    assign Student_SS_3_reset_int = Student_SS_3_Reset_to_Reset_reset;
    assign Student_SS_3_ss_ctrl_3 = Student_SS_3_SS_CTRL_to_SS_Ctrl_clk_ctrl;

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg SS_cg(
        // Interface: clk_in
        .clk                 (SS_cg_clk),
        // Interface: clk_out
        .clk_out             (SS_cg_clk_out),
        // These ports are not in any interface
        .en                  (SS_cg_en));

    // IP-XACT VLNV: tuni.fi:subsystem:Student_SS_3:1.0
    Student_SS_3 Student_SS_3(
        // Interface: APB
        .PADDR               (Student_SS_3_PADDR),
        .PENABLE             (Student_SS_3_PENABLE),
        .PSEL                (Student_SS_3_PSEL),
        .PWDATA              (Student_SS_3_PWDATA),
        .PWRITE              (Student_SS_3_PWRITE),
        .PRDATA              (Student_SS_3_PRDATA),
        .PREADY              (Student_SS_3_PREADY),
        .PSLVERR             (Student_SS_3_PSLVERR),
        // Interface: Clock
        .clk_in              (Student_SS_3_clk_in),
        // Interface: IRQ
        .irq_3               (Student_SS_3_irq_3),
        // Interface: Reset
        .reset_int           (Student_SS_3_reset_int),
        // Interface: SS_CTRL
        .irq_en_3            (Student_SS_3_irq_en_3),
        .ss_ctrl_3           (Student_SS_3_ss_ctrl_3));


endmodule
