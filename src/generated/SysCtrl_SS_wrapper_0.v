//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_wrapper_0.v
// Creation date : 16.08.2024
// Creation time : 11:27:28
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.2 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.wrapper:SysCtrl_SS_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem.wrapper/SysCtrl_SS_wrapper/1.0/SysCtrl_SS_wrapper.1.0.xml
//-----------------------------------------------------------------------------

`ifdef VERILATOR
    `include "verification/verilator/src/hdl/nms/SysCtrl_SS_wrapper_0.sv"
`endif

module SysCtrl_SS_wrapper_0 #(
    parameter                              AXI4LITE_AW      = 32,
    parameter                              AXI4LITE_DW      = 32,
    parameter                              SS_CTRL_W        = 8,
    parameter                              NUM_GPIO         = 8,
    parameter                              IOCELL_COUNT     = 26,
    parameter                              IOCELL_CFGW      = 5
) (
    // Interface: AXI4LITE_icn
    input  logic                        icn_ar_ready_in,
    input  logic                        icn_aw_ready_in,
    input  logic         [1:0]          icn_b_resp_in,
    input  logic                        icn_b_valid_in,
    input  logic         [31:0]         icn_r_data_in,
    input  logic         [1:0]          icn_r_resp_in,
    input  logic                        icn_r_valid_in,
    input  logic                        icn_w_ready_in,
    output logic         [31:0]         icn_ar_addr_out,
    output logic                        icn_ar_valid_out,
    output logic         [31:0]         icn_aw_addr_out,
    output logic                        icn_aw_valid_out,
    output logic                        icn_b_ready_out,
    output logic                        icn_r_ready_out,
    output logic         [31:0]         icn_w_data_out,
    output logic         [3:0]          icn_w_strb_out,
    output logic                        icn_w_valid_out,

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
    `ifdef VERILATOR
        `include "verification/verilator/src/hdl/ms/SysCtrl_SS_wrapper_0.sv"
    `endif

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
    wire [129:0] i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg;
    // i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel wires:
    wire [7:0] i_pmod_mux_pmod_sel_to_SysCtrl_SS_pmod_sel_gpo;
    // i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO wires:
    wire [7:0] i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi;
    wire [7:0] i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo;
    // SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core wires:
    wire [129:0] SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg;
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
    // SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn wires:
    wire [31:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_ADDR;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_READY;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_VALID;
    wire [31:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_ADDR;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_READY;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_VALID;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_READY;
    wire [1:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_RESP;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_VALID;
    wire [31:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_DATA;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_READY;
    wire [1:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_RESP;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_VALID;
    wire [31:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_DATA;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_READY;
    wire [3:0] SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_STRB;
    wire       SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_VALID;

    // SysCtrl_SS port wires:
    wire       SysCtrl_SS_BootSel_internal;
    wire [129:0] SysCtrl_SS_cell_cfg;
    wire       SysCtrl_SS_clk_internal;
    wire       SysCtrl_SS_fetchEn_internal;
    wire [7:0] SysCtrl_SS_gpio_from_core;
    wire [7:0] SysCtrl_SS_gpio_to_core;
    wire [31:0] SysCtrl_SS_icn_ar_addr_out;
    wire       SysCtrl_SS_icn_ar_ready_in;
    wire       SysCtrl_SS_icn_ar_valid_out;
    wire [31:0] SysCtrl_SS_icn_aw_addr_out;
    wire       SysCtrl_SS_icn_aw_ready_in;
    wire       SysCtrl_SS_icn_aw_valid_out;
    wire       SysCtrl_SS_icn_b_ready_out;
    wire [1:0] SysCtrl_SS_icn_b_resp_in;
    wire       SysCtrl_SS_icn_b_valid_in;
    wire [31:0] SysCtrl_SS_icn_r_data_in;
    wire       SysCtrl_SS_icn_r_ready_out;
    wire [1:0] SysCtrl_SS_icn_r_resp_in;
    wire       SysCtrl_SS_icn_r_valid_in;
    wire [31:0] SysCtrl_SS_icn_w_data_out;
    wire       SysCtrl_SS_icn_w_ready_in;
    wire [3:0] SysCtrl_SS_icn_w_strb_out;
    wire       SysCtrl_SS_icn_w_valid_out;
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
    wire [129:0] i_io_cell_frame_cell_cfg;
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
    wire [129:0] i_pmod_mux_cell_cfg_from_core;
    wire [129:0] i_pmod_mux_cell_cfg_to_io;
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
    assign clk = i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    assign icn_ar_addr_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_ADDR;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_READY = icn_ar_ready_in;
    assign icn_ar_valid_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_VALID;
    assign icn_aw_addr_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_ADDR;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_READY = icn_aw_ready_in;
    assign icn_aw_valid_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_VALID;
    assign icn_b_ready_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_READY;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_RESP = icn_b_resp_in;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_VALID = icn_b_valid_in;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_DATA = icn_r_data_in;
    assign icn_r_ready_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_READY;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_RESP = icn_r_resp_in;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_VALID = icn_r_valid_in;
    assign icn_w_data_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_DATA;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_READY = icn_w_ready_in;
    assign icn_w_strb_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_STRB;
    assign icn_w_valid_out = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_VALID;
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
    assign SysCtrl_SS_BootSel_internal = i_io_cell_frame_BootSel_internal_to_SysCtrl_SS_BootSel_gpo;
    assign SysCtrl_SS_io_cell_cfg_to_i_pmod_mux_cell_cfg_from_core_cfg = SysCtrl_SS_cell_cfg;
    assign SysCtrl_SS_clk_internal = i_io_cell_frame_Clock_internal_to_SysCtrl_SS_Clk_clk;
    assign SysCtrl_SS_fetchEn_internal = i_io_cell_frame_FetchEn_internal_to_SysCtrl_SS_FetchEn_gpo;
    assign i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpo = SysCtrl_SS_gpio_from_core;
    assign SysCtrl_SS_gpio_to_core = i_pmod_mux_gpio_core_to_SysCtrl_SS_GPIO_gpi;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_ADDR = SysCtrl_SS_icn_ar_addr_out;
    assign SysCtrl_SS_icn_ar_ready_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_READY;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AR_VALID = SysCtrl_SS_icn_ar_valid_out;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_ADDR = SysCtrl_SS_icn_aw_addr_out;
    assign SysCtrl_SS_icn_aw_ready_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_READY;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_AW_VALID = SysCtrl_SS_icn_aw_valid_out;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_READY = SysCtrl_SS_icn_b_ready_out;
    assign SysCtrl_SS_icn_b_resp_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_RESP;
    assign SysCtrl_SS_icn_b_valid_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_B_VALID;
    assign SysCtrl_SS_icn_r_data_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_DATA;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_READY = SysCtrl_SS_icn_r_ready_out;
    assign SysCtrl_SS_icn_r_resp_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_RESP;
    assign SysCtrl_SS_icn_r_valid_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_R_VALID;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_DATA = SysCtrl_SS_icn_w_data_out;
    assign SysCtrl_SS_icn_w_ready_in = SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_READY;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_STRB = SysCtrl_SS_icn_w_strb_out;
    assign SysCtrl_SS_AXI4LITE_icn_to_AXI4LITE_icn_W_VALID = SysCtrl_SS_icn_w_valid_out;
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
    assign i_io_cell_frame_cell_cfg = i_pmod_mux_cell_cfg_to_io_to_i_io_cell_frame_Cfg_cfg;
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
    SysCtrl_SS_0 #(
        .AXI4LITE_AW         (32),
        .AXI4LITE_DW         (32),
        .IOCELL_CFG_W        (5),
        .IOCELL_COUNT        (26),
        .NUM_GPIO            (8),
        .SS_CTRL_W           (8))
    SysCtrl_SS(
        // Interface: AXI4LITE_icn
        .icn_ar_ready_in     (SysCtrl_SS_icn_ar_ready_in),
        .icn_aw_ready_in     (SysCtrl_SS_icn_aw_ready_in),
        .icn_b_resp_in       (SysCtrl_SS_icn_b_resp_in),
        .icn_b_valid_in      (SysCtrl_SS_icn_b_valid_in),
        .icn_r_data_in       (SysCtrl_SS_icn_r_data_in),
        .icn_r_resp_in       (SysCtrl_SS_icn_r_resp_in),
        .icn_r_valid_in      (SysCtrl_SS_icn_r_valid_in),
        .icn_w_ready_in      (SysCtrl_SS_icn_w_ready_in),
        .icn_ar_addr_out     (SysCtrl_SS_icn_ar_addr_out),
        .icn_ar_valid_out    (SysCtrl_SS_icn_ar_valid_out),
        .icn_aw_addr_out     (SysCtrl_SS_icn_aw_addr_out),
        .icn_aw_valid_out    (SysCtrl_SS_icn_aw_valid_out),
        .icn_b_ready_out     (SysCtrl_SS_icn_b_ready_out),
        .icn_r_ready_out     (SysCtrl_SS_icn_r_ready_out),
        .icn_w_data_out      (SysCtrl_SS_icn_w_data_out),
        .icn_w_strb_out      (SysCtrl_SS_icn_w_strb_out),
        .icn_w_valid_out     (SysCtrl_SS_icn_w_valid_out),
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
    io_cell_frame_sysctrl #(
        .IOCELL_CFG_W        (5),
        .IOCELL_COUNT        (26),
        .NUM_GPIO            (8))
    i_io_cell_frame(
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
    pmod_mux #(
        .IOCELL_CFG_W        (5),
        .IOCELL_COUNT        (26),
        .NUM_GPIO            (8))
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
