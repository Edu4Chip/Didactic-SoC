//-----------------------------------------------------------------------------
// File          : i_io_cell_frame.v
// Creation date : 02.02.2024
// Creation time : 12:20:14
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.0 64-bit
// Plugin : Verilog generator 2.4
// This file was origillay generated based on IP-XACT component tuni.fi:subsystem.io:i_io_cell_frame:1.0
// whose XML file ipxact/tuni.fi/subsystem.io/i_io_cell_frame/1.0/i_io_cell_frame.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * SoC io cells
*/


module i_io_cell_frame#(
    parameter IOCELL_CFG_W = 5
    // count and modify according to cells
    localparam IOCELL_COUNT = 25
  )
  (
    // Interface: BootSel
    inout     wire                         boot_sel,

    // Interface: BootSel_internal
    output    logic                          BootSel_internal,

    // Interface: Cfg
    input      logic          [(IOCELL_CFG_W*IOCELL_COUNT)-1:0]         cell_cfg,

    // Interface: Clock
    inout     wire                          clk_in,

    // Interface: Clock_internal
    output   logic                           clk_internal,

    // Interface: FetchEn
    inout     wire                          fetch_en,

    // Interface: FetchEn_internal
    output     logic                         fetchEn_internal,

    // Interface: GPIO
    inout     wire           [3:0]          gpio,

    // Interface: GPIO_internal
    input     logic           [3:0]          gpio_from_core,
    output    logic           [3:0]          gpio_to_core,

    // Interface: JTAG
    inout         wire                      jtag_tck,
    inout        wire                       jtag_tdi,    // Data can be daisy chained or routed directly back
    inout        wire                       jtag_tdo,    // Data can be daisy chained or routed directly back
    inout       wire                        jtag_tms,
    inout       wire                        jtag_trst,

    // Interface: JTAG_internal
    input        logic                       jtag_tdo_internal,
    output       logic                       jtag_tck_internal,
    output       logic                       jtag_tdi_internal,
    output       logic                       jtag_tms_internal,
    output       logic                       jtag_trst_internal,

    // Interface: Reset
    inout          wire                     reset,

    // Interface: Reset_internal
    output       logic                       reset_internal,

    // Interface: SDIO
    inout         wire                      sdio_clk,
    inout         wire                      sdio_cmd,
    inout        wire        [3:0]          sdio_data,

    // Interface: SDIO_internal
    input         logic                      sdio_clk_internal,
    input         logic                      sdio_cmd_internal,
    input        logic        [3:0]          sdio_data_o_internal,
    output        logic       [3:0]          sdio_data_i_internal,

    // Interface: SPI
    inout         wire       [1:0]          spi_csn,
    inout         wire       [3:0]          spi_data,
    inout         wire                      spi_sck,

    // Interface: SPI_internal
    input       logic         [1:0]          spim_csn_internal,
    input      logic          [3:0]          spim_mosi_internal,
    input      logic                         spim_sck_internal,
    output      logic         [3:0]          spim_miso_internal,

    // Interface: UART
    inout          wire                     uart_rx,
    inout          wire                     uart_tx,

    // Interface: UART_internal
    input      logic                         uart_tx_internal,
    output     logic                         uart_rx_internal
);

// bootSel
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(BootSel_internal), .PAD(boot_sel), .io_cell_cfg(cell_cfg[1*IOCELL_CFG_W-1:0*IOCELL_CFG_W]));

// clk
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(clk_internal), .PAD(clk_in), .io_cell_cfg(cell_cfg[2*IOCELL_CFG_W-1:1*IOCELL_CFG_W]));

// fetchEn
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(fetch_en), .PAD(fetchEn_internal), .io_cell_cfg(cell_cfg[3*IOCELL_CFG_W-1:2*IOCELL_CFG_W]));

// gpio
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(gpio_from_core[0]), .TO_CORE(gpio_to_core[0]), .PAD(gpio[0]), .io_cell_cfg(cell_cfg[4*IOCELL_CFG_W-1:3*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(gpio_from_core[1]), .TO_CORE(gpio_to_core[1]), .PAD(gpio[1]), .io_cell_cfg(cell_cfg[5*IOCELL_CFG_W-1:4*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(gpio_from_core[2]), .TO_CORE(gpio_to_core[2]), .PAD(gpio[2]), .io_cell_cfg(cell_cfg[6*IOCELL_CFG_W-1:5*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(gpio_from_core[2]), .TO_CORE(gpio_to_core[3]), .PAD(gpio[3]), .io_cell_cfg(cell_cfg[7*IOCELL_CFG_W-1:6*IOCELL_CFG_W]));

// jtag
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(jtag_tck_internal), .PAD(jtag_tck), .io_cell_cfg(cell_cfg[8*IOCELL_CFG_W-1:7*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(jtag_tms_internal), .PAD(jtag_tms), .io_cell_cfg(cell_cfg[9*IOCELL_CFG_W-1:8*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(jtag_trst_internal), .PAD(jtag_trst), .io_cell_cfg(cell_cfg[10*IOCELL_CFG_W-1:9*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(jtag_tdi_internal), .PAD(jtag_tdi), .io_cell_cfg(cell_cfg[11*IOCELL_CFG_W-1:10*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(jtag_tdo_internal), .TO_CORE(), .PAD(jtag_tdo), .io_cell_cfg(cell_cfg[12*IOCELL_CFG_W-1:11*IOCELL_CFG_W]));

// reset
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(1'b0), .TO_CORE(reset_internal), .PAD(reset), .io_cell_cfg(cell_cfg[13*IOCELL_CFG_W-1:12*IOCELL_CFG_W]));

// sdio
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(sdio_clk_internal), .TO_CORE(), .PAD(sdio_clk), .io_cell_cfg(cell_cfg[14*IOCELL_CFG_W-1:13*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(sdio_cmd_internal), .TO_CORE(), .PAD(sdio_cmd), .io_cell_cfg(cell_cfg[15*IOCELL_CFG_W-1:14*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(sdio_data_o_internal[0]), .TO_CORE(sdio_data_i_internal[0]), .PAD(sdio_data[0]), .io_cell_cfg(cell_cfg[16*IOCELL_CFG_W-1:15*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(sdio_data_o_internal[1]), .TO_CORE(sdio_data_i_internal[1]), .PAD(sdio_data[1]), .io_cell_cfg(cell_cfg[17*IOCELL_CFG_W-1:16*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(sdio_data_o_internal[2]), .TO_CORE(sdio_data_i_internal[2]), .PAD(sdio_data[2]), .io_cell_cfg(cell_cfg[18*IOCELL_CFG_W-1:17*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(sdio_data_o_internal[3]), .TO_CORE(sdio_data_i_internal[3]), .PAD(sdio_data[3]), .io_cell_cfg(cell_cfg[19*IOCELL_CFG_W-1:18*IOCELL_CFG_W]));

// spi
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_sck_internal), .TO_CORE(), .PAD(spi_sck), .io_cell_cfg(cell_cfg[20*IOCELL_CFG_W-1:19*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_csn_internal[1]), .TO_CORE(), .PAD(spi_csn[0]), .io_cell_cfg(cell_cfg[21*IOCELL_CFG_W-1:20*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_csn_internal[1]), .TO_CORE(), .PAD(spi_csn[1]), .io_cell_cfg(cell_cfg[22*IOCELL_CFG_W-1:21*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_mosi_internal[0]), .TO_CORE(spim_miso_internal[0]), .PAD(spi_data[0]), .io_cell_cfg(cell_cfg[23*IOCELL_CFG_W-1:22*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_mosi_internal[1]), .TO_CORE(spim_miso_internal[1]), .PAD(spi_data[1]), .io_cell_cfg(cell_cfg[24*IOCELL_CFG_W-1:23*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_mosi_internal[2]), .TO_CORE(spim_miso_internal[2]), .PAD(spi_data[2]), .io_cell_cfg(cell_cfg[25*IOCELL_CFG_W-1:24*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_(.FROM_CORE(spim_mosi_internal[3]), .TO_CORE(spim_miso_internal[3]), .PAD(spi_data[3]), .io_cell_cfg(cell_cfg[26*IOCELL_CFG_W-1:25*IOCELL_CFG_W]));

// uart
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_uart_rx(.FROM_CORE(1'b0), .TO_CORE(uart_rx_internal), .PAD(uart_rx), .io_cell_cfg(cell_cfg[27*IOCELL_CFG_W-1:26*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_uart_tx(.FROM_CORE(uart_tx_internal), .TO_CORE(), .PAD(uart_tx), .io_cell_cfg(cell_cfg[28*IOCELL_CFG_W-1:27*IOCELL_CFG_W]));

endmodule
