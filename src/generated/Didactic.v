//-----------------------------------------------------------------------------
// File          : Didactic.v
// Creation date : 25.03.2025
// Creation time : 13:44:27
// Description   : Edu4Chip top level example SoC.
//                 
//                 Spec: 
//                 * RiscV core
//                 * 28 signal IO
//                 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:soc:Didactic:1.1
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/soc/Didactic/1.1/Didactic.1.1.xml
//-----------------------------------------------------------------------------

module Didactic #(
    parameter                              AW               = 32,    // Global SoC address width
    parameter                              DW               = 32,    // Global SoC data width
    parameter                              SS_CTRL_W        = 5,    // SoC SS control width
    parameter                              NUM_GPIO         = 4,    // SoC GPIO Cell count. Default 2x pmod = 8.
    parameter                              IOCELL_CFG_W     = 4,    // Tech cell control width.
    parameter                              IOCELL_COUNT     = 15    // number of configurable io cells in design. Total 24? + analog + power.
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
    inout  wire          [1:0]          ana_core_out,

    // Interface: high_speed_clock
    inout  wire                         high_speed_clk_n_in,
    inout  wire                         high_speed_clk_p_in
);

    // SystemControl_SS_UART_to_UART wires:
    // SystemControl_SS_SPI_to_SPI wires:
    // SystemControl_SS_GPIO_to_GPIO wires:
    // SystemControl_SS_Reset_to_Reset wires:
    // SystemControl_SS_Clock_to_Clock wires:
    // SystemControl_SS_Clock_int_to_Student_SS_0_Clock wires:
    wire       SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk;
    // SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_irq_en;
    // SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_irq_en;
    // SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_irq_en;
    // SystemControl_SS_JTAG_to_JTAG wires:
    // SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_irq_en;
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
    // SystemControl_SS_high_speed_clock_to_high_speed_clock wires:
    // SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in
    // wires:
    wire       SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in_clk;
    // obi_icn_ss_0_apb_0_to_Student_SS_0_APB wires:
    wire [31:0] obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PADDR;
    wire       obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PENABLE;
    wire [31:0] obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PRDATA;
    wire       obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PREADY;
    wire       obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSEL;
    wire       obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSLVERR;
    wire [3:0] obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSTRB;
    wire [31:0] obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PWDATA;
    wire       obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PWRITE;
    // obi_icn_ss_0_apb_1_to_Student_SS_1_APB wires:
    wire [31:0] obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PADDR;
    wire       obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PENABLE;
    wire [31:0] obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PRDATA;
    wire       obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PREADY;
    wire       obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSEL;
    wire       obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSLVERR;
    wire [3:0] obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSTRB;
    wire [31:0] obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PWDATA;
    wire       obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PWRITE;
    // obi_icn_ss_0_apb_2_to_Student_SS_2_APB wires:
    wire [31:0] obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PADDR;
    wire       obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PENABLE;
    wire [31:0] obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PRDATA;
    wire       obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PREADY;
    wire       obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSEL;
    wire       obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSLVERR;
    wire [3:0] obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSTRB;
    wire [31:0] obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PWDATA;
    wire       obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PWRITE;
    // obi_icn_ss_0_apb_3_to_Student_SS_3_APB wires:
    wire [31:0] obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PADDR;
    wire       obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PENABLE;
    wire [31:0] obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PRDATA;
    wire       obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PREADY;
    wire       obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSEL;
    wire       obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSLVERR;
    wire [3:0] obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSTRB;
    wire [31:0] obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PWDATA;
    wire       obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PWRITE;
    // SystemControl_SS_OBI_to_obi_icn_ss_0_OBI wires:
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_achk;
    wire [31:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_addr;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_aid;
    wire [5:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_atop;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_auser;
    wire [3:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_be;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_dbg;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_err;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_exokay;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_gnt;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_gntpar;
    wire [1:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_memtype;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_mid;
    wire [2:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_prot;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rchk;
    wire [31:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rdata;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_req;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_reqpar;
    wire [1:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rid;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rready;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rreadypar;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_ruser;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rvalid;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rvalidpar;
    wire [31:0] SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_wdata;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_we;
    wire       SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_wuser;
    // obi_icn_ss_0_reset_to_SystemControl_SS_Reset_icn wires:
    wire       obi_icn_ss_0_reset_to_SystemControl_SS_Reset_icn_reset;
    // SystemControl_SS_ICN_SS_Ctrl_to_obi_icn_ss_0_icn_ss_ctrl wires:
    wire [4:0] SystemControl_SS_ICN_SS_Ctrl_to_obi_icn_ss_0_icn_ss_ctrl_clk_ctrl;
    // student_ss_analog_analog_bus_to_analog_if wires:

    // Ad-hoc wires:
    wire       Student_SS_0_rst_to_SystemControl_SS_reset_ss;
    wire       Student_SS_1_reset_int_to_SystemControl_SS_reset_ss;
    wire       Student_SS_2_reset_int_to_SystemControl_SS_reset_ss;
    wire       Student_SS_3_reset_int_to_SystemControl_SS_reset_ss;
    wire       Student_SS_0_irq_to_SystemControl_SS_irq_i;
    wire       Student_SS_1_irq_1_to_SystemControl_SS_irq_i;
    wire       Student_SS_2_irq_2_to_SystemControl_SS_irq_i;
    wire       Student_SS_3_irq_3_to_SystemControl_SS_irq_i;

    // Student_SS_0 port wires:
    wire [31:0] Student_SS_0_PADDR;
    wire       Student_SS_0_PENABLE;
    wire [31:0] Student_SS_0_PRDATA;
    wire       Student_SS_0_PREADY;
    wire       Student_SS_0_PSEL;
    wire       Student_SS_0_PSLVERR;
    wire [3:0] Student_SS_0_PSTRB;
    wire [31:0] Student_SS_0_PWDATA;
    wire       Student_SS_0_PWRITE;
    wire       Student_SS_0_clk;
    wire [7:0] Student_SS_0_clk_ctrl;
    wire       Student_SS_0_high_speed_clk;
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
    wire       Student_SS_1_PSLVERR;
    wire [3:0] Student_SS_1_PSTRB;
    wire [31:0] Student_SS_1_PWDATA;
    wire       Student_SS_1_PWRITE;
    wire       Student_SS_1_clk_in;
    wire       Student_SS_1_high_speed_clk;
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
    wire       Student_SS_2_PSLVERR;
    wire [3:0] Student_SS_2_PSTRB;
    wire [31:0] Student_SS_2_PWDATA;
    wire       Student_SS_2_PWRITE;
    wire       Student_SS_2_clk;
    wire       Student_SS_2_high_speed_clk;
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
    wire [3:0] Student_SS_3_PSTRB;
    wire [31:0] Student_SS_3_PWDATA;
    wire       Student_SS_3_PWRITE;
    wire       Student_SS_3_clk_in;
    wire       Student_SS_3_high_speed_clk;
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
    wire       SystemControl_SS_high_speed_clk_internal;
    wire       SystemControl_SS_irq_en_0;
    wire       SystemControl_SS_irq_en_1;
    wire       SystemControl_SS_irq_en_2;
    wire       SystemControl_SS_irq_en_3;
    wire [3:0] SystemControl_SS_irq_i;
    wire       SystemControl_SS_obi_achk;
    wire [31:0] SystemControl_SS_obi_addr;
    wire       SystemControl_SS_obi_aid;
    wire [5:0] SystemControl_SS_obi_atop;
    wire       SystemControl_SS_obi_auser;
    wire [3:0] SystemControl_SS_obi_be;
    wire       SystemControl_SS_obi_dbg;
    wire       SystemControl_SS_obi_err;
    wire       SystemControl_SS_obi_exokay;
    wire       SystemControl_SS_obi_gnt;
    wire       SystemControl_SS_obi_gntpar;
    wire [1:0] SystemControl_SS_obi_memtype;
    wire       SystemControl_SS_obi_mid;
    wire [2:0] SystemControl_SS_obi_prot;
    wire       SystemControl_SS_obi_rchk;
    wire [31:0] SystemControl_SS_obi_rdata;
    wire       SystemControl_SS_obi_req;
    wire       SystemControl_SS_obi_reqpar;
    wire [1:0] SystemControl_SS_obi_rid;
    wire       SystemControl_SS_obi_rready;
    wire       SystemControl_SS_obi_rreadypar;
    wire       SystemControl_SS_obi_ruser;
    wire       SystemControl_SS_obi_rvalid;
    wire       SystemControl_SS_obi_rvalidpar;
    wire [31:0] SystemControl_SS_obi_wdata;
    wire       SystemControl_SS_obi_we;
    wire       SystemControl_SS_obi_wuser;
    wire       SystemControl_SS_reset_int;
    wire [3:0] SystemControl_SS_reset_ss;
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
    wire [4:0] SystemControl_SS_ss_ctrl_0;
    wire [4:0] SystemControl_SS_ss_ctrl_1;
    wire [4:0] SystemControl_SS_ss_ctrl_2;
    wire [4:0] SystemControl_SS_ss_ctrl_3;
    wire [4:0] SystemControl_SS_ss_ctrl_icn;
    // obi_icn_ss_0 port wires:
    wire [31:0] obi_icn_ss_0_APB_0_PADDR;
    wire       obi_icn_ss_0_APB_0_PENABLE;
    wire [31:0] obi_icn_ss_0_APB_0_PRDATA;
    wire       obi_icn_ss_0_APB_0_PREADY;
    wire       obi_icn_ss_0_APB_0_PSEL;
    wire       obi_icn_ss_0_APB_0_PSLVERR;
    wire [3:0] obi_icn_ss_0_APB_0_PSTRB;
    wire [31:0] obi_icn_ss_0_APB_0_PWDATA;
    wire       obi_icn_ss_0_APB_0_PWRITE;
    wire [31:0] obi_icn_ss_0_APB_1_PADDR;
    wire       obi_icn_ss_0_APB_1_PENABLE;
    wire [31:0] obi_icn_ss_0_APB_1_PRDATA;
    wire       obi_icn_ss_0_APB_1_PREADY;
    wire       obi_icn_ss_0_APB_1_PSEL;
    wire       obi_icn_ss_0_APB_1_PSLVERR;
    wire [3:0] obi_icn_ss_0_APB_1_PSTRB;
    wire [31:0] obi_icn_ss_0_APB_1_PWDATA;
    wire       obi_icn_ss_0_APB_1_PWRITE;
    wire [31:0] obi_icn_ss_0_APB_2_PADDR;
    wire       obi_icn_ss_0_APB_2_PENABLE;
    wire [31:0] obi_icn_ss_0_APB_2_PRDATA;
    wire       obi_icn_ss_0_APB_2_PREADY;
    wire       obi_icn_ss_0_APB_2_PSEL;
    wire       obi_icn_ss_0_APB_2_PSLVERR;
    wire [3:0] obi_icn_ss_0_APB_2_PSTRB;
    wire [31:0] obi_icn_ss_0_APB_2_PWDATA;
    wire       obi_icn_ss_0_APB_2_PWRITE;
    wire [31:0] obi_icn_ss_0_APB_3_PADDR;
    wire       obi_icn_ss_0_APB_3_PENABLE;
    wire [31:0] obi_icn_ss_0_APB_3_PRDATA;
    wire       obi_icn_ss_0_APB_3_PREADY;
    wire       obi_icn_ss_0_APB_3_PSEL;
    wire       obi_icn_ss_0_APB_3_PSLVERR;
    wire [3:0] obi_icn_ss_0_APB_3_PSTRB;
    wire [31:0] obi_icn_ss_0_APB_3_PWDATA;
    wire       obi_icn_ss_0_APB_3_PWRITE;
    wire       obi_icn_ss_0_clk;
    wire       obi_icn_ss_0_obi_achk;
    wire [31:0] obi_icn_ss_0_obi_addr;
    wire       obi_icn_ss_0_obi_aid;
    wire [5:0] obi_icn_ss_0_obi_atop;
    wire       obi_icn_ss_0_obi_auser;
    wire [3:0] obi_icn_ss_0_obi_be;
    wire       obi_icn_ss_0_obi_dbg;
    wire       obi_icn_ss_0_obi_err;
    wire       obi_icn_ss_0_obi_exokay;
    wire       obi_icn_ss_0_obi_gnt;
    wire       obi_icn_ss_0_obi_gntpar;
    wire [1:0] obi_icn_ss_0_obi_memtype;
    wire       obi_icn_ss_0_obi_mid;
    wire [2:0] obi_icn_ss_0_obi_prot;
    wire       obi_icn_ss_0_obi_rchk;
    wire [31:0] obi_icn_ss_0_obi_rdata;
    wire       obi_icn_ss_0_obi_req;
    wire       obi_icn_ss_0_obi_reqpar;
    wire       obi_icn_ss_0_obi_rid;
    wire       obi_icn_ss_0_obi_rready;
    wire       obi_icn_ss_0_obi_rreadypar;
    wire       obi_icn_ss_0_obi_ruser;
    wire       obi_icn_ss_0_obi_rvalid;
    wire       obi_icn_ss_0_obi_rvalidpar;
    wire [31:0] obi_icn_ss_0_obi_wdata;
    wire       obi_icn_ss_0_obi_we;
    wire       obi_icn_ss_0_obi_wuser;
    wire       obi_icn_ss_0_reset_n;
    wire [4:0] obi_icn_ss_0_ss_ctrl_icn;
    // student_ss_analog port wires:

    // Assignments for the ports of the encompassing component:

    // Student_SS_0 assignments:
    assign Student_SS_0_PADDR = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PADDR;
    assign Student_SS_0_PENABLE = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PENABLE;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PRDATA = Student_SS_0_PRDATA;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PREADY = Student_SS_0_PREADY;
    assign Student_SS_0_PSEL = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSEL;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSLVERR = Student_SS_0_PSLVERR;
    assign Student_SS_0_PSTRB = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSTRB;
    assign Student_SS_0_PWDATA = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PWDATA;
    assign Student_SS_0_PWRITE = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PWRITE;
    assign Student_SS_0_clk = SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk;
    assign Student_SS_0_clk_ctrl = SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_clk_ctrl;
    assign Student_SS_0_high_speed_clk = SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in_clk;
    assign Student_SS_0_irq_to_SystemControl_SS_irq_i = Student_SS_0_irq;
    assign Student_SS_0_irq_en = SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_irq_en;
    assign Student_SS_0_pmod_0_gpi = Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpi;
    assign Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpio_oe = Student_SS_0_pmod_0_gpio_oe;
    assign Student_SS_0_pmod_gpio_0_to_SystemControl_SS_ss_0_pmod_gpio_0_gpo = Student_SS_0_pmod_0_gpo;
    assign Student_SS_0_pmod_1_gpi = SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpi;
    assign SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpio_oe = Student_SS_0_pmod_1_gpio_oe;
    assign SystemControl_SS_ss_0_pmod_gpio_1_to_Student_SS_0_pmod_gpio_1_gpo = Student_SS_0_pmod_1_gpo;
    assign Student_SS_0_rst = Student_SS_0_rst_to_SystemControl_SS_reset_ss;
    // Student_SS_1 assignments:
    assign Student_SS_1_PADDR = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PADDR;
    assign Student_SS_1_PENABLE = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PENABLE;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PRDATA = Student_SS_1_PRDATA;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PREADY = Student_SS_1_PREADY;
    assign Student_SS_1_PSEL = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSEL;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSLVERR = Student_SS_1_PSLVERR;
    assign Student_SS_1_PSTRB = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSTRB;
    assign Student_SS_1_PWDATA = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PWDATA;
    assign Student_SS_1_PWRITE = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PWRITE;
    assign Student_SS_1_clk_in = SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk;
    assign Student_SS_1_high_speed_clk = SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in_clk;
    assign Student_SS_1_irq_1_to_SystemControl_SS_irq_i = Student_SS_1_irq_1;
    assign Student_SS_1_irq_en_1 = SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_irq_en;
    assign Student_SS_1_pmod_0_gpi = Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpi;
    assign Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpio_oe = Student_SS_1_pmod_0_gpio_oe;
    assign Student_SS_1_pmod_gpio_0_to_SystemControl_SS_ss_1_pmod_gpio_0_gpo = Student_SS_1_pmod_0_gpo;
    assign Student_SS_1_pmod_1_gpi = Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpi;
    assign Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpio_oe = Student_SS_1_pmod_1_gpio_oe;
    assign Student_SS_1_pmod_gpio_1_to_SystemControl_SS_ss_1_pmod_gpio_1_gpo = Student_SS_1_pmod_1_gpo;
    assign Student_SS_1_reset_int = Student_SS_1_reset_int_to_SystemControl_SS_reset_ss;
    assign Student_SS_1_ss_ctrl_1 = SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_clk_ctrl;
    // Student_SS_2 assignments:
    assign Student_SS_2_PADDR = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PADDR;
    assign Student_SS_2_PENABLE = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PENABLE;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PRDATA = Student_SS_2_PRDATA;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PREADY = Student_SS_2_PREADY;
    assign Student_SS_2_PSEL = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSEL;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSLVERR = Student_SS_2_PSLVERR;
    assign Student_SS_2_PSTRB = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSTRB;
    assign Student_SS_2_PWDATA = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PWDATA;
    assign Student_SS_2_PWRITE = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PWRITE;
    assign Student_SS_2_clk = SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk;
    assign Student_SS_2_high_speed_clk = SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in_clk;
    assign Student_SS_2_irq_2_to_SystemControl_SS_irq_i = Student_SS_2_irq_2;
    assign Student_SS_2_irq_en_2 = SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_irq_en;
    assign Student_SS_2_pmod_0_gpi = Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpi;
    assign Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpio_oe = Student_SS_2_pmod_0_gpio_oe;
    assign Student_SS_2_pmod_gpio_0_to_SystemControl_SS_ss_2_pmod_gpio_0_gpo = Student_SS_2_pmod_0_gpo;
    assign Student_SS_2_pmod_1_gpi = SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpi;
    assign SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpio_oe = Student_SS_2_pmod_1_gpio_oe;
    assign SystemControl_SS_ss_2_pmod_gpio_1_to_Student_SS_2_pmod_gpio_1_gpo = Student_SS_2_pmod_1_gpo;
    assign Student_SS_2_reset_int = Student_SS_2_reset_int_to_SystemControl_SS_reset_ss;
    assign Student_SS_2_ss_ctrl_2 = SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_clk_ctrl;
    // Student_SS_3 assignments:
    assign Student_SS_3_PADDR = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PADDR;
    assign Student_SS_3_PENABLE = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PENABLE;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PRDATA = Student_SS_3_PRDATA;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PREADY = Student_SS_3_PREADY;
    assign Student_SS_3_PSEL = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSEL;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSLVERR = Student_SS_3_PSLVERR;
    assign Student_SS_3_PSTRB = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSTRB;
    assign Student_SS_3_PWDATA = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PWDATA;
    assign Student_SS_3_PWRITE = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PWRITE;
    assign Student_SS_3_clk_in = SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk;
    assign Student_SS_3_high_speed_clk = SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in_clk;
    assign Student_SS_3_irq_3_to_SystemControl_SS_irq_i = Student_SS_3_irq_3;
    assign Student_SS_3_irq_en_3 = SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_irq_en;
    assign Student_SS_3_pmod_0_gpi = Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpi;
    assign Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpio_oe = Student_SS_3_pmod_0_gpio_oe;
    assign Student_SS_3_pmod_gpio_0_to_SystemControl_SS_ss_3_pmod_gpio_0_gpo = Student_SS_3_pmod_0_gpo;
    assign Student_SS_3_pmod_1_gpi = Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpi;
    assign Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpio_oe = Student_SS_3_pmod_1_gpio_oe;
    assign Student_SS_3_pmod_gpio_1_to_SystemControl_SS_ss_3_pmod_gpio_1_gpo = Student_SS_3_pmod_1_gpo;
    assign Student_SS_3_reset_int = Student_SS_3_reset_int_to_SystemControl_SS_reset_ss;
    assign Student_SS_3_ss_ctrl_3 = SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_clk_ctrl;
    // SystemControl_SS assignments:
    assign SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk = SystemControl_SS_clk;
    assign SystemControl_SS_high_speed_clock_internal_to_Student_SS_0_high_speed_clk_in_clk = SystemControl_SS_high_speed_clk_internal;
    assign SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_irq_en = SystemControl_SS_irq_en_0;
    assign SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_irq_en = SystemControl_SS_irq_en_1;
    assign SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_irq_en = SystemControl_SS_irq_en_2;
    assign SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_irq_en = SystemControl_SS_irq_en_3;
    assign SystemControl_SS_irq_i[0] = Student_SS_0_irq_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[1] = Student_SS_1_irq_1_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[2] = Student_SS_2_irq_2_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[3] = Student_SS_3_irq_3_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_achk = SystemControl_SS_obi_achk;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_addr = SystemControl_SS_obi_addr;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_aid = SystemControl_SS_obi_aid;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_atop = SystemControl_SS_obi_atop;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_auser = SystemControl_SS_obi_auser;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_be = SystemControl_SS_obi_be;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_dbg = SystemControl_SS_obi_dbg;
    assign SystemControl_SS_obi_err = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_err;
    assign SystemControl_SS_obi_exokay = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_exokay;
    assign SystemControl_SS_obi_gnt = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_gnt;
    assign SystemControl_SS_obi_gntpar = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_gntpar;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_memtype = SystemControl_SS_obi_memtype;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_mid = SystemControl_SS_obi_mid;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_prot = SystemControl_SS_obi_prot;
    assign SystemControl_SS_obi_rchk = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rchk;
    assign SystemControl_SS_obi_rdata = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rdata;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_req = SystemControl_SS_obi_req;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_reqpar = SystemControl_SS_obi_reqpar;
    assign SystemControl_SS_obi_rid = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rid;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rready = SystemControl_SS_obi_rready;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rreadypar = SystemControl_SS_obi_rreadypar;
    assign SystemControl_SS_obi_ruser = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_ruser;
    assign SystemControl_SS_obi_rvalid = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rvalid;
    assign SystemControl_SS_obi_rvalidpar = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rvalidpar;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_wdata = SystemControl_SS_obi_wdata;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_we = SystemControl_SS_obi_we;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_wuser = SystemControl_SS_obi_wuser;
    assign obi_icn_ss_0_reset_to_SystemControl_SS_Reset_icn_reset = SystemControl_SS_reset_int;
    assign Student_SS_0_rst_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[0];
    assign Student_SS_1_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[1];
    assign Student_SS_2_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[2];
    assign Student_SS_3_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[3];
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
    assign SystemControl_SS_SS_0_Ctrl_to_Student_SS_0_SS_Ctrl_clk_ctrl[4:0] = SystemControl_SS_ss_ctrl_0;
    assign SystemControl_SS_SS_1_Ctrl_to_Student_SS_1_SS_Ctrl_clk_ctrl[4:0] = SystemControl_SS_ss_ctrl_1;
    assign SystemControl_SS_SS_2_Ctrl_to_Student_SS_2_SS_Ctrl_clk_ctrl[4:0] = SystemControl_SS_ss_ctrl_2;
    assign SystemControl_SS_SS_3_Ctrl_to_Student_SS_3_SS_Ctrl_clk_ctrl[4:0] = SystemControl_SS_ss_ctrl_3;
    assign SystemControl_SS_ICN_SS_Ctrl_to_obi_icn_ss_0_icn_ss_ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_icn;
    // obi_icn_ss_0 assignments:
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PADDR = obi_icn_ss_0_APB_0_PADDR;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PENABLE = obi_icn_ss_0_APB_0_PENABLE;
    assign obi_icn_ss_0_APB_0_PRDATA = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PRDATA;
    assign obi_icn_ss_0_APB_0_PREADY = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PREADY;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSEL = obi_icn_ss_0_APB_0_PSEL;
    assign obi_icn_ss_0_APB_0_PSLVERR = obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSLVERR;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PSTRB = obi_icn_ss_0_APB_0_PSTRB;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PWDATA = obi_icn_ss_0_APB_0_PWDATA;
    assign obi_icn_ss_0_apb_0_to_Student_SS_0_APB_PWRITE = obi_icn_ss_0_APB_0_PWRITE;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PADDR = obi_icn_ss_0_APB_1_PADDR;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PENABLE = obi_icn_ss_0_APB_1_PENABLE;
    assign obi_icn_ss_0_APB_1_PRDATA = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PRDATA;
    assign obi_icn_ss_0_APB_1_PREADY = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PREADY;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSEL = obi_icn_ss_0_APB_1_PSEL;
    assign obi_icn_ss_0_APB_1_PSLVERR = obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSLVERR;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PSTRB = obi_icn_ss_0_APB_1_PSTRB;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PWDATA = obi_icn_ss_0_APB_1_PWDATA;
    assign obi_icn_ss_0_apb_1_to_Student_SS_1_APB_PWRITE = obi_icn_ss_0_APB_1_PWRITE;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PADDR = obi_icn_ss_0_APB_2_PADDR;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PENABLE = obi_icn_ss_0_APB_2_PENABLE;
    assign obi_icn_ss_0_APB_2_PRDATA = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PRDATA;
    assign obi_icn_ss_0_APB_2_PREADY = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PREADY;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSEL = obi_icn_ss_0_APB_2_PSEL;
    assign obi_icn_ss_0_APB_2_PSLVERR = obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSLVERR;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PSTRB = obi_icn_ss_0_APB_2_PSTRB;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PWDATA = obi_icn_ss_0_APB_2_PWDATA;
    assign obi_icn_ss_0_apb_2_to_Student_SS_2_APB_PWRITE = obi_icn_ss_0_APB_2_PWRITE;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PADDR = obi_icn_ss_0_APB_3_PADDR;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PENABLE = obi_icn_ss_0_APB_3_PENABLE;
    assign obi_icn_ss_0_APB_3_PRDATA = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PRDATA;
    assign obi_icn_ss_0_APB_3_PREADY = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PREADY;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSEL = obi_icn_ss_0_APB_3_PSEL;
    assign obi_icn_ss_0_APB_3_PSLVERR = obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSLVERR;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PSTRB = obi_icn_ss_0_APB_3_PSTRB;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PWDATA = obi_icn_ss_0_APB_3_PWDATA;
    assign obi_icn_ss_0_apb_3_to_Student_SS_3_APB_PWRITE = obi_icn_ss_0_APB_3_PWRITE;
    assign obi_icn_ss_0_clk = SystemControl_SS_Clock_int_to_Student_SS_0_Clock_clk;
    assign obi_icn_ss_0_obi_achk = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_achk;
    assign obi_icn_ss_0_obi_addr = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_addr;
    assign obi_icn_ss_0_obi_aid = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_aid;
    assign obi_icn_ss_0_obi_atop = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_atop;
    assign obi_icn_ss_0_obi_auser = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_auser;
    assign obi_icn_ss_0_obi_be = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_be;
    assign obi_icn_ss_0_obi_dbg = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_dbg;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_err = obi_icn_ss_0_obi_err;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_exokay = obi_icn_ss_0_obi_exokay;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_gnt = obi_icn_ss_0_obi_gnt;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_gntpar = obi_icn_ss_0_obi_gntpar;
    assign obi_icn_ss_0_obi_memtype = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_memtype;
    assign obi_icn_ss_0_obi_mid = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_mid;
    assign obi_icn_ss_0_obi_prot = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_prot;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rchk = obi_icn_ss_0_obi_rchk;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rdata = obi_icn_ss_0_obi_rdata;
    assign obi_icn_ss_0_obi_req = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_req;
    assign obi_icn_ss_0_obi_reqpar = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_reqpar;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rid[0] = obi_icn_ss_0_obi_rid;
    assign obi_icn_ss_0_obi_rready = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rready;
    assign obi_icn_ss_0_obi_rreadypar = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rreadypar;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_ruser = obi_icn_ss_0_obi_ruser;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rvalid = obi_icn_ss_0_obi_rvalid;
    assign SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_rvalidpar = obi_icn_ss_0_obi_rvalidpar;
    assign obi_icn_ss_0_obi_wdata = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_wdata;
    assign obi_icn_ss_0_obi_we = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_we;
    assign obi_icn_ss_0_obi_wuser = SystemControl_SS_OBI_to_obi_icn_ss_0_OBI_wuser;
    assign obi_icn_ss_0_reset_n = obi_icn_ss_0_reset_to_SystemControl_SS_Reset_icn_reset;
    assign obi_icn_ss_0_ss_ctrl_icn = SystemControl_SS_ICN_SS_Ctrl_to_obi_icn_ss_0_icn_ss_ctrl_clk_ctrl;
    // student_ss_analog assignments:

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:Student_SS_0:1.0
    Student_SS_0_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    Student_SS_0(
        // Interface: APB
        .PADDR               (Student_SS_0_PADDR),
        .PENABLE             (Student_SS_0_PENABLE),
        .PSEL                (Student_SS_0_PSEL),
        .PSTRB               (Student_SS_0_PSTRB),
        .PWDATA              (Student_SS_0_PWDATA),
        .PWRITE              (Student_SS_0_PWRITE),
        .PRDATA              (Student_SS_0_PRDATA),
        .PREADY              (Student_SS_0_PREADY),
        .PSLVERR             (Student_SS_0_PSLVERR),
        // Interface: Clock
        .clk                 (Student_SS_0_clk),
        // Interface: IRQ
        .irq                 (Student_SS_0_irq),
        // Interface: Reset
        .rst                 (Student_SS_0_rst),
        // Interface: SS_Ctrl
        .clk_ctrl            (Student_SS_0_clk_ctrl),
        .irq_en              (Student_SS_0_irq_en),
        // Interface: high_speed_clk_in
        .high_speed_clk      (Student_SS_0_high_speed_clk),
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
        .PSTRB               (Student_SS_1_PSTRB),
        .PWDATA              (Student_SS_1_PWDATA),
        .PWRITE              (Student_SS_1_PWRITE),
        .PRDATA              (Student_SS_1_PRDATA),
        .PREADY              (Student_SS_1_PREADY),
        .PSLVERR             (Student_SS_1_PSLVERR),
        // Interface: Clock
        .clk_in              (Student_SS_1_clk_in),
        // Interface: IRQ
        .irq_1               (Student_SS_1_irq_1),
        // Interface: Reset
        .reset_int           (Student_SS_1_reset_int),
        // Interface: SS_Ctrl
        .irq_en_1            (Student_SS_1_irq_en_1),
        .ss_ctrl_1           (Student_SS_1_ss_ctrl_1),
        // Interface: high_speed_clk
        .high_speed_clk      (Student_SS_1_high_speed_clk),
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
        .PSTRB               (Student_SS_2_PSTRB),
        .PWDATA              (Student_SS_2_PWDATA),
        .PWRITE              (Student_SS_2_PWRITE),
        .PRDATA              (Student_SS_2_PRDATA),
        .PREADY              (Student_SS_2_PREADY),
        .PSLVERR             (Student_SS_2_PSLVERR),
        // Interface: Clock
        .clk                 (Student_SS_2_clk),
        // Interface: IRQ
        .irq_2               (Student_SS_2_irq_2),
        // Interface: Reset
        .reset_int           (Student_SS_2_reset_int),
        // Interface: SS_Ctrl
        .irq_en_2            (Student_SS_2_irq_en_2),
        .ss_ctrl_2           (Student_SS_2_ss_ctrl_2),
        // Interface: high_speed_clk
        .high_speed_clk      (Student_SS_2_high_speed_clk),
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
        .PSTRB               (Student_SS_3_PSTRB),
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
        // Interface: high_speed_clk
        .high_speed_clk      (Student_SS_3_high_speed_clk),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (Student_SS_3_pmod_0_gpi),
        .pmod_0_gpio_oe      (Student_SS_3_pmod_0_gpio_oe),
        .pmod_0_gpo          (Student_SS_3_pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (Student_SS_3_pmod_1_gpi),
        .pmod_1_gpio_oe      (Student_SS_3_pmod_1_gpio_oe),
        .pmod_1_gpo          (Student_SS_3_pmod_1_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:SysCtrl_SS_wrapper:1.1
    SysCtrl_SS_wrapper_0 #(
        .AXI4LITE_AW         (32),
        .AXI4LITE_DW         (32),
        .SS_CTRL_W           (5),
        .NUM_GPIO            (4),
        .IOCELL_COUNT        (15),
        .IOCELL_CFGW         (4))
    SystemControl_SS(
        // Interface: Clock
        .clock               (clk_in),
        // Interface: Clock_int
        .clk                 (SystemControl_SS_clk),
        // Interface: GPIO
        .gpio                (gpio[7:0]),
        // Interface: ICN_SS_Ctrl
        .ss_ctrl_icn         (SystemControl_SS_ss_ctrl_icn),
        // Interface: IRQ
        .irq_i               (SystemControl_SS_irq_i),
        // Interface: JTAG
        .jtag_tck            (jtag_tck),
        .jtag_tdi            (jtag_tdi),
        .jtag_tdo            (jtag_tdo),
        .jtag_tms            (jtag_tms),
        .jtag_trst           (jtag_trst),
        // Interface: OBI
        .obi_err             (SystemControl_SS_obi_err),
        .obi_exokay          (SystemControl_SS_obi_exokay),
        .obi_gnt             (SystemControl_SS_obi_gnt),
        .obi_gntpar          (SystemControl_SS_obi_gntpar),
        .obi_rchk            (SystemControl_SS_obi_rchk),
        .obi_rdata           (SystemControl_SS_obi_rdata),
        .obi_rid             (SystemControl_SS_obi_rid),
        .obi_ruser           (SystemControl_SS_obi_ruser),
        .obi_rvalid          (SystemControl_SS_obi_rvalid),
        .obi_rvalidpar       (SystemControl_SS_obi_rvalidpar),
        .obi_achk            (SystemControl_SS_obi_achk),
        .obi_addr            (SystemControl_SS_obi_addr),
        .obi_aid             (SystemControl_SS_obi_aid),
        .obi_atop            (SystemControl_SS_obi_atop),
        .obi_auser           (SystemControl_SS_obi_auser),
        .obi_be              (SystemControl_SS_obi_be),
        .obi_dbg             (SystemControl_SS_obi_dbg),
        .obi_memtype         (SystemControl_SS_obi_memtype),
        .obi_mid             (SystemControl_SS_obi_mid),
        .obi_prot            (SystemControl_SS_obi_prot),
        .obi_req             (SystemControl_SS_obi_req),
        .obi_reqpar          (SystemControl_SS_obi_reqpar),
        .obi_rready          (SystemControl_SS_obi_rready),
        .obi_rreadypar       (SystemControl_SS_obi_rreadypar),
        .obi_wdata           (SystemControl_SS_obi_wdata),
        .obi_we              (SystemControl_SS_obi_we),
        .obi_wuser           (SystemControl_SS_obi_wuser),
        // Interface: Reset
        .reset               (reset),
        // Interface: Reset_SS
        .reset_ss            (SystemControl_SS_reset_ss),
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
        // Interface: high_speed_clock
        .high_speed_clk_n_in (high_speed_clk_n_in),
        .high_speed_clk_p_in (high_speed_clk_p_in),
        // Interface: high_speed_clock_internal
        .high_speed_clk_internal(SystemControl_SS_high_speed_clk_internal),
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

    // IP-XACT VLNV: tuni.fi:interconnect:obi_icn_ss:1.0
    obi_icn_ss #(
        .OBI_AW              (32),
        .OBI_CHKW            (1),
        .OBI_DW              (32),
        .OBI_IDW             (1),
        .OBI_USERW           (1),
        .APB_DW              (32),
        .APB_AW              (32),
        .SS_CTRL_W           (5))
    obi_icn_ss_0(
        // Interface: OBI
        .obi_achk            (obi_icn_ss_0_obi_achk),
        .obi_addr            (obi_icn_ss_0_obi_addr),
        .obi_aid             (obi_icn_ss_0_obi_aid),
        .obi_atop            (obi_icn_ss_0_obi_atop),
        .obi_auser           (obi_icn_ss_0_obi_auser),
        .obi_be              (obi_icn_ss_0_obi_be),
        .obi_dbg             (obi_icn_ss_0_obi_dbg),
        .obi_memtype         (obi_icn_ss_0_obi_memtype),
        .obi_mid             (obi_icn_ss_0_obi_mid),
        .obi_prot            (obi_icn_ss_0_obi_prot),
        .obi_req             (obi_icn_ss_0_obi_req),
        .obi_reqpar          (obi_icn_ss_0_obi_reqpar),
        .obi_rready          (obi_icn_ss_0_obi_rready),
        .obi_rreadypar       (obi_icn_ss_0_obi_rreadypar),
        .obi_wdata           (obi_icn_ss_0_obi_wdata),
        .obi_we              (obi_icn_ss_0_obi_we),
        .obi_wuser           (obi_icn_ss_0_obi_wuser),
        .obi_err             (obi_icn_ss_0_obi_err),
        .obi_exokay          (obi_icn_ss_0_obi_exokay),
        .obi_gnt             (obi_icn_ss_0_obi_gnt),
        .obi_gntpar          (obi_icn_ss_0_obi_gntpar),
        .obi_rchk            (obi_icn_ss_0_obi_rchk),
        .obi_rdata           (obi_icn_ss_0_obi_rdata),
        .obi_rid             (obi_icn_ss_0_obi_rid),
        .obi_ruser           (obi_icn_ss_0_obi_ruser),
        .obi_rvalid          (obi_icn_ss_0_obi_rvalid),
        .obi_rvalidpar       (obi_icn_ss_0_obi_rvalidpar),
        // Interface: apb_0
        .APB_0_PRDATA        (obi_icn_ss_0_APB_0_PRDATA),
        .APB_0_PREADY        (obi_icn_ss_0_APB_0_PREADY),
        .APB_0_PSLVERR       (obi_icn_ss_0_APB_0_PSLVERR),
        .APB_0_PADDR         (obi_icn_ss_0_APB_0_PADDR),
        .APB_0_PENABLE       (obi_icn_ss_0_APB_0_PENABLE),
        .APB_0_PSEL          (obi_icn_ss_0_APB_0_PSEL),
        .APB_0_PSTRB         (obi_icn_ss_0_APB_0_PSTRB),
        .APB_0_PWDATA        (obi_icn_ss_0_APB_0_PWDATA),
        .APB_0_PWRITE        (obi_icn_ss_0_APB_0_PWRITE),
        // Interface: apb_1
        .APB_1_PRDATA        (obi_icn_ss_0_APB_1_PRDATA),
        .APB_1_PREADY        (obi_icn_ss_0_APB_1_PREADY),
        .APB_1_PSLVERR       (obi_icn_ss_0_APB_1_PSLVERR),
        .APB_1_PADDR         (obi_icn_ss_0_APB_1_PADDR),
        .APB_1_PENABLE       (obi_icn_ss_0_APB_1_PENABLE),
        .APB_1_PSEL          (obi_icn_ss_0_APB_1_PSEL),
        .APB_1_PSTRB         (obi_icn_ss_0_APB_1_PSTRB),
        .APB_1_PWDATA        (obi_icn_ss_0_APB_1_PWDATA),
        .APB_1_PWRITE        (obi_icn_ss_0_APB_1_PWRITE),
        // Interface: apb_2
        .APB_2_PRDATA        (obi_icn_ss_0_APB_2_PRDATA),
        .APB_2_PREADY        (obi_icn_ss_0_APB_2_PREADY),
        .APB_2_PSLVERR       (obi_icn_ss_0_APB_2_PSLVERR),
        .APB_2_PADDR         (obi_icn_ss_0_APB_2_PADDR),
        .APB_2_PENABLE       (obi_icn_ss_0_APB_2_PENABLE),
        .APB_2_PSEL          (obi_icn_ss_0_APB_2_PSEL),
        .APB_2_PSTRB         (obi_icn_ss_0_APB_2_PSTRB),
        .APB_2_PWDATA        (obi_icn_ss_0_APB_2_PWDATA),
        .APB_2_PWRITE        (obi_icn_ss_0_APB_2_PWRITE),
        // Interface: apb_3
        .APB_3_PRDATA        (obi_icn_ss_0_APB_3_PRDATA),
        .APB_3_PREADY        (obi_icn_ss_0_APB_3_PREADY),
        .APB_3_PSLVERR       (obi_icn_ss_0_APB_3_PSLVERR),
        .APB_3_PADDR         (obi_icn_ss_0_APB_3_PADDR),
        .APB_3_PENABLE       (obi_icn_ss_0_APB_3_PENABLE),
        .APB_3_PSEL          (obi_icn_ss_0_APB_3_PSEL),
        .APB_3_PSTRB         (obi_icn_ss_0_APB_3_PSTRB),
        .APB_3_PWDATA        (obi_icn_ss_0_APB_3_PWDATA),
        .APB_3_PWRITE        (obi_icn_ss_0_APB_3_PWRITE),
        // Interface: clock
        .clk                 (obi_icn_ss_0_clk),
        // Interface: icn_ss_ctrl
        .ss_ctrl_icn         (obi_icn_ss_0_ss_ctrl_icn),
        // Interface: reset
        .reset_n             (obi_icn_ss_0_reset_n));

    // IP-XACT VLNV: tuni.fi:analog:student_ss_analog:1.0
    student_ss_analog     student_ss_analog(
        // Interface: analog_bus
        .ana_core_in         (ana_core_in[1:0]),
        .ana_core_out        (ana_core_out[1:0]));


endmodule
