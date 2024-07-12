//-----------------------------------------------------------------------------
// File          : Student_SS_2_0.v
// Creation date : 12.07.2024
// Creation time : 09:40:19
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.2 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_2:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/Student_SS_2/1.0/Student_SS_2.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_2_0 #(
    parameter                              APB_AW           = 32,
    parameter                              APB_DW           = 32
) (
    // Interface: APB
    input  logic         [31:0]         PADDR,
    input  logic                        PENABLE,
    input  logic                        PSEL,
    input  logic         [31:0]         PWDATA,
    input  logic                        PWRITE,
    output logic         [31:0]         PRDATA,
    output logic                        PREADY,
    output logic                        PSELERR,

    // Interface: Clock
    input  logic                        clk,

    // Interface: IRQ
    output logic                        irq_2,

    // Interface: Reset
    input  logic                        reset_int,

    // Interface: SS_Ctrl
    input  logic                        irq_en_2,
    input  logic         [7:0]          ss_ctrl_2,

    // Interface: analog_if
    inout  wire          [1:0]          ana_core_in,
    inout  wire          [1:0]          ana_core_out,

    // Interface: pmod_gpio_0
    input  logic         [3:0]          pmod_0_gpi,
    output logic         [3:0]          pmod_0_gpio_oe,
    output logic         [3:0]          pmod_0_gpo,

    // Interface: pmod_gpio_1
    input  logic         [3:0]          pmod_1_gpi,
    output logic         [3:0]          pmod_1_gpio_oe,
    output logic         [3:0]          pmod_1_gpo
);
    `ifdef VERILATOR
    `include "verification/verilator/src/common.v"
    `INCREMENT_CYCLE_COUNT(clk)
    `endif

    // SS_cg_clk_in_to_Clock wires:
    wire       SS_cg_clk_in_to_Clock_clk;
    // SS_cg_clk_out_to_student_ss_2_Clock wires:
    wire       SS_cg_clk_out_to_student_ss_2_Clock_clk;
    // student_ss_2_Reset_to_Reset wires:
    wire       student_ss_2_Reset_to_Reset_reset;
    // student_ss_2_SS_Ctrl_to_SS_Ctrl wires:
    wire [7:0] student_ss_2_SS_Ctrl_to_SS_Ctrl_clk_ctrl;
    wire       student_ss_2_SS_Ctrl_to_SS_Ctrl_irq_en;
    // student_ss_2_APB_to_APB wires:
    wire [31:0] student_ss_2_APB_to_APB_PADDR;
    wire       student_ss_2_APB_to_APB_PENABLE;
    wire [31:0] student_ss_2_APB_to_APB_PRDATA;
    wire       student_ss_2_APB_to_APB_PREADY;
    wire       student_ss_2_APB_to_APB_PSEL;
    wire       student_ss_2_APB_to_APB_PSLVERR;
    wire [31:0] student_ss_2_APB_to_APB_PWDATA;
    wire       student_ss_2_APB_to_APB_PWRITE;
    // student_ss_2_IRQ_to_IRQ wires:
    wire       student_ss_2_IRQ_to_IRQ_irq;
    // student_ss_2_pmod_gpio_0_to_bus wires:
    wire [3:0] student_ss_2_pmod_gpio_0_to_bus_gpi;
    wire [3:0] student_ss_2_pmod_gpio_0_to_bus_gpio_oe;
    wire [3:0] student_ss_2_pmod_gpio_0_to_bus_gpo;
    // student_ss_2_pmod_gpio_1_to_bus_1 wires:
    wire [3:0] student_ss_2_pmod_gpio_1_to_bus_1_gpi;
    wire [3:0] student_ss_2_pmod_gpio_1_to_bus_1_gpio_oe;
    wire [3:0] student_ss_2_pmod_gpio_1_to_bus_1_gpo;
    // student_ss_2_analog_if_to_bus_2 wires:

    // Ad-hoc wires:
    wire       SS_cg_en_to_ss_ctrl_2;

    // SS_cg port wires:
    wire       SS_cg_clk;
    wire       SS_cg_clk_out;
    wire       SS_cg_en;
    // student_ss_2 port wires:
    wire [31:0] student_ss_2_PADDR;
    wire       student_ss_2_PENABLE;
    wire [31:0] student_ss_2_PRDATA;
    wire       student_ss_2_PREADY;
    wire       student_ss_2_PSEL;
    wire       student_ss_2_PSELERR;
    wire [31:0] student_ss_2_PWDATA;
    wire       student_ss_2_PWRITE;
    wire       student_ss_2_clk_in;
    wire       student_ss_2_irq_2;
    wire       student_ss_2_irq_en_2;
    wire [3:0] student_ss_2_pmod_0_gpi;
    wire [3:0] student_ss_2_pmod_0_gpio_oe;
    wire [3:0] student_ss_2_pmod_0_gpo;
    wire [3:0] student_ss_2_pmod_1_gpi;
    wire [3:0] student_ss_2_pmod_1_gpio_oe;
    wire [3:0] student_ss_2_pmod_1_gpo;
    wire       student_ss_2_reset_int;
    wire [7:0] student_ss_2_ss_ctrl_2;

    // Assignments for the ports of the encompassing component:
    assign student_ss_2_APB_to_APB_PADDR = PADDR;
    assign student_ss_2_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = student_ss_2_APB_to_APB_PRDATA;
    assign PREADY = student_ss_2_APB_to_APB_PREADY;
    assign student_ss_2_APB_to_APB_PSEL = PSEL;
    assign PSELERR = student_ss_2_APB_to_APB_PSLVERR;
    assign student_ss_2_APB_to_APB_PWDATA = PWDATA;
    assign student_ss_2_APB_to_APB_PWRITE = PWRITE;
    assign SS_cg_clk_in_to_Clock_clk = clk;
    assign irq_2 = student_ss_2_IRQ_to_IRQ_irq;
    assign student_ss_2_SS_Ctrl_to_SS_Ctrl_irq_en = irq_en_2;
    assign student_ss_2_pmod_gpio_0_to_bus_gpi = pmod_0_gpi;
    assign pmod_0_gpio_oe = student_ss_2_pmod_gpio_0_to_bus_gpio_oe;
    assign pmod_0_gpo = student_ss_2_pmod_gpio_0_to_bus_gpo;
    assign student_ss_2_pmod_gpio_1_to_bus_1_gpi = pmod_1_gpi;
    assign pmod_1_gpio_oe = student_ss_2_pmod_gpio_1_to_bus_1_gpio_oe;
    assign pmod_1_gpo = student_ss_2_pmod_gpio_1_to_bus_1_gpo;
    assign student_ss_2_Reset_to_Reset_reset = reset_int;
    assign SS_cg_en_to_ss_ctrl_2 = ss_ctrl_2[0];
    assign student_ss_2_SS_Ctrl_to_SS_Ctrl_clk_ctrl = ss_ctrl_2;

    // SS_cg assignments:
    assign SS_cg_clk = SS_cg_clk_in_to_Clock_clk;
    assign SS_cg_clk_out_to_student_ss_2_Clock_clk = SS_cg_clk_out;
    assign SS_cg_en = SS_cg_en_to_ss_ctrl_2;
    // student_ss_2 assignments:
    assign student_ss_2_PADDR = student_ss_2_APB_to_APB_PADDR;
    assign student_ss_2_PENABLE = student_ss_2_APB_to_APB_PENABLE;
    assign student_ss_2_APB_to_APB_PRDATA = student_ss_2_PRDATA;
    assign student_ss_2_APB_to_APB_PREADY = student_ss_2_PREADY;
    assign student_ss_2_PSEL = student_ss_2_APB_to_APB_PSEL;
    assign student_ss_2_APB_to_APB_PSLVERR = student_ss_2_PSELERR;
    assign student_ss_2_PWDATA = student_ss_2_APB_to_APB_PWDATA;
    assign student_ss_2_PWRITE = student_ss_2_APB_to_APB_PWRITE;
    assign student_ss_2_clk_in = SS_cg_clk_out_to_student_ss_2_Clock_clk;
    assign student_ss_2_IRQ_to_IRQ_irq = student_ss_2_irq_2;
    assign student_ss_2_irq_en_2 = student_ss_2_SS_Ctrl_to_SS_Ctrl_irq_en;
    assign student_ss_2_pmod_0_gpi = student_ss_2_pmod_gpio_0_to_bus_gpi;
    assign student_ss_2_pmod_gpio_0_to_bus_gpio_oe = student_ss_2_pmod_0_gpio_oe;
    assign student_ss_2_pmod_gpio_0_to_bus_gpo = student_ss_2_pmod_0_gpo;
    assign student_ss_2_pmod_1_gpi = student_ss_2_pmod_gpio_1_to_bus_1_gpi;
    assign student_ss_2_pmod_gpio_1_to_bus_1_gpio_oe = student_ss_2_pmod_1_gpio_oe;
    assign student_ss_2_pmod_gpio_1_to_bus_1_gpo = student_ss_2_pmod_1_gpo;
    assign student_ss_2_reset_int = student_ss_2_Reset_to_Reset_reset;
    assign student_ss_2_ss_ctrl_2 = student_ss_2_SS_Ctrl_to_SS_Ctrl_clk_ctrl;

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg SS_cg(
        // Interface: clk_in
        .clk                 (SS_cg_clk),
        // Interface: clk_out
        .clk_out             (SS_cg_clk_out),
        // These ports are not in any interface
        .en                  (SS_cg_en));

    // IP-XACT VLNV: tuni.fi:subsystem:student_ss_2:1.0
    student_ss_2 student_ss_2(
        // Interface: APB
        .PADDR               (student_ss_2_PADDR),
        .PENABLE             (student_ss_2_PENABLE),
        .PSEL                (student_ss_2_PSEL),
        .PWDATA              (student_ss_2_PWDATA),
        .PWRITE              (student_ss_2_PWRITE),
        .PRDATA              (student_ss_2_PRDATA),
        .PREADY              (student_ss_2_PREADY),
        .PSELERR             (student_ss_2_PSELERR),
        // Interface: Clock
        .clk_in              (student_ss_2_clk_in),
        // Interface: IRQ
        .irq_2               (student_ss_2_irq_2),
        // Interface: Reset
        .reset_int           (student_ss_2_reset_int),
        // Interface: SS_Ctrl
        .irq_en_2            (student_ss_2_irq_en_2),
        .ss_ctrl_2           (student_ss_2_ss_ctrl_2),
        // Interface: analog_if
        .ana_core_in         (ana_core_in[1:0]),
        .ana_core_out        (ana_core_out[1:0]),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (student_ss_2_pmod_0_gpi),
        .pmod_0_gpio_oe      (student_ss_2_pmod_0_gpio_oe),
        .pmod_0_gpo          (student_ss_2_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (student_ss_2_pmod_1_gpi),
        .pmod_1_gpio_oe      (student_ss_2_pmod_1_gpio_oe),
        .pmod_1_gpo          (student_ss_2_pmod_1_gpo));


endmodule
