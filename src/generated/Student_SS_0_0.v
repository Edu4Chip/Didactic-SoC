//-----------------------------------------------------------------------------
// File          : Student_SS_0_0.v
// Creation date : 11.12.2024
// Creation time : 14:56:31
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:Student_SS_0:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/Student_SS_0/1.0/Student_SS_0.1.0.xml
//-----------------------------------------------------------------------------

`ifdef VERILATOR
    `include "verification/verilator/src/hdl/nms/Student_SS_0_0.sv"
`endif

module Student_SS_0_0 #(
    parameter                              APB_DW           = 32,
    parameter                              APB_AW           = 32
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
    output logic                        irq,

    // Interface: Reset
    input  logic                        rst,

    // Interface: SS_Ctrl
    input  logic         [7:0]          clk_ctrl,
    input  logic                        irq_en,

    // Interface: high_speed_clk_in
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
    `ifdef VERILATOR
        `include "verification/verilator/src/hdl/ms/Student_SS_0_0.sv"
    `endif

    // ss_cg_clk_in_to_Clock wires:
    wire       ss_cg_clk_in_to_Clock_clk;
    // ss_cg_clk_out_to_Student_area_0_clk wires:
    wire       ss_cg_clk_out_to_Student_area_0_clk_clk;
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
    // Student_area_0_pmod_gpio_0_to_bus_1 wires:
    wire [3:0] Student_area_0_pmod_gpio_0_to_bus_1_gpi;
    wire [3:0] Student_area_0_pmod_gpio_0_to_bus_1_gpio_oe;
    wire [3:0] Student_area_0_pmod_gpio_0_to_bus_1_gpo;
    // Student_area_0_pmod_gpio_1_to_bus wires:
    wire [3:0] Student_area_0_pmod_gpio_1_to_bus_gpi;
    wire [3:0] Student_area_0_pmod_gpio_1_to_bus_gpio_oe;
    wire [3:0] Student_area_0_pmod_gpio_1_to_bus_gpo;
    // ss_high_speed_cg_clk_in_to_high_speed_clk_in wires:
    wire       ss_high_speed_cg_clk_in_to_high_speed_clk_in_clk;
    // ss_high_speed_cg_clk_out_to_Student_area_0_high_speed_clk wires:
    wire       ss_high_speed_cg_clk_out_to_Student_area_0_high_speed_clk_clk;

    // Ad-hoc wires:
    wire       ss_cg_en_to_clk_ctrl;
    wire       ss_high_speed_cg_en_to_clk_ctrl;

    // Student_area_0 port wires:
    wire [11:0] Student_area_0_PADDR;
    wire       Student_area_0_PENABLE;
    wire [31:0] Student_area_0_PRDATA;
    wire       Student_area_0_PREADY;
    wire       Student_area_0_PSEL;
    wire       Student_area_0_PSLVERR;
    wire [31:0] Student_area_0_PWDATA;
    wire       Student_area_0_PWRITE;
    wire [7:0] Student_area_0_clk_ctrl;
    wire       Student_area_0_clk_in;
    wire       Student_area_0_high_speed_clk;
    wire       Student_area_0_irq;
    wire       Student_area_0_irq_en;
    wire [3:0] Student_area_0_pmod_0_gpi;
    wire [3:0] Student_area_0_pmod_0_gpio_oe;
    wire [3:0] Student_area_0_pmod_0_gpo;
    wire [3:0] Student_area_0_pmod_1_gpi;
    wire [3:0] Student_area_0_pmod_1_gpio_oe;
    wire [3:0] Student_area_0_pmod_1_gpo;
    wire       Student_area_0_rst;
    // ss_cg port wires:
    wire       ss_cg_clk;
    wire       ss_cg_clk_out;
    wire       ss_cg_en;
    // ss_high_speed_cg port wires:
    wire       ss_high_speed_cg_clk;
    wire       ss_high_speed_cg_clk_out;
    wire       ss_high_speed_cg_en;

    // Assignments for the ports of the encompassing component:
    assign Student_area_0_APB_to_APB_PADDR = PADDR;
    assign Student_area_0_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = Student_area_0_APB_to_APB_PRDATA;
    assign PREADY = Student_area_0_APB_to_APB_PREADY;
    assign Student_area_0_APB_to_APB_PSEL = PSEL;
    assign PSELERR = Student_area_0_APB_to_APB_PSLVERR;
    assign Student_area_0_APB_to_APB_PWDATA = PWDATA;
    assign Student_area_0_APB_to_APB_PWRITE = PWRITE;
    assign ss_cg_clk_in_to_Clock_clk = clk;
    assign Student_area_0_SS_Ctrl_to_SS_Ctrl_clk_ctrl = clk_ctrl;
    assign ss_cg_en_to_clk_ctrl = clk_ctrl[0];
    assign ss_high_speed_cg_en_to_clk_ctrl = clk_ctrl[1];
    assign ss_high_speed_cg_clk_in_to_high_speed_clk_in_clk = high_speed_clk;
    assign irq = Student_area_0_IRQ_to_IRQ_irq;
    assign Student_area_0_SS_Ctrl_to_SS_Ctrl_irq_en = irq_en;
    assign Student_area_0_pmod_gpio_0_to_bus_1_gpi = pmod_0_gpi;
    assign pmod_0_gpio_oe = Student_area_0_pmod_gpio_0_to_bus_1_gpio_oe;
    assign pmod_0_gpo = Student_area_0_pmod_gpio_0_to_bus_1_gpo;
    assign Student_area_0_pmod_gpio_1_to_bus_gpi = pmod_1_gpi;
    assign pmod_1_gpio_oe = Student_area_0_pmod_gpio_1_to_bus_gpio_oe;
    assign pmod_1_gpo = Student_area_0_pmod_gpio_1_to_bus_gpo;
    assign Student_area_0_reset_to_Reset_reset = rst;

    // Student_area_0 assignments:
    assign Student_area_0_PADDR = Student_area_0_APB_to_APB_PADDR[11:0];
    assign Student_area_0_PENABLE = Student_area_0_APB_to_APB_PENABLE;
    assign Student_area_0_APB_to_APB_PRDATA = Student_area_0_PRDATA;
    assign Student_area_0_APB_to_APB_PREADY = Student_area_0_PREADY;
    assign Student_area_0_PSEL = Student_area_0_APB_to_APB_PSEL;
    assign Student_area_0_APB_to_APB_PSLVERR = Student_area_0_PSLVERR;
    assign Student_area_0_PWDATA = Student_area_0_APB_to_APB_PWDATA;
    assign Student_area_0_PWRITE = Student_area_0_APB_to_APB_PWRITE;
    assign Student_area_0_clk_ctrl = Student_area_0_SS_Ctrl_to_SS_Ctrl_clk_ctrl;
    assign Student_area_0_clk_in = ss_cg_clk_out_to_Student_area_0_clk_clk;
    assign Student_area_0_high_speed_clk = ss_high_speed_cg_clk_out_to_Student_area_0_high_speed_clk_clk;
    assign Student_area_0_IRQ_to_IRQ_irq = Student_area_0_irq;
    assign Student_area_0_irq_en = Student_area_0_SS_Ctrl_to_SS_Ctrl_irq_en;
    assign Student_area_0_pmod_0_gpi = Student_area_0_pmod_gpio_0_to_bus_1_gpi;
    assign Student_area_0_pmod_gpio_0_to_bus_1_gpio_oe = Student_area_0_pmod_0_gpio_oe;
    assign Student_area_0_pmod_gpio_0_to_bus_1_gpo = Student_area_0_pmod_0_gpo;
    assign Student_area_0_pmod_1_gpi = Student_area_0_pmod_gpio_1_to_bus_gpi;
    assign Student_area_0_pmod_gpio_1_to_bus_gpio_oe = Student_area_0_pmod_1_gpio_oe;
    assign Student_area_0_pmod_gpio_1_to_bus_gpo = Student_area_0_pmod_1_gpo;
    assign Student_area_0_rst = Student_area_0_reset_to_Reset_reset;
    // ss_cg assignments:
    assign ss_cg_clk = ss_cg_clk_in_to_Clock_clk;
    assign ss_cg_clk_out_to_Student_area_0_clk_clk = ss_cg_clk_out;
    assign ss_cg_en = ss_cg_en_to_clk_ctrl;
    // ss_high_speed_cg assignments:
    assign ss_high_speed_cg_clk = ss_high_speed_cg_clk_in_to_high_speed_clk_in_clk;
    assign ss_high_speed_cg_clk_out_to_Student_area_0_high_speed_clk_clk = ss_high_speed_cg_clk_out;
    assign ss_high_speed_cg_en = ss_high_speed_cg_en_to_clk_ctrl;

    // IP-XACT VLNV: tuni.fi:subsystem:Student_area_0:1.0
    Student_area_0 #(
        .APB_AW              (12),
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
        // Interface: high_speed_clk
        .high_speed_clk      (Student_area_0_high_speed_clk),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (Student_area_0_pmod_0_gpi),
        .pmod_0_gpio_oe      (Student_area_0_pmod_0_gpio_oe),
        .pmod_0_gpo          (Student_area_0_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (Student_area_0_pmod_1_gpi),
        .pmod_1_gpio_oe      (Student_area_0_pmod_1_gpio_oe),
        .pmod_1_gpo          (Student_area_0_pmod_1_gpo),
        // Interface: reset
        .rst                 (Student_area_0_rst));

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
