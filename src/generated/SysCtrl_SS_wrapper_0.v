//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_wrapper_0.v
// Creation date : 02.07.2024
// Creation time : 13:51:03
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.2 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:SysCtrl_SS_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/SysCtrl_SS_wrapper/1.0/SysCtrl_SS_wrapper.1.0.xml
//-----------------------------------------------------------------------------

module SysCtrl_SS_wrapper_0 #(
    parameter                              AXI_AW           = 32,
    parameter                              AXI_DW           = 32,
    parameter                              AXI_IDW          = 10,
    parameter                              AXI_USERW        = 1,
    parameter                              IOCELL_CFG_W     = 5,
    parameter                              IOCELL_COUNT     = 28
) (
    // Interface: AXI
    input  logic                        AR_READY,
    input  logic                        AW_READY,
    input  logic         [9:0]          B_ID,
    input  logic         [1:0]          B_RESP,
    input  logic                        B_USER,
    input  logic                        B_VALID,
    input  logic         [31:0]         R_DATA,
    input  logic         [9:0]          R_ID,
    input  logic                        R_LAST,
    input  logic         [1:0]          R_RESP,
    input  logic         [1:0]          R_USER,
    input  logic                        R_VALID,
    input  logic                        W_READY,
    output logic         [31:0]         AR_ADDR,
    output logic         [1:0]          AR_BURST,
    output logic         [3:0]          AR_CACHE,
    output logic         [9:0]          AR_ID,
    output logic         [7:0]          AR_LEN,
    output logic                        AR_LOCK,
    output logic         [2:0]          AR_PROT,
    output logic         [3:0]          AR_QOS,
    output logic         [2:0]          AR_REGION,
    output logic         [2:0]          AR_SIZE,
    output logic                        AR_USER,
    output logic                        AR_VALID,
    output logic         [31:0]         AW_ADDR,
    output logic         [5:0]          AW_ATOP,
    output logic         [1:0]          AW_BURST,
    output logic         [3:0]          AW_CACHE,
    output logic         [9:0]          AW_ID,
    output logic         [7:0]          AW_LEN,
    output logic                        AW_LOCK,
    output logic         [2:0]          AW_PROT,
    output logic         [3:0]          AW_QOS,
    output logic         [3:0]          AW_REGION,
    output logic         [2:0]          AW_SIZE,
    output logic                        AW_USER,
    output logic                        AW_VALID,
    output logic                        B_READY,
    output logic                        R_READY,
    output logic         [31:0]         W_DATA,
    output logic                        W_LAST,
    output logic         [3:0]          W_STROBE,
    output logic                        W_USER,
    output logic                        W_VALID,

    // Interface: BootSel
    inout  wire                         boot_sel,

    // Interface: Clock
    inout  logic                        clock,

    // Interface: Clock_int
    output logic                        clk,

    // Interface: FetchEn
    inout  wire                         fetch_en,

    // Interface: GPIO
    inout  wire          [7:0]          gpio,

    // Interface: ICN_SS_Ctrl
    output logic         [7:0]          ss_ctrl_icn,

    // Interface: IRQ0
    input  logic                        irq_0,

    // Interface: IRQ1
    input  logic                        irq_1,

    // Interface: IRQ2
    input  logic                        irq_2,

    // Interface: IRQ3
    input  logic                        irq_3,

    // Interface: JTAG
    inout  wire                         jtag_tck,
    inout  wire                         jtag_tdi,    // Data can be daisy chained or routed directly back
    inout  wire                         jtag_tdo,    // Data can be daisy chained or routed directly back
    inout  wire                         jtag_tms,
    inout  wire                         jtag_trst,

    // Interface: Reset
    inout  wire                         reset,

    // Interface: Reset_SS_0
    output logic                        reset_ss_0,

    // Interface: Reset_SS_1
    output logic                        reset_ss_1,

    // Interface: Reset_SS_2
    output logic                        reset_ss_2,

    // Interface: Reset_SS_3
    output logic                        reset_ss_3,

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

    // Interface: ss_0_pmod_gpio_0
    input  logic         [3:0]          ss_0_pmo_0_gpio_oe,
    input  logic         [3:0]          ss_0_pmo_0_gpo,
    output logic         [3:0]          ss_0_pmo_0_gpi,

    // Interface: ss_0_pmod_gpio_1
    input  logic         [3:0]          ss_0_pmo_1_gpio_oe,
    input  logic         [3:0]          ss_0_pmo_1_gpo,
    output logic         [3:0]          ss_0_pmo_1_gpi,

    // Interface: ss_1_pmod_gpio_0
    input  logic         [3:0]          ss_1_pmod_0_gpio_oe,
    input  logic         [3:0]          ss_1_pmod_0_gpo,
    output logic         [3:0]          ss_1_pmod_0_gpi,

    // Interface: ss_1_pmod_gpio_1
    input  logic         [3:0]          ss_1_pmod_1_gpio_oe,
    input  logic         [3:0]          ss_1_pmod_1_gpo,
    output logic         [3:0]          ss_1_pmod_1_gpi,

    // Interface: ss_2_pmod_gpio_0
    input  logic         [3:0]          ss_2_pmod_0_gpio_oe,
    input  logic         [3:0]          ss_2_pmod_0_gpo,
    output logic         [3:0]          ss_2_pmod_0_gpi,

    // Interface: ss_2_pmod_gpio_1
    input  logic         [3:0]          ss_2_pmod_1_gpio_oe,
    input  logic         [3:0]          ss_2_pmod_1_gpo,
    output logic         [3:0]          ss_2_pmod_1_gpi,

    // Interface: ss_3_pmod_gpio_0
    input  logic         [3:0]          ss_3_pmod_0_gpio_oe,
    input  logic         [3:0]          ss_3_pmod_0_gpo,
    output logic         [3:0]          ss_3_pmod_0_gpi,

    // Interface: ss_3_pmod_gpio_1
    input  logic         [3:0]          ss_3_pmod_1_gpio_oe,
    input  logic         [3:0]          ss_3_pmod_1_gpo,
    output logic         [3:0]          ss_3_pmod_1_gpi
);

    // SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl wires:
    wire [7:0] SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl_clk_ctrl;
    // SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_irq_en;
    // SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_irq_en;
    // SysCtrl_SS_IRQ0_to_IRQ0 wires:
    wire       SysCtrl_SS_IRQ0_to_IRQ0_irq;
    // SysCtrl_SS_IRQ3_to_IRQ3 wires:
    wire       SysCtrl_SS_IRQ3_to_IRQ3_irq;
    // SysCtrl_SS_IRQ2_to_IRQ2 wires:
    wire       SysCtrl_SS_IRQ2_to_IRQ2_irq;
    // SysCtrl_SS_IRQ1_to_IRQ1 wires:
    wire       SysCtrl_SS_IRQ1_to_IRQ1_irq;
    // SysCtrl_SS_AXI_to_AXI wires:
    wire [31:0] SysCtrl_SS_AXI_to_AXI_AR_ADDR;
    wire [1:0] SysCtrl_SS_AXI_to_AXI_AR_BURST;
    wire [3:0] SysCtrl_SS_AXI_to_AXI_AR_CACHE;
    wire [9:0] SysCtrl_SS_AXI_to_AXI_AR_ID;
    wire [7:0] SysCtrl_SS_AXI_to_AXI_AR_LEN;
    wire       SysCtrl_SS_AXI_to_AXI_AR_LOCK;
    wire [2:0] SysCtrl_SS_AXI_to_AXI_AR_PROT;
    wire [3:0] SysCtrl_SS_AXI_to_AXI_AR_QOS;
    wire       SysCtrl_SS_AXI_to_AXI_AR_READY;
    wire [2:0] SysCtrl_SS_AXI_to_AXI_AR_REGION;
    wire [2:0] SysCtrl_SS_AXI_to_AXI_AR_SIZE;
    wire       SysCtrl_SS_AXI_to_AXI_AR_USER;
    wire       SysCtrl_SS_AXI_to_AXI_AR_VALID;
    wire [31:0] SysCtrl_SS_AXI_to_AXI_AW_ADDR;
    wire [5:0] SysCtrl_SS_AXI_to_AXI_AW_ATOP;
    wire [1:0] SysCtrl_SS_AXI_to_AXI_AW_BURST;
    wire [3:0] SysCtrl_SS_AXI_to_AXI_AW_CACHE;
    wire [9:0] SysCtrl_SS_AXI_to_AXI_AW_ID;
    wire [7:0] SysCtrl_SS_AXI_to_AXI_AW_LEN;
    wire       SysCtrl_SS_AXI_to_AXI_AW_LOCK;
    wire [2:0] SysCtrl_SS_AXI_to_AXI_AW_PROT;
    wire [3:0] SysCtrl_SS_AXI_to_AXI_AW_QOS;
    wire       SysCtrl_SS_AXI_to_AXI_AW_READY;
    wire [3:0] SysCtrl_SS_AXI_to_AXI_AW_REGION;
    wire [2:0] SysCtrl_SS_AXI_to_AXI_AW_SIZE;
    wire       SysCtrl_SS_AXI_to_AXI_AW_USER;
    wire       SysCtrl_SS_AXI_to_AXI_AW_VALID;
    wire [9:0] SysCtrl_SS_AXI_to_AXI_B_ID;
    wire       SysCtrl_SS_AXI_to_AXI_B_READY;
    wire [1:0] SysCtrl_SS_AXI_to_AXI_B_RESP;
    wire       SysCtrl_SS_AXI_to_AXI_B_USER;
    wire       SysCtrl_SS_AXI_to_AXI_B_VALID;
    wire [31:0] SysCtrl_SS_AXI_to_AXI_R_DATA;
    wire [9:0] SysCtrl_SS_AXI_to_AXI_R_ID;
    wire       SysCtrl_SS_AXI_to_AXI_R_LAST;
    wire       SysCtrl_SS_AXI_to_AXI_R_READY;
    wire [1:0] SysCtrl_SS_AXI_to_AXI_R_RESP;
    wire [1:0] SysCtrl_SS_AXI_to_AXI_R_USER;
    wire       SysCtrl_SS_AXI_to_AXI_R_VALID;
    wire [31:0] SysCtrl_SS_AXI_to_AXI_W_DATA;
    wire       SysCtrl_SS_AXI_to_AXI_W_LAST;
    wire       SysCtrl_SS_AXI_to_AXI_W_READY;
    wire [3:0] SysCtrl_SS_AXI_to_AXI_W_STROBE;
    wire       SysCtrl_SS_AXI_to_AXI_W_USER;
    wire       SysCtrl_SS_AXI_to_AXI_W_VALID;
    // i_io_cell_frame_JTAG_to_JTAG wires:
    // i_io_cell_frame_UART_to_UART wires:
    // i_io_cell_frame_GPIO_to_GPIO wires:
    // i_io_cell_frame_SPI_to_SPI wires:
    // i_io_cell_frame_Reset_to_Reset wires:
    // i_io_cell_frame_Clock_to_Clock wires:
    // i_io_cell_frame_FetchEn_to_FetchEn wires:
    // i_io_cell_frame_BootSel_to_BootSel wires:
    // i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG wires:
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tck;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdi;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdo;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tms;
    wire       i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_trst;
    // i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk wires:
    wire       i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    // i_io_cell_frame_BootSel_internal_to_SysCtrl_SS_BootSel wires:
    wire       i_io_cell_frame_BootSel_internal_to_SysCtrl_SS_BootSel_gpo;
    // i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI wires:
    wire [1:0] i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_csn;
    wire [3:0] i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_miso;
    wire [3:0] i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_mosi;
    wire       i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_sck;
    // i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART wires:
    wire       i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_rx;
    wire       i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_tx;
    // i_io_cell_frame_FetchEn_internal_to_SysCtrl_SS_FetchEn wires:
    wire       i_io_cell_frame_FetchEn_internal_to_SysCtrl_SS_FetchEn_gpo;
    // i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset wires:
    wire       i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset_reset;
    // SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_irq_en;
    // SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl wires:
    wire [7:0] SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_clk_ctrl;
    wire       SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_irq_en;
    // SysCtrl_SS_Reset_SS_0_to_bus_3 wires:
    wire       SysCtrl_SS_Reset_SS_0_to_bus_3_reset;
    // SysCtrl_SS_Reset_SS_3_to_bus wires:
    wire       SysCtrl_SS_Reset_SS_3_to_bus_reset;
    // SysCtrl_SS_Reset_SS_1_to_bus_2 wires:
    wire       SysCtrl_SS_Reset_SS_1_to_bus_2_reset;
    // SysCtrl_SS_Reset_SS_2_to_bus_1 wires:
    wire       SysCtrl_SS_Reset_SS_2_to_bus_1_reset;
    // SysCtrl_SS_Reset_ICN_to_Reset_icn wires:
    wire       SysCtrl_SS_Reset_ICN_to_Reset_icn_reset;
    // i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg wires:
    wire [139:0] i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg;
    // i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel wires:
    wire [7:0] i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo;
    // i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO wires:
    wire [7:0] i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi;
    wire [7:0] i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo;
    // SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core wires:
    wire [139:0] SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg;
    // i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal wires:
    wire [7:0] i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpi;
    wire [7:0] i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpo;
    // i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0 wires:
    wire [3:0] i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpi;
    wire [3:0] i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpo;
    // i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1 wires:
    wire [3:0] i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpi;
    wire [3:0] i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpo;
    // i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0 wires:
    wire [3:0] i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpi;
    wire [3:0] i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpo;
    // i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1 wires:
    wire [3:0] i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpi;
    wire [3:0] i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpo;
    // i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0 wires:
    wire [3:0] i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpi;
    wire [3:0] i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpo;
    // i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1 wires:
    wire [3:0] i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpi;
    wire [3:0] i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpo;
    // i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0 wires:
    wire [3:0] i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpi;
    wire [3:0] i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpo;
    // i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1 wires:
    wire [3:0] i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpi;
    wire [3:0] i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpo;

    // SysCtrl_SS port wires:
    wire [31:0] SysCtrl_SS_AR_ADDR;
    wire [1:0] SysCtrl_SS_AR_BURST;
    wire [3:0] SysCtrl_SS_AR_CACHE;
    wire [9:0] SysCtrl_SS_AR_ID;
    wire [7:0] SysCtrl_SS_AR_LEN;
    wire       SysCtrl_SS_AR_LOCK;
    wire [2:0] SysCtrl_SS_AR_PROT;
    wire [3:0] SysCtrl_SS_AR_QOS;
    wire       SysCtrl_SS_AR_READY;
    wire [2:0] SysCtrl_SS_AR_REGION;
    wire [2:0] SysCtrl_SS_AR_SIZE;
    wire       SysCtrl_SS_AR_USER;
    wire       SysCtrl_SS_AR_VALID;
    wire [31:0] SysCtrl_SS_AW_ADDR;
    wire [5:0] SysCtrl_SS_AW_ATOP;
    wire [1:0] SysCtrl_SS_AW_BURST;
    wire [3:0] SysCtrl_SS_AW_CACHE;
    wire [9:0] SysCtrl_SS_AW_ID;
    wire [7:0] SysCtrl_SS_AW_LEN;
    wire       SysCtrl_SS_AW_LOCK;
    wire [2:0] SysCtrl_SS_AW_PROT;
    wire [3:0] SysCtrl_SS_AW_QOS;
    wire       SysCtrl_SS_AW_READY;
    wire [3:0] SysCtrl_SS_AW_REGION;
    wire [2:0] SysCtrl_SS_AW_SIZE;
    wire       SysCtrl_SS_AW_USER;
    wire       SysCtrl_SS_AW_VALID;
    wire [9:0] SysCtrl_SS_B_ID;
    wire       SysCtrl_SS_B_READY;
    wire [1:0] SysCtrl_SS_B_RESP;
    wire       SysCtrl_SS_B_USER;
    wire       SysCtrl_SS_B_VALID;
    wire       SysCtrl_SS_BootSel_internal;
    wire [31:0] SysCtrl_SS_R_DATA;
    wire [9:0] SysCtrl_SS_R_ID;
    wire       SysCtrl_SS_R_LAST;
    wire       SysCtrl_SS_R_READY;
    wire [1:0] SysCtrl_SS_R_RESP;
    wire       SysCtrl_SS_R_USER;
    wire       SysCtrl_SS_R_VALID;
    wire [31:0] SysCtrl_SS_W_DATA;
    wire       SysCtrl_SS_W_LAST;
    wire       SysCtrl_SS_W_READY;
    wire [3:0] SysCtrl_SS_W_STROBE;
    wire       SysCtrl_SS_W_USER;
    wire       SysCtrl_SS_W_VALID;
    wire [139:0] SysCtrl_SS_cell_cfg;
    wire       SysCtrl_SS_clk_internal;
    wire       SysCtrl_SS_fetchEn_internal;
    wire [7:0] SysCtrl_SS_gpio_from_core;
    wire [7:0] SysCtrl_SS_gpio_to_core;
    wire       SysCtrl_SS_irq_0;
    wire       SysCtrl_SS_irq_1;
    wire       SysCtrl_SS_irq_2;
    wire       SysCtrl_SS_irq_3;
    wire       SysCtrl_SS_irq_en_0;
    wire       SysCtrl_SS_irq_en_1;
    wire       SysCtrl_SS_irq_en_2;
    wire       SysCtrl_SS_irq_en_3;
    wire       SysCtrl_SS_jtag_tck_internal;
    wire       SysCtrl_SS_jtag_tdi_internal;
    wire       SysCtrl_SS_jtag_tdo_internal;
    wire       SysCtrl_SS_jtag_tms_internal;
    wire       SysCtrl_SS_jtag_trst_internal;
    wire [7:0] SysCtrl_SS_pmod_sel;
    wire       SysCtrl_SS_reset_icn;
    wire       SysCtrl_SS_reset_internal;
    wire       SysCtrl_SS_reset_ss_0;
    wire       SysCtrl_SS_reset_ss_1;
    wire       SysCtrl_SS_reset_ss_2;
    wire       SysCtrl_SS_reset_ss_3;
    wire [1:0] SysCtrl_SS_spim_csn_internal;
    wire [3:0] SysCtrl_SS_spim_miso_internal;
    wire [3:0] SysCtrl_SS_spim_mosi_internal;
    wire       SysCtrl_SS_spim_sck_internal;
    wire [7:0] SysCtrl_SS_ss_ctrl_0;
    wire [7:0] SysCtrl_SS_ss_ctrl_1;
    wire [7:0] SysCtrl_SS_ss_ctrl_2;
    wire [7:0] SysCtrl_SS_ss_ctrl_3;
    wire [7:0] SysCtrl_SS_ss_ctrl_icn;
    wire       SysCtrl_SS_uart_rx_internal;
    wire       SysCtrl_SS_uart_tx_internal;
    // i_io_cell_frame port wires:
    wire       i_io_cell_frame_BootSel_internal;
    wire [119:0] i_io_cell_frame_cell_cfg;
    wire       i_io_cell_frame_clk_internal;
    wire       i_io_cell_frame_fetchEn_internal;
    wire [7:0] i_io_cell_frame_gpio_from_core;
    wire [7:0] i_io_cell_frame_gpio_to_core;
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
    wire [139:0] i_pmod_mux_cell_cfg_from_core;
    wire [139:0] i_pmod_mux_cell_cfg_to_io;
    wire [7:0] i_pmod_mux_gpio_from_core;
    wire [7:0] i_pmod_mux_gpio_from_io;
    wire [7:0] i_pmod_mux_gpio_to_core;
    wire [7:0] i_pmod_mux_gpio_to_io;
    wire [7:0] i_pmod_mux_pmod_sel;
    wire [3:0] i_pmod_mux_ss_0_pmod_0_gpi;
    wire [3:0] i_pmod_mux_ss_0_pmod_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_0_pmod_0_gpo;
    wire [3:0] i_pmod_mux_ss_0_pmod_1_gpi;
    wire [3:0] i_pmod_mux_ss_0_pmod_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_0_pmod_1_gpo;
    wire [3:0] i_pmod_mux_ss_1_pmod_0_gpi;
    wire [3:0] i_pmod_mux_ss_1_pmod_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_1_pmod_0_gpo;
    wire [3:0] i_pmod_mux_ss_1_pmod_1_gpi;
    wire [3:0] i_pmod_mux_ss_1_pmod_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_1_pmod_1_gpo;
    wire [3:0] i_pmod_mux_ss_2_pmod_0_gpi;
    wire [3:0] i_pmod_mux_ss_2_pmod_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_2_pmod_0_gpo;
    wire [3:0] i_pmod_mux_ss_2_pmod_1_gpi;
    wire [3:0] i_pmod_mux_ss_2_pmod_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_2_pmod_1_gpo;
    wire [3:0] i_pmod_mux_ss_3_pmod_0_gpi;
    wire [3:0] i_pmod_mux_ss_3_pmod_0_gpio_oe;
    wire [3:0] i_pmod_mux_ss_3_pmod_0_gpo;
    wire [3:0] i_pmod_mux_ss_3_pmod_1_gpi;
    wire [3:0] i_pmod_mux_ss_3_pmod_1_gpio_oe;
    wire [3:0] i_pmod_mux_ss_3_pmod_1_gpo;

    // Assignments for the ports of the encompassing component:
    assign AR_ADDR = SysCtrl_SS_AXI_to_AXI_AR_ADDR;
    assign AR_BURST = SysCtrl_SS_AXI_to_AXI_AR_BURST;
    assign AR_CACHE = SysCtrl_SS_AXI_to_AXI_AR_CACHE;
    assign AR_ID = SysCtrl_SS_AXI_to_AXI_AR_ID;
    assign AR_LEN = SysCtrl_SS_AXI_to_AXI_AR_LEN;
    assign AR_LOCK = SysCtrl_SS_AXI_to_AXI_AR_LOCK;
    assign AR_PROT = SysCtrl_SS_AXI_to_AXI_AR_PROT;
    assign AR_QOS = SysCtrl_SS_AXI_to_AXI_AR_QOS;
    assign SysCtrl_SS_AXI_to_AXI_AR_READY = AR_READY;
    assign AR_REGION = SysCtrl_SS_AXI_to_AXI_AR_REGION;
    assign AR_SIZE = SysCtrl_SS_AXI_to_AXI_AR_SIZE;
    assign AR_USER = SysCtrl_SS_AXI_to_AXI_AR_USER;
    assign AR_VALID = SysCtrl_SS_AXI_to_AXI_AR_VALID;
    assign AW_ADDR = SysCtrl_SS_AXI_to_AXI_AW_ADDR;
    assign AW_ATOP = SysCtrl_SS_AXI_to_AXI_AW_ATOP;
    assign AW_BURST = SysCtrl_SS_AXI_to_AXI_AW_BURST;
    assign AW_CACHE = SysCtrl_SS_AXI_to_AXI_AW_CACHE;
    assign AW_ID = SysCtrl_SS_AXI_to_AXI_AW_ID;
    assign AW_LEN = SysCtrl_SS_AXI_to_AXI_AW_LEN;
    assign AW_LOCK = SysCtrl_SS_AXI_to_AXI_AW_LOCK;
    assign AW_PROT = SysCtrl_SS_AXI_to_AXI_AW_PROT;
    assign AW_QOS = SysCtrl_SS_AXI_to_AXI_AW_QOS;
    assign SysCtrl_SS_AXI_to_AXI_AW_READY = AW_READY;
    assign AW_REGION = SysCtrl_SS_AXI_to_AXI_AW_REGION;
    assign AW_SIZE = SysCtrl_SS_AXI_to_AXI_AW_SIZE;
    assign AW_USER = SysCtrl_SS_AXI_to_AXI_AW_USER;
    assign AW_VALID = SysCtrl_SS_AXI_to_AXI_AW_VALID;
    assign SysCtrl_SS_AXI_to_AXI_B_ID = B_ID;
    assign B_READY = SysCtrl_SS_AXI_to_AXI_B_READY;
    assign SysCtrl_SS_AXI_to_AXI_B_RESP = B_RESP;
    assign SysCtrl_SS_AXI_to_AXI_B_USER = B_USER;
    assign SysCtrl_SS_AXI_to_AXI_B_VALID = B_VALID;
    assign SysCtrl_SS_AXI_to_AXI_R_DATA = R_DATA;
    assign SysCtrl_SS_AXI_to_AXI_R_ID = R_ID;
    assign SysCtrl_SS_AXI_to_AXI_R_LAST = R_LAST;
    assign R_READY = SysCtrl_SS_AXI_to_AXI_R_READY;
    assign SysCtrl_SS_AXI_to_AXI_R_RESP = R_RESP;
    assign SysCtrl_SS_AXI_to_AXI_R_USER = R_USER;
    assign SysCtrl_SS_AXI_to_AXI_R_VALID = R_VALID;
    assign W_DATA = SysCtrl_SS_AXI_to_AXI_W_DATA;
    assign W_LAST = SysCtrl_SS_AXI_to_AXI_W_LAST;
    assign SysCtrl_SS_AXI_to_AXI_W_READY = W_READY;
    assign W_STROBE = SysCtrl_SS_AXI_to_AXI_W_STROBE;
    assign W_USER = SysCtrl_SS_AXI_to_AXI_W_USER;
    assign W_VALID = SysCtrl_SS_AXI_to_AXI_W_VALID;
    assign clk = i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    assign SysCtrl_SS_IRQ0_to_IRQ0_irq = irq_0;
    assign SysCtrl_SS_IRQ1_to_IRQ1_irq = irq_1;
    assign SysCtrl_SS_IRQ2_to_IRQ2_irq = irq_2;
    assign SysCtrl_SS_IRQ3_to_IRQ3_irq = irq_3;
    assign irq_en_0 = SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_irq_en;
    assign irq_en_1 = SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_irq_en;
    assign irq_en_2 = SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_irq_en;
    assign irq_en_3 = SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_irq_en;
    assign reset_int = SysCtrl_SS_Reset_ICN_to_Reset_icn_reset;
    assign reset_ss_0 = SysCtrl_SS_Reset_SS_0_to_bus_3_reset;
    assign reset_ss_1 = SysCtrl_SS_Reset_SS_1_to_bus_2_reset;
    assign reset_ss_2 = SysCtrl_SS_Reset_SS_2_to_bus_1_reset;
    assign reset_ss_3 = SysCtrl_SS_Reset_SS_3_to_bus_reset;
    assign ss_0_pmo_0_gpi = i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpi;
    assign i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpio_oe = ss_0_pmo_0_gpio_oe;
    assign i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpo = ss_0_pmo_0_gpo;
    assign ss_0_pmo_1_gpi = i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpi;
    assign i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpio_oe = ss_0_pmo_1_gpio_oe;
    assign i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpo = ss_0_pmo_1_gpo;
    assign ss_1_pmod_0_gpi = i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpi;
    assign i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpio_oe = ss_1_pmod_0_gpio_oe;
    assign i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpo = ss_1_pmod_0_gpo;
    assign ss_1_pmod_1_gpi = i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpi;
    assign i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpio_oe = ss_1_pmod_1_gpio_oe;
    assign i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpo = ss_1_pmod_1_gpo;
    assign ss_2_pmod_0_gpi = i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpi;
    assign i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpio_oe = ss_2_pmod_0_gpio_oe;
    assign i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpo = ss_2_pmod_0_gpo;
    assign ss_2_pmod_1_gpi = i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpi;
    assign i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpio_oe = ss_2_pmod_1_gpio_oe;
    assign i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpo = ss_2_pmod_1_gpo;
    assign ss_3_pmod_0_gpi = i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpi;
    assign i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpio_oe = ss_3_pmod_0_gpio_oe;
    assign i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpo = ss_3_pmod_0_gpo;
    assign ss_3_pmod_1_gpi = i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpi;
    assign i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpio_oe = ss_3_pmod_1_gpio_oe;
    assign i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpo = ss_3_pmod_1_gpo;
    assign ss_ctrl_0 = SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_clk_ctrl;
    assign ss_ctrl_1 = SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_clk_ctrl;
    assign ss_ctrl_2 = SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_clk_ctrl;
    assign ss_ctrl_3 = SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_clk_ctrl;
    assign ss_ctrl_icn = SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl_clk_ctrl;

    // SysCtrl_SS assignments:
    assign SysCtrl_SS_AXI_to_AXI_AR_ADDR = SysCtrl_SS_AR_ADDR;
    assign SysCtrl_SS_AXI_to_AXI_AR_BURST = SysCtrl_SS_AR_BURST;
    assign SysCtrl_SS_AXI_to_AXI_AR_CACHE = SysCtrl_SS_AR_CACHE;
    assign SysCtrl_SS_AXI_to_AXI_AR_ID = SysCtrl_SS_AR_ID;
    assign SysCtrl_SS_AXI_to_AXI_AR_LEN = SysCtrl_SS_AR_LEN;
    assign SysCtrl_SS_AXI_to_AXI_AR_LOCK = SysCtrl_SS_AR_LOCK;
    assign SysCtrl_SS_AXI_to_AXI_AR_PROT = SysCtrl_SS_AR_PROT;
    assign SysCtrl_SS_AXI_to_AXI_AR_QOS = SysCtrl_SS_AR_QOS;
    assign SysCtrl_SS_AR_READY = SysCtrl_SS_AXI_to_AXI_AR_READY;
    assign SysCtrl_SS_AXI_to_AXI_AR_REGION = SysCtrl_SS_AR_REGION;
    assign SysCtrl_SS_AXI_to_AXI_AR_SIZE = SysCtrl_SS_AR_SIZE;
    assign SysCtrl_SS_AXI_to_AXI_AR_USER = SysCtrl_SS_AR_USER;
    assign SysCtrl_SS_AXI_to_AXI_AR_VALID = SysCtrl_SS_AR_VALID;
    assign SysCtrl_SS_AXI_to_AXI_AW_ADDR = SysCtrl_SS_AW_ADDR;
    assign SysCtrl_SS_AXI_to_AXI_AW_ATOP = SysCtrl_SS_AW_ATOP;
    assign SysCtrl_SS_AXI_to_AXI_AW_BURST = SysCtrl_SS_AW_BURST;
    assign SysCtrl_SS_AXI_to_AXI_AW_CACHE = SysCtrl_SS_AW_CACHE;
    assign SysCtrl_SS_AXI_to_AXI_AW_ID = SysCtrl_SS_AW_ID;
    assign SysCtrl_SS_AXI_to_AXI_AW_LEN = SysCtrl_SS_AW_LEN;
    assign SysCtrl_SS_AXI_to_AXI_AW_LOCK = SysCtrl_SS_AW_LOCK;
    assign SysCtrl_SS_AXI_to_AXI_AW_PROT = SysCtrl_SS_AW_PROT;
    assign SysCtrl_SS_AXI_to_AXI_AW_QOS = SysCtrl_SS_AW_QOS;
    assign SysCtrl_SS_AW_READY = SysCtrl_SS_AXI_to_AXI_AW_READY;
    assign SysCtrl_SS_AXI_to_AXI_AW_REGION = SysCtrl_SS_AW_REGION;
    assign SysCtrl_SS_AXI_to_AXI_AW_SIZE = SysCtrl_SS_AW_SIZE;
    assign SysCtrl_SS_AXI_to_AXI_AW_USER = SysCtrl_SS_AW_USER;
    assign SysCtrl_SS_AXI_to_AXI_AW_VALID = SysCtrl_SS_AW_VALID;
    assign SysCtrl_SS_B_ID = SysCtrl_SS_AXI_to_AXI_B_ID;
    assign SysCtrl_SS_AXI_to_AXI_B_READY = SysCtrl_SS_B_READY;
    assign SysCtrl_SS_B_RESP = SysCtrl_SS_AXI_to_AXI_B_RESP;
    assign SysCtrl_SS_B_USER = SysCtrl_SS_AXI_to_AXI_B_USER;
    assign SysCtrl_SS_B_VALID = SysCtrl_SS_AXI_to_AXI_B_VALID;
    assign SysCtrl_SS_BootSel_internal = i_io_cell_frame_BootSel_internal_to_SysCtrl_SS_BootSel_gpo;
    assign SysCtrl_SS_R_DATA = SysCtrl_SS_AXI_to_AXI_R_DATA;
    assign SysCtrl_SS_R_ID = SysCtrl_SS_AXI_to_AXI_R_ID;
    assign SysCtrl_SS_R_LAST = SysCtrl_SS_AXI_to_AXI_R_LAST;
    assign SysCtrl_SS_AXI_to_AXI_R_READY = SysCtrl_SS_R_READY;
    assign SysCtrl_SS_R_RESP = SysCtrl_SS_AXI_to_AXI_R_RESP;
    assign SysCtrl_SS_R_USER = SysCtrl_SS_AXI_to_AXI_R_USER[0];
    assign SysCtrl_SS_R_VALID = SysCtrl_SS_AXI_to_AXI_R_VALID;
    assign SysCtrl_SS_AXI_to_AXI_W_DATA = SysCtrl_SS_W_DATA;
    assign SysCtrl_SS_AXI_to_AXI_W_LAST = SysCtrl_SS_W_LAST;
    assign SysCtrl_SS_W_READY = SysCtrl_SS_AXI_to_AXI_W_READY;
    assign SysCtrl_SS_AXI_to_AXI_W_STROBE = SysCtrl_SS_W_STROBE;
    assign SysCtrl_SS_AXI_to_AXI_W_USER = SysCtrl_SS_W_USER;
    assign SysCtrl_SS_AXI_to_AXI_W_VALID = SysCtrl_SS_W_VALID;
    assign SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg = SysCtrl_SS_cell_cfg;
    assign SysCtrl_SS_clk_internal = i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    assign SysCtrl_SS_fetchEn_internal = i_io_cell_frame_FetchEn_internal_to_SysCtrl_SS_FetchEn_gpo;
    assign i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo = SysCtrl_SS_gpio_from_core;
    assign SysCtrl_SS_gpio_to_core = i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi;
    assign SysCtrl_SS_irq_0 = SysCtrl_SS_IRQ0_to_IRQ0_irq;
    assign SysCtrl_SS_irq_1 = SysCtrl_SS_IRQ1_to_IRQ1_irq;
    assign SysCtrl_SS_irq_2 = SysCtrl_SS_IRQ2_to_IRQ2_irq;
    assign SysCtrl_SS_irq_3 = SysCtrl_SS_IRQ3_to_IRQ3_irq;
    assign SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_irq_en = SysCtrl_SS_irq_en_0;
    assign SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_irq_en = SysCtrl_SS_irq_en_1;
    assign SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_irq_en = SysCtrl_SS_irq_en_2;
    assign SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_irq_en = SysCtrl_SS_irq_en_3;
    assign SysCtrl_SS_jtag_tck_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tck;
    assign SysCtrl_SS_jtag_tdi_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdi;
    assign i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tdo = SysCtrl_SS_jtag_tdo_internal;
    assign SysCtrl_SS_jtag_tms_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_tms;
    assign SysCtrl_SS_jtag_trst_internal = i_io_cell_frame_JTAG_internal_to_SysCtrl_SS_JTAG_trst;
    assign i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo = SysCtrl_SS_pmod_sel;
    assign SysCtrl_SS_Reset_ICN_to_Reset_icn_reset = SysCtrl_SS_reset_icn;
    assign SysCtrl_SS_reset_internal = i_io_cell_frame_Reset_internal_to_SysCtrl_SS_Reset_reset;
    assign SysCtrl_SS_Reset_SS_0_to_bus_3_reset = SysCtrl_SS_reset_ss_0;
    assign SysCtrl_SS_Reset_SS_1_to_bus_2_reset = SysCtrl_SS_reset_ss_1;
    assign SysCtrl_SS_Reset_SS_2_to_bus_1_reset = SysCtrl_SS_reset_ss_2;
    assign SysCtrl_SS_Reset_SS_3_to_bus_reset = SysCtrl_SS_reset_ss_3;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_csn = SysCtrl_SS_spim_csn_internal;
    assign SysCtrl_SS_spim_miso_internal = i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_miso;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_mosi = SysCtrl_SS_spim_mosi_internal;
    assign i_io_cell_frame_SPI_internal_to_SysCtrl_SS_SPI_sck = SysCtrl_SS_spim_sck_internal;
    assign SysCtrl_SS_SS_Ctrl_0_to_SS_0_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_0;
    assign SysCtrl_SS_SS_Ctrl_1_to_SS_1_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_1;
    assign SysCtrl_SS_SS_Ctrl_2_to_SS_2_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_2;
    assign SysCtrl_SS_SS_Ctrl_3_to_SS_3_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_3;
    assign SysCtrl_SS_ICN_SS_Ctrl_to_ICN_SS_Ctrl_clk_ctrl = SysCtrl_SS_ss_ctrl_icn;
    assign SysCtrl_SS_uart_rx_internal = i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_rx;
    assign i_io_cell_frame_UART_internal_to_SysCtrl_SS_UART_uart_tx = SysCtrl_SS_uart_tx_internal;
    // i_io_cell_frame assignments:
    assign i_io_cell_frame_BootSel_internal_to_SysCtrl_SS_BootSel_gpo = i_io_cell_frame_BootSel_internal;
    assign i_io_cell_frame_cell_cfg = i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg[119:0];
    assign i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk = i_io_cell_frame_clk_internal;
    assign i_io_cell_frame_FetchEn_internal_to_SysCtrl_SS_FetchEn_gpo = i_io_cell_frame_fetchEn_internal;
    assign i_io_cell_frame_gpio_from_core = i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpo;
    assign i_pmod_mux_gpio_io_to_i_io_cell_frame_GPIO_internal_gpi = i_io_cell_frame_gpio_to_core;
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
    assign i_pmod_mux_pmod_sel = i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo;
    assign i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpi = i_pmod_mux_ss_0_pmod_0_gpi;
    assign i_pmod_mux_ss_0_pmod_0_gpio_oe = i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpio_oe;
    assign i_pmod_mux_ss_0_pmod_0_gpo = i_pmod_mux_ss_0_pmod_0_to_ss_0_pmod_gpio_0_gpo;
    assign i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpi = i_pmod_mux_ss_0_pmod_1_gpi;
    assign i_pmod_mux_ss_0_pmod_1_gpio_oe = i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpio_oe;
    assign i_pmod_mux_ss_0_pmod_1_gpo = i_pmod_mux_ss_0_pmod_1_to_ss_0_pmod_gpio_1_gpo;
    assign i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpi = i_pmod_mux_ss_1_pmod_0_gpi;
    assign i_pmod_mux_ss_1_pmod_0_gpio_oe = i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpio_oe;
    assign i_pmod_mux_ss_1_pmod_0_gpo = i_pmod_mux_ss_1_pmod_0_to_ss_1_pmod_gpio_0_gpo;
    assign i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpi = i_pmod_mux_ss_1_pmod_1_gpi;
    assign i_pmod_mux_ss_1_pmod_1_gpio_oe = i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpio_oe;
    assign i_pmod_mux_ss_1_pmod_1_gpo = i_pmod_mux_ss_1_pmod_1_to_ss_1_pmod_gpio_1_gpo;
    assign i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpi = i_pmod_mux_ss_2_pmod_0_gpi;
    assign i_pmod_mux_ss_2_pmod_0_gpio_oe = i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpio_oe;
    assign i_pmod_mux_ss_2_pmod_0_gpo = i_pmod_mux_ss_2_pmod_0_to_ss_2_pmod_gpio_0_gpo;
    assign i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpi = i_pmod_mux_ss_2_pmod_1_gpi;
    assign i_pmod_mux_ss_2_pmod_1_gpio_oe = i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpio_oe;
    assign i_pmod_mux_ss_2_pmod_1_gpo = i_pmod_mux_ss_2_pmod_1_to_ss_2_pmod_gpio_1_gpo;
    assign i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpi = i_pmod_mux_ss_3_pmod_0_gpi;
    assign i_pmod_mux_ss_3_pmod_0_gpio_oe = i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpio_oe;
    assign i_pmod_mux_ss_3_pmod_0_gpo = i_pmod_mux_ss_3_pmod_0_to_ss_3_pmod_gpio_0_gpo;
    assign i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpi = i_pmod_mux_ss_3_pmod_1_gpi;
    assign i_pmod_mux_ss_3_pmod_1_gpio_oe = i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpio_oe;
    assign i_pmod_mux_ss_3_pmod_1_gpo = i_pmod_mux_ss_3_pmod_1_to_ss_3_pmod_gpio_1_gpo;

    // IP-XACT VLNV: tuni.fi:subsystem:SysCtrl_SS:1.0
    SysCtrl_SS_0     SysCtrl_SS(
        // Interface: AXI
        .AR_READY            (SysCtrl_SS_AR_READY),
        .AW_READY            (SysCtrl_SS_AW_READY),
        .B_ID                (SysCtrl_SS_B_ID),
        .B_RESP              (SysCtrl_SS_B_RESP),
        .B_USER              (SysCtrl_SS_B_USER),
        .B_VALID             (SysCtrl_SS_B_VALID),
        .R_DATA              (SysCtrl_SS_R_DATA),
        .R_ID                (SysCtrl_SS_R_ID),
        .R_LAST              (SysCtrl_SS_R_LAST),
        .R_RESP              (SysCtrl_SS_R_RESP),
        .R_USER              (SysCtrl_SS_R_USER),
        .R_VALID             (SysCtrl_SS_R_VALID),
        .W_READY             (SysCtrl_SS_W_READY),
        .AR_ADDR             (SysCtrl_SS_AR_ADDR),
        .AR_BURST            (SysCtrl_SS_AR_BURST),
        .AR_CACHE            (SysCtrl_SS_AR_CACHE),
        .AR_ID               (SysCtrl_SS_AR_ID),
        .AR_LEN              (SysCtrl_SS_AR_LEN),
        .AR_LOCK             (SysCtrl_SS_AR_LOCK),
        .AR_PROT             (SysCtrl_SS_AR_PROT),
        .AR_QOS              (SysCtrl_SS_AR_QOS),
        .AR_REGION           (SysCtrl_SS_AR_REGION),
        .AR_SIZE             (SysCtrl_SS_AR_SIZE),
        .AR_USER             (SysCtrl_SS_AR_USER),
        .AR_VALID            (SysCtrl_SS_AR_VALID),
        .AW_ADDR             (SysCtrl_SS_AW_ADDR),
        .AW_ATOP             (SysCtrl_SS_AW_ATOP),
        .AW_BURST            (SysCtrl_SS_AW_BURST),
        .AW_CACHE            (SysCtrl_SS_AW_CACHE),
        .AW_ID               (SysCtrl_SS_AW_ID),
        .AW_LEN              (SysCtrl_SS_AW_LEN),
        .AW_LOCK             (SysCtrl_SS_AW_LOCK),
        .AW_PROT             (SysCtrl_SS_AW_PROT),
        .AW_QOS              (SysCtrl_SS_AW_QOS),
        .AW_REGION           (SysCtrl_SS_AW_REGION),
        .AW_SIZE             (SysCtrl_SS_AW_SIZE),
        .AW_USER             (SysCtrl_SS_AW_USER),
        .AW_VALID            (SysCtrl_SS_AW_VALID),
        .B_READY             (SysCtrl_SS_B_READY),
        .R_READY             (SysCtrl_SS_R_READY),
        .W_DATA              (SysCtrl_SS_W_DATA),
        .W_LAST              (SysCtrl_SS_W_LAST),
        .W_STROBE            (SysCtrl_SS_W_STROBE),
        .W_USER              (SysCtrl_SS_W_USER),
        .W_VALID             (SysCtrl_SS_W_VALID),
        // Interface: BootSel
        .BootSel_internal    (SysCtrl_SS_BootSel_internal),
        // Interface: Clk
        .clk_internal        (SysCtrl_SS_clk_internal),
        // Interface: FetchEn
        .fetchEn_internal    (SysCtrl_SS_fetchEn_internal),
        // Interface: GPIO
        .gpio_to_core        (SysCtrl_SS_gpio_to_core),
        .gpio_from_core      (SysCtrl_SS_gpio_from_core),
        // Interface: ICN_SS_Ctrl
        .ss_ctrl_icn         (SysCtrl_SS_ss_ctrl_icn),
        // Interface: IRQ0
        .irq_0               (SysCtrl_SS_irq_0),
        // Interface: IRQ1
        .irq_1               (SysCtrl_SS_irq_1),
        // Interface: IRQ2
        .irq_2               (SysCtrl_SS_irq_2),
        // Interface: IRQ3
        .irq_3               (SysCtrl_SS_irq_3),
        // Interface: JTAG
        .jtag_tck_internal   (SysCtrl_SS_jtag_tck_internal),
        .jtag_tdi_internal   (SysCtrl_SS_jtag_tdi_internal),
        .jtag_tms_internal   (SysCtrl_SS_jtag_tms_internal),
        .jtag_trst_internal  (SysCtrl_SS_jtag_trst_internal),
        .jtag_tdo_internal   (SysCtrl_SS_jtag_tdo_internal),
        // Interface: Reset
        .reset_internal      (SysCtrl_SS_reset_internal),
        // Interface: Reset_ICN
        .reset_icn           (SysCtrl_SS_reset_icn),
        // Interface: Reset_SS_0
        .reset_ss_0          (SysCtrl_SS_reset_ss_0),
        // Interface: Reset_SS_1
        .reset_ss_1          (SysCtrl_SS_reset_ss_1),
        // Interface: Reset_SS_2
        .reset_ss_2          (SysCtrl_SS_reset_ss_2),
        // Interface: Reset_SS_3
        .reset_ss_3          (SysCtrl_SS_reset_ss_3),
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
        // These ports are not in any interface
        .irq_upper_tieoff    (15'h0));

    // IP-XACT VLNV: tuni.fi:subsystem.io:io_cell_frame_sysctrl:1.0
    io_cell_frame_sysctrl     i_io_cell_frame(
        // Interface: BootSel
        .boot_sel            (boot_sel),
        // Interface: BootSel_internal
        .BootSel_internal    (i_io_cell_frame_BootSel_internal),
        // Interface: Cfg
        .cell_cfg            (i_io_cell_frame_cell_cfg),
        // Interface: Clock
        .clk_in              (clock),
        // Interface: Clock_internal
        .clk_internal        (i_io_cell_frame_clk_internal),
        // Interface: FetchEn
        .fetch_en            (fetch_en),
        // Interface: FetchEn_internal
        .fetchEn_internal    (i_io_cell_frame_fetchEn_internal),
        // Interface: GPIO
        .gpio                (gpio[7:0]),
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
        .uart_rx_internal    (i_io_cell_frame_uart_rx_internal));

    // IP-XACT VLNV: tuni.fi:ip:pmod_mux:1.0
    pmod_mux     i_pmod_mux(
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
        // Interface: ss_0_pmod_0
        .ss_0_pmod_0_gpio_oe (i_pmod_mux_ss_0_pmod_0_gpio_oe),
        .ss_0_pmod_0_gpo     (i_pmod_mux_ss_0_pmod_0_gpo),
        .ss_0_pmod_0_gpi     (i_pmod_mux_ss_0_pmod_0_gpi),
        // Interface: ss_0_pmod_1
        .ss_0_pmod_1_gpio_oe (i_pmod_mux_ss_0_pmod_1_gpio_oe),
        .ss_0_pmod_1_gpo     (i_pmod_mux_ss_0_pmod_1_gpo),
        .ss_0_pmod_1_gpi     (i_pmod_mux_ss_0_pmod_1_gpi),
        // Interface: ss_1_pmod_0
        .ss_1_pmod_0_gpio_oe (i_pmod_mux_ss_1_pmod_0_gpio_oe),
        .ss_1_pmod_0_gpo     (i_pmod_mux_ss_1_pmod_0_gpo),
        .ss_1_pmod_0_gpi     (i_pmod_mux_ss_1_pmod_0_gpi),
        // Interface: ss_1_pmod_1
        .ss_1_pmod_1_gpio_oe (i_pmod_mux_ss_1_pmod_1_gpio_oe),
        .ss_1_pmod_1_gpo     (i_pmod_mux_ss_1_pmod_1_gpo),
        .ss_1_pmod_1_gpi     (i_pmod_mux_ss_1_pmod_1_gpi),
        // Interface: ss_2_pmod_0
        .ss_2_pmod_0_gpio_oe (i_pmod_mux_ss_2_pmod_0_gpio_oe),
        .ss_2_pmod_0_gpo     (i_pmod_mux_ss_2_pmod_0_gpo),
        .ss_2_pmod_0_gpi     (i_pmod_mux_ss_2_pmod_0_gpi),
        // Interface: ss_2_pmod_1
        .ss_2_pmod_1_gpio_oe (i_pmod_mux_ss_2_pmod_1_gpio_oe),
        .ss_2_pmod_1_gpo     (i_pmod_mux_ss_2_pmod_1_gpo),
        .ss_2_pmod_1_gpi     (i_pmod_mux_ss_2_pmod_1_gpi),
        // Interface: ss_3_pmod_0
        .ss_3_pmod_0_gpio_oe (i_pmod_mux_ss_3_pmod_0_gpio_oe),
        .ss_3_pmod_0_gpo     (i_pmod_mux_ss_3_pmod_0_gpo),
        .ss_3_pmod_0_gpi     (i_pmod_mux_ss_3_pmod_0_gpi),
        // Interface: ss_3_pmod_1
        .ss_3_pmod_1_gpio_oe (i_pmod_mux_ss_3_pmod_1_gpio_oe),
        .ss_3_pmod_1_gpo     (i_pmod_mux_ss_3_pmod_1_gpo),
        .ss_3_pmod_1_gpi     (i_pmod_mux_ss_3_pmod_1_gpi));


endmodule
