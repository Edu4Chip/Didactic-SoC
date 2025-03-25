//-----------------------------------------------------------------------------
// File          : Student_SS_1_0.v
// Creation date : 25.03.2025
// Creation time : 13:44:27
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_1:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/Student_SS_1/1.0/Student_SS_1.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_1_0 #(
    parameter                              APB_AW           = 32,
    parameter                              APB_DW           = 32
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
    output logic                        irq_1,

    // Interface: Reset
    input  logic                        reset_int,

    // Interface: SS_Ctrl
    input  logic                        irq_en_1,
    input  logic         [7:0]          ss_ctrl_1,

    // Interface: high_speed_clk
    input  logic                        high_speed_clk,

    // Interface: pmod_gpio_0
    input  logic         [3:0]          pmod_0_gpi,
    output logic         [3:0]          pmod_0_gpio_oe,
    output logic         [3:0]          pmod_0_gpo,

    // Interface: pmod_gpio_1
    input  logic         [3:0]          pmod_1_gpi,
    output logic         [3:0]          pmod_1_gpio_oe,
    output logic         [3:0]          pmod_1_gpo
);

    // ss_cg_clk_in_to_Clock wires:
    wire       ss_cg_clk_in_to_Clock_clk;
    // student_ss_1_ss_ctrl_to_SS_Ctrl wires:
    wire [7:0] student_ss_1_ss_ctrl_to_SS_Ctrl_clk_ctrl;
    wire       student_ss_1_ss_ctrl_to_SS_Ctrl_irq_en;
    // ss_cg_clk_out_to_student_ss_1_Clock wires:
    wire       ss_cg_clk_out_to_student_ss_1_Clock_clk;
    // student_ss_1_Reset_to_Reset wires:
    wire       student_ss_1_Reset_to_Reset_reset;
    // student_ss_1_APB_to_APB wires:
    wire [31:0] student_ss_1_APB_to_APB_PADDR;
    wire       student_ss_1_APB_to_APB_PENABLE;
    wire [31:0] student_ss_1_APB_to_APB_PRDATA;
    wire       student_ss_1_APB_to_APB_PREADY;
    wire       student_ss_1_APB_to_APB_PSEL;
    wire       student_ss_1_APB_to_APB_PSLVERR;
    wire [3:0] student_ss_1_APB_to_APB_PSTRB;
    wire [31:0] student_ss_1_APB_to_APB_PWDATA;
    wire       student_ss_1_APB_to_APB_PWRITE;
    // student_ss_1_IRQ_to_IRQ wires:
    wire       student_ss_1_IRQ_to_IRQ_irq;
    // student_ss_1_pmod_gpio_0_to_bus_1 wires:
    wire [3:0] student_ss_1_pmod_gpio_0_to_bus_1_gpi;
    wire [3:0] student_ss_1_pmod_gpio_0_to_bus_1_gpio_oe;
    wire [3:0] student_ss_1_pmod_gpio_0_to_bus_1_gpo;
    // student_ss_1_pmod_gpio_1_to_bus wires:
    wire [3:0] student_ss_1_pmod_gpio_1_to_bus_gpi;
    wire [3:0] student_ss_1_pmod_gpio_1_to_bus_gpio_oe;
    wire [3:0] student_ss_1_pmod_gpio_1_to_bus_gpo;
    // student_ss_1_high_speed_clock_to_ss_high_speed_cg_clk_out wires:
    wire       student_ss_1_high_speed_clock_to_ss_high_speed_cg_clk_out_clk;
    // ss_high_speed_cg_clk_in_to_high_speed_clk wires:
    wire       ss_high_speed_cg_clk_in_to_high_speed_clk_clk;

    // Ad-hoc wires:
    wire       ss_cg_en_to_ss_ctrl_1;
    wire       ss_high_speed_cg_en_to_ss_ctrl_1;

    // ss_cg port wires:
    wire       ss_cg_clk;
    wire       ss_cg_clk_out;
    wire       ss_cg_en;
    // ss_high_speed_cg port wires:
    wire       ss_high_speed_cg_clk;
    wire       ss_high_speed_cg_clk_out;
    wire       ss_high_speed_cg_en;
    // student_ss_1 port wires:
    wire [9:0] student_ss_1_PADDR;
    wire       student_ss_1_PENABLE;
    wire [31:0] student_ss_1_PRDATA;
    wire       student_ss_1_PREADY;
    wire       student_ss_1_PSEL;
    wire       student_ss_1_PSLVERR;
    wire [3:0] student_ss_1_PSTRB;
    wire [31:0] student_ss_1_PWDATA;
    wire       student_ss_1_PWRITE;
    wire       student_ss_1_clk_in;
    wire       student_ss_1_high_speed_clk;
    wire       student_ss_1_irq_1;
    wire       student_ss_1_irq_en_1;
    wire [3:0] student_ss_1_pmod_0_gpi;
    wire [3:0] student_ss_1_pmod_0_gpio_oe;
    wire [3:0] student_ss_1_pmod_0_gpo;
    wire [3:0] student_ss_1_pmod_1_gpi;
    wire [3:0] student_ss_1_pmod_1_gpio_oe;
    wire [3:0] student_ss_1_pmod_1_gpo;
    wire       student_ss_1_reset_int;
    wire [7:0] student_ss_1_ss_ctrl_1;

    // Assignments for the ports of the encompassing component:
    assign student_ss_1_APB_to_APB_PADDR = PADDR;
    assign student_ss_1_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = student_ss_1_APB_to_APB_PRDATA;
    assign PREADY = student_ss_1_APB_to_APB_PREADY;
    assign student_ss_1_APB_to_APB_PSEL = PSEL;
    assign PSLVERR = student_ss_1_APB_to_APB_PSLVERR;
    assign student_ss_1_APB_to_APB_PSTRB = PSTRB;
    assign student_ss_1_APB_to_APB_PWDATA = PWDATA;
    assign student_ss_1_APB_to_APB_PWRITE = PWRITE;
    assign ss_cg_clk_in_to_Clock_clk = clk_in;
    assign ss_high_speed_cg_clk_in_to_high_speed_clk_clk = high_speed_clk;
    assign irq_1 = student_ss_1_IRQ_to_IRQ_irq;
    assign student_ss_1_ss_ctrl_to_SS_Ctrl_irq_en = irq_en_1;
    assign student_ss_1_pmod_gpio_0_to_bus_1_gpi = pmod_0_gpi;
    assign pmod_0_gpio_oe = student_ss_1_pmod_gpio_0_to_bus_1_gpio_oe;
    assign pmod_0_gpo = student_ss_1_pmod_gpio_0_to_bus_1_gpo;
    assign student_ss_1_pmod_gpio_1_to_bus_gpi = pmod_1_gpi;
    assign pmod_1_gpio_oe = student_ss_1_pmod_gpio_1_to_bus_gpio_oe;
    assign pmod_1_gpo = student_ss_1_pmod_gpio_1_to_bus_gpo;
    assign student_ss_1_Reset_to_Reset_reset = reset_int;
    assign student_ss_1_ss_ctrl_to_SS_Ctrl_clk_ctrl = ss_ctrl_1;
    assign ss_cg_en_to_ss_ctrl_1 = ss_ctrl_1[0];
    assign ss_high_speed_cg_en_to_ss_ctrl_1 = ss_ctrl_1[1];

    // ss_cg assignments:
    assign ss_cg_clk = ss_cg_clk_in_to_Clock_clk;
    assign ss_cg_clk_out_to_student_ss_1_Clock_clk = ss_cg_clk_out;
    assign ss_cg_en = ss_cg_en_to_ss_ctrl_1;
    // ss_high_speed_cg assignments:
    assign ss_high_speed_cg_clk = ss_high_speed_cg_clk_in_to_high_speed_clk_clk;
    assign student_ss_1_high_speed_clock_to_ss_high_speed_cg_clk_out_clk = ss_high_speed_cg_clk_out;
    assign ss_high_speed_cg_en = ss_high_speed_cg_en_to_ss_ctrl_1;
    // student_ss_1 assignments:
    assign student_ss_1_PADDR = student_ss_1_APB_to_APB_PADDR[9:0];
    assign student_ss_1_PENABLE = student_ss_1_APB_to_APB_PENABLE;
    assign student_ss_1_APB_to_APB_PRDATA = student_ss_1_PRDATA;
    assign student_ss_1_APB_to_APB_PREADY = student_ss_1_PREADY;
    assign student_ss_1_PSEL = student_ss_1_APB_to_APB_PSEL;
    assign student_ss_1_APB_to_APB_PSLVERR = student_ss_1_PSLVERR;
    assign student_ss_1_PSTRB = student_ss_1_APB_to_APB_PSTRB;
    assign student_ss_1_PWDATA = student_ss_1_APB_to_APB_PWDATA;
    assign student_ss_1_PWRITE = student_ss_1_APB_to_APB_PWRITE;
    assign student_ss_1_clk_in = ss_cg_clk_out_to_student_ss_1_Clock_clk;
    assign student_ss_1_high_speed_clk = student_ss_1_high_speed_clock_to_ss_high_speed_cg_clk_out_clk;
    assign student_ss_1_IRQ_to_IRQ_irq = student_ss_1_irq_1;
    assign student_ss_1_irq_en_1 = student_ss_1_ss_ctrl_to_SS_Ctrl_irq_en;
    assign student_ss_1_pmod_0_gpi = student_ss_1_pmod_gpio_0_to_bus_1_gpi;
    assign student_ss_1_pmod_gpio_0_to_bus_1_gpio_oe = student_ss_1_pmod_0_gpio_oe;
    assign student_ss_1_pmod_gpio_0_to_bus_1_gpo = student_ss_1_pmod_0_gpo;
    assign student_ss_1_pmod_1_gpi = student_ss_1_pmod_gpio_1_to_bus_gpi;
    assign student_ss_1_pmod_gpio_1_to_bus_gpio_oe = student_ss_1_pmod_1_gpio_oe;
    assign student_ss_1_pmod_gpio_1_to_bus_gpo = student_ss_1_pmod_1_gpo;
    assign student_ss_1_reset_int = student_ss_1_Reset_to_Reset_reset;
    assign student_ss_1_ss_ctrl_1 = student_ss_1_ss_ctrl_to_SS_Ctrl_clk_ctrl;

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

    // IP-XACT VLNV: tuni.fi:subsystem:student_ss_1:1.0
    student_ss_1     student_ss_1(
        // Interface: APB
        .PADDR               (student_ss_1_PADDR),
        .PENABLE             (student_ss_1_PENABLE),
        .PSEL                (student_ss_1_PSEL),
        .PSTRB               (student_ss_1_PSTRB),
        .PWDATA              (student_ss_1_PWDATA),
        .PWRITE              (student_ss_1_PWRITE),
        .PRDATA              (student_ss_1_PRDATA),
        .PREADY              (student_ss_1_PREADY),
        .PSLVERR             (student_ss_1_PSLVERR),
        // Interface: Clock
        .clk_in              (student_ss_1_clk_in),
        // Interface: IRQ
        .irq_1               (student_ss_1_irq_1),
        // Interface: Reset
        .reset_int           (student_ss_1_reset_int),
        // Interface: high_speed_clock
        .high_speed_clk      (student_ss_1_high_speed_clk),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (student_ss_1_pmod_0_gpi),
        .pmod_0_gpio_oe      (student_ss_1_pmod_0_gpio_oe),
        .pmod_0_gpo          (student_ss_1_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (student_ss_1_pmod_1_gpi),
        .pmod_1_gpio_oe      (student_ss_1_pmod_1_gpio_oe),
        .pmod_1_gpo          (student_ss_1_pmod_1_gpo),
        // Interface: ss_ctrl
        .irq_en_1            (student_ss_1_irq_en_1),
        .ss_ctrl_1           (student_ss_1_ss_ctrl_1));


endmodule
