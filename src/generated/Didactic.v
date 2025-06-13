//-----------------------------------------------------------------------------
// File          : Didactic.v
// Creation date : 13.06.2025
// Creation time : 14:24:42
// Description   : Edu4Chip top level example SoC.
//                 
//                 Spec: 
//                 * RiscV core
//                 * Extendable
//                 * UART/SPI/GPIO peripherals
//                 * programmable via JTAG
//                 
// Created by    : 
// Tool : Kactus2 3.13.5 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:soc:Didactic:1.2
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/soc/Didactic/1.2/Didactic.1.2.xml
//-----------------------------------------------------------------------------

module Didactic #(
    parameter                              AW               = 32,    // Global SoC address width
    parameter                              DW               = 32,    // Global SoC data width
    parameter                              SS_CTRL_W        = 8,    // SoC SS control width
    parameter                              NUM_GPIO         = 16,    // SoC GPIO Cell count. Default 16.
    parameter                              IOCELL_CFG_W     = 10,    // Tech cell control width.
    parameter                              IOCELL_COUNT     = 25,    // number of configurable io cells in design
    parameter                              NUM_SS           = 5    // number of student systems present in top level.
) (
    // Interface: Clock
    inout  wire                         clk_in,
    inout  wire                         clk_out,

    // Interface: GPIO
    inout  wire          [15:0]         gpio,

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

    // Interface: analog_io
    inout  wire          [1:0]          ana_core_in,
    inout  wire          [1:0]          ana_core_io,
    inout  wire          [2:0]          ana_core_out,

    // Interface: high_speed_clock
    inout  wire                         high_speed_clk_n_in,
    inout  wire                         high_speed_clk_p_in
);

    // SystemControl_SS_UART_to_UART wires:
    // SystemControl_SS_SPI_to_SPI wires:
    // SystemControl_SS_GPIO_to_GPIO wires:
    // SystemControl_SS_Reset_to_Reset wires:
    // SystemControl_SS_Clock_to_Clock wires:
    // SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock wires:
    wire       SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    // SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl_irq_en;
    // SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl_irq_en;
    // SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl_irq_en;
    // SystemControl_SS_JTAG_to_JTAG wires:
    // SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl wires:
    wire [7:0] SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl_clk_ctrl;
    wire       SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl_irq_en;
    // SystemControl_SS_high_speed_clock_to_high_speed_clock wires:
    // i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal
    // wires:
    wire       i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk;
    // i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB wires:
    wire [31:0] i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PADDR;
    wire       i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PENABLE;
    wire [31:0] i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PRDATA;
    wire       i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PREADY;
    wire       i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSEL;
    wire       i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSLVERR;
    wire [3:0] i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSTRB;
    wire [31:0] i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PWDATA;
    wire       i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PWRITE;
    // i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB wires:
    wire [31:0] i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PADDR;
    wire       i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PENABLE;
    wire [31:0] i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PRDATA;
    wire       i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PREADY;
    wire       i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSEL;
    wire       i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSLVERR;
    wire [3:0] i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSTRB;
    wire [31:0] i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PWDATA;
    wire       i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PWRITE;
    // i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB wires:
    wire [31:0] i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PADDR;
    wire       i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PENABLE;
    wire [31:0] i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PRDATA;
    wire       i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PREADY;
    wire       i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSEL;
    wire       i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSLVERR;
    wire [3:0] i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSTRB;
    wire [31:0] i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PWDATA;
    wire       i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PWRITE;
    // i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB wires:
    wire [31:0] i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PADDR;
    wire       i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PENABLE;
    wire [31:0] i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PRDATA;
    wire       i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PREADY;
    wire       i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSEL;
    wire       i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSLVERR;
    wire [3:0] i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSTRB;
    wire [31:0] i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PWDATA;
    wire       i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PWRITE;
    // SystemControl_SS_OBI_to_i_obi_icn_ss_OBI wires:
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_achk;
    wire [31:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_addr;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_aid;
    wire [5:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_atop;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_auser;
    wire [3:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_be;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_dbg;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_err;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_exokay;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_gnt;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_gntpar;
    wire [1:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_memtype;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_mid;
    wire [2:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_prot;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rchk;
    wire [31:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rdata;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_req;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_reqpar;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rid;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rready;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rreadypar;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_ruser;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rvalid;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rvalidpar;
    wire [31:0] SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_wdata;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_we;
    wire       SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_wuser;
    // i_obi_icn_ss_reset_to_SystemControl_SS_Reset_icn wires:
    wire       i_obi_icn_ss_reset_to_SystemControl_SS_Reset_icn_reset;
    // SystemControl_SS_ICN_SS_Ctrl_to_i_obi_icn_ss_icn_ss_ctrl wires:
    wire [7:0] SystemControl_SS_ICN_SS_Ctrl_to_i_obi_icn_ss_icn_ss_ctrl_clk_ctrl;
    // analog_wrapper_0_analog_io_to_analog_io wires:
    // analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4 wires:
    wire [31:0] analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PADDR;
    wire       analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PENABLE;
    wire [31:0] analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PRDATA;
    wire       analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PREADY;
    wire       analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSEL;
    wire       analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSLVERR;
    wire [3:0] analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSTRB;
    wire [31:0] analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PWDATA;
    wire       analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PWRITE;
    // analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl wires:
    wire [7:0] analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl_clk_ctrl;
    wire       analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl_irq_en;
    // SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio wires:
    wire [15:0] SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpi;
    wire [15:0] SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpio_oe;
    wire [15:0] SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpo;
    // i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio wires:
    wire [15:0] i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpi;
    wire [15:0] i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpio_oe;
    wire [15:0] i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpo;
    // i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio wires:
    wire [15:0] i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpi;
    wire [15:0] i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpio_oe;
    wire [15:0] i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpo;
    // i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio wires:
    wire [15:0] i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpi;
    wire [15:0] i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpio_oe;
    wire [15:0] i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpo;

    // Ad-hoc wires:
    wire       i_dtu_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss;
    wire       i_dtu_ss_wrapper_irq_to_SystemControl_SS_irq_i;
    wire       i_imt_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss;
    wire       i_tum_ss_warpper_reset_int_to_SystemControl_SS_reset_ss;
    wire       i_kth_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss;
    wire       i_kth_ss_wrapper_irq_to_SystemControl_SS_irq_i;
    wire       i_tum_ss_warpper_irq_to_SystemControl_SS_irq_i;
    wire       i_imt_ss_wrapper_irq_to_SystemControl_SS_irq_i;
    wire       analog_wrapper_0_irq_to_SystemControl_SS_irq_i;
    wire       analog_wrapper_0_reset_int_to_SystemControl_SS_reset_ss;

    // SystemControl_SS port wires:
    wire       SystemControl_SS_clk;
    wire       SystemControl_SS_high_speed_clk_internal;
    wire       SystemControl_SS_irq_en_0;
    wire       SystemControl_SS_irq_en_1;
    wire       SystemControl_SS_irq_en_2;
    wire       SystemControl_SS_irq_en_3;
    wire       SystemControl_SS_irq_en_4;
    wire [4:0] SystemControl_SS_irq_i;
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
    wire       SystemControl_SS_obi_rid;
    wire       SystemControl_SS_obi_rready;
    wire       SystemControl_SS_obi_rreadypar;
    wire       SystemControl_SS_obi_ruser;
    wire       SystemControl_SS_obi_rvalid;
    wire       SystemControl_SS_obi_rvalidpar;
    wire [31:0] SystemControl_SS_obi_wdata;
    wire       SystemControl_SS_obi_we;
    wire       SystemControl_SS_obi_wuser;
    wire       SystemControl_SS_reset_int;
    wire [4:0] SystemControl_SS_reset_ss;
    wire [15:0] SystemControl_SS_ss_0_pmod_gpi;
    wire [15:0] SystemControl_SS_ss_0_pmod_gpio_oe;
    wire [15:0] SystemControl_SS_ss_0_pmod_gpo;
    wire [15:0] SystemControl_SS_ss_1_pmod_gpi;
    wire [15:0] SystemControl_SS_ss_1_pmod_gpio_oe;
    wire [15:0] SystemControl_SS_ss_1_pmod_gpo;
    wire [15:0] SystemControl_SS_ss_2_pmod_gpi;
    wire [15:0] SystemControl_SS_ss_2_pmod_gpio_oe;
    wire [15:0] SystemControl_SS_ss_2_pmod_gpo;
    wire [15:0] SystemControl_SS_ss_3_pmod_gpi;
    wire [15:0] SystemControl_SS_ss_3_pmod_gpio_oe;
    wire [15:0] SystemControl_SS_ss_3_pmod_gpo;
    wire [7:0] SystemControl_SS_ss_ctrl_0;
    wire [7:0] SystemControl_SS_ss_ctrl_1;
    wire [7:0] SystemControl_SS_ss_ctrl_2;
    wire [7:0] SystemControl_SS_ss_ctrl_3;
    wire [7:0] SystemControl_SS_ss_ctrl_4;
    wire [7:0] SystemControl_SS_ss_ctrl_icn;
    // analog_wrapper_0 port wires:
    wire [31:0] analog_wrapper_0_PADDR;
    wire       analog_wrapper_0_PENABLE;
    wire [31:0] analog_wrapper_0_PRDATA;
    wire       analog_wrapper_0_PREADY;
    wire       analog_wrapper_0_PSEL;
    wire       analog_wrapper_0_PSLVERR;
    wire [3:0] analog_wrapper_0_PSTRB;
    wire [31:0] analog_wrapper_0_PWDATA;
    wire       analog_wrapper_0_PWRITE;
    wire       analog_wrapper_0_clk_in;
    wire       analog_wrapper_0_high_speed_clk;
    wire       analog_wrapper_0_irq;
    wire       analog_wrapper_0_irq_en;
    wire       analog_wrapper_0_reset_int;
    wire [7:0] analog_wrapper_0_ss_ctrl;
    // i_dtu_ss_wrapper port wires:
    wire [31:0] i_dtu_ss_wrapper_PADDR;
    wire       i_dtu_ss_wrapper_PENABLE;
    wire [31:0] i_dtu_ss_wrapper_PRDATA;
    wire       i_dtu_ss_wrapper_PREADY;
    wire       i_dtu_ss_wrapper_PSEL;
    wire       i_dtu_ss_wrapper_PSLVERR;
    wire [3:0] i_dtu_ss_wrapper_PSTRB;
    wire [31:0] i_dtu_ss_wrapper_PWDATA;
    wire       i_dtu_ss_wrapper_PWRITE;
    wire       i_dtu_ss_wrapper_clk;
    wire       i_dtu_ss_wrapper_high_speed_clk;
    wire       i_dtu_ss_wrapper_irq;
    wire       i_dtu_ss_wrapper_irq_en_2;
    wire [15:0] i_dtu_ss_wrapper_pmod_gpi;
    wire [15:0] i_dtu_ss_wrapper_pmod_gpio_oe;
    wire [15:0] i_dtu_ss_wrapper_pmod_gpo;
    wire       i_dtu_ss_wrapper_reset_int;
    wire [7:0] i_dtu_ss_wrapper_ss_ctrl_2;
    // i_imt_ss_wrapper port wires:
    wire [31:0] i_imt_ss_wrapper_PADDR;
    wire       i_imt_ss_wrapper_PENABLE;
    wire [31:0] i_imt_ss_wrapper_PRDATA;
    wire       i_imt_ss_wrapper_PREADY;
    wire       i_imt_ss_wrapper_PSEL;
    wire       i_imt_ss_wrapper_PSLVERR;
    wire [3:0] i_imt_ss_wrapper_PSTRB;
    wire [31:0] i_imt_ss_wrapper_PWDATA;
    wire       i_imt_ss_wrapper_PWRITE;
    wire       i_imt_ss_wrapper_clk_in;
    wire       i_imt_ss_wrapper_high_speed_clk;
    wire       i_imt_ss_wrapper_irq;
    wire       i_imt_ss_wrapper_irq_en_3;
    wire [15:0] i_imt_ss_wrapper_pmod_gpi;
    wire [15:0] i_imt_ss_wrapper_pmod_gpio_oe;
    wire [15:0] i_imt_ss_wrapper_pmod_gpo;
    wire       i_imt_ss_wrapper_reset_int;
    wire [7:0] i_imt_ss_wrapper_ss_ctrl_3;
    // i_kth_ss_wrapper port wires:
    wire [31:0] i_kth_ss_wrapper_PADDR;
    wire       i_kth_ss_wrapper_PENABLE;
    wire [31:0] i_kth_ss_wrapper_PRDATA;
    wire       i_kth_ss_wrapper_PREADY;
    wire       i_kth_ss_wrapper_PSEL;
    wire       i_kth_ss_wrapper_PSLVERR;
    wire [3:0] i_kth_ss_wrapper_PSTRB;
    wire [31:0] i_kth_ss_wrapper_PWDATA;
    wire       i_kth_ss_wrapper_PWRITE;
    wire       i_kth_ss_wrapper_clk_in;
    wire       i_kth_ss_wrapper_high_speed_clk;
    wire       i_kth_ss_wrapper_irq;
    wire       i_kth_ss_wrapper_irq_en_3;
    wire [15:0] i_kth_ss_wrapper_pmod_gpi;
    wire [15:0] i_kth_ss_wrapper_pmod_gpio_oe;
    wire [15:0] i_kth_ss_wrapper_pmod_gpo;
    wire       i_kth_ss_wrapper_reset_int;
    wire [7:0] i_kth_ss_wrapper_ss_ctrl_3;
    // i_obi_icn_ss port wires:
    wire [31:0] i_obi_icn_ss_APB_0_PADDR;
    wire       i_obi_icn_ss_APB_0_PENABLE;
    wire [31:0] i_obi_icn_ss_APB_0_PRDATA;
    wire       i_obi_icn_ss_APB_0_PREADY;
    wire       i_obi_icn_ss_APB_0_PSEL;
    wire       i_obi_icn_ss_APB_0_PSLVERR;
    wire [3:0] i_obi_icn_ss_APB_0_PSTRB;
    wire [31:0] i_obi_icn_ss_APB_0_PWDATA;
    wire       i_obi_icn_ss_APB_0_PWRITE;
    wire [31:0] i_obi_icn_ss_APB_1_PADDR;
    wire       i_obi_icn_ss_APB_1_PENABLE;
    wire [31:0] i_obi_icn_ss_APB_1_PRDATA;
    wire       i_obi_icn_ss_APB_1_PREADY;
    wire       i_obi_icn_ss_APB_1_PSEL;
    wire       i_obi_icn_ss_APB_1_PSLVERR;
    wire [3:0] i_obi_icn_ss_APB_1_PSTRB;
    wire [31:0] i_obi_icn_ss_APB_1_PWDATA;
    wire       i_obi_icn_ss_APB_1_PWRITE;
    wire [31:0] i_obi_icn_ss_APB_2_PADDR;
    wire       i_obi_icn_ss_APB_2_PENABLE;
    wire [31:0] i_obi_icn_ss_APB_2_PRDATA;
    wire       i_obi_icn_ss_APB_2_PREADY;
    wire       i_obi_icn_ss_APB_2_PSEL;
    wire       i_obi_icn_ss_APB_2_PSLVERR;
    wire [3:0] i_obi_icn_ss_APB_2_PSTRB;
    wire [31:0] i_obi_icn_ss_APB_2_PWDATA;
    wire       i_obi_icn_ss_APB_2_PWRITE;
    wire [31:0] i_obi_icn_ss_APB_3_PADDR;
    wire       i_obi_icn_ss_APB_3_PENABLE;
    wire [31:0] i_obi_icn_ss_APB_3_PRDATA;
    wire       i_obi_icn_ss_APB_3_PREADY;
    wire       i_obi_icn_ss_APB_3_PSEL;
    wire       i_obi_icn_ss_APB_3_PSLVERR;
    wire [3:0] i_obi_icn_ss_APB_3_PSTRB;
    wire [31:0] i_obi_icn_ss_APB_3_PWDATA;
    wire       i_obi_icn_ss_APB_3_PWRITE;
    wire [31:0] i_obi_icn_ss_APB_4_PADDR;
    wire       i_obi_icn_ss_APB_4_PENABLE;
    wire [31:0] i_obi_icn_ss_APB_4_PRDATA;
    wire       i_obi_icn_ss_APB_4_PREADY;
    wire       i_obi_icn_ss_APB_4_PSEL;
    wire       i_obi_icn_ss_APB_4_PSLVERR;
    wire [3:0] i_obi_icn_ss_APB_4_PSTRB;
    wire [31:0] i_obi_icn_ss_APB_4_PWDATA;
    wire       i_obi_icn_ss_APB_4_PWRITE;
    wire       i_obi_icn_ss_clk;
    wire       i_obi_icn_ss_obi_achk;
    wire [31:0] i_obi_icn_ss_obi_addr;
    wire       i_obi_icn_ss_obi_aid;
    wire [5:0] i_obi_icn_ss_obi_atop;
    wire       i_obi_icn_ss_obi_auser;
    wire [3:0] i_obi_icn_ss_obi_be;
    wire       i_obi_icn_ss_obi_dbg;
    wire       i_obi_icn_ss_obi_err;
    wire       i_obi_icn_ss_obi_exokay;
    wire       i_obi_icn_ss_obi_gnt;
    wire       i_obi_icn_ss_obi_gntpar;
    wire [1:0] i_obi_icn_ss_obi_memtype;
    wire       i_obi_icn_ss_obi_mid;
    wire [2:0] i_obi_icn_ss_obi_prot;
    wire       i_obi_icn_ss_obi_rchk;
    wire [31:0] i_obi_icn_ss_obi_rdata;
    wire       i_obi_icn_ss_obi_req;
    wire       i_obi_icn_ss_obi_reqpar;
    wire       i_obi_icn_ss_obi_rid;
    wire       i_obi_icn_ss_obi_rready;
    wire       i_obi_icn_ss_obi_rreadypar;
    wire       i_obi_icn_ss_obi_ruser;
    wire       i_obi_icn_ss_obi_rvalid;
    wire       i_obi_icn_ss_obi_rvalidpar;
    wire [31:0] i_obi_icn_ss_obi_wdata;
    wire       i_obi_icn_ss_obi_we;
    wire       i_obi_icn_ss_obi_wuser;
    wire       i_obi_icn_ss_reset_n;
    wire [7:0] i_obi_icn_ss_ss_ctrl_icn;
    // i_tum_ss_warpper port wires:
    wire [31:0] i_tum_ss_warpper_PADDR;
    wire       i_tum_ss_warpper_PENABLE;
    wire [31:0] i_tum_ss_warpper_PRDATA;
    wire       i_tum_ss_warpper_PREADY;
    wire       i_tum_ss_warpper_PSEL;
    wire       i_tum_ss_warpper_PSLVERR;
    wire [3:0] i_tum_ss_warpper_PSTRB;
    wire [31:0] i_tum_ss_warpper_PWDATA;
    wire       i_tum_ss_warpper_PWRITE;
    wire       i_tum_ss_warpper_clk_in;
    wire       i_tum_ss_warpper_high_speed_clk;
    wire       i_tum_ss_warpper_irq;
    wire       i_tum_ss_warpper_irq_en_3;
    wire [15:0] i_tum_ss_warpper_pmod_gpi;
    wire [15:0] i_tum_ss_warpper_pmod_gpio_oe;
    wire [15:0] i_tum_ss_warpper_pmod_gpo;
    wire       i_tum_ss_warpper_reset_int;
    wire [7:0] i_tum_ss_warpper_ss_ctrl_3;

    // Assignments for the ports of the encompassing component:

    // SystemControl_SS assignments:
    assign SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk = SystemControl_SS_clk;
    assign i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk = SystemControl_SS_high_speed_clk_internal;
    assign SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl_irq_en = SystemControl_SS_irq_en_0;
    assign SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl_irq_en = SystemControl_SS_irq_en_1;
    assign SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl_irq_en = SystemControl_SS_irq_en_2;
    assign SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl_irq_en = SystemControl_SS_irq_en_3;
    assign analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl_irq_en = SystemControl_SS_irq_en_4;
    assign SystemControl_SS_irq_i[4] = analog_wrapper_0_irq_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[2] = i_dtu_ss_wrapper_irq_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[0] = i_imt_ss_wrapper_irq_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[3] = i_kth_ss_wrapper_irq_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_irq_i[1] = i_tum_ss_warpper_irq_to_SystemControl_SS_irq_i;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_addr = SystemControl_SS_obi_addr;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_aid = SystemControl_SS_obi_aid;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_be = SystemControl_SS_obi_be;
    assign SystemControl_SS_obi_err = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_err;
    assign SystemControl_SS_obi_gnt = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_gnt;
    assign SystemControl_SS_obi_gntpar = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_gntpar;
    assign SystemControl_SS_obi_rdata = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rdata;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_req = SystemControl_SS_obi_req;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_reqpar = SystemControl_SS_obi_reqpar;
    assign SystemControl_SS_obi_rid = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rid;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rready = SystemControl_SS_obi_rready;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rreadypar = SystemControl_SS_obi_rreadypar;
    assign SystemControl_SS_obi_rvalid = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rvalid;
    assign SystemControl_SS_obi_rvalidpar = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rvalidpar;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_wdata = SystemControl_SS_obi_wdata;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_we = SystemControl_SS_obi_we;
    assign i_obi_icn_ss_reset_to_SystemControl_SS_Reset_icn_reset = SystemControl_SS_reset_int;
    assign analog_wrapper_0_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[4];
    assign i_dtu_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[2];
    assign i_imt_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[0];
    assign i_kth_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[3];
    assign i_tum_ss_warpper_reset_int_to_SystemControl_SS_reset_ss = SystemControl_SS_reset_ss[1];
    assign SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpi = SystemControl_SS_ss_0_pmod_gpi;
    assign SystemControl_SS_ss_0_pmod_gpio_oe = SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpio_oe;
    assign SystemControl_SS_ss_0_pmod_gpo = SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpo;
    assign i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpi = SystemControl_SS_ss_1_pmod_gpi;
    assign SystemControl_SS_ss_1_pmod_gpio_oe = i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpio_oe;
    assign SystemControl_SS_ss_1_pmod_gpo = i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpo;
    assign i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpi = SystemControl_SS_ss_2_pmod_gpi;
    assign SystemControl_SS_ss_2_pmod_gpio_oe = i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpio_oe;
    assign SystemControl_SS_ss_2_pmod_gpo = i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpo;
    assign i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpi = SystemControl_SS_ss_3_pmod_gpi;
    assign SystemControl_SS_ss_3_pmod_gpio_oe = i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpio_oe;
    assign SystemControl_SS_ss_3_pmod_gpo = i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpo;
    assign SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_0;
    assign SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_1;
    assign SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_2;
    assign SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_3;
    assign analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_4;
    assign SystemControl_SS_ICN_SS_Ctrl_to_i_obi_icn_ss_icn_ss_ctrl_clk_ctrl = SystemControl_SS_ss_ctrl_icn;
    // analog_wrapper_0 assignments:
    assign analog_wrapper_0_PADDR = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PADDR;
    assign analog_wrapper_0_PENABLE = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PENABLE;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PRDATA = analog_wrapper_0_PRDATA;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PREADY = analog_wrapper_0_PREADY;
    assign analog_wrapper_0_PSEL = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSEL;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSLVERR = analog_wrapper_0_PSLVERR;
    assign analog_wrapper_0_PSTRB = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSTRB;
    assign analog_wrapper_0_PWDATA = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PWDATA;
    assign analog_wrapper_0_PWRITE = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PWRITE;
    assign analog_wrapper_0_clk_in = SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    assign analog_wrapper_0_high_speed_clk = i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk;
    assign analog_wrapper_0_irq_to_SystemControl_SS_irq_i = analog_wrapper_0_irq;
    assign analog_wrapper_0_irq_en = analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl_irq_en;
    assign analog_wrapper_0_reset_int = analog_wrapper_0_reset_int_to_SystemControl_SS_reset_ss;
    assign analog_wrapper_0_ss_ctrl = analog_wrapper_0_SS_Ctrl_to_SystemControl_SS_ss_4_ctrl_clk_ctrl;
    // i_dtu_ss_wrapper assignments:
    assign i_dtu_ss_wrapper_PADDR = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PADDR;
    assign i_dtu_ss_wrapper_PENABLE = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PENABLE;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PRDATA = i_dtu_ss_wrapper_PRDATA;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PREADY = i_dtu_ss_wrapper_PREADY;
    assign i_dtu_ss_wrapper_PSEL = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSEL;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSLVERR = i_dtu_ss_wrapper_PSLVERR;
    assign i_dtu_ss_wrapper_PSTRB = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSTRB;
    assign i_dtu_ss_wrapper_PWDATA = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PWDATA;
    assign i_dtu_ss_wrapper_PWRITE = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PWRITE;
    assign i_dtu_ss_wrapper_clk = SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    assign i_dtu_ss_wrapper_high_speed_clk = i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk;
    assign i_dtu_ss_wrapper_irq_to_SystemControl_SS_irq_i = i_dtu_ss_wrapper_irq;
    assign i_dtu_ss_wrapper_irq_en_2 = SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl_irq_en;
    assign i_dtu_ss_wrapper_pmod_gpi = i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpi;
    assign i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpio_oe = i_dtu_ss_wrapper_pmod_gpio_oe;
    assign i_dtu_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_2_pmod_gpio_gpo = i_dtu_ss_wrapper_pmod_gpo;
    assign i_dtu_ss_wrapper_reset_int = i_dtu_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss;
    assign i_dtu_ss_wrapper_ss_ctrl_2 = SystemControl_SS_SS_2_Ctrl_to_i_dtu_ss_wrapper_SS_Ctrl_clk_ctrl;
    // i_imt_ss_wrapper assignments:
    assign i_imt_ss_wrapper_PADDR = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PADDR;
    assign i_imt_ss_wrapper_PENABLE = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PENABLE;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PRDATA = i_imt_ss_wrapper_PRDATA;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PREADY = i_imt_ss_wrapper_PREADY;
    assign i_imt_ss_wrapper_PSEL = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSEL;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSLVERR = i_imt_ss_wrapper_PSLVERR;
    assign i_imt_ss_wrapper_PSTRB = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSTRB;
    assign i_imt_ss_wrapper_PWDATA = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PWDATA;
    assign i_imt_ss_wrapper_PWRITE = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PWRITE;
    assign i_imt_ss_wrapper_clk_in = SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    assign i_imt_ss_wrapper_high_speed_clk = i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk;
    assign i_imt_ss_wrapper_irq_to_SystemControl_SS_irq_i = i_imt_ss_wrapper_irq;
    assign i_imt_ss_wrapper_irq_en_3 = SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl_irq_en;
    assign i_imt_ss_wrapper_pmod_gpi = SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpi;
    assign SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpio_oe = i_imt_ss_wrapper_pmod_gpio_oe;
    assign SystemControl_SS_ss_0_pmod_gpio_to_i_imt_ss_wrapper_pmod_gpio_gpo = i_imt_ss_wrapper_pmod_gpo;
    assign i_imt_ss_wrapper_reset_int = i_imt_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss;
    assign i_imt_ss_wrapper_ss_ctrl_3 = SystemControl_SS_SS_0_Ctrl_to_i_imt_ss_wrapper_SS_Ctrl_clk_ctrl;
    // i_kth_ss_wrapper assignments:
    assign i_kth_ss_wrapper_PADDR = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PADDR;
    assign i_kth_ss_wrapper_PENABLE = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PENABLE;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PRDATA = i_kth_ss_wrapper_PRDATA;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PREADY = i_kth_ss_wrapper_PREADY;
    assign i_kth_ss_wrapper_PSEL = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSEL;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSLVERR = i_kth_ss_wrapper_PSLVERR;
    assign i_kth_ss_wrapper_PSTRB = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSTRB;
    assign i_kth_ss_wrapper_PWDATA = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PWDATA;
    assign i_kth_ss_wrapper_PWRITE = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PWRITE;
    assign i_kth_ss_wrapper_clk_in = SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    assign i_kth_ss_wrapper_high_speed_clk = i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk;
    assign i_kth_ss_wrapper_irq_to_SystemControl_SS_irq_i = i_kth_ss_wrapper_irq;
    assign i_kth_ss_wrapper_irq_en_3 = SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl_irq_en;
    assign i_kth_ss_wrapper_pmod_gpi = i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpi;
    assign i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpio_oe = i_kth_ss_wrapper_pmod_gpio_oe;
    assign i_kth_ss_wrapper_pmod_gpio_to_SystemControl_SS_ss_3_pmod_gpio_gpo = i_kth_ss_wrapper_pmod_gpo;
    assign i_kth_ss_wrapper_reset_int = i_kth_ss_wrapper_reset_int_to_SystemControl_SS_reset_ss;
    assign i_kth_ss_wrapper_ss_ctrl_3 = SystemControl_SS_SS_3_Ctrl_to_i_kth_ss_wrapper_SS_Ctrl_clk_ctrl;
    // i_obi_icn_ss assignments:
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PADDR = i_obi_icn_ss_APB_0_PADDR;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PENABLE = i_obi_icn_ss_APB_0_PENABLE;
    assign i_obi_icn_ss_APB_0_PRDATA = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PRDATA;
    assign i_obi_icn_ss_APB_0_PREADY = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PREADY;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSEL = i_obi_icn_ss_APB_0_PSEL;
    assign i_obi_icn_ss_APB_0_PSLVERR = i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSLVERR;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PSTRB = i_obi_icn_ss_APB_0_PSTRB;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PWDATA = i_obi_icn_ss_APB_0_PWDATA;
    assign i_obi_icn_ss_apb_0_to_i_imt_ss_wrapper_APB_PWRITE = i_obi_icn_ss_APB_0_PWRITE;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PADDR = i_obi_icn_ss_APB_1_PADDR;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PENABLE = i_obi_icn_ss_APB_1_PENABLE;
    assign i_obi_icn_ss_APB_1_PRDATA = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PRDATA;
    assign i_obi_icn_ss_APB_1_PREADY = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PREADY;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSEL = i_obi_icn_ss_APB_1_PSEL;
    assign i_obi_icn_ss_APB_1_PSLVERR = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSLVERR;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSTRB = i_obi_icn_ss_APB_1_PSTRB;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PWDATA = i_obi_icn_ss_APB_1_PWDATA;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PWRITE = i_obi_icn_ss_APB_1_PWRITE;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PADDR = i_obi_icn_ss_APB_2_PADDR;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PENABLE = i_obi_icn_ss_APB_2_PENABLE;
    assign i_obi_icn_ss_APB_2_PRDATA = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PRDATA;
    assign i_obi_icn_ss_APB_2_PREADY = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PREADY;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSEL = i_obi_icn_ss_APB_2_PSEL;
    assign i_obi_icn_ss_APB_2_PSLVERR = i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSLVERR;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PSTRB = i_obi_icn_ss_APB_2_PSTRB;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PWDATA = i_obi_icn_ss_APB_2_PWDATA;
    assign i_obi_icn_ss_apb_2_to_i_dtu_ss_wrapper_APB_PWRITE = i_obi_icn_ss_APB_2_PWRITE;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PADDR = i_obi_icn_ss_APB_3_PADDR;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PENABLE = i_obi_icn_ss_APB_3_PENABLE;
    assign i_obi_icn_ss_APB_3_PRDATA = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PRDATA;
    assign i_obi_icn_ss_APB_3_PREADY = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PREADY;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSEL = i_obi_icn_ss_APB_3_PSEL;
    assign i_obi_icn_ss_APB_3_PSLVERR = i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSLVERR;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PSTRB = i_obi_icn_ss_APB_3_PSTRB;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PWDATA = i_obi_icn_ss_APB_3_PWDATA;
    assign i_obi_icn_ss_apb_3_to_i_kth_ss_wrapper_APB_PWRITE = i_obi_icn_ss_APB_3_PWRITE;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PADDR = i_obi_icn_ss_APB_4_PADDR;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PENABLE = i_obi_icn_ss_APB_4_PENABLE;
    assign i_obi_icn_ss_APB_4_PRDATA = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PRDATA;
    assign i_obi_icn_ss_APB_4_PREADY = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PREADY;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSEL = i_obi_icn_ss_APB_4_PSEL;
    assign i_obi_icn_ss_APB_4_PSLVERR = analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSLVERR;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PSTRB = i_obi_icn_ss_APB_4_PSTRB;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PWDATA = i_obi_icn_ss_APB_4_PWDATA;
    assign analog_wrapper_0_APB_to_i_obi_icn_ss_apb_4_PWRITE = i_obi_icn_ss_APB_4_PWRITE;
    assign i_obi_icn_ss_clk = SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    assign i_obi_icn_ss_obi_addr = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_addr;
    assign i_obi_icn_ss_obi_aid = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_aid;
    assign i_obi_icn_ss_obi_be = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_be;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_err = i_obi_icn_ss_obi_err;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_gnt = i_obi_icn_ss_obi_gnt;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_gntpar = i_obi_icn_ss_obi_gntpar;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rdata = i_obi_icn_ss_obi_rdata;
    assign i_obi_icn_ss_obi_req = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_req;
    assign i_obi_icn_ss_obi_reqpar = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_reqpar;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rid = i_obi_icn_ss_obi_rid;
    assign i_obi_icn_ss_obi_rready = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rready;
    assign i_obi_icn_ss_obi_rreadypar = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rreadypar;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rvalid = i_obi_icn_ss_obi_rvalid;
    assign SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_rvalidpar = i_obi_icn_ss_obi_rvalidpar;
    assign i_obi_icn_ss_obi_wdata = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_wdata;
    assign i_obi_icn_ss_obi_we = SystemControl_SS_OBI_to_i_obi_icn_ss_OBI_we;
    assign i_obi_icn_ss_reset_n = i_obi_icn_ss_reset_to_SystemControl_SS_Reset_icn_reset;
    assign i_obi_icn_ss_ss_ctrl_icn = SystemControl_SS_ICN_SS_Ctrl_to_i_obi_icn_ss_icn_ss_ctrl_clk_ctrl;
    // i_tum_ss_warpper assignments:
    assign i_tum_ss_warpper_PADDR = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PADDR;
    assign i_tum_ss_warpper_PENABLE = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PENABLE;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PRDATA = i_tum_ss_warpper_PRDATA;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PREADY = i_tum_ss_warpper_PREADY;
    assign i_tum_ss_warpper_PSEL = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSEL;
    assign i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSLVERR = i_tum_ss_warpper_PSLVERR;
    assign i_tum_ss_warpper_PSTRB = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PSTRB;
    assign i_tum_ss_warpper_PWDATA = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PWDATA;
    assign i_tum_ss_warpper_PWRITE = i_obi_icn_ss_apb_1_to_i_tum_ss_warpper_APB_PWRITE;
    assign i_tum_ss_warpper_clk_in = SystemControl_SS_Clock_int_to_i_imt_ss_wrapper_Clock_clk;
    assign i_tum_ss_warpper_high_speed_clk = i_tum_ss_warpper_high_speed_clk_to_SystemControl_SS_high_speed_clock_internal_clk;
    assign i_tum_ss_warpper_irq_to_SystemControl_SS_irq_i = i_tum_ss_warpper_irq;
    assign i_tum_ss_warpper_irq_en_3 = SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl_irq_en;
    assign i_tum_ss_warpper_pmod_gpi = i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpi;
    assign i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpio_oe = i_tum_ss_warpper_pmod_gpio_oe;
    assign i_tum_ss_warpper_pmod_gpio_to_SystemControl_SS_ss_1_pmod_gpio_gpo = i_tum_ss_warpper_pmod_gpo;
    assign i_tum_ss_warpper_reset_int = i_tum_ss_warpper_reset_int_to_SystemControl_SS_reset_ss;
    assign i_tum_ss_warpper_ss_ctrl_3 = SystemControl_SS_SS_1_Ctrl_to_i_tum_ss_warpper_SS_Ctrl_clk_ctrl;

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:SysCtrl_SS_wrapper:1.1
    SysCtrl_SS_wrapper_0 #(
        .OBI_AW              (32),
        .OBI_DW              (32),
        .SS_CTRL_W           (8),
        .NUM_GPIO            (16),
        .IOCELL_COUNT        (25),
        .IOCELL_CFGW         (10),
        .NUM_SS              (5),
        .OBI_IDW             (1))
    SystemControl_SS(
        // Interface: Clock
        .clock_in            (clk_in),
        .clock_out           (clk_out),
        // Interface: Clock_int
        .clk                 (SystemControl_SS_clk),
        // Interface: GPIO
        .gpio                (gpio[15:0]),
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
        .obi_gnt             (SystemControl_SS_obi_gnt),
        .obi_gntpar          (SystemControl_SS_obi_gntpar),
        .obi_rdata           (SystemControl_SS_obi_rdata),
        .obi_rid             (SystemControl_SS_obi_rid),
        .obi_rvalid          (SystemControl_SS_obi_rvalid),
        .obi_rvalidpar       (SystemControl_SS_obi_rvalidpar),
        .obi_addr            (SystemControl_SS_obi_addr),
        .obi_aid             (SystemControl_SS_obi_aid),
        .obi_be              (SystemControl_SS_obi_be),
        .obi_req             (SystemControl_SS_obi_req),
        .obi_reqpar          (SystemControl_SS_obi_reqpar),
        .obi_rready          (SystemControl_SS_obi_rready),
        .obi_rreadypar       (SystemControl_SS_obi_rreadypar),
        .obi_wdata           (SystemControl_SS_obi_wdata),
        .obi_we              (SystemControl_SS_obi_we),
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
        // Interface: ss_0_pmod_gpio
        .ss_0_pmod_gpio_oe   (SystemControl_SS_ss_0_pmod_gpio_oe),
        .ss_0_pmod_gpo       (SystemControl_SS_ss_0_pmod_gpo),
        .ss_0_pmod_gpi       (SystemControl_SS_ss_0_pmod_gpi),
        // Interface: ss_1_pmod_gpio
        .ss_1_pmod_gpio_oe   (SystemControl_SS_ss_1_pmod_gpio_oe),
        .ss_1_pmod_gpo       (SystemControl_SS_ss_1_pmod_gpo),
        .ss_1_pmod_gpi       (SystemControl_SS_ss_1_pmod_gpi),
        // Interface: ss_2_pmod_gpio
        .ss_2_pmod_gpio_oe   (SystemControl_SS_ss_2_pmod_gpio_oe),
        .ss_2_pmod_gpo       (SystemControl_SS_ss_2_pmod_gpo),
        .ss_2_pmod_gpi       (SystemControl_SS_ss_2_pmod_gpi),
        // Interface: ss_3_pmod_gpio
        .ss_3_pmod_gpio_oe   (SystemControl_SS_ss_3_pmod_gpio_oe),
        .ss_3_pmod_gpo       (SystemControl_SS_ss_3_pmod_gpo),
        .ss_3_pmod_gpi       (SystemControl_SS_ss_3_pmod_gpi),
        // Interface: ss_4_ctrl
        .irq_en_4            (SystemControl_SS_irq_en_4),
        .ss_ctrl_4           (SystemControl_SS_ss_ctrl_4));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:analog_wrapper:1.0
    analog_wrapper_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    analog_wrapper_0(
        // Interface: APB
        .PADDR               (analog_wrapper_0_PADDR),
        .PENABLE             (analog_wrapper_0_PENABLE),
        .PSEL                (analog_wrapper_0_PSEL),
        .PSTRB               (analog_wrapper_0_PSTRB),
        .PWDATA              (analog_wrapper_0_PWDATA),
        .PWRITE              (analog_wrapper_0_PWRITE),
        .PRDATA              (analog_wrapper_0_PRDATA),
        .PREADY              (analog_wrapper_0_PREADY),
        .PSLVERR             (analog_wrapper_0_PSLVERR),
        // Interface: Clock
        .clk_in              (analog_wrapper_0_clk_in),
        // Interface: IRQ
        .irq                 (analog_wrapper_0_irq),
        // Interface: Reset
        .reset_int           (analog_wrapper_0_reset_int),
        // Interface: SS_Ctrl
        .irq_en              (analog_wrapper_0_irq_en),
        .ss_ctrl             (analog_wrapper_0_ss_ctrl),
        // Interface: analog_io
        .ana_core_in         (ana_core_in[1:0]),
        .ana_core_io         (ana_core_io[1:0]),
        .ana_core_out        (ana_core_out[2:0]),
        // Interface: high_speed_clk
        .high_speed_clk      (analog_wrapper_0_high_speed_clk));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:dtu_wrapper:1.0
    dtu_wrapper_0 #(
        .APB_AW              (32),
        .APB_DW              (32))
    i_dtu_ss_wrapper(
        // Interface: APB
        .PADDR               (i_dtu_ss_wrapper_PADDR),
        .PENABLE             (i_dtu_ss_wrapper_PENABLE),
        .PSEL                (i_dtu_ss_wrapper_PSEL),
        .PSTRB               (i_dtu_ss_wrapper_PSTRB),
        .PWDATA              (i_dtu_ss_wrapper_PWDATA),
        .PWRITE              (i_dtu_ss_wrapper_PWRITE),
        .PRDATA              (i_dtu_ss_wrapper_PRDATA),
        .PREADY              (i_dtu_ss_wrapper_PREADY),
        .PSLVERR             (i_dtu_ss_wrapper_PSLVERR),
        // Interface: Clock
        .clk                 (i_dtu_ss_wrapper_clk),
        // Interface: IRQ
        .irq                 (i_dtu_ss_wrapper_irq),
        // Interface: Reset
        .reset_int           (i_dtu_ss_wrapper_reset_int),
        // Interface: SS_Ctrl
        .irq_en_2            (i_dtu_ss_wrapper_irq_en_2),
        .ss_ctrl_2           (i_dtu_ss_wrapper_ss_ctrl_2),
        // Interface: high_speed_clk
        .high_speed_clk      (i_dtu_ss_wrapper_high_speed_clk),
        // Interface: pmod_gpio
        .pmod_gpi            (i_dtu_ss_wrapper_pmod_gpi),
        .pmod_gpio_oe        (i_dtu_ss_wrapper_pmod_gpio_oe),
        .pmod_gpo            (i_dtu_ss_wrapper_pmod_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:imt_wrapper:1.0
    imt_wrapper_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    i_imt_ss_wrapper(
        // Interface: APB
        .PADDR               (i_imt_ss_wrapper_PADDR),
        .PENABLE             (i_imt_ss_wrapper_PENABLE),
        .PSEL                (i_imt_ss_wrapper_PSEL),
        .PSTRB               (i_imt_ss_wrapper_PSTRB),
        .PWDATA              (i_imt_ss_wrapper_PWDATA),
        .PWRITE              (i_imt_ss_wrapper_PWRITE),
        .PRDATA              (i_imt_ss_wrapper_PRDATA),
        .PREADY              (i_imt_ss_wrapper_PREADY),
        .PSLVERR             (i_imt_ss_wrapper_PSLVERR),
        // Interface: Clock
        .clk_in              (i_imt_ss_wrapper_clk_in),
        // Interface: IRQ
        .irq                 (i_imt_ss_wrapper_irq),
        // Interface: Reset
        .reset_int           (i_imt_ss_wrapper_reset_int),
        // Interface: SS_Ctrl
        .irq_en_3            (i_imt_ss_wrapper_irq_en_3),
        .ss_ctrl_3           (i_imt_ss_wrapper_ss_ctrl_3),
        // Interface: high_speed_clk
        .high_speed_clk      (i_imt_ss_wrapper_high_speed_clk),
        // Interface: pmod_gpio
        .pmod_gpi            (i_imt_ss_wrapper_pmod_gpi),
        .pmod_gpio_oe        (i_imt_ss_wrapper_pmod_gpio_oe),
        .pmod_gpo            (i_imt_ss_wrapper_pmod_gpo));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:kth_wrapper:1.0
    kth_wrapper_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    i_kth_ss_wrapper(
        // Interface: APB
        .PADDR               (i_kth_ss_wrapper_PADDR),
        .PENABLE             (i_kth_ss_wrapper_PENABLE),
        .PSEL                (i_kth_ss_wrapper_PSEL),
        .PSTRB               (i_kth_ss_wrapper_PSTRB),
        .PWDATA              (i_kth_ss_wrapper_PWDATA),
        .PWRITE              (i_kth_ss_wrapper_PWRITE),
        .PRDATA              (i_kth_ss_wrapper_PRDATA),
        .PREADY              (i_kth_ss_wrapper_PREADY),
        .PSLVERR             (i_kth_ss_wrapper_PSLVERR),
        // Interface: Clock
        .clk_in              (i_kth_ss_wrapper_clk_in),
        // Interface: IRQ
        .irq                 (i_kth_ss_wrapper_irq),
        // Interface: Reset
        .reset_int           (i_kth_ss_wrapper_reset_int),
        // Interface: SS_Ctrl
        .irq_en_3            (i_kth_ss_wrapper_irq_en_3),
        .ss_ctrl_3           (i_kth_ss_wrapper_ss_ctrl_3),
        // Interface: high_speed_clk
        .high_speed_clk      (i_kth_ss_wrapper_high_speed_clk),
        // Interface: pmod_gpio
        .pmod_gpi            (i_kth_ss_wrapper_pmod_gpi),
        .pmod_gpio_oe        (i_kth_ss_wrapper_pmod_gpio_oe),
        .pmod_gpo            (i_kth_ss_wrapper_pmod_gpo));

    // IP-XACT VLNV: tuni.fi:interconnect:obi_icn_ss:1.0
    obi_icn_ss #(
        .OBI_AW              (32),
        .OBI_CHKW            (1),
        .OBI_DW              (32),
        .OBI_IDW             (1),
        .OBI_USERW           (1),
        .APB_DW              (32),
        .APB_AW              (32),
        .SS_CTRL_W           (8))
    i_obi_icn_ss(
        // Interface: OBI
        .obi_addr            (i_obi_icn_ss_obi_addr),
        .obi_aid             (i_obi_icn_ss_obi_aid),
        .obi_be              (i_obi_icn_ss_obi_be),
        .obi_req             (i_obi_icn_ss_obi_req),
        .obi_reqpar          (i_obi_icn_ss_obi_reqpar),
        .obi_rready          (i_obi_icn_ss_obi_rready),
        .obi_rreadypar       (i_obi_icn_ss_obi_rreadypar),
        .obi_wdata           (i_obi_icn_ss_obi_wdata),
        .obi_we              (i_obi_icn_ss_obi_we),
        .obi_err             (i_obi_icn_ss_obi_err),
        .obi_gnt             (i_obi_icn_ss_obi_gnt),
        .obi_gntpar          (i_obi_icn_ss_obi_gntpar),
        .obi_rdata           (i_obi_icn_ss_obi_rdata),
        .obi_rid             (i_obi_icn_ss_obi_rid),
        .obi_rvalid          (i_obi_icn_ss_obi_rvalid),
        .obi_rvalidpar       (i_obi_icn_ss_obi_rvalidpar),
        // Interface: apb_0
        .APB_0_PRDATA        (i_obi_icn_ss_APB_0_PRDATA),
        .APB_0_PREADY        (i_obi_icn_ss_APB_0_PREADY),
        .APB_0_PSLVERR       (i_obi_icn_ss_APB_0_PSLVERR),
        .APB_0_PADDR         (i_obi_icn_ss_APB_0_PADDR),
        .APB_0_PENABLE       (i_obi_icn_ss_APB_0_PENABLE),
        .APB_0_PSEL          (i_obi_icn_ss_APB_0_PSEL),
        .APB_0_PSTRB         (i_obi_icn_ss_APB_0_PSTRB),
        .APB_0_PWDATA        (i_obi_icn_ss_APB_0_PWDATA),
        .APB_0_PWRITE        (i_obi_icn_ss_APB_0_PWRITE),
        // Interface: apb_1
        .APB_1_PRDATA        (i_obi_icn_ss_APB_1_PRDATA),
        .APB_1_PREADY        (i_obi_icn_ss_APB_1_PREADY),
        .APB_1_PSLVERR       (i_obi_icn_ss_APB_1_PSLVERR),
        .APB_1_PADDR         (i_obi_icn_ss_APB_1_PADDR),
        .APB_1_PENABLE       (i_obi_icn_ss_APB_1_PENABLE),
        .APB_1_PSEL          (i_obi_icn_ss_APB_1_PSEL),
        .APB_1_PSTRB         (i_obi_icn_ss_APB_1_PSTRB),
        .APB_1_PWDATA        (i_obi_icn_ss_APB_1_PWDATA),
        .APB_1_PWRITE        (i_obi_icn_ss_APB_1_PWRITE),
        // Interface: apb_2
        .APB_2_PRDATA        (i_obi_icn_ss_APB_2_PRDATA),
        .APB_2_PREADY        (i_obi_icn_ss_APB_2_PREADY),
        .APB_2_PSLVERR       (i_obi_icn_ss_APB_2_PSLVERR),
        .APB_2_PADDR         (i_obi_icn_ss_APB_2_PADDR),
        .APB_2_PENABLE       (i_obi_icn_ss_APB_2_PENABLE),
        .APB_2_PSEL          (i_obi_icn_ss_APB_2_PSEL),
        .APB_2_PSTRB         (i_obi_icn_ss_APB_2_PSTRB),
        .APB_2_PWDATA        (i_obi_icn_ss_APB_2_PWDATA),
        .APB_2_PWRITE        (i_obi_icn_ss_APB_2_PWRITE),
        // Interface: apb_3
        .APB_3_PRDATA        (i_obi_icn_ss_APB_3_PRDATA),
        .APB_3_PREADY        (i_obi_icn_ss_APB_3_PREADY),
        .APB_3_PSLVERR       (i_obi_icn_ss_APB_3_PSLVERR),
        .APB_3_PADDR         (i_obi_icn_ss_APB_3_PADDR),
        .APB_3_PENABLE       (i_obi_icn_ss_APB_3_PENABLE),
        .APB_3_PSEL          (i_obi_icn_ss_APB_3_PSEL),
        .APB_3_PSTRB         (i_obi_icn_ss_APB_3_PSTRB),
        .APB_3_PWDATA        (i_obi_icn_ss_APB_3_PWDATA),
        .APB_3_PWRITE        (i_obi_icn_ss_APB_3_PWRITE),
        // Interface: apb_4
        .APB_4_PRDATA        (i_obi_icn_ss_APB_4_PRDATA),
        .APB_4_PREADY        (i_obi_icn_ss_APB_4_PREADY),
        .APB_4_PSLVERR       (i_obi_icn_ss_APB_4_PSLVERR),
        .APB_4_PADDR         (i_obi_icn_ss_APB_4_PADDR),
        .APB_4_PENABLE       (i_obi_icn_ss_APB_4_PENABLE),
        .APB_4_PSEL          (i_obi_icn_ss_APB_4_PSEL),
        .APB_4_PSTRB         (i_obi_icn_ss_APB_4_PSTRB),
        .APB_4_PWDATA        (i_obi_icn_ss_APB_4_PWDATA),
        .APB_4_PWRITE        (i_obi_icn_ss_APB_4_PWRITE),
        // Interface: clock
        .clk                 (i_obi_icn_ss_clk),
        // Interface: icn_ss_ctrl
        .ss_ctrl_icn         (i_obi_icn_ss_ss_ctrl_icn),
        // Interface: reset
        .reset_n             (i_obi_icn_ss_reset_n));

    // IP-XACT VLNV: tuni.fi:subsystem.wrapper:tum_wrapper:1.0
    tum_wrapper_0 #(
        .APB_DW              (32),
        .APB_AW              (32))
    i_tum_ss_warpper(
        // Interface: APB
        .PADDR               (i_tum_ss_warpper_PADDR),
        .PENABLE             (i_tum_ss_warpper_PENABLE),
        .PSEL                (i_tum_ss_warpper_PSEL),
        .PSTRB               (i_tum_ss_warpper_PSTRB),
        .PWDATA              (i_tum_ss_warpper_PWDATA),
        .PWRITE              (i_tum_ss_warpper_PWRITE),
        .PRDATA              (i_tum_ss_warpper_PRDATA),
        .PREADY              (i_tum_ss_warpper_PREADY),
        .PSLVERR             (i_tum_ss_warpper_PSLVERR),
        // Interface: Clock
        .clk_in              (i_tum_ss_warpper_clk_in),
        // Interface: IRQ
        .irq                 (i_tum_ss_warpper_irq),
        // Interface: Reset
        .reset_int           (i_tum_ss_warpper_reset_int),
        // Interface: SS_Ctrl
        .irq_en_3            (i_tum_ss_warpper_irq_en_3),
        .ss_ctrl_3           (i_tum_ss_warpper_ss_ctrl_3),
        // Interface: high_speed_clk
        .high_speed_clk      (i_tum_ss_warpper_high_speed_clk),
        // Interface: pmod_gpio
        .pmod_gpi            (i_tum_ss_warpper_pmod_gpi),
        .pmod_gpio_oe        (i_tum_ss_warpper_pmod_gpio_oe),
        .pmod_gpo            (i_tum_ss_warpper_pmod_gpo));


endmodule
