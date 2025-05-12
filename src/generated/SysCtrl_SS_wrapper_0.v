//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_wrapper_0.v
// Creation date : 12.05.2025
// Creation time : 14:32:35
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.4 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:SysCtrl_SS_wrapper:1.1
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/SysCtrl_SS_wrapper/1.1/SysCtrl_SS_wrapper.1.1.xml
//-----------------------------------------------------------------------------

module SysCtrl_SS_wrapper_0 #(
    parameter                              OBI_AW           = 32,
    parameter                              OBI_DW           = 32,
    parameter                              SS_CTRL_W        = 8,
    parameter                              NUM_GPIO         = 16,
    parameter                              IOCELL_COUNT     = 25,
    parameter                              IOCELL_CFGW      = 5,
    parameter                              NUM_SS           = 5,
    parameter                              OBI_IDW          = 1,
    parameter                              OBI_CHKW         = 1,
    parameter                              OBI_USERW        = 1
) (
    // Interface: Clock
    inout  logic                        clock,

    // Interface: Clock_int
    output logic                        clk,

    // Interface: GPIO
    inout  wire          [15:0]         gpio,

    // Interface: ICN_SS_Ctrl
    output logic         [7:0]          ss_ctrl_icn,

    // Interface: IRQ
    input  logic         [4:0]          irq_i,

    // Interface: JTAG
    inout  wire                         jtag_tck,
    inout  wire                         jtag_tdi,
    inout  wire                         jtag_tdo,
    inout  wire                         jtag_tms,
    inout  wire                         jtag_trst,

    // Interface: OBI
    input  logic                        obi_err,
    input  logic                        obi_gnt,
    input  logic                        obi_gntpar,
    input  logic         [31:0]         obi_rdata,
    input  logic                        obi_rid,
    input  logic                        obi_rvalid,
    input  logic                        obi_rvalidpar,
    output logic         [31:0]         obi_addr,
    output logic                        obi_aid,
    output logic         [3:0]          obi_be,
    output logic                        obi_req,
    output logic                        obi_reqpar,
    output logic                        obi_rready,
    output logic                        obi_rreadypar,
    output logic         [31:0]         obi_wdata,
    output logic                        obi_we,

    // Interface: Reset
    inout  wire                         reset,

    // Interface: Reset_SS
    output logic         [4:0]          reset_ss,

    // Interface: Reset_icn
    output logic                        reset_int,

    // Interface: SPI
    inout  wire          [1:0]          spi_csn,
    inout  wire          [3:0]          spi_data,
    inout  wire                         spi_sck,

    // Interface: SS_0_Ctrl
    output logic                        irq_en_0,
    output logic         [7:0]          ss_ctrl_0,

    // Interface: SS_1_Ctrl
    output logic                        irq_en_1,
    output logic         [7:0]          ss_ctrl_1,

    // Interface: SS_2_Ctrl
    output logic                        irq_en_2,
    output logic         [7:0]          ss_ctrl_2,

    // Interface: SS_3_Ctrl
    output logic                        irq_en_3,
    output logic         [7:0]          ss_ctrl_3,

    // Interface: UART
    inout  wire                         uart_rx,
    inout  wire                         uart_tx,

    // Interface: high_speed_clock
    inout  wire                         high_speed_clk_n_in,
    inout  wire                         high_speed_clk_p_in,

    // Interface: high_speed_clock_internal
    output logic                        high_speed_clk_internal,

    // Interface: ss_0_pmod_gpio
    input  logic         [15:0]         ss_0_pmod_gpio_oe,
    input  logic         [15:0]         ss_0_pmod_gpo,
    output logic         [15:0]         ss_0_pmod_gpi,

    // Interface: ss_1_pmod_gpio
    input  logic         [15:0]         ss_1_pmod_gpio_oe,
    input  logic         [15:0]         ss_1_pmod_gpo,
    output logic         [15:0]         ss_1_pmod_gpi,

    // Interface: ss_2_pmod_gpio
    input  logic         [15:0]         ss_2_pmod_gpio_oe,
    input  logic         [15:0]         ss_2_pmod_gpo,
    output logic         [15:0]         ss_2_pmod_gpi,

    // Interface: ss_3_pmod_gpio
    input  logic         [15:0]         ss_3_pmod_gpio_oe,
    input  logic         [15:0]         ss_3_pmod_gpo,
    output logic         [15:0]         ss_3_pmod_gpi,

    // Interface: ss_4_ctrl
    output logic                        irq_en_4,
    output logic         [7:0]          ss_ctrl_4
);

    // SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl wires:
    wire [7:0] SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl_clk_ctrl;
    // SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_irq_en;
    // SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_irq_en;
    // i_io_cell_frame_JTAG_to_JTAG wires:
    // i_io_cell_frame_UART_to_UART wires:
    // i_io_cell_frame_GPIO_to_GPIO wires:
    // i_io_cell_frame_SPI_to_SPI wires:
    // i_io_cell_frame_Reset_to_Reset wires:
    // i_io_cell_frame_Clock_to_Clock wires:
    // i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG wires:
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tck;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdi;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdo;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tms;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_trst;
    // i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk wires:
    wire       i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    // i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI wires:
    wire [1:0] i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_csn;
    wire [3:0] i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_miso;
    wire [3:0] i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_mosi;
    wire       i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_sck;
    // i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART wires:
    wire       i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_rx;
    wire       i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_tx;
    // i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset wires:
    wire       i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset_reset;
    // SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_irq_en;
    // SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_irq_en;
    // SysCtrl_SS_Reset_ICN_to_Reset_icn wires:
    wire       SysCtrl_SS_Reset_ICN_to_Reset_icn_reset;
    // i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg wires:
    wire [124:0] i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg;
    // i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel wires:
    wire [15:0] i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo;
    // i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO wires:
    wire [15:0] i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi;
    wire [15:0] i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo;
    // SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core wires:
    wire [124:0] SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg;
    // i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal wires:
    wire [15:0] i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpi;
    wire [15:0] i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpo;
    // i_io_cell_frame_high_speed_clock_to_high_speed_clock wires:
    // i_io_cell_frame_high_speed_clock_internal_to_high_speed_clock_internal wires:
    wire       i_io_cell_frame_high_speed_clock_internal_to_high_speed_clock_internal_clk;
    // SysCtrl_SS_Reset_SS_to_Reset_SS wires:
    wire [4:0] SysCtrl_SS_Reset_SS_to_Reset_SS_reset;
    // SysCtrl_SS_IRQ_to_IRQ wires:
    wire [4:0] SysCtrl_SS_IRQ_to_IRQ_irq;
    // SysCtrl_SS_OBI_to_OBI wires:
    wire       SysCtrl_SS_OBI_to_OBI_achk;
    wire [31:0] SysCtrl_SS_OBI_to_OBI_addr;
    wire       SysCtrl_SS_OBI_to_OBI_aid;
    wire [5:0] SysCtrl_SS_OBI_to_OBI_atop;
    wire       SysCtrl_SS_OBI_to_OBI_auser;
    wire [3:0] SysCtrl_SS_OBI_to_OBI_be;
    wire       SysCtrl_SS_OBI_to_OBI_dbg;
    wire       SysCtrl_SS_OBI_to_OBI_err;
    wire       SysCtrl_SS_OBI_to_OBI_exokay;
    wire       SysCtrl_SS_OBI_to_OBI_gnt;
    wire       SysCtrl_SS_OBI_to_OBI_gntpar;
    wire [1:0] SysCtrl_SS_OBI_to_OBI_memtype;
    wire       SysCtrl_SS_OBI_to_OBI_mid;
    wire [2:0] SysCtrl_SS_OBI_to_OBI_prot;
    wire       SysCtrl_SS_OBI_to_OBI_rchk;
    wire [31:0] SysCtrl_SS_OBI_to_OBI_rdata;
    wire       SysCtrl_SS_OBI_to_OBI_req;
    wire       SysCtrl_SS_OBI_to_OBI_reqpar;
    wire [1:0] SysCtrl_SS_OBI_to_OBI_rid;
    wire       SysCtrl_SS_OBI_to_OBI_rready;
    wire       SysCtrl_SS_OBI_to_OBI_rreadypar;
    wire       SysCtrl_SS_OBI_to_OBI_ruser;
    wire       SysCtrl_SS_OBI_to_OBI_rvalid;
    wire       SysCtrl_SS_OBI_to_OBI_rvalidpar;
    wire [31:0] SysCtrl_SS_OBI_to_OBI_wdata;
    wire       SysCtrl_SS_OBI_to_OBI_we;
    wire       SysCtrl_SS_OBI_to_OBI_wuser;
    // SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl wires:
    wire [7:0] SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl_clk_ctrl;
    wire       SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl_irq_en;
    // i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio wires:
    wire [15:0] i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpi;
    wire [15:0] i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpio_oe;
    wire [15:0] i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpo;
    // i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio wires:
    wire [15:0] i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpi;
    wire [15:0] i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpio_oe;
    wire [15:0] i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpo;
    // i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio wires:
    wire [15:0] i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpi;
    wire [15:0] i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpio_oe;
    wire [15:0] i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpo;
    // i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio wires:
    wire [15:0] i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpi;
    wire [15:0] i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpio_oe;
    wire [15:0] i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpo;

    // SysCtrl_SS port wires:
    wire [124:0] SysCtrl_SS_cell_cfg;
    wire       SysCtrl_SS_clk_internal;
    wire [15:0] SysCtrl_SS_gpio_from_core;
    wire [15:0] SysCtrl_SS_gpio_to_core;
    wire       SysCtrl_SS_irq_en_0;
    wire       SysCtrl_SS_irq_en_1;
    wire       SysCtrl_SS_irq_en_2;
    wire       SysCtrl_SS_irq_en_3;
    wire       SysCtrl_SS_irq_en_4;
    wire       SysCtrl_SS_jtag_tck_internal;
    wire       SysCtrl_SS_jtag_tdi_internal;
    wire       SysCtrl_SS_jtag_tdo_internal;
    wire       SysCtrl_SS_jtag_tms_internal;
    wire       SysCtrl_SS_jtag_trst_internal;
    wire       SysCtrl_SS_obi_achk;
    wire [31:0] SysCtrl_SS_obi_addr;
    wire       SysCtrl_SS_obi_aid;
    wire [5:0] SysCtrl_SS_obi_atop;
    wire       SysCtrl_SS_obi_auser;
    wire [3:0] SysCtrl_SS_obi_be;
    wire       SysCtrl_SS_obi_dbg;
    wire       SysCtrl_SS_obi_err;
    wire       SysCtrl_SS_obi_exokay;
    wire       SysCtrl_SS_obi_gnt;
    wire       SysCtrl_SS_obi_gntpar;
    wire [1:0] SysCtrl_SS_obi_memtype;
    wire       SysCtrl_SS_obi_mid;
    wire [2:0] SysCtrl_SS_obi_prot;
    wire       SysCtrl_SS_obi_rchk;
    wire [31:0] SysCtrl_SS_obi_rdata;
    wire       SysCtrl_SS_obi_req;
    wire       SysCtrl_SS_obi_reqpar;
    wire [1:0] SysCtrl_SS_obi_rid;
    wire       SysCtrl_SS_obi_rready;
    wire       SysCtrl_SS_obi_rreadypar;
    wire       SysCtrl_SS_obi_ruser;
    wire       SysCtrl_SS_obi_rvalid;
    wire       SysCtrl_SS_obi_rvalidpar;
    wire [31:0] SysCtrl_SS_obi_wdata;
    wire       SysCtrl_SS_obi_we;
    wire       SysCtrl_SS_obi_wuser;
    wire [15:0] SysCtrl_SS_pmod_sel;
    wire       SysCtrl_SS_reset_icn;
    wire       SysCtrl_SS_reset_internal;
    wire [4:0] SysCtrl_SS_reset_ss;
    wire [1:0] SysCtrl_SS_spim_csn_internal;
    wire [3:0] SysCtrl_SS_spim_miso_internal;
    wire [3:0] SysCtrl_SS_spim_mosi_internal;
    wire       SysCtrl_SS_spim_sck_internal;
    wire [7:0] SysCtrl_SS_ss_ctrl_0;
    wire [7:0] SysCtrl_SS_ss_ctrl_1;
    wire [7:0] SysCtrl_SS_ss_ctrl_2;
    wire [7:0] SysCtrl_SS_ss_ctrl_3;
    wire [7:0] SysCtrl_SS_ss_ctrl_4;
    wire [7:0] SysCtrl_SS_ss_ctrl_icn;
    wire [4:0] SysCtrl_SS_sysctrl_irq_i;
    wire       SysCtrl_SS_uart_rx_internal;
    wire       SysCtrl_SS_uart_tx_internal;
    // i_io_cell_frame port wires:
    wire [124:0] i_io_cell_frame_cell_cfg;
    wire       i_io_cell_frame_clk_internal;
    wire [15:0] i_io_cell_frame_gpio_from_core;
    wire [15:0] i_io_cell_frame_gpio_to_core;
    wire       i_io_cell_frame_high_speed_clk_internal;
    wire       i_io_cell_frame_jtag_tck_internal;
    wire       i_io_cell_frame_jtag_tdi_internal;
    wire       i_io_cell_frame_jtag_tdo_internal;
    wire       i_io_cell_frame_jtag_tms_internal;
    wire       i_io_cell_frame_jtag_trst_internal;
    wire       i_io_cell_frame_reset_internal;
    wire [1:0] i_io_cell_frame_spim_csn_internal;
    wire [3:0] i_io_cell_frame_spim_miso_internal;
    wire [3:0] i_io_cell_frame_spim_mosi_internal;
    wire       i_io_cell_frame_spim_sck_internal;
    wire       i_io_cell_frame_uart_rx_internal;
    wire       i_io_cell_frame_uart_tx_internal;
    // i_pmod_mux port wires:
    wire [124:0] i_pmod_mux_cell_cfg_from_core;
    wire [124:0] i_pmod_mux_cell_cfg_to_io;
    wire [15:0] i_pmod_mux_gpio_from_core;
    wire [15:0] i_pmod_mux_gpio_from_io;
    wire [15:0] i_pmod_mux_gpio_to_core;
    wire [15:0] i_pmod_mux_gpio_to_io;
    wire [7:0] i_pmod_mux_pmod_sel;
    wire [15:0] i_pmod_mux_ss_0_pmod_gpi;
    wire [15:0] i_pmod_mux_ss_0_pmod_gpio_oe;
    wire [15:0] i_pmod_mux_ss_0_pmod_gpo;
    wire [15:0] i_pmod_mux_ss_1_pmod_gpi;
    wire [15:0] i_pmod_mux_ss_1_pmod_gpio_oe;
    wire [15:0] i_pmod_mux_ss_1_pmod_gpo;
    wire [15:0] i_pmod_mux_ss_2_pmod_gpi;
    wire [15:0] i_pmod_mux_ss_2_pmod_gpio_oe;
    wire [15:0] i_pmod_mux_ss_2_pmod_gpo;
    wire [15:0] i_pmod_mux_ss_3_pmod_gpi;
    wire [15:0] i_pmod_mux_ss_3_pmod_gpio_oe;
    wire [15:0] i_pmod_mux_ss_3_pmod_gpo;

    // Assignments for the ports of the encompassing component:
    assign clk = i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    assign high_speed_clk_internal = i_io_cell_frame_high_speed_clock_internal_to_high_speed_clock_internal_clk;
    assign irq_en_0 = SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_irq_en;
    assign irq_en_1 = SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_irq_en;
    assign irq_en_2 = SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_irq_en;
    assign irq_en_3 = SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_irq_en;
    assign irq_en_4 = SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl_irq_en;
    assign SysCtrl_SS_IRQ_to_IRQ_irq = irq_i;
    assign obi_addr = SysCtrl_SS_OBI_to_OBI_addr;
    assign obi_aid = SysCtrl_SS_OBI_to_OBI_aid;
    assign obi_be = SysCtrl_SS_OBI_to_OBI_be;
    assign SysCtrl_SS_OBI_to_OBI_err = obi_err;
    assign SysCtrl_SS_OBI_to_OBI_gnt = obi_gnt;
    assign SysCtrl_SS_OBI_to_OBI_gntpar = obi_gntpar;
    assign SysCtrl_SS_OBI_to_OBI_rdata = obi_rdata;
    assign obi_req = SysCtrl_SS_OBI_to_OBI_req;
    assign obi_reqpar = SysCtrl_SS_OBI_to_OBI_reqpar;
    assign SysCtrl_SS_OBI_to_OBI_rid[0] = obi_rid;
    assign obi_rready = SysCtrl_SS_OBI_to_OBI_rready;
    assign obi_rreadypar = SysCtrl_SS_OBI_to_OBI_rreadypar;
    assign SysCtrl_SS_OBI_to_OBI_rvalid = obi_rvalid;
    assign SysCtrl_SS_OBI_to_OBI_rvalidpar = obi_rvalidpar;
    assign obi_wdata = SysCtrl_SS_OBI_to_OBI_wdata;
    assign obi_we = SysCtrl_SS_OBI_to_OBI_we;
    assign reset_int = SysCtrl_SS_Reset_ICN_to_Reset_icn_reset;
    assign reset_ss = SysCtrl_SS_Reset_SS_to_Reset_SS_reset;
    assign ss_0_pmod_gpi = i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpi;
    assign i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpio_oe = ss_0_pmod_gpio_oe;
    assign i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpo = ss_0_pmod_gpo;
    assign ss_1_pmod_gpi = i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpi;
    assign i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpio_oe = ss_1_pmod_gpio_oe;
    assign i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpo = ss_1_pmod_gpo;
    assign ss_2_pmod_gpi = i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpi;
    assign i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpio_oe = ss_2_pmod_gpio_oe;
    assign i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpo = ss_2_pmod_gpo;
    assign ss_3_pmod_gpi = i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpi;
    assign i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpio_oe = ss_3_pmod_gpio_oe;
    assign i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpo = ss_3_pmod_gpo;
    assign ss_ctrl_0 = SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_clk_ctrl;
    assign ss_ctrl_1 = SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_clk_ctrl;
    assign ss_ctrl_2 = SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_clk_ctrl;
    assign ss_ctrl_3 = SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_clk_ctrl;
    assign ss_ctrl_4 = SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl_clk_ctrl;
    assign ss_ctrl_icn = SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl_clk_ctrl;

    // SysCtrl_SS assignments:
    assign SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg = SysCtrl_SS_cell_cfg;
    assign SysCtrl_SS_clk_internal = i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    assign i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo = SysCtrl_SS_gpio_from_core;
    assign SysCtrl_SS_gpio_to_core = i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi;
    assign SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_irq_en = SysCtrl_SS_irq_en_0;
    assign SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_irq_en = SysCtrl_SS_irq_en_1;
    assign SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_irq_en = SysCtrl_SS_irq_en_2;
    assign SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_irq_en = SysCtrl_SS_irq_en_3;
    assign SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl_irq_en = SysCtrl_SS_irq_en_4;
    assign SysCtrl_SS_jtag_tck_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tck;
    assign SysCtrl_SS_jtag_tdi_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdi;
    assign i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdo = SysCtrl_SS_jtag_tdo_internal;
    assign SysCtrl_SS_jtag_tms_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tms;
    assign SysCtrl_SS_jtag_trst_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_trst;
    assign SysCtrl_SS_OBI_to_OBI_addr = SysCtrl_SS_obi_addr;
    assign SysCtrl_SS_OBI_to_OBI_aid = SysCtrl_SS_obi_aid;
    assign SysCtrl_SS_OBI_to_OBI_be = SysCtrl_SS_obi_be;
    assign SysCtrl_SS_obi_err = SysCtrl_SS_OBI_to_OBI_err;
    assign SysCtrl_SS_obi_gnt = SysCtrl_SS_OBI_to_OBI_gnt;
    assign SysCtrl_SS_obi_gntpar = SysCtrl_SS_OBI_to_OBI_gntpar;
    assign SysCtrl_SS_obi_rdata = SysCtrl_SS_OBI_to_OBI_rdata;
    assign SysCtrl_SS_OBI_to_OBI_req = SysCtrl_SS_obi_req;
    assign SysCtrl_SS_OBI_to_OBI_reqpar = SysCtrl_SS_obi_reqpar;
    assign SysCtrl_SS_obi_rid = SysCtrl_SS_OBI_to_OBI_rid;
    assign SysCtrl_SS_OBI_to_OBI_rready = SysCtrl_SS_obi_rready;
    assign SysCtrl_SS_OBI_to_OBI_rreadypar = SysCtrl_SS_obi_rreadypar;
    assign SysCtrl_SS_obi_rvalid = SysCtrl_SS_OBI_to_OBI_rvalid;
    assign SysCtrl_SS_obi_rvalidpar = SysCtrl_SS_OBI_to_OBI_rvalidpar;
    assign SysCtrl_SS_OBI_to_OBI_wdata = SysCtrl_SS_obi_wdata;
    assign SysCtrl_SS_OBI_to_OBI_we = SysCtrl_SS_obi_we;
    assign i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo = SysCtrl_SS_pmod_sel;
    assign SysCtrl_SS_Reset_ICN_to_Reset_icn_reset = SysCtrl_SS_reset_icn;
    assign SysCtrl_SS_reset_internal = i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset_reset;
    assign SysCtrl_SS_Reset_SS_to_Reset_SS_reset = SysCtrl_SS_reset_ss;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_csn = SysCtrl_SS_spim_csn_internal;
    assign SysCtrl_SS_spim_miso_internal = i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_miso;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_mosi = SysCtrl_SS_spim_mosi_internal;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_sck = SysCtrl_SS_spim_sck_internal;
    assign SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_0;
    assign SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_1;
    assign SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_2;
    assign SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_3;
    assign SysCtrl_SS_ss_ctrl_4_to_ss_4_ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_4;
    assign SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_icn;
    assign SysCtrl_SS_sysctrl_irq_i = SysCtrl_SS_IRQ_to_IRQ_irq;
    assign SysCtrl_SS_uart_rx_internal = i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_rx;
    assign i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_tx = SysCtrl_SS_uart_tx_internal;
    // i_io_cell_frame assignments:
    assign i_io_cell_frame_cell_cfg = i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg;
    assign i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk = i_io_cell_frame_clk_internal;
    assign i_io_cell_frame_gpio_from_core = i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpo;
    assign i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpi = i_io_cell_frame_gpio_to_core;
    assign i_io_cell_frame_high_speed_clock_internal_to_high_speed_clock_internal_clk = i_io_cell_frame_high_speed_clk_internal;
    assign i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tck = i_io_cell_frame_jtag_tck_internal;
    assign i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdi = i_io_cell_frame_jtag_tdi_internal;
    assign i_io_cell_frame_jtag_tdo_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdo;
    assign i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tms = i_io_cell_frame_jtag_tms_internal;
    assign i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_trst = i_io_cell_frame_jtag_trst_internal;
    assign i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset_reset = i_io_cell_frame_reset_internal;
    assign i_io_cell_frame_spim_csn_internal = i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_csn;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_miso = i_io_cell_frame_spim_miso_internal;
    assign i_io_cell_frame_spim_mosi_internal = i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_mosi;
    assign i_io_cell_frame_spim_sck_internal = i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_sck;
    assign i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_rx = i_io_cell_frame_uart_rx_internal;
    assign i_io_cell_frame_uart_tx_internal = i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_tx;
    // i_pmod_mux assignments:
    assign i_pmod_mux_cell_cfg_from_core = SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg;
    assign i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg = i_pmod_mux_cell_cfg_to_io;
    assign i_pmod_mux_gpio_from_core = i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo;
    assign i_pmod_mux_gpio_from_io = i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpi;
    assign i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi = i_pmod_mux_gpio_to_core;
    assign i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpo = i_pmod_mux_gpio_to_io;
    assign i_pmod_mux_pmod_sel = i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo[7:0];
    assign i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpi = i_pmod_mux_ss_0_pmod_gpi;
    assign i_pmod_mux_ss_0_pmod_gpio_oe = i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpio_oe;
    assign i_pmod_mux_ss_0_pmod_gpo = i_pmod_mux_ss_0_pmod_gpio_to_ss_0_pmod_gpio_gpo;
    assign i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpi = i_pmod_mux_ss_1_pmod_gpi;
    assign i_pmod_mux_ss_1_pmod_gpio_oe = i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpio_oe;
    assign i_pmod_mux_ss_1_pmod_gpo = i_pmod_mux_ss_1_pmod_gpio_to_ss_1_pmod_gpio_gpo;
    assign i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpi = i_pmod_mux_ss_2_pmod_gpi;
    assign i_pmod_mux_ss_2_pmod_gpio_oe = i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpio_oe;
    assign i_pmod_mux_ss_2_pmod_gpo = i_pmod_mux_ss_2_pmod_gpio_to_ss_2_pmod_gpio_gpo;
    assign i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpi = i_pmod_mux_ss_3_pmod_gpi;
    assign i_pmod_mux_ss_3_pmod_gpio_oe = i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpio_oe;
    assign i_pmod_mux_ss_3_pmod_gpo = i_pmod_mux_ss_3_pmod_gpio_to_ss_3_pmod_gpio_gpo;

    // IP-XACT VLNV: tuni.fi:subsystem:SysCtrl_SS:1.1
    SysCtrl_SS_0 #(
        .IOCELL_CFG_W        (5),
        .IOCELL_COUNT        (25),
        .NUM_GPIO            (16),
        .SS_CTRL_W           (8),
        .OBI_IDW             (1),
        .OBI_CHKW            (1),
        .OBI_USERW           (1),
        .OBI_AW              (32),
        .OBI_DW              (32),
        .NUM_SS              (5))
    SysCtrl_SS(
        // Interface: Clk
        .clk_internal        (SysCtrl_SS_clk_internal),
        // Interface: GPIO
        .gpio_to_core        (SysCtrl_SS_gpio_to_core),
        .gpio_from_core      (SysCtrl_SS_gpio_from_core),
        // Interface: ICN_SS_Ctrl
        .ss_ctrl_icn         (SysCtrl_SS_ss_ctrl_icn),
        // Interface: IRQ
        .sysctrl_irq_i       (SysCtrl_SS_sysctrl_irq_i),
        // Interface: JTAG
        .jtag_tck_internal   (SysCtrl_SS_jtag_tck_internal),
        .jtag_tdi_internal   (SysCtrl_SS_jtag_tdi_internal),
        .jtag_tms_internal   (SysCtrl_SS_jtag_tms_internal),
        .jtag_trst_internal  (SysCtrl_SS_jtag_trst_internal),
        .jtag_tdo_internal   (SysCtrl_SS_jtag_tdo_internal),
        // Interface: OBI
        .obi_err             (SysCtrl_SS_obi_err),
        .obi_gnt             (SysCtrl_SS_obi_gnt),
        .obi_gntpar          (SysCtrl_SS_obi_gntpar),
        .obi_rdata           (SysCtrl_SS_obi_rdata),
        .obi_rid             (SysCtrl_SS_obi_rid),
        .obi_rvalid          (SysCtrl_SS_obi_rvalid),
        .obi_rvalidpar       (SysCtrl_SS_obi_rvalidpar),
        .obi_addr            (SysCtrl_SS_obi_addr),
        .obi_aid             (SysCtrl_SS_obi_aid),
        .obi_be              (SysCtrl_SS_obi_be),
        .obi_req             (SysCtrl_SS_obi_req),
        .obi_reqpar          (SysCtrl_SS_obi_reqpar),
        .obi_rready          (SysCtrl_SS_obi_rready),
        .obi_rreadypar       (SysCtrl_SS_obi_rreadypar),
        .obi_wdata           (SysCtrl_SS_obi_wdata),
        .obi_we              (SysCtrl_SS_obi_we),
        // Interface: Reset
        .reset_internal      (SysCtrl_SS_reset_internal),
        // Interface: Reset_ICN
        .reset_icn           (SysCtrl_SS_reset_icn),
        // Interface: Reset_SS
        .reset_ss            (SysCtrl_SS_reset_ss),
        // Interface: SPI
        .spim_miso_internal  (SysCtrl_SS_spim_miso_internal),
        .spim_csn_internal   (SysCtrl_SS_spim_csn_internal),
        .spim_mosi_internal  (SysCtrl_SS_spim_mosi_internal),
        .spim_sck_internal   (SysCtrl_SS_spim_sck_internal),
        // Interface: SS_Ctrl_0
        .irq_en_0            (SysCtrl_SS_irq_en_0),
        .ss_ctrl_0           (SysCtrl_SS_ss_ctrl_0),
        // Interface: SS_Ctrl_1
        .irq_en_1            (SysCtrl_SS_irq_en_1),
        .ss_ctrl_1           (SysCtrl_SS_ss_ctrl_1),
        // Interface: SS_Ctrl_2
        .irq_en_2            (SysCtrl_SS_irq_en_2),
        .ss_ctrl_2           (SysCtrl_SS_ss_ctrl_2),
        // Interface: SS_Ctrl_3
        .irq_en_3            (SysCtrl_SS_irq_en_3),
        .ss_ctrl_3           (SysCtrl_SS_ss_ctrl_3),
        // Interface: UART
        .uart_rx_internal    (SysCtrl_SS_uart_rx_internal),
        .uart_tx_internal    (SysCtrl_SS_uart_tx_internal),
        // Interface: io_cell_cfg
        .cell_cfg            (SysCtrl_SS_cell_cfg),
        // Interface: pmod_sel
        .pmod_sel            (SysCtrl_SS_pmod_sel),
        // Interface: ss_ctrl_4
        .irq_en_4            (SysCtrl_SS_irq_en_4),
        .ss_ctrl_4           (SysCtrl_SS_ss_ctrl_4),
        // These ports are not in any interface
        .irq_upper_tieoff    (15'h0));

    // IP-XACT VLNV: tuni.fi:subsystem.io:io_cell_frame_sysctrl:1.0
    io_cell_frame_sysctrl #(
        .IOCELL_CFG_W        (5),
        .IOCELL_COUNT        (25),
        .NUM_GPIO            (16))
    i_io_cell_frame(
        // Interface: Cfg
        .cell_cfg            (i_io_cell_frame_cell_cfg),
        // Interface: Clock
        .clk_in              (clock),
        // Interface: Clock_internal
        .clk_internal        (i_io_cell_frame_clk_internal),
        // Interface: GPIO
        .gpio                (gpio[15:0]),
        // Interface: GPIO_internal
        .gpio_from_core      (i_io_cell_frame_gpio_from_core),
        .gpio_to_core        (i_io_cell_frame_gpio_to_core),
        // Interface: JTAG
        .jtag_tck            (jtag_tck),
        .jtag_tdi            (jtag_tdi),
        .jtag_tdo            (jtag_tdo),
        .jtag_tms            (jtag_tms),
        .jtag_trst           (jtag_trst),
        // Interface: JTAG_internal
        .jtag_tdo_internal   (i_io_cell_frame_jtag_tdo_internal),
        .jtag_tck_internal   (i_io_cell_frame_jtag_tck_internal),
        .jtag_tdi_internal   (i_io_cell_frame_jtag_tdi_internal),
        .jtag_tms_internal   (i_io_cell_frame_jtag_tms_internal),
        .jtag_trst_internal  (i_io_cell_frame_jtag_trst_internal),
        // Interface: Reset
        .reset               (reset),
        // Interface: Reset_internal
        .reset_internal      (i_io_cell_frame_reset_internal),
        // Interface: SPI
        .spi_csn             (spi_csn[1:0]),
        .spi_data            (spi_data[3:0]),
        .spi_sck             (spi_sck),
        // Interface: SPI_internal
        .spim_csn_internal   (i_io_cell_frame_spim_csn_internal),
        .spim_mosi_internal  (i_io_cell_frame_spim_mosi_internal),
        .spim_sck_internal   (i_io_cell_frame_spim_sck_internal),
        .spim_miso_internal  (i_io_cell_frame_spim_miso_internal),
        // Interface: UART
        .uart_rx             (uart_rx),
        .uart_tx             (uart_tx),
        // Interface: UART_internal
        .uart_tx_internal    (i_io_cell_frame_uart_tx_internal),
        .uart_rx_internal    (i_io_cell_frame_uart_rx_internal),
        // Interface: high_speed_clock
        .high_speed_clk_n_i  (high_speed_clk_n_in),
        .high_speed_clk_p_i  (high_speed_clk_p_in),
        // Interface: high_speed_clock_internal
        .high_speed_clk_internal(i_io_cell_frame_high_speed_clk_internal));

    // IP-XACT VLNV: tuni.fi:ip:pmod_mux:1.0
    pmod_mux #(
        .IOCELL_CFG_W        (5),
        .IOCELL_COUNT        (25),
        .NUM_GPIO            (16))
    i_pmod_mux(
        // Interface: cell_cfg_from_core
        .cell_cfg_from_core  (i_pmod_mux_cell_cfg_from_core),
        // Interface: cell_cfg_to_io
        .cell_cfg_to_io      (i_pmod_mux_cell_cfg_to_io),
        // Interface: gpio_core
        .gpio_from_core      (i_pmod_mux_gpio_from_core),
        .gpio_to_core        (i_pmod_mux_gpio_to_core),
        // Interface: gpio_io
        .gpio_from_io        (i_pmod_mux_gpio_from_io),
        .gpio_to_io          (i_pmod_mux_gpio_to_io),
        // Interface: pmod_sel
        .pmod_sel            (i_pmod_mux_pmod_sel),
        // Interface: ss_0_pmod_gpio
        .ss_0_pmod_gpio_oe   (i_pmod_mux_ss_0_pmod_gpio_oe),
        .ss_0_pmod_gpo       (i_pmod_mux_ss_0_pmod_gpo),
        .ss_0_pmod_gpi       (i_pmod_mux_ss_0_pmod_gpi),
        // Interface: ss_1_pmod_gpio
        .ss_1_pmod_gpio_oe   (i_pmod_mux_ss_1_pmod_gpio_oe),
        .ss_1_pmod_gpo       (i_pmod_mux_ss_1_pmod_gpo),
        .ss_1_pmod_gpi       (i_pmod_mux_ss_1_pmod_gpi),
        // Interface: ss_2_pmod_gpio
        .ss_2_pmod_gpio_oe   (i_pmod_mux_ss_2_pmod_gpio_oe),
        .ss_2_pmod_gpo       (i_pmod_mux_ss_2_pmod_gpo),
        .ss_2_pmod_gpi       (i_pmod_mux_ss_2_pmod_gpi),
        // Interface: ss_3_pmod_gpio
        .ss_3_pmod_gpio_oe   (i_pmod_mux_ss_3_pmod_gpio_oe),
        .ss_3_pmod_gpo       (i_pmod_mux_ss_3_pmod_gpo),
        .ss_3_pmod_gpi       (i_pmod_mux_ss_3_pmod_gpi));


endmodule
