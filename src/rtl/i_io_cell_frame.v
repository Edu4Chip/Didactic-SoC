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
    parameter CONF_WIDTH = 5
    // count and modify according to cells
    localparam NUMBER_OF_CELLS = 25
  )
  (
    // Interface: BootSel
    inout     wire                         boot_sel,

    // Interface: BootSel_internal
    output    logic                          BootSel_internal,

    // Interface: Cfg
    input      logic          [49:0]         cell_cfg,

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
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// clk
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// fetchEn
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// gpio
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// jtag
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// reset
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// sdio
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// spi
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_(.FROM_CORE(), .TO_CORE(), .PAD(), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

// uart
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_uart_rx(.FROM_CORE(1'b0), .TO_CORE(uart_rx_internal), .PAD(uart_rx), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));
io_cell_wrapper#(.CELL_TYPE(0), .CONF_WIDTH(CONF_WIDTH)) i_io_cell_uart_tx(.FROM_CORE(uart_tx_internal), .TO_CORE(), .PAD(uart_tx), .io_cell_cfg(cell_cfg[1*CONF_WIDTH-1:0*CONF_WIDTH]));

endmodule
