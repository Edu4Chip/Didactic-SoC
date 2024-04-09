//-----------------------------------------------------------------------------
// File          : Student_SS_1_0.v
// Creation date : 09.04.2024
// Creation time : 14:15:23
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_1:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/subsystem.wrapper/Student_SS_1/1.0/Student_SS_1.1.0.xml
//-----------------------------------------------------------------------------

module Student_SS_1_0(
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

    // Interface: GPIO
    inout                [1:0]          gpio,

    // Interface: IRQ
    output                              irq_1,

    // Interface: Reset
    input                               reset_int,

    // Interface: SS_Ctrl
    input                               irq_en_1,
    input                [7:0]          ss_ctrl_1
);

    // tech_cg_0_clk_in_to_Clock wires:
    wire       tech_cg_0_clk_in_to_Clock_clk;
    // student_ss_1_ss_ctrl_to_SS_Ctrl wires:
    wire [7:0] student_ss_1_ss_ctrl_to_SS_Ctrl_clk_ctrl;
    wire       student_ss_1_ss_ctrl_to_SS_Ctrl_irq_en;
    // tech_cg_0_clk_out_to_student_ss_1_Clock wires:
    wire       tech_cg_0_clk_out_to_student_ss_1_Clock_clk;
    // student_ss_1_Reset_to_Reset wires:
    wire       student_ss_1_Reset_to_Reset_reset;
    // student_ss_1_APB_to_APB wires:
    wire [31:0] student_ss_1_APB_to_APB_PADDR;
    wire       student_ss_1_APB_to_APB_PENABLE;
    wire [31:0] student_ss_1_APB_to_APB_PRDATA;
    wire       student_ss_1_APB_to_APB_PREADY;
    wire       student_ss_1_APB_to_APB_PSEL;
    wire       student_ss_1_APB_to_APB_PSLVERR;
    wire [31:0] student_ss_1_APB_to_APB_PWDATA;
    wire       student_ss_1_APB_to_APB_PWRITE;
    // student_ss_1_IRQ_to_IRQ wires:
    wire       student_ss_1_IRQ_to_IRQ_irq;
    // io_cell_frame_1_GPIO_external_to_GPIO wires:
    // io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio wires:
    wire [1:0] io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpi;
    wire [1:0] io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpio_oe;
    wire [1:0] io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpo;

    // Ad-hoc wires:
    wire       tech_cg_0_en_to_ss_ctrl_1;
    wire [7:0] io_cell_frame_1_io_cell_cfg_to_ss_ctrl_1;

    // io_cell_frame_1 port wires:
    wire [1:0] io_cell_frame_1_gpi_out;
    wire [1:0] io_cell_frame_1_gpio_oe;
    wire [1:0] io_cell_frame_1_gpo_in;
    wire [4:0] io_cell_frame_1_io_cell_cfg;
    // student_ss_1 port wires:
    wire [9:0] student_ss_1_PADDR;
    wire       student_ss_1_PENABLE;
    wire [31:0] student_ss_1_PRDATA;
    wire       student_ss_1_PREADY;
    wire       student_ss_1_PSEL;
    wire       student_ss_1_PSELERR;
    wire [31:0] student_ss_1_PWDATA;
    wire       student_ss_1_PWRITE;
    wire       student_ss_1_clk_in;
    wire [1:0] student_ss_1_gpi_i;
    wire [1:0] student_ss_1_gpio_oe;
    wire [1:0] student_ss_1_gpo_o;
    wire       student_ss_1_irq_1;
    wire       student_ss_1_irq_en_1;
    wire       student_ss_1_reset_int;
    wire [7:0] student_ss_1_ss_ctrl_1;
    // tech_cg_0 port wires:
    wire       tech_cg_0_clk;
    wire       tech_cg_0_clk_out;
    wire       tech_cg_0_en;

    // Assignments for the ports of the encompassing component:
    assign student_ss_1_APB_to_APB_PADDR = PADDR;
    assign student_ss_1_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = student_ss_1_APB_to_APB_PRDATA;
    assign PREADY = student_ss_1_APB_to_APB_PREADY;
    assign student_ss_1_APB_to_APB_PSEL = PSEL;
    assign PSELERR = student_ss_1_APB_to_APB_PSLVERR;
    assign student_ss_1_APB_to_APB_PWDATA = PWDATA;
    assign student_ss_1_APB_to_APB_PWRITE = PWRITE;
    assign tech_cg_0_clk_in_to_Clock_clk = clk;
    assign irq_1 = student_ss_1_IRQ_to_IRQ_irq;
    assign student_ss_1_ss_ctrl_to_SS_Ctrl_irq_en = irq_en_1;
    assign student_ss_1_Reset_to_Reset_reset = reset_int;
    assign student_ss_1_ss_ctrl_to_SS_Ctrl_clk_ctrl = ss_ctrl_1;
    assign io_cell_frame_1_io_cell_cfg_to_ss_ctrl_1 = ss_ctrl_1;
    assign tech_cg_0_en_to_ss_ctrl_1 = ss_ctrl_1[0];

    // io_cell_frame_1 assignments:
    assign io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpi = io_cell_frame_1_gpi_out;
    assign io_cell_frame_1_gpio_oe = io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpio_oe;
    assign io_cell_frame_1_gpo_in = io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpo;
    assign io_cell_frame_1_io_cell_cfg[5:0] = io_cell_frame_1_io_cell_cfg_to_ss_ctrl_1[5:0];
    // student_ss_1 assignments:
    assign student_ss_1_PADDR = student_ss_1_APB_to_APB_PADDR[9:0];
    assign student_ss_1_PENABLE = student_ss_1_APB_to_APB_PENABLE;
    assign student_ss_1_APB_to_APB_PRDATA = student_ss_1_PRDATA;
    assign student_ss_1_APB_to_APB_PREADY = student_ss_1_PREADY;
    assign student_ss_1_PSEL = student_ss_1_APB_to_APB_PSEL;
    assign student_ss_1_APB_to_APB_PSLVERR = student_ss_1_PSELERR;
    assign student_ss_1_PWDATA = student_ss_1_APB_to_APB_PWDATA;
    assign student_ss_1_PWRITE = student_ss_1_APB_to_APB_PWRITE;
    assign student_ss_1_clk_in = tech_cg_0_clk_out_to_student_ss_1_Clock_clk;
    assign student_ss_1_gpi_i = io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpi;
    assign io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpio_oe = student_ss_1_gpio_oe;
    assign io_cell_frame_1_GPIO_internal_to_student_ss_1_gpio_gpo = student_ss_1_gpo_o;
    assign student_ss_1_IRQ_to_IRQ_irq = student_ss_1_irq_1;
    assign student_ss_1_irq_en_1 = student_ss_1_ss_ctrl_to_SS_Ctrl_irq_en;
    assign student_ss_1_reset_int = student_ss_1_Reset_to_Reset_reset;
    assign student_ss_1_ss_ctrl_1 = student_ss_1_ss_ctrl_to_SS_Ctrl_clk_ctrl;
    // tech_cg_0 assignments:
    assign tech_cg_0_clk = tech_cg_0_clk_in_to_Clock_clk;
    assign tech_cg_0_clk_out_to_student_ss_1_Clock_clk = tech_cg_0_clk_out;
    assign tech_cg_0_en = tech_cg_0_en_to_ss_ctrl_1;

    // IP-XACT VLNV: tuni.fi:subsystem.io:io_cell_frame_ss_1:1.0
    io_cell_frame_ss_1     io_cell_frame_1(
        // Interface: GPIO_external
        .gpio                (gpio[1:0]),
        // Interface: GPIO_internal
        .gpio_oe             (io_cell_frame_1_gpio_oe),
        .gpo_in              (io_cell_frame_1_gpo_in),
        .gpi_out             (io_cell_frame_1_gpi_out),
        // These ports are not in any interface
        .io_cell_cfg         (io_cell_frame_1_io_cell_cfg));

    // IP-XACT VLNV: tuni.fi:subsystem:student_ss_1:1.0
    student_ss_1     student_ss_1(
        // Interface: APB
        .PADDR               (student_ss_1_PADDR),
        .PENABLE             (student_ss_1_PENABLE),
        .PSEL                (student_ss_1_PSEL),
        .PWDATA              (student_ss_1_PWDATA),
        .PWRITE              (student_ss_1_PWRITE),
        .PRDATA              (student_ss_1_PRDATA),
        .PREADY              (student_ss_1_PREADY),
        .PSELERR             (student_ss_1_PSELERR),
        // Interface: Clock
        .clk_in              (student_ss_1_clk_in),
        // Interface: IRQ
        .irq_1               (student_ss_1_irq_1),
        // Interface: Reset
        .reset_int           (student_ss_1_reset_int),
        // Interface: gpio
        .gpi_i               (student_ss_1_gpi_i),
        .gpio_oe             (student_ss_1_gpio_oe),
        .gpo_o               (student_ss_1_gpo_o),
        // Interface: ss_ctrl
        .irq_en_1            (student_ss_1_irq_en_1),
        .ss_ctrl_1           (student_ss_1_ss_ctrl_1));

    // IP-XACT VLNV: tuni.fi:tech:tech_cg:1.0
    tech_cg tech_cg_0(
        // Interface: clk_in
        .clk                 (tech_cg_0_clk),
        // Interface: clk_out
        .clk_out             (tech_cg_0_clk_out),
        // These ports are not in any interface
        .en                  (tech_cg_0_en));


endmodule
