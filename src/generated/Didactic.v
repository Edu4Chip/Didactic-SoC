//-----------------------------------------------------------------------------
// File          : Didactic.v
// Creation date : 26.09.2024
// Creation time : 12:18:21
// Description   : Edu4Chip top level example SoC.
//                 
//                 Spec: 
//                 * RiscV core
//                 * 28 signal IO
//                 
// Created by    : 
// Tool : Kactus2 3.13.2 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:soc:Didactic:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/soc/Didactic/1.0/Didactic.1.0.xml
//-----------------------------------------------------------------------------

`ifdef VERILATOR
    `include "verification/verilator/src/hdl/nms/Didactic.sv"
`endif

module Didactic #(
    parameter                              AW               = 32,    // Global SoC address width
    parameter                              DW               = 32,    // Global SoC data width
    parameter                              SS_CTRL_W        = 8,    // SoC SS control width
    parameter                              NUM_GPIO         = 8,    // SoC GPIO Cell count. Default 2x pmod = 8.
    parameter                              IOCELL_CFG_W     = 5,    // Tech cell control width.
    parameter                              IOCELL_COUNT     = 17    // number of configurable io cells in design. Total 24? + analog + power.
) (
    // Interface: Clock
    inout  wire                         clk_in,

    // Interface: GPIO
    inout  wire          [7:0]          gpio,

    // Interface: JTAG
    inout  wire                         jtag_tck,
    inout  wire                         jtag_tdi,
    inout  wire                         jtag_tdo,
    inout  wire                         jtag_tms,
    inout  wire                         jtag_trst,

    // Interface: Reset
    inout  wire                         reset,

    // Interface: SPI
    inout  wire          [1:0]          spi_csn,
    inout  wire          [3:0]          spi_data,
    inout  wire                         spi_sck,

    // Interface: UART
    inout  wire                         uart_rx,
    inout  wire                         uart_tx,

    // Interface: analog_if
    inout  wire          [1:0]          ana_core_in,
    inout  wire          [1:0]          ana_core_out
);
    `ifdef VERILATOR
        `include "verification/verilator/src/hdl/ms/Didactic.sv"
    `endif

    // SystemControl_SS_UART_to_UART wires:
    // SystemControl_SS_SPI_to_SPI wires:
    // SystemControl_SS_GPIO_to_GPIO wires:
    // SystemControl_SS_Reset_to_Reset wires:
    // SystemControl_SS_Clock_to_Clock wires:
    // SystemControl_SS_Clock_int_to_ICN_SS_Clock wires:
    wire       SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk;
    // SystemControl_SS_ICN_SS_Ctrl_to_ICN_SS_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_ICN_SS_Ctrl_to_ICN_SS_SS_Ctrl_clk_ctrl;
    // SystemControl_SS_IRQ0_to_Student_SS_0_IRQ wires:
    wire       SystemControl_SS_IRQ0_to_Student_SS_0_IRQ_irq;
    // SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_irq_en;
    // ICN_SS_APB0_to_Student_SS_0_APB wires:
    wire [31:0] ICN_SS_APB0_to_Student_SS_0_APB_PADDR;
    wire       ICN_SS_APB0_to_Student_SS_0_APB_PENABLE;
    wire [31:0] ICN_SS_APB0_to_Student_SS_0_APB_PRDATA;
    wire       ICN_SS_APB0_to_Student_SS_0_APB_PREADY;
    wire       ICN_SS_APB0_to_Student_SS_0_APB_PSEL;
    wire       ICN_SS_APB0_to_Student_SS_0_APB_PSLVERR;
    wire [31:0] ICN_SS_APB0_to_Student_SS_0_APB_PWDATA;
    wire       ICN_SS_APB0_to_Student_SS_0_APB_PWRITE;
    // ICN_SS_APB1_to_Student_SS_1_APB wires:
    wire [31:0] ICN_SS_APB1_to_Student_SS_1_APB_PADDR;
    wire       ICN_SS_APB1_to_Student_SS_1_APB_PENABLE;
    wire [31:0] ICN_SS_APB1_to_Student_SS_1_APB_PRDATA;
    wire       ICN_SS_APB1_to_Student_SS_1_APB_PREADY;
    wire       ICN_SS_APB1_to_Student_SS_1_APB_PSEL;
    wire       ICN_SS_APB1_to_Student_SS_1_APB_PSLVERR;
    wire [31:0] ICN_SS_APB1_to_Student_SS_1_APB_PWDATA;
    wire       ICN_SS_APB1_to_Student_SS_1_APB_PWRITE;
    // SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_irq_en;
    // SystemControl_SS_IRQ1_to_Student_SS_1_IRQ wires:
    wire       SystemControl_SS_IRQ1_to_Student_SS_1_IRQ_irq;
    // ICN_SS_APB2_to_Student_SS_2_APB wires:
    wire [31:0] ICN_SS_APB2_to_Student_SS_2_APB_PADDR;
    wire       ICN_SS_APB2_to_Student_SS_2_APB_PENABLE;
    wire [31:0] ICN_SS_APB2_to_Student_SS_2_APB_PRDATA;
    wire       ICN_SS_APB2_to_Student_SS_2_APB_PREADY;
    wire       ICN_SS_APB2_to_Student_SS_2_APB_PSEL;
    wire       ICN_SS_APB2_to_Student_SS_2_APB_PSLVERR;
    wire [31:0] ICN_SS_APB2_to_Student_SS_2_APB_PWDATA;
    wire       ICN_SS_APB2_to_Student_SS_2_APB_PWRITE;
    // SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_irq_en;
    // SystemControl_SS_IRQ2_to_Student_SS_2_IRQ wires:
    wire       SystemControl_SS_IRQ2_to_Student_SS_2_IRQ_irq;
    // SystemControl_SS_JTAG_to_JTAG wires:
    // SystemControl_SS_Reset_icn_to_ICN_SS_Reset wires:
    wire       SystemControl_SS_Reset_icn_to_ICN_SS_Reset_reset;
    // SystemControl_SS_Reset_SS_0_to_Student_SS_0_Reset wires:
    wire       SystemControl_SS_Reset_SS_0_to_Student_SS_0_Reset_reset;
    // SystemControl_SS_Reset_SS_1_to_Student_SS_1_Reset wires:
    wire       SystemControl_SS_Reset_SS_1_to_Student_SS_1_Reset_reset;
    // SystemControl_SS_Reset_SS_2_to_Student_SS_2_Reset wires:
    wire       SystemControl_SS_Reset_SS_2_to_Student_SS_2_Reset_reset;
    // SystemControl_SS_Reset_SS_3_to_Student_SS_3_Reset wires:
    wire       SystemControl_SS_Reset_SS_3_to_Student_SS_3_Reset_reset;
    // SystemControl_SS_IRQ3_to_Student_SS_3_IRQ wires:
    wire       SystemControl_SS_IRQ3_to_Student_SS_3_IRQ_irq;
    // SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_irq_en;
    // ICN_SS_APB3_to_Student_SS_3_APB wires:
    wire [31:0] ICN_SS_APB3_to_Student_SS_3_APB_PADDR;
    wire       ICN_SS_APB3_to_Student_SS_3_APB_PENABLE;
    wire [31:0] ICN_SS_APB3_to_Student_SS_3_APB_PRDATA;
    wire       ICN_SS_APB3_to_Student_SS_3_APB_PREADY;
    wire       ICN_SS_APB3_to_Student_SS_3_APB_PSEL;
    wire       ICN_SS_APB3_to_Student_SS_3_APB_PSLVERR;
    wire [31:0] ICN_SS_APB3_to_Student_SS_3_APB_PWDATA;
    wire       ICN_SS_APB3_to_Student_SS_3_APB_PWRITE;
    // Student_SS_2_analog_if_to_bus wires:
    // Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0 wires:
    wire [3:0] Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpi;
    wire [3:0] Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpio_oe;
    wire [3:0] Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpo;
    // SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1 wires:
    wire [3:0] SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpi;
    wire [3:0] SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpio_oe;
    wire [3:0] SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpo;
    // Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0 wires:
    wire [3:0] Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpi;
    wire [3:0] Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpio_oe;
    wire [3:0] Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpo;
    // Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1 wires:
    wire [3:0] Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpi;
    wire [3:0] Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpio_oe;
    wire [3:0] Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpo;
    // Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0 wires:
    wire [3:0] Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpi;
    wire [3:0] Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpio_oe;
    wire [3:0] Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpo;
    // SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1 wires:
    wire [3:0] SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpi;
    wire [3:0] SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpio_oe;
    wire [3:0] SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpo;
    // Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0 wires:
    wire [3:0] Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpi;
    wire [3:0] Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpio_oe;
    wire [3:0] Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpo;
    // Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1 wires:
    wire [3:0] Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpi;
    wire [3:0] Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpio_oe;
    wire [3:0] Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpo;
    // ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn wires:
    wire [31:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_ADDR;
    wire [3:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_PROT;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_READY;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_VALID;
    wire [31:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_ADDR;
    wire [3:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_PROT;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_READY;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_VALID;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_READY;
    wire [1:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_RESP;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_VALID;
    wire [31:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_DATA;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_READY;
    wire [1:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_RESP;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_VALID;
    wire [31:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_DATA;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_READY;
    wire [3:0] ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_STRB;
    wire       ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_VALID;

    // ICN_SS port wires:
    wire [31:0] ICN_SS_PADDR;
    wire       ICN_SS_PENABLE;
    wire [127:0] ICN_SS_PRDATA;
    wire [3:0] ICN_SS_PREADY;
    wire [3:0] ICN_SS_PSEL;
    wire [3:0] ICN_SS_PSLVERR;
    wire [31:0] ICN_SS_PWDATA;
    wire       ICN_SS_PWRITE;
    wire       ICN_SS_clk;
    wire [31:0] ICN_SS_icn_ar_addr_in;
    wire [3:0] ICN_SS_icn_ar_prot_in;
    wire       ICN_SS_icn_ar_ready_out;
    wire       ICN_SS_icn_ar_valid_in;
    wire [31:0] ICN_SS_icn_aw_addr_in;
    wire [3:0] ICN_SS_icn_aw_prot_in;
    wire       ICN_SS_icn_aw_ready_out;
    wire       ICN_SS_icn_aw_valid_in;
    wire       ICN_SS_icn_b_ready_in;
    wire [1:0] ICN_SS_icn_b_resp_out;
    wire       ICN_SS_icn_b_valid_out;
    wire [31:0] ICN_SS_icn_r_data_out;
    wire       ICN_SS_icn_r_ready_in;
    wire [1:0] ICN_SS_icn_r_resp_out;
    wire       ICN_SS_icn_r_valid_out;
    wire [31:0] ICN_SS_icn_w_data_in;
    wire       ICN_SS_icn_w_ready_out;
    wire [3:0] ICN_SS_icn_w_strb_in;
    wire       ICN_SS_icn_w_valid_in;
    wire       ICN_SS_reset_int;
    wire [7:0] ICN_SS_ss_ctrl_icn;
    // Student_SS_0 port wires:
    wire [31:0] Student_SS_0_PADDR;
    wire       Student_SS_0_PENABLE;
    wire [31:0] Student_SS_0_PRDATA;
    wire       Student_SS_0_PREADY;
    wire       Student_SS_0_PSEL;
    wire       Student_SS_0_PSELERR;
    wire [31:0] Student_SS_0_PWDATA;
    wire       Student_SS_0_PWRITE;
    wire       Student_SS_0_clk;
    wire [7:0] Student_SS_0_clk_ctrl;
    wire       Student_SS_0_irq;
    wire       Student_SS_0_irq_en;
    wire [3:0] Student_SS_0_pmod_0_gpi;
    wire [3:0] Student_SS_0_pmod_0_gpio_oe;
    wire [3:0] Student_SS_0_pmod_0_gpo;
    wire [3:0] Student_SS_0_pmod_1_gpi;
    wire [3:0] Student_SS_0_pmod_1_gpio_oe;
    wire [3:0] Student_SS_0_pmod_1_gpo;
    wire       Student_SS_0_rst;
    // Student_SS_1 port wires:
    wire [31:0] Student_SS_1_PADDR;
    wire       Student_SS_1_PENABLE;
    wire [31:0] Student_SS_1_PRDATA;
    wire       Student_SS_1_PREADY;
    wire       Student_SS_1_PSEL;
    wire       Student_SS_1_PSELERR;
    wire [31:0] Student_SS_1_PWDATA;
    wire       Student_SS_1_PWRITE;
    wire       Student_SS_1_clk;
    wire       Student_SS_1_irq_1;
    wire       Student_SS_1_irq_en_1;
    wire [3:0] Student_SS_1_pmod_0_gpi;
    wire [3:0] Student_SS_1_pmod_0_gpio_oe;
    wire [3:0] Student_SS_1_pmod_0_gpo;
    wire [3:0] Student_SS_1_pmod_1_gpi;
    wire [3:0] Student_SS_1_pmod_1_gpio_oe;
    wire [3:0] Student_SS_1_pmod_1_gpo;
    wire       Student_SS_1_reset_int;
    wire [7:0] Student_SS_1_ss_ctrl_1;
    // Student_SS_2 port wires:
    wire [31:0] Student_SS_2_PADDR;
    wire       Student_SS_2_PENABLE;
    wire [31:0] Student_SS_2_PRDATA;
    wire       Student_SS_2_PREADY;
    wire       Student_SS_2_PSEL;
    wire       Student_SS_2_PSELERR;
    wire [31:0] Student_SS_2_PWDATA;
    wire       Student_SS_2_PWRITE;
    wire       Student_SS_2_clk;
    wire       Student_SS_2_irq_2;
    wire       Student_SS_2_irq_en_2;
    wire [3:0] Student_SS_2_pmod_0_gpi;
    wire [3:0] Student_SS_2_pmod_0_gpio_oe;
    wire [3:0] Student_SS_2_pmod_0_gpo;
    wire [3:0] Student_SS_2_pmod_1_gpi;
    wire [3:0] Student_SS_2_pmod_1_gpio_oe;
    wire [3:0] Student_SS_2_pmod_1_gpo;
    wire       Student_SS_2_reset_int;
    wire [7:0] Student_SS_2_ss_ctrl_2;
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
    wire [3:0] Student_SS_3_pmod_0_gpi;
    wire [3:0] Student_SS_3_pmod_0_gpio_oe;
    wire [3:0] Student_SS_3_pmod_0_gpo;
    wire [3:0] Student_SS_3_pmod_1_gpi;
    wire [3:0] Student_SS_3_pmod_1_gpio_oe;
    wire [3:0] Student_SS_3_pmod_1_gpo;
    wire       Student_SS_3_reset_int;
    wire [7:0] Student_SS_3_ss_ctrl_3;
    // SystemControl_SS port wires:
    wire       SystemControl_SS_clk;
    wire [31:0] SystemControl_SS_icn_ar_addr_out;
    wire [3:0] SystemControl_SS_icn_ar_prot_out;
    wire       SystemControl_SS_icn_ar_ready_in;
    wire       SystemControl_SS_icn_ar_valid_out;
    wire [31:0] SystemControl_SS_icn_aw_addr_out;
    wire [3:0] SystemControl_SS_icn_aw_prot_out;
    wire       SystemControl_SS_icn_aw_ready_in;
    wire       SystemControl_SS_icn_aw_valid_out;
    wire       SystemControl_SS_icn_b_ready_out;
    wire [1:0] SystemControl_SS_icn_b_resp_in;
    wire       SystemControl_SS_icn_b_valid_in;
    wire [31:0] SystemControl_SS_icn_r_data_in;
    wire       SystemControl_SS_icn_r_ready_out;
    wire [1:0] SystemControl_SS_icn_r_resp_in;
    wire       SystemControl_SS_icn_r_valid_in;
    wire [31:0] SystemControl_SS_icn_w_data_out;
    wire       SystemControl_SS_icn_w_ready_in;
    wire [3:0] SystemControl_SS_icn_w_strb_out;
    wire       SystemControl_SS_icn_w_valid_out;
    wire       SystemControl_SS_irq_0;
    wire       SystemControl_SS_irq_1;
    wire       SystemControl_SS_irq_2;
    wire       SystemControl_SS_irq_3;
    wire       SystemControl_SS_irq_en_0;
    wire       SystemControl_SS_irq_en_1;
    wire       SystemControl_SS_irq_en_2;
    wire       SystemControl_SS_irq_en_3;
    wire       SystemControl_SS_reset_int;
    wire       SystemControl_SS_reset_ss_0;
    wire       SystemControl_SS_reset_ss_1;
    wire       SystemControl_SS_reset_ss_2;
    wire       SystemControl_SS_reset_ss_3;
    wire [3:0] SystemControl_SS_ss_0_pmo_0_gpi;
    wire [3:0] SystemControl_SS_ss_0_pmo_0_gpio_oe;
    wire [3:0] SystemControl_SS_ss_0_pmo_0_gpo;
    wire [3:0] SystemControl_SS_ss_0_pmo_1_gpi;
    wire [3:0] SystemControl_SS_ss_0_pmo_1_gpio_oe;
    wire [3:0] SystemControl_SS_ss_0_pmo_1_gpo;
    wire [3:0] SystemControl_SS_ss_1_pmod_0_gpi;
    wire [3:0] SystemControl_SS_ss_1_pmod_0_gpio_oe;
    wire [3:0] SystemControl_SS_ss_1_pmod_0_gpo;
    wire [3:0] SystemControl_SS_ss_1_pmod_1_gpi;
    wire [3:0] SystemControl_SS_ss_1_pmod_1_gpio_oe;
    wire [3:0] SystemControl_SS_ss_1_pmod_1_gpo;
    wire [3:0] SystemControl_SS_ss_2_pmod_0_gpi;
    wire [3:0] SystemControl_SS_ss_2_pmod_0_gpio_oe;
    wire [3:0] SystemControl_SS_ss_2_pmod_0_gpo;
    wire [3:0] SystemControl_SS_ss_2_pmod_1_gpi;
    wire [3:0] SystemControl_SS_ss_2_pmod_1_gpio_oe;
    wire [3:0] SystemControl_SS_ss_2_pmod_1_gpo;
    wire [3:0] SystemControl_SS_ss_3_pmod_0_gpi;
    wire [3:0] SystemControl_SS_ss_3_pmod_0_gpio_oe;
    wire [3:0] SystemControl_SS_ss_3_pmod_0_gpo;
    wire [3:0] SystemControl_SS_ss_3_pmod_1_gpi;
    wire [3:0] SystemControl_SS_ss_3_pmod_1_gpio_oe;
    wire [3:0] SystemControl_SS_ss_3_pmod_1_gpo;
    wire [7:0] SystemControl_SS_ss_ctrl_0;
    wire [7:0] SystemControl_SS_ss_ctrl_1;
    wire [7:0] SystemControl_SS_ss_ctrl_2;
    wire [7:0] SystemControl_SS_ss_ctrl_3;
    wire [7:0] SystemControl_SS_ss_ctrl_icn;

    // Assignments for the ports of the encompassing component:

    // ICN_SS assignments:
    assign ICN_SS_APB3_to_Student_SS_3_APB_PADDR = ICN_SS_PADDR;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PADDR = ICN_SS_PADDR;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PADDR = ICN_SS_PADDR;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PADDR = ICN_SS_PADDR;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PENABLE = ICN_SS_PENABLE;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PENABLE = ICN_SS_PENABLE;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PENABLE = ICN_SS_PENABLE;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PENABLE = ICN_SS_PENABLE;
    assign ICN_SS_PRDATA[127:96] = ICN_SS_APB3_to_Student_SS_3_APB_PRDATA;
    assign ICN_SS_PRDATA[95:64] = ICN_SS_APB2_to_Student_SS_2_APB_PRDATA;
    assign ICN_SS_PRDATA[63:32] = ICN_SS_APB1_to_Student_SS_1_APB_PRDATA;
    assign ICN_SS_PRDATA[31:0] = ICN_SS_APB0_to_Student_SS_0_APB_PRDATA;
    assign ICN_SS_PREADY[3] = ICN_SS_APB3_to_Student_SS_3_APB_PREADY;
    assign ICN_SS_PREADY[2] = ICN_SS_APB2_to_Student_SS_2_APB_PREADY;
    assign ICN_SS_PREADY[1] = ICN_SS_APB1_to_Student_SS_1_APB_PREADY;
    assign ICN_SS_PREADY[0] = ICN_SS_APB0_to_Student_SS_0_APB_PREADY;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PSEL = ICN_SS_PSEL[3];
    assign ICN_SS_APB2_to_Student_SS_2_APB_PSEL = ICN_SS_PSEL[2];
    assign ICN_SS_APB1_to_Student_SS_1_APB_PSEL = ICN_SS_PSEL[1];
    assign ICN_SS_APB0_to_Student_SS_0_APB_PSEL = ICN_SS_PSEL[0];
    assign ICN_SS_PSLVERR[3] = ICN_SS_APB3_to_Student_SS_3_APB_PSLVERR;
    assign ICN_SS_PSLVERR[2] = ICN_SS_APB2_to_Student_SS_2_APB_PSLVERR;
    assign ICN_SS_PSLVERR[1] = ICN_SS_APB1_to_Student_SS_1_APB_PSLVERR;
    assign ICN_SS_PSLVERR[0] = ICN_SS_APB0_to_Student_SS_0_APB_PSLVERR;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PWDATA = ICN_SS_PWDATA;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PWDATA = ICN_SS_PWDATA;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PWDATA = ICN_SS_PWDATA;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PWDATA = ICN_SS_PWDATA;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PWRITE = ICN_SS_PWRITE;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PWRITE = ICN_SS_PWRITE;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PWRITE = ICN_SS_PWRITE;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PWRITE = ICN_SS_PWRITE;
    assign ICN_SS_clk = SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk;
    assign ICN_SS_icn_ar_addr_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_ADDR;
    assign ICN_SS_icn_ar_prot_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_PROT;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_READY = ICN_SS_icn_ar_ready_out;
    assign ICN_SS_icn_ar_valid_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_VALID;
    assign ICN_SS_icn_aw_addr_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_ADDR;
    assign ICN_SS_icn_aw_prot_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_PROT;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_READY = ICN_SS_icn_aw_ready_out;
    assign ICN_SS_icn_aw_valid_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_VALID;
    assign ICN_SS_icn_b_ready_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_READY;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_RESP = ICN_SS_icn_b_resp_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_VALID = ICN_SS_icn_b_valid_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_DATA = ICN_SS_icn_r_data_out;
    assign ICN_SS_icn_r_ready_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_READY;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_RESP = ICN_SS_icn_r_resp_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_VALID = ICN_SS_icn_r_valid_out;
    assign ICN_SS_icn_w_data_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_DATA;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_READY = ICN_SS_icn_w_ready_out;
    assign ICN_SS_icn_w_strb_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_STRB;
    assign ICN_SS_icn_w_valid_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_VALID;
    assign ICN_SS_reset_int = SystemControl_SS_Reset_icn_to_ICN_SS_Reset_reset;
    assign ICN_SS_ss_ctrl_icn = SystemControl_SS_ICN_SS_Ctrl_to_ICN_SS_SS_Ctrl_clk_ctrl;
    // Student_SS_0 assignments:
    assign Student_SS_0_PADDR = ICN_SS_APB0_to_Student_SS_0_APB_PADDR;
    assign Student_SS_0_PENABLE = ICN_SS_APB0_to_Student_SS_0_APB_PENABLE;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PRDATA = Student_SS_0_PRDATA;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PREADY = Student_SS_0_PREADY;
    assign Student_SS_0_PSEL = ICN_SS_APB0_to_Student_SS_0_APB_PSEL;
    assign ICN_SS_APB0_to_Student_SS_0_APB_PSLVERR = Student_SS_0_PSELERR;
    assign Student_SS_0_PWDATA = ICN_SS_APB0_to_Student_SS_0_APB_PWDATA;
    assign Student_SS_0_PWRITE = ICN_SS_APB0_to_Student_SS_0_APB_PWRITE;
    assign Student_SS_0_clk = SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk;
    assign Student_SS_0_clk_ctrl = SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_clk_ctrl;
    assign SystemControl_SS_IRQ0_to_Student_SS_0_IRQ_irq = Student_SS_0_irq;
    assign Student_SS_0_irq_en = SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_irq_en;
    assign Student_SS_0_pmod_0_gpi = Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpi;
    assign Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpio_oe = Student_SS_0_pmod_0_gpio_oe;
    assign Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpo = Student_SS_0_pmod_0_gpo;
    assign Student_SS_0_pmod_1_gpi = SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpi;
    assign SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpio_oe = Student_SS_0_pmod_1_gpio_oe;
    assign SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpo = Student_SS_0_pmod_1_gpo;
    assign Student_SS_0_rst = SystemControl_SS_Reset_SS_0_to_Student_SS_0_Reset_reset;
    // Student_SS_1 assignments:
    assign Student_SS_1_PADDR = ICN_SS_APB1_to_Student_SS_1_APB_PADDR;
    assign Student_SS_1_PENABLE = ICN_SS_APB1_to_Student_SS_1_APB_PENABLE;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PRDATA = Student_SS_1_PRDATA;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PREADY = Student_SS_1_PREADY;
    assign Student_SS_1_PSEL = ICN_SS_APB1_to_Student_SS_1_APB_PSEL;
    assign ICN_SS_APB1_to_Student_SS_1_APB_PSLVERR = Student_SS_1_PSELERR;
    assign Student_SS_1_PWDATA = ICN_SS_APB1_to_Student_SS_1_APB_PWDATA;
    assign Student_SS_1_PWRITE = ICN_SS_APB1_to_Student_SS_1_APB_PWRITE;
    assign Student_SS_1_clk = SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk;
    assign SystemControl_SS_IRQ1_to_Student_SS_1_IRQ_irq = Student_SS_1_irq_1;
    assign Student_SS_1_irq_en_1 = SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_irq_en;
    assign Student_SS_1_pmod_0_gpi = Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpi;
    assign Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpio_oe = Student_SS_1_pmod_0_gpio_oe;
    assign Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpo = Student_SS_1_pmod_0_gpo;
    assign Student_SS_1_pmod_1_gpi = Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpi;
    assign Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpio_oe = Student_SS_1_pmod_1_gpio_oe;
    assign Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpo = Student_SS_1_pmod_1_gpo;
    assign Student_SS_1_reset_int = SystemControl_SS_Reset_SS_1_to_Student_SS_1_Reset_reset;
    assign Student_SS_1_ss_ctrl_1 = SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_clk_ctrl;
    // Student_SS_2 assignments:
    assign Student_SS_2_PADDR = ICN_SS_APB2_to_Student_SS_2_APB_PADDR;
    assign Student_SS_2_PENABLE = ICN_SS_APB2_to_Student_SS_2_APB_PENABLE;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PRDATA = Student_SS_2_PRDATA;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PREADY = Student_SS_2_PREADY;
    assign Student_SS_2_PSEL = ICN_SS_APB2_to_Student_SS_2_APB_PSEL;
    assign ICN_SS_APB2_to_Student_SS_2_APB_PSLVERR = Student_SS_2_PSELERR;
    assign Student_SS_2_PWDATA = ICN_SS_APB2_to_Student_SS_2_APB_PWDATA;
    assign Student_SS_2_PWRITE = ICN_SS_APB2_to_Student_SS_2_APB_PWRITE;
    assign Student_SS_2_clk = SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk;
    assign SystemControl_SS_IRQ2_to_Student_SS_2_IRQ_irq = Student_SS_2_irq_2;
    assign Student_SS_2_irq_en_2 = SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_irq_en;
    assign Student_SS_2_pmod_0_gpi = Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpi;
    assign Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpio_oe = Student_SS_2_pmod_0_gpio_oe;
    assign Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpo = Student_SS_2_pmod_0_gpo;
    assign Student_SS_2_pmod_1_gpi = SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpi;
    assign SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpio_oe = Student_SS_2_pmod_1_gpio_oe;
    assign SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpo = Student_SS_2_pmod_1_gpo;
    assign Student_SS_2_reset_int = SystemControl_SS_Reset_SS_2_to_Student_SS_2_Reset_reset;
    assign Student_SS_2_ss_ctrl_2 = SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_clk_ctrl;
    // Student_SS_3 assignments:
    assign Student_SS_3_PADDR = ICN_SS_APB3_to_Student_SS_3_APB_PADDR;
    assign Student_SS_3_PENABLE = ICN_SS_APB3_to_Student_SS_3_APB_PENABLE;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PRDATA = Student_SS_3_PRDATA;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PREADY = Student_SS_3_PREADY;
    assign Student_SS_3_PSEL = ICN_SS_APB3_to_Student_SS_3_APB_PSEL;
    assign ICN_SS_APB3_to_Student_SS_3_APB_PSLVERR = Student_SS_3_PSLVERR;
    assign Student_SS_3_PWDATA = ICN_SS_APB3_to_Student_SS_3_APB_PWDATA;
    assign Student_SS_3_PWRITE = ICN_SS_APB3_to_Student_SS_3_APB_PWRITE;
    assign Student_SS_3_clk_in = SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk;
    assign SystemControl_SS_IRQ3_to_Student_SS_3_IRQ_irq = Student_SS_3_irq_3;
    assign Student_SS_3_irq_en_3 = SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_irq_en;
    assign Student_SS_3_pmod_0_gpi = Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpi;
    assign Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpio_oe = Student_SS_3_pmod_0_gpio_oe;
    assign Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpo = Student_SS_3_pmod_0_gpo;
    assign Student_SS_3_pmod_1_gpi = Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpi;
    assign Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpio_oe = Student_SS_3_pmod_1_gpio_oe;
    assign Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpo = Student_SS_3_pmod_1_gpo;
    assign Student_SS_3_reset_int = SystemControl_SS_Reset_SS_3_to_Student_SS_3_Reset_reset;
    assign Student_SS_3_ss_ctrl_3 = SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_clk_ctrl;
    // SystemControl_SS assignments:
    assign SystemControl_SS_Clock_int_to_ICN_SS_Clock_clk = SystemControl_SS_clk;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_ADDR = SystemControl_SS_icn_ar_addr_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_PROT = SystemControl_SS_icn_ar_prot_out;
    assign SystemControl_SS_icn_ar_ready_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_READY;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AR_VALID = SystemControl_SS_icn_ar_valid_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_ADDR = SystemControl_SS_icn_aw_addr_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_PROT = SystemControl_SS_icn_aw_prot_out;
    assign SystemControl_SS_icn_aw_ready_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_READY;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_AW_VALID = SystemControl_SS_icn_aw_valid_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_READY = SystemControl_SS_icn_b_ready_out;
    assign SystemControl_SS_icn_b_resp_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_RESP;
    assign SystemControl_SS_icn_b_valid_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_B_VALID;
    assign SystemControl_SS_icn_r_data_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_DATA;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_READY = SystemControl_SS_icn_r_ready_out;
    assign SystemControl_SS_icn_r_resp_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_RESP;
    assign SystemControl_SS_icn_r_valid_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_R_VALID;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_DATA = SystemControl_SS_icn_w_data_out;
    assign SystemControl_SS_icn_w_ready_in = ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_READY;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_STRB = SystemControl_SS_icn_w_strb_out;
    assign ICN_SS_AXI4LITE_icn_to_SystemControl_SS_AXI4LITE_icn_W_VALID = SystemControl_SS_icn_w_valid_out;
    assign SystemControl_SS_irq_0 = SystemControl_SS_IRQ0_to_Student_SS_0_IRQ_irq;
    assign SystemControl_SS_irq_1 = SystemControl_SS_IRQ1_to_Student_SS_1_IRQ_irq;
    assign SystemControl_SS_irq_2 = SystemControl_SS_IRQ2_to_Student_SS_2_IRQ_irq;
    assign SystemControl_SS_irq_3 = SystemControl_SS_IRQ3_to_Student_SS_3_IRQ_irq;
    assign SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_irq_en = SystemControl_SS_irq_en_0;
    assign SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_irq_en = SystemControl_SS_irq_en_1;
    assign SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_irq_en = SystemControl_SS_irq_en_2;
    assign SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_irq_en = SystemControl_SS_irq_en_3;
    assign SystemControl_SS_Reset_icn_to_ICN_SS_Reset_reset = SystemControl_SS_reset_int;
    assign SystemControl_SS_Reset_SS_0_to_Student_SS_0_Reset_reset = SystemControl_SS_reset_ss_0;
    assign SystemControl_SS_Reset_SS_1_to_Student_SS_1_Reset_reset = SystemControl_SS_reset_ss_1;
    assign SystemControl_SS_Reset_SS_2_to_Student_SS_2_Reset_reset = SystemControl_SS_reset_ss_2;
    assign SystemControl_SS_Reset_SS_3_to_Student_SS_3_Reset_reset = SystemControl_SS_reset_ss_3;
    assign Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpi = SystemControl_SS_ss_0_pmo_0_gpi;
    assign SystemControl_SS_ss_0_pmo_0_gpio_oe = Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpio_oe;
    assign SystemControl_SS_ss_0_pmo_0_gpo = Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpo;
    assign SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpi = SystemControl_SS_ss_0_pmo_1_gpi;
    assign SystemControl_SS_ss_0_pmo_1_gpio_oe = SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpio_oe;
    assign SystemControl_SS_ss_0_pmo_1_gpo = SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpo;
    assign Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpi = SystemControl_SS_ss_1_pmod_0_gpi;
    assign SystemControl_SS_ss_1_pmod_0_gpio_oe = Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpio_oe;
    assign SystemControl_SS_ss_1_pmod_0_gpo = Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpo;
    assign Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpi = SystemControl_SS_ss_1_pmod_1_gpi;
    assign SystemControl_SS_ss_1_pmod_1_gpio_oe = Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpio_oe;
    assign SystemControl_SS_ss_1_pmod_1_gpo = Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpo;
    assign Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpi = SystemControl_SS_ss_2_pmod_0_gpi;
    assign SystemControl_SS_ss_2_pmod_0_gpio_oe = Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpio_oe;
    assign SystemControl_SS_ss_2_pmod_0_gpo = Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpo;
    assign SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpi = SystemControl_SS_ss_2_pmod_1_gpi;
    assign SystemControl_SS_ss_2_pmod_1_gpio_oe = SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpio_oe;
    assign SystemControl_SS_ss_2_pmod_1_gpo = SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpo;
    assign Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpi = SystemControl_SS_ss_3_pmod_0_gpi;
    assign SystemControl_SS_ss_3_pmod_0_gpio_oe = Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpio_oe;
    assign SystemControl_SS_ss_3_pmod_0_gpo = Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpo;
    assign Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpi = SystemControl_SS_ss_3_pmod_1_gpi;
    assign SystemControl_SS_ss_3_pmod_1_gpio_oe = Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpio_oe;
    assign SystemControl_SS_ss_3_pmod_1_gpo = Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpo;
    assign SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_0;
    assign SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_1;
    assign SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_2;
    assign SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_3;
    assign SystemControl_SS_ICN_SS_Ctrl_to_ICN_SS_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_icn;

    // IP-XACT VLNV: tuni.fi:interconnect:ICN_SS:1.0
    ICN_SS #(
        .APB_DW              (32),
        .APB_AW              (32),
        .SS_CTRL_W           (8))
    ICN_SS(
        // Interface: AXI4LITE_icn
        .icn_ar_addr_in      (ICN_SS_icn_ar_addr_in),
        .icn_ar_prot_in      (ICN_SS_icn_ar_prot_in),
        .icn_ar_valid_in     (ICN_SS_icn_ar_valid_in),
        .icn_aw_addr_in      (ICN_SS_icn_aw_addr_in),
        .icn_aw_prot_in      (ICN_SS_icn_aw_prot_in),
        .icn_aw_valid_in     (ICN_SS_icn_aw_valid_in),
        .icn_b_ready_in      (ICN_SS_icn_b_ready_in),
        .icn_r_ready_in      (ICN_SS_icn_r_ready_in),
        .icn_w_data_in       (ICN_SS_icn_w_data_in),
        .icn_w_strb_in       (ICN_SS_icn_w_strb_in),
        .icn_w_valid_in      (ICN_SS_icn_w_valid_in),
        .icn_ar_ready_out    (ICN_SS_icn_ar_ready_out),
        .icn_aw_ready_out    (ICN_SS_icn_aw_ready_out),
        .icn_b_resp_out      (ICN_SS_icn_b_resp_out),
        .icn_b_valid_out     (ICN_SS_icn_b_valid_out),
        .icn_r_data_out      (ICN_SS_icn_r_data_out),
        .icn_r_resp_out      (ICN_SS_icn_r_resp_out),
        .icn_r_valid_out     (ICN_SS_icn_r_valid_out),
        .icn_w_ready_out     (ICN_SS_icn_w_ready_out),
        // Interface: Clock
        .clk                 (ICN_SS_clk),
        // Interface: Reset
        .reset_int           (ICN_SS_reset_int),
        // Interface: SS_Ctrl
        .ss_ctrl_icn         (ICN_SS_ss_ctrl_icn),
        // There ports are contained in many interfaces
        .PRDATA              (ICN_SS_PRDATA),
        .PREADY              (ICN_SS_PREADY),
        .PSLVERR             (ICN_SS_PSLVERR),
        .PADDR               (ICN_SS_PADDR),
        .PENABLE             (ICN_SS_PENABLE),
        .PSEL                (ICN_SS_PSEL),
        .PWDATA              (ICN_SS_PWDATA),
        .PWRITE              (ICN_SS_PWRITE));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:Student_SS_0:1.0
    Student_SS_0_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    Student_SS_0(
        // Interface: APB
        .PADDR               (Student_SS_0_PADDR),
        .PENABLE             (Student_SS_0_PENABLE),
        .PSEL                (Student_SS_0_PSEL),
        .PWDATA              (Student_SS_0_PWDATA),
        .PWRITE              (Student_SS_0_PWRITE),
        .PRDATA              (Student_SS_0_PRDATA),
        .PREADY              (Student_SS_0_PREADY),
        .PSELERR             (Student_SS_0_PSELERR),
        // Interface: Clock
        .clk                 (Student_SS_0_clk),
        // Interface: IRQ
        .irq                 (Student_SS_0_irq),
        // Interface: Reset
        .rst                 (Student_SS_0_rst),
        // Interface: SS_Ctrl
        .clk_ctrl            (Student_SS_0_clk_ctrl),
        .irq_en              (Student_SS_0_irq_en),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (Student_SS_0_pmod_0_gpi),
        .pmod_0_gpio_oe      (Student_SS_0_pmod_0_gpio_oe),
        .pmod_0_gpo          (Student_SS_0_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (Student_SS_0_pmod_1_gpi),
        .pmod_1_gpio_oe      (Student_SS_0_pmod_1_gpio_oe),
        .pmod_1_gpo          (Student_SS_0_pmod_1_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:Student_SS_1:1.0
    Student_SS_1_0 #(
        .APB_AW              (32),
        .APB_DW              (32))
    Student_SS_1(
        // Interface: APB
        .PADDR               (Student_SS_1_PADDR),
        .PENABLE             (Student_SS_1_PENABLE),
        .PSEL                (Student_SS_1_PSEL),
        .PWDATA              (Student_SS_1_PWDATA),
        .PWRITE              (Student_SS_1_PWRITE),
        .PRDATA              (Student_SS_1_PRDATA),
        .PREADY              (Student_SS_1_PREADY),
        .PSELERR             (Student_SS_1_PSELERR),
        // Interface: Clock
        .clk                 (Student_SS_1_clk),
        // Interface: IRQ
        .irq_1               (Student_SS_1_irq_1),
        // Interface: Reset
        .reset_int           (Student_SS_1_reset_int),
        // Interface: SS_Ctrl
        .irq_en_1            (Student_SS_1_irq_en_1),
        .ss_ctrl_1           (Student_SS_1_ss_ctrl_1),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (Student_SS_1_pmod_0_gpi),
        .pmod_0_gpio_oe      (Student_SS_1_pmod_0_gpio_oe),
        .pmod_0_gpo          (Student_SS_1_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (Student_SS_1_pmod_1_gpi),
        .pmod_1_gpio_oe      (Student_SS_1_pmod_1_gpio_oe),
        .pmod_1_gpo          (Student_SS_1_pmod_1_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:Student_SS_2:1.0
    Student_SS_2_0 #(
        .APB_AW              (32),
        .APB_DW              (32))
    Student_SS_2(
        // Interface: APB
        .PADDR               (Student_SS_2_PADDR),
        .PENABLE             (Student_SS_2_PENABLE),
        .PSEL                (Student_SS_2_PSEL),
        .PWDATA              (Student_SS_2_PWDATA),
        .PWRITE              (Student_SS_2_PWRITE),
        .PRDATA              (Student_SS_2_PRDATA),
        .PREADY              (Student_SS_2_PREADY),
        .PSELERR             (Student_SS_2_PSELERR),
        // Interface: Clock
        .clk                 (Student_SS_2_clk),
        // Interface: IRQ
        .irq_2               (Student_SS_2_irq_2),
        // Interface: Reset
        .reset_int           (Student_SS_2_reset_int),
        // Interface: SS_Ctrl
        .irq_en_2            (Student_SS_2_irq_en_2),
        .ss_ctrl_2           (Student_SS_2_ss_ctrl_2),
        // Interface: analog_if
        .ana_core_in         (ana_core_in[1:0]),
        .ana_core_out        (ana_core_out[1:0]),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (Student_SS_2_pmod_0_gpi),
        .pmod_0_gpio_oe      (Student_SS_2_pmod_0_gpio_oe),
        .pmod_0_gpo          (Student_SS_2_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (Student_SS_2_pmod_1_gpi),
        .pmod_1_gpio_oe      (Student_SS_2_pmod_1_gpio_oe),
        .pmod_1_gpo          (Student_SS_2_pmod_1_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:Student_SS_3:1.0
    Student_SS_3_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    Student_SS_3(
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
        // Interface: SS_Ctrl
        .irq_en_3            (Student_SS_3_irq_en_3),
        .ss_ctrl_3           (Student_SS_3_ss_ctrl_3),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (Student_SS_3_pmod_0_gpi),
        .pmod_0_gpio_oe      (Student_SS_3_pmod_0_gpio_oe),
        .pmod_0_gpo          (Student_SS_3_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (Student_SS_3_pmod_1_gpi),
        .pmod_1_gpio_oe      (Student_SS_3_pmod_1_gpio_oe),
        .pmod_1_gpo          (Student_SS_3_pmod_1_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:SysCtrl_SS_wrapper:1.0
    SysCtrl_SS_wrapper_0 #(
        .AXI4LITE_AW         (32),
        .AXI4LITE_DW         (32),
        .SS_CTRL_W           (8),
        .NUM_GPIO            (8),
        .IOCELL_COUNT        (17),
        .IOCELL_CFGW         (5))
    SystemControl_SS(
        // Interface: AXI4LITE_icn
        .icn_ar_ready_in     (SystemControl_SS_icn_ar_ready_in),
        .icn_aw_ready_in     (SystemControl_SS_icn_aw_ready_in),
        .icn_b_resp_in       (SystemControl_SS_icn_b_resp_in),
        .icn_b_valid_in      (SystemControl_SS_icn_b_valid_in),
        .icn_r_data_in       (SystemControl_SS_icn_r_data_in),
        .icn_r_resp_in       (SystemControl_SS_icn_r_resp_in),
        .icn_r_valid_in      (SystemControl_SS_icn_r_valid_in),
        .icn_w_ready_in      (SystemControl_SS_icn_w_ready_in),
        .icn_ar_addr_out     (SystemControl_SS_icn_ar_addr_out),
        .icn_ar_prot_out     (SystemControl_SS_icn_ar_prot_out),
        .icn_ar_valid_out    (SystemControl_SS_icn_ar_valid_out),
        .icn_aw_addr_out     (SystemControl_SS_icn_aw_addr_out),
        .icn_aw_prot_out     (SystemControl_SS_icn_aw_prot_out),
        .icn_aw_valid_out    (SystemControl_SS_icn_aw_valid_out),
        .icn_b_ready_out     (SystemControl_SS_icn_b_ready_out),
        .icn_r_ready_out     (SystemControl_SS_icn_r_ready_out),
        .icn_w_data_out      (SystemControl_SS_icn_w_data_out),
        .icn_w_strb_out      (SystemControl_SS_icn_w_strb_out),
        .icn_w_valid_out     (SystemControl_SS_icn_w_valid_out),
        // Interface: Clock
        .clock               (clk_in),
        // Interface: Clock_int
        .clk                 (SystemControl_SS_clk),
        // Interface: GPIO
        .gpio                (gpio[7:0]),
        // Interface: ICN_SS_Ctrl
        .ss_ctrl_icn         (SystemControl_SS_ss_ctrl_icn),
        // Interface: IRQ0
        .irq_0               (SystemControl_SS_irq_0),
        // Interface: IRQ1
        .irq_1               (SystemControl_SS_irq_1),
        // Interface: IRQ2
        .irq_2               (SystemControl_SS_irq_2),
        // Interface: IRQ3
        .irq_3               (SystemControl_SS_irq_3),
        // Interface: JTAG
        .jtag_tck            (jtag_tck),
        .jtag_tdi            (jtag_tdi),
        .jtag_tdo            (jtag_tdo),
        .jtag_tms            (jtag_tms),
        .jtag_trst           (jtag_trst),
        // Interface: Reset
        .reset               (reset),
        // Interface: Reset_SS_0
        .reset_ss_0          (SystemControl_SS_reset_ss_0),
        // Interface: Reset_SS_1
        .reset_ss_1          (SystemControl_SS_reset_ss_1),
        // Interface: Reset_SS_2
        .reset_ss_2          (SystemControl_SS_reset_ss_2),
        // Interface: Reset_SS_3
        .reset_ss_3          (SystemControl_SS_reset_ss_3),
        // Interface: Reset_icn
        .reset_int           (SystemControl_SS_reset_int),
        // Interface: SPI
        .spi_csn             (spi_csn[1:0]),
        .spi_data            (spi_data[3:0]),
        .spi_sck             (spi_sck),
        // Interface: SS_0_Ctrl
        .irq_en_0            (SystemControl_SS_irq_en_0),
        .ss_ctrl_0           (SystemControl_SS_ss_ctrl_0),
        // Interface: SS_1_Ctrl
        .irq_en_1            (SystemControl_SS_irq_en_1),
        .ss_ctrl_1           (SystemControl_SS_ss_ctrl_1),
        // Interface: SS_2_Ctrl
        .irq_en_2            (SystemControl_SS_irq_en_2),
        .ss_ctrl_2           (SystemControl_SS_ss_ctrl_2),
        // Interface: SS_3_Ctrl
        .irq_en_3            (SystemControl_SS_irq_en_3),
        .ss_ctrl_3           (SystemControl_SS_ss_ctrl_3),
        // Interface: UART
        .uart_rx             (uart_rx),
        .uart_tx             (uart_tx),
        // Interface: ss_0_pmod_gpio_0
        .ss_0_pmo_0_gpio_oe  (SystemControl_SS_ss_0_pmo_0_gpio_oe),
        .ss_0_pmo_0_gpo      (SystemControl_SS_ss_0_pmo_0_gpo),
        .ss_0_pmo_0_gpi      (SystemControl_SS_ss_0_pmo_0_gpi),
        // Interface: ss_0_pmod_gpio_1
        .ss_0_pmo_1_gpio_oe  (SystemControl_SS_ss_0_pmo_1_gpio_oe),
        .ss_0_pmo_1_gpo      (SystemControl_SS_ss_0_pmo_1_gpo),
        .ss_0_pmo_1_gpi      (SystemControl_SS_ss_0_pmo_1_gpi),
        // Interface: ss_1_pmod_gpio_0
        .ss_1_pmod_0_gpio_oe (SystemControl_SS_ss_1_pmod_0_gpio_oe),
        .ss_1_pmod_0_gpo     (SystemControl_SS_ss_1_pmod_0_gpo),
        .ss_1_pmod_0_gpi     (SystemControl_SS_ss_1_pmod_0_gpi),
        // Interface: ss_1_pmod_gpio_1
        .ss_1_pmod_1_gpio_oe (SystemControl_SS_ss_1_pmod_1_gpio_oe),
        .ss_1_pmod_1_gpo     (SystemControl_SS_ss_1_pmod_1_gpo),
        .ss_1_pmod_1_gpi     (SystemControl_SS_ss_1_pmod_1_gpi),
        // Interface: ss_2_pmod_gpio_0
        .ss_2_pmod_0_gpio_oe (SystemControl_SS_ss_2_pmod_0_gpio_oe),
        .ss_2_pmod_0_gpo     (SystemControl_SS_ss_2_pmod_0_gpo),
        .ss_2_pmod_0_gpi     (SystemControl_SS_ss_2_pmod_0_gpi),
        // Interface: ss_2_pmod_gpio_1
        .ss_2_pmod_1_gpio_oe (SystemControl_SS_ss_2_pmod_1_gpio_oe),
        .ss_2_pmod_1_gpo     (SystemControl_SS_ss_2_pmod_1_gpo),
        .ss_2_pmod_1_gpi     (SystemControl_SS_ss_2_pmod_1_gpi),
        // Interface: ss_3_pmod_gpio_0
        .ss_3_pmod_0_gpio_oe (SystemControl_SS_ss_3_pmod_0_gpio_oe),
        .ss_3_pmod_0_gpo     (SystemControl_SS_ss_3_pmod_0_gpo),
        .ss_3_pmod_0_gpi     (SystemControl_SS_ss_3_pmod_0_gpi),
        // Interface: ss_3_pmod_gpio_1
        .ss_3_pmod_1_gpio_oe (SystemControl_SS_ss_3_pmod_1_gpio_oe),
        .ss_3_pmod_1_gpo     (SystemControl_SS_ss_3_pmod_1_gpo),
        .ss_3_pmod_1_gpi     (SystemControl_SS_ss_3_pmod_1_gpi));


endmodule
