//-----------------------------------------------------------------------------
// File          : analog_wrapper_0.v
// Creation date : 08.10.2025
// Creation time : 12:12:35
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.5 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:analog_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/analog_wrapper/1.0/analog_wrapper.1.0.xml
//-----------------------------------------------------------------------------

module analog_wrapper_0 #(
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
    input  logic                        irq_en,
    input  logic         [7:0]          ss_ctrl,

    // Interface: digital_gpio
    input  logic         [15:0]         pmod_gpi,
    output logic         [15:0]         pmod_gpio_oe,
    output logic         [15:0]         pmod_gpo,

    // Interface: high_speed_clk
    input  logic                        high_speed_clk
);

    // ss_cg_clk_in_to_Clock wires:
    wire       ss_cg_clk_in_to_Clock_clk;
    // analog_status_array_APB_to_APB wires:
    wire [31:0] analog_status_array_APB_to_APB_PADDR;
    wire       analog_status_array_APB_to_APB_PENABLE;
    wire [31:0] analog_status_array_APB_to_APB_PRDATA;
    wire       analog_status_array_APB_to_APB_PREADY;
    wire       analog_status_array_APB_to_APB_PSEL;
    wire       analog_status_array_APB_to_APB_PSLVERR;
    wire [3:0] analog_status_array_APB_to_APB_PSTRB;
    wire [31:0] analog_status_array_APB_to_APB_PWDATA;
    wire       analog_status_array_APB_to_APB_PWRITE;
    // analog_status_array_clk_to_ss_cg_clk_out wires:
    wire       analog_status_array_clk_to_ss_cg_clk_out_clk;
    // analog_status_array_reset_to_Reset wires:
    wire       analog_status_array_reset_to_Reset_reset;
    // ss_high_speed_cg_clk_in_to_high_speed_clk wires:
    wire       ss_high_speed_cg_clk_in_to_high_speed_clk_clk;
    // analog_ss_digital_gpio_to_digital_gpio wires:
    wire [15:0] analog_ss_digital_gpio_to_digital_gpio_gpi;
    wire [15:0] analog_ss_digital_gpio_to_digital_gpio_gpio_oe;
    wire [15:0] analog_ss_digital_gpio_to_digital_gpio_gpo;

    // Ad-hoc wires:
    wire       ss_cg_en_to_ss_ctrl;
    wire       ss_high_speed_cg_en_to_ss_ctrl;

    // analog_ss port wires:
    wire [15:0] analog_ss_pmod_gpi;
    wire [15:0] analog_ss_pmod_gpio_oe;
    wire [15:0] analog_ss_pmod_gpo;
    // analog_status_array port wires:
    wire [11:0] analog_status_array_PADDR;
    wire       analog_status_array_PENABLE;
    wire [31:0] analog_status_array_PRDATA;
    wire       analog_status_array_PREADY;
    wire       analog_status_array_PSEL;
    wire       analog_status_array_PSLVERR;
    wire [3:0] analog_status_array_PSTRB;
    wire [31:0] analog_status_array_PWDATA;
    wire       analog_status_array_PWRITE;
    wire       analog_status_array_clk_in;
    wire       analog_status_array_reset_n;
    // ss_cg port wires:
    wire       ss_cg_clk;
    wire       ss_cg_clk_out;
    wire       ss_cg_en;
    // ss_high_speed_cg port wires:
    wire       ss_high_speed_cg_clk;
    wire       ss_high_speed_cg_en;

    // Assignments for the ports of the encompassing component:
    assign analog_status_array_APB_to_APB_PADDR = PADDR;
    assign analog_status_array_APB_to_APB_PENABLE = PENABLE;
    assign PRDATA = analog_status_array_APB_to_APB_PRDATA;
    assign PREADY = analog_status_array_APB_to_APB_PREADY;
    assign analog_status_array_APB_to_APB_PSEL = PSEL;
    assign PSLVERR = analog_status_array_APB_to_APB_PSLVERR;
    assign analog_status_array_APB_to_APB_PSTRB = PSTRB;
    assign analog_status_array_APB_to_APB_PWDATA = PWDATA;
    assign analog_status_array_APB_to_APB_PWRITE = PWRITE;
    assign ss_cg_clk_in_to_Clock_clk = clk_in;
    assign ss_high_speed_cg_clk_in_to_high_speed_clk_clk = high_speed_clk;
    assign irq = 0;
    assign analog_ss_digital_gpio_to_digital_gpio_gpi = pmod_gpi;
    assign pmod_gpio_oe = analog_ss_digital_gpio_to_digital_gpio_gpio_oe;
    assign pmod_gpo = analog_ss_digital_gpio_to_digital_gpio_gpo;
    assign analog_status_array_reset_to_Reset_reset = reset_int;
    assign ss_cg_en_to_ss_ctrl = ss_ctrl[0];
    assign ss_high_speed_cg_en_to_ss_ctrl = ss_ctrl[1];


    // analog_ss assignments:
    assign analog_ss_pmod_gpi = analog_ss_digital_gpio_to_digital_gpio_gpi;
    assign analog_ss_digital_gpio_to_digital_gpio_gpio_oe = analog_ss_pmod_gpio_oe;
    assign analog_ss_digital_gpio_to_digital_gpio_gpo = analog_ss_pmod_gpo;
    // analog_status_array assignments:
    assign analog_status_array_PADDR = analog_status_array_APB_to_APB_PADDR[11:0];
    assign analog_status_array_PENABLE = analog_status_array_APB_to_APB_PENABLE;
    assign analog_status_array_APB_to_APB_PRDATA = analog_status_array_PRDATA;
    assign analog_status_array_APB_to_APB_PREADY = analog_status_array_PREADY;
    assign analog_status_array_PSEL = analog_status_array_APB_to_APB_PSEL;
    assign analog_status_array_APB_to_APB_PSLVERR = analog_status_array_PSLVERR;
    assign analog_status_array_PSTRB = analog_status_array_APB_to_APB_PSTRB;
    assign analog_status_array_PWDATA = analog_status_array_APB_to_APB_PWDATA;
    assign analog_status_array_PWRITE = analog_status_array_APB_to_APB_PWRITE;
    assign analog_status_array_clk_in = analog_status_array_clk_to_ss_cg_clk_out_clk;
    assign analog_status_array_reset_n = analog_status_array_reset_to_Reset_reset;
    // ss_cg assignments:
    assign ss_cg_clk = ss_cg_clk_in_to_Clock_clk;
    assign analog_status_array_clk_to_ss_cg_clk_out_clk = ss_cg_clk_out;
    assign ss_cg_en = ss_cg_en_to_ss_ctrl;
    // ss_high_speed_cg assignments:
    assign ss_high_speed_cg_clk = ss_high_speed_cg_clk_in_to_high_speed_clk_clk;
    assign ss_high_speed_cg_en = ss_high_speed_cg_en_to_ss_ctrl;

    // IP-XACT VLNV: tuni.fi:analog:student_ss_analog:1.0
    student_ss_analog     analog_ss(
        // Interface: digital_gpio
        .pmod_gpi            (analog_ss_pmod_gpi),
        .pmod_gpio_oe        (analog_ss_pmod_gpio_oe),
        .pmod_gpo            (analog_ss_pmod_gpo));

    // IP-XACT VLNV: tuni.fi:ip:analog_status_array:1.0
    analog_status_array analog_status_array(
        // Interface: APB
        .PADDR               (analog_status_array_PADDR),
        .PENABLE             (analog_status_array_PENABLE),
        .PSEL                (analog_status_array_PSEL),
        .PSTRB               (analog_status_array_PSTRB),
        .PWDATA              (analog_status_array_PWDATA),
        .PWRITE              (analog_status_array_PWRITE),
        .PRDATA              (analog_status_array_PRDATA),
        .PREADY              (analog_status_array_PREADY),
        .PSLVERR             (analog_status_array_PSLVERR),
        // Interface: clk
        .clk_in              (analog_status_array_clk_in),
        // Interface: reset
        .reset_n             (analog_status_array_reset_n),
        // Interface: status_0
        .status_0            (32'h0),
        // Interface: status_1
        .status_1            (32'h1),
        // Interface: status_2
        .status_2            (32'h2),
        // Interface: status_3
        .status_3            (32'h3));

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
        .clk_out             (),
        // These ports are not in any interface
        .en                  (ss_high_speed_cg_en));


endmodule
