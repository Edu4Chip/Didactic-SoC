//-----------------------------------------------------------------------------
// File          : kth_wrapper_0.v
// Creation date : 13.06.2025
// Creation time : 14:24:42
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.5 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:kth_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/kth_wrapper/1.0/kth_wrapper.1.0.xml
//-----------------------------------------------------------------------------

module kth_wrapper_0 #(
    parameter                              APB_DW           = 32,
    parameter                              APB_AW           = 32
) (
    // Interface: APB
    input  logic         [31:0]         PADDR,
    input  logic                        PENABLE,
    input  logic                        PSEL,
    input  logic         [3:0]          PSTRB,
    input  logic         [31:0]         PWDATA,
    input  logic                        PWRITE,
    output logic         [31:0]         PRDATA,
    output logic                        PREADY,
    output logic                        PSLVERR,

    // Interface: Clock
    input  logic                        clk_in,

    // Interface: IRQ
    output logic                        irq,

    // Interface: Reset
    input  logic                        reset_int,

    // Interface: SS_Ctrl
    input  logic                        irq_en_3,
    input  logic         [7:0]          ss_ctrl_3,

    // Interface: high_speed_clk
    input  logic                        high_speed_clk,

    // Interface: pmod_gpio
    input  logic         [15:0]         pmod_gpi,
    output logic         [15:0]         pmod_gpio_oe,
    output logic         [15:0]         pmod_gpo
);

    // ss_cg_clk_in_to_Clock wires:
    wire       ss_cg_clk_in_to_Clock_clk;
    // Student_SS_3_IRQ_to_IRQ wires:
    wire       Student_SS_3_IRQ_to_IRQ_irq;
    // Student_SS_3_APB_to_APB wires:
    wire [31:0] Student_SS_3_APB_to_APB_PADDR;
    wire       Student_SS_3_APB_to_APB_PENABLE;
    wire [31:0] Student_SS_3_APB_to_APB_PRDATA;
    wire       Student_SS_3_APB_to_APB_PREADY;
    wire       Student_SS_3_APB_to_APB_PSEL;
    wire       Student_SS_3_APB_to_APB_PSLVERR;
    wire [3:0] Student_SS_3_APB_to_APB_PSTRB;
    wire [31:0] Student_SS_3_APB_to_APB_PWDATA;
    wire       Student_SS_3_APB_to_APB_PWRITE;
    // Student_SS_3_SS_CTRL_to_SS_Ctrl wires:
    wire [7:0] Student_SS_3_SS_CTRL_to_SS_Ctrl_clk_ctrl;
    wire       Student_SS_3_SS_CTRL_to_SS_Ctrl_irq_en;
    // Student_SS_3_Reset_to_Reset wires:
    wire       Student_SS_3_Reset_to_Reset_reset;
    // ss_cg_clk_out_to_Student_SS_3_Clock wires:
    wire       ss_cg_clk_out_to_Student_SS_3_Clock_clk;
    // ss_high_speed_cg_clk_out_to_Student_SS_3_high_speed_clk wires:
    wire       ss_high_speed_cg_clk_out_to_Student_SS_3_high_speed_clk_clk;
    // ss_high_speed_cg_clk_in_to_high_speed_clk wires:
    wire       ss_high_speed_cg_clk_in_to_high_speed_clk_clk;
    // Student_SS_3_pmod_gpio_to_pmod_gpio wires:
    wire [15:0] Student_SS_3_pmod_gpio_to_pmod_gpio_gpi;
    wire [15:0] Student_SS_3_pmod_gpio_to_pmod_gpio_gpio_oe;
    wire [15:0] Student_SS_3_pmod_gpio_to_pmod_gpio_gpo;

    // Ad-hoc wires:
    wire       ss_cg_en_to_ss_ctrl_3;
    wire       ss_high_speed_cg_en_to_ss_ctrl_3;

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
    wire       Student_SS_3_high_speed_clk;
    wire       Student_SS_3_irq_3;
    wire       Student_SS_3_irq_en_3;
    wire [15:0] Student_SS_3_pmod_gpi;
    wire [15:0] Student_SS_3_pmod_gpio_oe;
    wire [15:0] Student_SS_3_pmod_gpo;
    wire       Student_SS_3_reset_int;
    wire [7:0] Student_SS_3_ss_ctrl_3;
    // ss_cg port wires:
    wire       ss_cg_clk;
    wire       ss_cg_clk_out;
    wire       ss_cg_en;
    // ss_high_speed_cg port wires:
    wire       ss_high_speed_cg_clk;
    wire       ss_high_speed_cg_clk_out;
    wire       ss_high_speed_cg_en;

    // Assignments for the ports of the encompassing component:
    assign Student_SS_3_APB_to_APB_PADDR = PADDR;
    assign Student_SS_3_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = Student_SS_3_APB_to_APB_PRDATA;
    assign PREADY = Student_SS_3_APB_to_APB_PREADY;
    assign Student_SS_3_APB_to_APB_PSEL = PSEL;
    assign PSLVERR = Student_SS_3_APB_to_APB_PSLVERR;
    assign Student_SS_3_APB_to_APB_PWDATA = PWDATA;
    assign Student_SS_3_APB_to_APB_PWRITE = PWRITE;
    assign ss_cg_clk_in_to_Clock_clk = clk_in;
    assign ss_high_speed_cg_clk_in_to_high_speed_clk_clk = high_speed_clk;
    assign irq = Student_SS_3_IRQ_to_IRQ_irq;
    assign Student_SS_3_SS_CTRL_to_SS_Ctrl_irq_en = irq_en_3;
    assign Student_SS_3_pmod_gpio_to_pmod_gpio_gpi = pmod_gpi;
    assign pmod_gpio_oe = Student_SS_3_pmod_gpio_to_pmod_gpio_gpio_oe;
    assign pmod_gpo = Student_SS_3_pmod_gpio_to_pmod_gpio_gpo;
    assign Student_SS_3_Reset_to_Reset_reset = reset_int;
    assign Student_SS_3_SS_CTRL_to_SS_Ctrl_clk_ctrl = ss_ctrl_3;
    assign ss_cg_en_to_ss_ctrl_3 = ss_ctrl_3[0];
    assign ss_high_speed_cg_en_to_ss_ctrl_3 = ss_ctrl_3[1];


    // Student_SS_3 assignments:
    assign Student_SS_3_PADDR = Student_SS_3_APB_to_APB_PADDR;
    assign Student_SS_3_PENABLE = Student_SS_3_APB_to_APB_PENABLE;
    assign Student_SS_3_APB_to_APB_PRDATA = Student_SS_3_PRDATA;
    assign Student_SS_3_APB_to_APB_PREADY = Student_SS_3_PREADY;
    assign Student_SS_3_PSEL = Student_SS_3_APB_to_APB_PSEL;
    assign Student_SS_3_APB_to_APB_PSLVERR = Student_SS_3_PSLVERR;
    assign Student_SS_3_PWDATA = Student_SS_3_APB_to_APB_PWDATA;
    assign Student_SS_3_PWRITE = Student_SS_3_APB_to_APB_PWRITE;
    assign Student_SS_3_clk_in = ss_cg_clk_out_to_Student_SS_3_Clock_clk;
    assign Student_SS_3_high_speed_clk = ss_high_speed_cg_clk_out_to_Student_SS_3_high_speed_clk_clk;
    assign Student_SS_3_IRQ_to_IRQ_irq = Student_SS_3_irq_3;
    assign Student_SS_3_irq_en_3 = Student_SS_3_SS_CTRL_to_SS_Ctrl_irq_en;
    assign Student_SS_3_pmod_gpi = Student_SS_3_pmod_gpio_to_pmod_gpio_gpi;
    assign Student_SS_3_pmod_gpio_to_pmod_gpio_gpio_oe = Student_SS_3_pmod_gpio_oe;
    assign Student_SS_3_pmod_gpio_to_pmod_gpio_gpo = Student_SS_3_pmod_gpo;
    assign Student_SS_3_reset_int = Student_SS_3_Reset_to_Reset_reset;
    assign Student_SS_3_ss_ctrl_3 = Student_SS_3_SS_CTRL_to_SS_Ctrl_clk_ctrl;
    // ss_cg assignments:
    assign ss_cg_clk = ss_cg_clk_in_to_Clock_clk;
    assign ss_cg_clk_out_to_Student_SS_3_Clock_clk = ss_cg_clk_out;
    assign ss_cg_en = ss_cg_en_to_ss_ctrl_3;
    // ss_high_speed_cg assignments:
    assign ss_high_speed_cg_clk = ss_high_speed_cg_clk_in_to_high_speed_clk_clk;
    assign ss_high_speed_cg_clk_out_to_Student_SS_3_high_speed_clk_clk = ss_high_speed_cg_clk_out;
    assign ss_high_speed_cg_en = ss_high_speed_cg_en_to_ss_ctrl_3;

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
        .ss_ctrl_3           (Student_SS_3_ss_ctrl_3),
        // Interface: high_speed_clk
        .high_speed_clk      (Student_SS_3_high_speed_clk),
        // Interface: pmod_gpio
        .pmod_gpi            (Student_SS_3_pmod_gpi),
        .pmod_gpio_oe        (Student_SS_3_pmod_gpio_oe),
        .pmod_gpo            (Student_SS_3_pmod_gpo));

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg ss_cg(
        // Interface: clk_in
        .clk                 (ss_cg_clk),
        // Interface: clk_out
        .clk_out             (ss_cg_clk_out),
        // These ports are not in any interface
        .en                  (ss_cg_en));

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg ss_high_speed_cg(
        // Interface: clk_in
        .clk                 (ss_high_speed_cg_clk),
        // Interface: clk_out
        .clk_out             (ss_high_speed_cg_clk_out),
        // These ports are not in any interface
        .en                  (ss_high_speed_cg_en));


endmodule
