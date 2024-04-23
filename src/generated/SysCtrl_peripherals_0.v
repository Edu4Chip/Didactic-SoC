//-----------------------------------------------------------------------------
// File          : SysCtrl_peripherals_0.v
// Creation date : 23.04.2024
// Creation time : 13:25:40
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:SysCtrl_peripherals:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/ip/SysCtrl_peripherals/1.0/SysCtrl_peripherals.1.0.xml
//-----------------------------------------------------------------------------

module SysCtrl_peripherals_0 #(
    parameter                              AXI4LITE_DW      = 32,
    parameter                              AXI4LITE_AW      = 32
) (
    // Interface: AXI4LITE
    input                [31:0]         ar_addr,
    input                [2:0]          ar_prot,
    input                               ar_valid,
    input                [31:0]         aw_addr,
    input                [2:0]          aw_prot,
    input                               aw_valid,
    input                               b_ready,
    input                               r_ready,
    input                [31:0]         w_data,
    input                [3:0]          w_strb,
    input                               w_valid,
    output                              ar_ready,
    output                              aw_ready,
    output               [1:0]          b_resp,
    output                              b_valid,
    output               [31:0]         r_data,
    output               [1:0]          r_resp,
    output                              r_valid,
    output                              w_ready,

    // Interface: Clock
    input                               clk,

    // Interface: GPIO
    input                [3:0]          gpio_to_core,
    output               [3:0]          gpio_from_core,

    // Interface: IRQ_GPIO
    output                              irq_gpio,

    // Interface: IRQ_SPI
    output               [1:0]          irq_spi,

    // Interface: IRQ_UART
    output                              irq_uart,

    // Interface: Reset
    input                               rst_n,

    // Interface: SDIO
    input                [3:0]          sdio_data_i_internal,
    output                              sdio_clk_internal,
    output                              sdio_cmd_internal,
    output               [3:0]          sdio_data_o_internal,

    // Interface: SPI
    input                [3:0]          spim_miso_internal,
    output               [1:0]          spim_csn_internal,
    output               [3:0]          spim_mosi_internal,
    output                              spim_sck_internal,

    // Interface: UART
    input                               uart_rx_internal,
    output                              uart_tx_internal
);

    // APB_SPI_SPI_to_SPI wires:
    wire [3:0] APB_SPI_SPI_to_SPI_csn;
    wire [1:0] APB_SPI_SPI_to_SPI_data_oe;
    wire [3:0] APB_SPI_SPI_to_SPI_miso;
    wire [3:0] APB_SPI_SPI_to_SPI_mosi;
    wire       APB_SPI_SPI_to_SPI_sck;
    // APB_SPI_IRQ_to_IRQ_SPI wires:
    wire [1:0] APB_SPI_IRQ_to_IRQ_SPI_irq;
    // APB_SPI_Clock_to_Clock wires:
    wire       APB_SPI_Clock_to_Clock_clk;
    // APB_SPI_Reset_n_to_Reset wires:
    wire       APB_SPI_Reset_n_to_Reset_reset;
    // AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB wires:
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PADDR;
    wire       AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PENABLE;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PRDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PREADY;
    wire       AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PSEL;
    wire       AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PSLVERR;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PWDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PWRITE;
    // AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB wires:
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PADDR;
    wire       AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PENABLE;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PRDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PREADY;
    wire       AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PSEL;
    wire       AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PSLVERR;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PWDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PWRITE;
    // APB_GPIO_GPIO_to_GPIO wires:
    wire [3:0] APB_GPIO_GPIO_to_GPIO_gpi;
    wire [3:0] APB_GPIO_GPIO_to_GPIO_gpio_oe;
    wire [3:0] APB_GPIO_GPIO_to_GPIO_gpo;
    // APB_GPIO_IRQ_to_IRQ_GPIO wires:
    wire       APB_GPIO_IRQ_to_IRQ_GPIO_irq;
    // AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB wires:
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PADDR;
    wire       AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PENABLE;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PRDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PREADY;
    wire       AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PSEL;
    wire       AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PSLVERR;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PWDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PWRITE;
    // APB_SDIO_SDIO_to_SDIO wires:
    wire       APB_SDIO_SDIO_to_SDIO_clk;
    wire       APB_SDIO_SDIO_to_SDIO_cmd;
    wire [3:0] APB_SDIO_SDIO_to_SDIO_data_i;
    wire [3:0] APB_SDIO_SDIO_to_SDIO_data_o;
    // AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE wires:
    wire [31:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_ADDR;
    wire [2:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_PROT;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_READY;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_VALID;
    wire [31:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_ADDR;
    wire [2:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_PROT;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_READY;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_VALID;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_READY;
    wire [1:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_RESP;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_VALID;
    wire [31:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_DATA;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_READY;
    wire [1:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_RESP;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_VALID;
    wire [31:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_DATA;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_READY;
    wire [3:0] AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_STRB;
    wire       AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_VALID;
    // AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB wires:
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PADDR;
    wire       AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PENABLE;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PRDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PREADY;
    wire       AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PSEL;
    wire       AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PSLVERR;
    wire [31:0] AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PWDATA;
    wire       AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PWRITE;
    // APB_UART_UART_to_UART wires:
    wire       APB_UART_UART_to_UART_uart_rx;
    wire       APB_UART_UART_to_UART_uart_tx;
    // APB_UART_IRQ_to_IRQ_UART wires:
    wire       APB_UART_IRQ_to_IRQ_UART_irq;

    // APB_GPIO port wires:
    wire       APB_GPIO_HCLK;
    wire       APB_GPIO_HRESETn;
    wire [11:0] APB_GPIO_PADDR;
    wire       APB_GPIO_PENABLE;
    wire [31:0] APB_GPIO_PRDATA;
    wire       APB_GPIO_PREADY;
    wire       APB_GPIO_PSEL;
    wire       APB_GPIO_PSLVERR;
    wire [31:0] APB_GPIO_PWDATA;
    wire       APB_GPIO_PWRITE;
    wire [3:0] APB_GPIO_gpio_in;
    wire [3:0] APB_GPIO_gpio_out;
    wire       APB_GPIO_interrupt;
    // APB_SDIO port wires:
    wire [31:0] APB_SDIO_PADDR;
    wire       APB_SDIO_PENABLE;
    wire [31:0] APB_SDIO_PRDATA;
    wire       APB_SDIO_PREADY;
    wire       APB_SDIO_PSEL;
    wire       APB_SDIO_PSLVERR;
    wire [31:0] APB_SDIO_PWDATA;
    wire       APB_SDIO_PWRITE;
    wire       APB_SDIO_periph_clk_i;
    wire       APB_SDIO_sdio_clk_internal;
    wire       APB_SDIO_sdio_cmd_internal;
    wire [3:0] APB_SDIO_sdio_data_i_internal;
    wire [3:0] APB_SDIO_sdio_data_o_internal;
    wire       APB_SDIO_sys_clk_i;
    // APB_SPI port wires:
    wire       APB_SPI_HCLK;
    wire       APB_SPI_HRESETn;
    wire [11:0] APB_SPI_PADDR;
    wire       APB_SPI_PENABLE;
    wire [31:0] APB_SPI_PRDATA;
    wire       APB_SPI_PREADY;
    wire       APB_SPI_PSEL;
    wire       APB_SPI_PSLVERR;
    wire [31:0] APB_SPI_PWDATA;
    wire       APB_SPI_PWRITE;
    wire [1:0] APB_SPI_events_o;
    wire       APB_SPI_spi_clk;
    wire       APB_SPI_spi_csn0;
    wire       APB_SPI_spi_csn1;
    wire       APB_SPI_spi_csn2;
    wire       APB_SPI_spi_csn3;
    wire       APB_SPI_spi_sdi0;
    wire       APB_SPI_spi_sdi1;
    wire       APB_SPI_spi_sdi2;
    wire       APB_SPI_spi_sdi3;
    wire       APB_SPI_spi_sdo0;
    wire       APB_SPI_spi_sdo1;
    wire       APB_SPI_spi_sdo2;
    wire       APB_SPI_spi_sdo3;
    // APB_UART port wires:
    wire       APB_UART_CLK;
    wire       APB_UART_INT;
    wire [2:0] APB_UART_PADDR;
    wire       APB_UART_PENABLE;
    wire [31:0] APB_UART_PRDATA;
    wire       APB_UART_PREADY;
    wire       APB_UART_PSEL;
    wire       APB_UART_PSLVERR;
    wire [31:0] APB_UART_PWDATA;
    wire       APB_UART_PWRITE;
    wire       APB_UART_RSTN;
    wire       APB_UART_SIN;
    wire       APB_UART_SOUT;
    // AX4LITE_APB_converter_wrapper port wires:
    wire [31:0] AX4LITE_APB_converter_wrapper_PADDR;
    wire       AX4LITE_APB_converter_wrapper_PENABLE;
    wire [127:0] AX4LITE_APB_converter_wrapper_PRDATA;
    wire [3:0] AX4LITE_APB_converter_wrapper_PREADY;
    wire [3:0] AX4LITE_APB_converter_wrapper_PSEL;
    wire [3:0] AX4LITE_APB_converter_wrapper_PSLVERR;
    wire [31:0] AX4LITE_APB_converter_wrapper_PWDATA;
    wire       AX4LITE_APB_converter_wrapper_PWRITE;
    wire [31:0] AX4LITE_APB_converter_wrapper_ar_addr;
    wire [2:0] AX4LITE_APB_converter_wrapper_ar_prot;
    wire       AX4LITE_APB_converter_wrapper_ar_ready;
    wire       AX4LITE_APB_converter_wrapper_ar_valid;
    wire [31:0] AX4LITE_APB_converter_wrapper_aw_addr;
    wire [2:0] AX4LITE_APB_converter_wrapper_aw_prot;
    wire       AX4LITE_APB_converter_wrapper_aw_ready;
    wire       AX4LITE_APB_converter_wrapper_aw_valid;
    wire       AX4LITE_APB_converter_wrapper_b_ready;
    wire [1:0] AX4LITE_APB_converter_wrapper_b_resp;
    wire       AX4LITE_APB_converter_wrapper_b_valid;
    wire       AX4LITE_APB_converter_wrapper_clk;
    wire [31:0] AX4LITE_APB_converter_wrapper_r_data;
    wire       AX4LITE_APB_converter_wrapper_r_ready;
    wire [1:0] AX4LITE_APB_converter_wrapper_r_resp;
    wire       AX4LITE_APB_converter_wrapper_r_valid;
    wire       AX4LITE_APB_converter_wrapper_rst_n;
    wire [31:0] AX4LITE_APB_converter_wrapper_w_data;
    wire       AX4LITE_APB_converter_wrapper_w_ready;
    wire [3:0] AX4LITE_APB_converter_wrapper_w_strb;
    wire       AX4LITE_APB_converter_wrapper_w_valid;

    // Assignments for the ports of the encompassing component:
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_ADDR = ar_addr;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_PROT = ar_prot;
    assign ar_ready = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_READY;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_VALID = ar_valid;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_ADDR = aw_addr;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_PROT = aw_prot;
    assign aw_ready = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_READY;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_VALID = aw_valid;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_READY = b_ready;
    assign b_resp = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_RESP;
    assign b_valid = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_VALID;
    assign APB_SPI_Clock_to_Clock_clk = clk;
    assign gpio_from_core = APB_GPIO_GPIO_to_GPIO_gpo;
    assign APB_GPIO_GPIO_to_GPIO_gpi = gpio_to_core;
    assign irq_gpio = APB_GPIO_IRQ_to_IRQ_GPIO_irq;
    assign irq_spi = APB_SPI_IRQ_to_IRQ_SPI_irq;
    assign irq_uart = APB_UART_IRQ_to_IRQ_UART_irq;
    assign r_data = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_DATA;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_READY = r_ready;
    assign r_resp = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_RESP;
    assign r_valid = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_VALID;
    assign APB_SPI_Reset_n_to_Reset_reset = rst_n;
    assign sdio_clk_internal = APB_SDIO_SDIO_to_SDIO_clk;
    assign sdio_cmd_internal = APB_SDIO_SDIO_to_SDIO_cmd;
    assign APB_SDIO_SDIO_to_SDIO_data_i = sdio_data_i_internal;
    assign sdio_data_o_internal = APB_SDIO_SDIO_to_SDIO_data_o;
    assign spim_csn_internal = APB_SPI_SPI_to_SPI_csn[1:0];
    assign APB_SPI_SPI_to_SPI_miso = spim_miso_internal;
    assign spim_mosi_internal = APB_SPI_SPI_to_SPI_mosi;
    assign spim_sck_internal = APB_SPI_SPI_to_SPI_sck;
    assign APB_UART_UART_to_UART_uart_rx = uart_rx_internal;
    assign uart_tx_internal = APB_UART_UART_to_UART_uart_tx;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_DATA = w_data;
    assign w_ready = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_READY;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_STRB = w_strb;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_VALID = w_valid;

    // APB_GPIO assignments:
    assign APB_GPIO_HCLK = APB_SPI_Clock_to_Clock_clk;
    assign APB_GPIO_HRESETn = APB_SPI_Reset_n_to_Reset_reset;
    assign APB_GPIO_PADDR = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PADDR[11:0];
    assign APB_GPIO_PENABLE = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PRDATA = APB_GPIO_PRDATA;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PREADY = APB_GPIO_PREADY;
    assign APB_GPIO_PSEL = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PSEL;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PSLVERR = APB_GPIO_PSLVERR;
    assign APB_GPIO_PWDATA = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PWDATA;
    assign APB_GPIO_PWRITE = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PWRITE;
    assign APB_GPIO_gpio_in = APB_GPIO_GPIO_to_GPIO_gpi;
    assign APB_GPIO_GPIO_to_GPIO_gpo = APB_GPIO_gpio_out;
    assign APB_GPIO_IRQ_to_IRQ_GPIO_irq = APB_GPIO_interrupt;
    // APB_SDIO assignments:
    assign APB_SDIO_PADDR = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PADDR;
    assign APB_SDIO_PENABLE = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PRDATA = APB_SDIO_PRDATA;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PREADY = APB_SDIO_PREADY;
    assign APB_SDIO_PSEL = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PSEL;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PSLVERR = APB_SDIO_PSLVERR;
    assign APB_SDIO_PWDATA = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PWDATA;
    assign APB_SDIO_PWRITE = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PWRITE;
    assign APB_SDIO_periph_clk_i = APB_SPI_Clock_to_Clock_clk;
    assign APB_SDIO_periph_clk_i = APB_SPI_Clock_to_Clock_clk;
    assign APB_SDIO_SDIO_to_SDIO_clk = APB_SDIO_sdio_clk_internal;
    assign APB_SDIO_SDIO_to_SDIO_cmd = APB_SDIO_sdio_cmd_internal;
    assign APB_SDIO_sdio_data_i_internal = APB_SDIO_SDIO_to_SDIO_data_i;
    assign APB_SDIO_SDIO_to_SDIO_data_o = APB_SDIO_sdio_data_o_internal;
    assign APB_SDIO_sys_clk_i = APB_SPI_Reset_n_to_Reset_reset;
    // APB_SPI assignments:
    assign APB_SPI_HCLK = APB_SPI_Clock_to_Clock_clk;
    assign APB_SPI_HRESETn = APB_SPI_Reset_n_to_Reset_reset;
    assign APB_SPI_PADDR = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PADDR[11:0];
    assign APB_SPI_PENABLE = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PRDATA = APB_SPI_PRDATA;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PREADY = APB_SPI_PREADY;
    assign APB_SPI_PSEL = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PSEL;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PSLVERR = APB_SPI_PSLVERR;
    assign APB_SPI_PWDATA = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PWDATA;
    assign APB_SPI_PWRITE = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PWRITE;
    assign APB_SPI_IRQ_to_IRQ_SPI_irq = APB_SPI_events_o;
    assign APB_SPI_SPI_to_SPI_sck = APB_SPI_spi_clk;
    assign APB_SPI_SPI_to_SPI_csn[0] = APB_SPI_spi_csn0;
    assign APB_SPI_SPI_to_SPI_csn[1] = APB_SPI_spi_csn1;
    assign APB_SPI_SPI_to_SPI_csn[2] = APB_SPI_spi_csn2;
    assign APB_SPI_SPI_to_SPI_csn[3] = APB_SPI_spi_csn3;
    assign APB_SPI_spi_sdi0 = APB_SPI_SPI_to_SPI_miso[0];
    assign APB_SPI_spi_sdi1 = APB_SPI_SPI_to_SPI_miso[1];
    assign APB_SPI_spi_sdi2 = APB_SPI_SPI_to_SPI_miso[2];
    assign APB_SPI_spi_sdi3 = APB_SPI_SPI_to_SPI_miso[3];
    assign APB_SPI_SPI_to_SPI_mosi[0] = APB_SPI_spi_sdo0;
    assign APB_SPI_SPI_to_SPI_mosi[1] = APB_SPI_spi_sdo1;
    assign APB_SPI_SPI_to_SPI_mosi[2] = APB_SPI_spi_sdo2;
    assign APB_SPI_SPI_to_SPI_mosi[3] = APB_SPI_spi_sdo3;
    // APB_UART assignments:
    assign APB_UART_CLK = APB_SPI_Clock_to_Clock_clk;
    assign APB_UART_IRQ_to_IRQ_UART_irq = APB_UART_INT;
    assign APB_UART_PADDR = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PADDR[2:0];
    assign APB_UART_PENABLE = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PRDATA = APB_UART_PRDATA;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PREADY = APB_UART_PREADY;
    assign APB_UART_PSEL = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PSEL;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PSLVERR = APB_UART_PSLVERR;
    assign APB_UART_PWDATA = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PWDATA;
    assign APB_UART_PWRITE = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PWRITE;
    assign APB_UART_RSTN = APB_SPI_Reset_n_to_Reset_reset;
    assign APB_UART_SIN = APB_UART_UART_to_UART_uart_rx;
    assign APB_UART_UART_to_UART_uart_tx = APB_UART_SOUT;
    // AX4LITE_APB_converter_wrapper assignments:
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PADDR = AX4LITE_APB_converter_wrapper_PADDR;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PADDR = AX4LITE_APB_converter_wrapper_PADDR;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PADDR = AX4LITE_APB_converter_wrapper_PADDR;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PADDR = AX4LITE_APB_converter_wrapper_PADDR;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PENABLE = AX4LITE_APB_converter_wrapper_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PENABLE = AX4LITE_APB_converter_wrapper_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PENABLE = AX4LITE_APB_converter_wrapper_PENABLE;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PENABLE = AX4LITE_APB_converter_wrapper_PENABLE;
    assign AX4LITE_APB_converter_wrapper_PRDATA[127:96] = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PRDATA;
    assign AX4LITE_APB_converter_wrapper_PRDATA[95:64] = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PRDATA;
    assign AX4LITE_APB_converter_wrapper_PRDATA[63:32] = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PRDATA;
    assign AX4LITE_APB_converter_wrapper_PRDATA[31:0] = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PRDATA;
    assign AX4LITE_APB_converter_wrapper_PREADY[3] = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PREADY;
    assign AX4LITE_APB_converter_wrapper_PREADY[2] = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PREADY;
    assign AX4LITE_APB_converter_wrapper_PREADY[1] = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PREADY;
    assign AX4LITE_APB_converter_wrapper_PREADY[0] = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PREADY;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PSEL = AX4LITE_APB_converter_wrapper_PSEL[3];
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PSEL = AX4LITE_APB_converter_wrapper_PSEL[2];
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PSEL = AX4LITE_APB_converter_wrapper_PSEL[1];
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PSEL = AX4LITE_APB_converter_wrapper_PSEL[0];
    assign AX4LITE_APB_converter_wrapper_PSLVERR[3] = AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PSLVERR;
    assign AX4LITE_APB_converter_wrapper_PSLVERR[2] = AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PSLVERR;
    assign AX4LITE_APB_converter_wrapper_PSLVERR[1] = AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PSLVERR;
    assign AX4LITE_APB_converter_wrapper_PSLVERR[0] = AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PSLVERR;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PWDATA = AX4LITE_APB_converter_wrapper_PWDATA;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PWDATA = AX4LITE_APB_converter_wrapper_PWDATA;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PWDATA = AX4LITE_APB_converter_wrapper_PWDATA;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PWDATA = AX4LITE_APB_converter_wrapper_PWDATA;
    assign AX4LITE_APB_converter_wrapper_APB_UART_to_APB_UART_APB_PWRITE = AX4LITE_APB_converter_wrapper_PWRITE;
    assign AX4LITE_APB_converter_wrapper_APB_SPI_to_APB_SPI_APB_PWRITE = AX4LITE_APB_converter_wrapper_PWRITE;
    assign AX4LITE_APB_converter_wrapper_APB_SDIO_to_APB_SDIO_APB_PWRITE = AX4LITE_APB_converter_wrapper_PWRITE;
    assign AX4LITE_APB_converter_wrapper_APB_GPIO_to_APB_GPIO_APB_PWRITE = AX4LITE_APB_converter_wrapper_PWRITE;
    assign AX4LITE_APB_converter_wrapper_ar_addr = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_ADDR;
    assign AX4LITE_APB_converter_wrapper_ar_prot = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_PROT;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_READY = AX4LITE_APB_converter_wrapper_ar_ready;
    assign AX4LITE_APB_converter_wrapper_ar_valid = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AR_VALID;
    assign AX4LITE_APB_converter_wrapper_aw_addr = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_ADDR;
    assign AX4LITE_APB_converter_wrapper_aw_prot = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_PROT;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_READY = AX4LITE_APB_converter_wrapper_aw_ready;
    assign AX4LITE_APB_converter_wrapper_aw_valid = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_AW_VALID;
    assign AX4LITE_APB_converter_wrapper_b_ready = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_READY;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_RESP = AX4LITE_APB_converter_wrapper_b_resp;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_B_VALID = AX4LITE_APB_converter_wrapper_b_valid;
    assign AX4LITE_APB_converter_wrapper_clk = APB_SPI_Clock_to_Clock_clk;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_DATA = AX4LITE_APB_converter_wrapper_r_data;
    assign AX4LITE_APB_converter_wrapper_r_ready = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_READY;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_RESP = AX4LITE_APB_converter_wrapper_r_resp;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_R_VALID = AX4LITE_APB_converter_wrapper_r_valid;
    assign AX4LITE_APB_converter_wrapper_rst_n = APB_SPI_Reset_n_to_Reset_reset;
    assign AX4LITE_APB_converter_wrapper_w_data = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_DATA;
    assign AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_READY = AX4LITE_APB_converter_wrapper_w_ready;
    assign AX4LITE_APB_converter_wrapper_w_strb = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_STRB;
    assign AX4LITE_APB_converter_wrapper_w_valid = AX4LITE_APB_converter_wrapper_AXI4LITE_to_AXI4LITE_W_VALID;

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:APB_GPIO:1.0
    apb_gpio #(
        .PAD_NUM             (4),
        .NBIT_PADCFG         (5))
    APB_GPIO(
        // Interface: APB
        .PADDR               (APB_GPIO_PADDR),
        .PENABLE             (APB_GPIO_PENABLE),
        .PSEL                (APB_GPIO_PSEL),
        .PWDATA              (APB_GPIO_PWDATA),
        .PWRITE              (APB_GPIO_PWRITE),
        .PRDATA              (APB_GPIO_PRDATA),
        .PREADY              (APB_GPIO_PREADY),
        .PSLVERR             (APB_GPIO_PSLVERR),
        // Interface: Clock
        .HCLK                (APB_GPIO_HCLK),
        // Interface: GPIO
        .gpio_in             (APB_GPIO_gpio_in),
        .gpio_dir            (),
        .gpio_out            (APB_GPIO_gpio_out),
        // Interface: IRQ
        .interrupt           (APB_GPIO_interrupt),
        // Interface: Reset_n
        .HRESETn             (APB_GPIO_HRESETn),
        // These ports are not in any interface
        .dft_cg_enable_i     (1'b0),
        .gpio_in_sync        (),
        .gpio_padcfg         ());

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:APB_SDIO:1.0
    APB_SDIO APB_SDIO(
        // Interface: APB
        .PADDR               (APB_SDIO_PADDR),
        .PENABLE             (APB_SDIO_PENABLE),
        .PSEL                (APB_SDIO_PSEL),
        .PWDATA              (APB_SDIO_PWDATA),
        .PWRITE              (APB_SDIO_PWRITE),
        .PRDATA              (APB_SDIO_PRDATA),
        .PREADY              (APB_SDIO_PREADY),
        .PSLVERR             (APB_SDIO_PSLVERR),
        // Interface: Reset_n
        .sys_clk_i           (APB_SDIO_sys_clk_i),
        // Interface: SDIO
        .sdio_data_i_internal(APB_SDIO_sdio_data_i_internal),
        .sdio_clk_internal   (APB_SDIO_sdio_clk_internal),
        .sdio_cmd_internal   (APB_SDIO_sdio_cmd_internal),
        .sdio_data_o_internal(APB_SDIO_sdio_data_o_internal),
        // There ports are contained in many interfaces
        .periph_clk_i        (APB_SDIO_periph_clk_i),
        // These ports are not in any interface
        .rst_n_i             (),
        .sdcmd_i             (),
        .sddata_i            (),
        .sdio_init_disable_i (),
        .eot_o               (),
        .err_o               (),
        .sdclk_o             (),
        .sdcmd_o             (),
        .sdcmd_oen_o         (),
        .sddata_o            (),
        .sddata_oen_o        ());

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:apb_spi_master:1.0
    apb_spi_master #(
        .APB_ADDR_WIDTH      (12))
    APB_SPI(
        // Interface: APB
        .PADDR               (APB_SPI_PADDR),
        .PENABLE             (APB_SPI_PENABLE),
        .PSEL                (APB_SPI_PSEL),
        .PWDATA              (APB_SPI_PWDATA),
        .PWRITE              (APB_SPI_PWRITE),
        .PRDATA              (APB_SPI_PRDATA),
        .PREADY              (APB_SPI_PREADY),
        .PSLVERR             (APB_SPI_PSLVERR),
        // Interface: Clock
        .HCLK                (APB_SPI_HCLK),
        // Interface: IRQ
        .events_o            (APB_SPI_events_o),
        // Interface: Reset_n
        .HRESETn             (APB_SPI_HRESETn),
        // Interface: SPI
        .spi_sdi0            (APB_SPI_spi_sdi0),
        .spi_sdi1            (APB_SPI_spi_sdi1),
        .spi_sdi2            (APB_SPI_spi_sdi2),
        .spi_sdi3            (APB_SPI_spi_sdi3),
        .spi_clk             (APB_SPI_spi_clk),
        .spi_csn0            (APB_SPI_spi_csn0),
        .spi_csn1            (APB_SPI_spi_csn1),
        .spi_csn2            (APB_SPI_spi_csn2),
        .spi_csn3            (APB_SPI_spi_csn3),
        .spi_mode            (),
        .spi_sdo0            (APB_SPI_spi_sdo0),
        .spi_sdo1            (APB_SPI_spi_sdo1),
        .spi_sdo2            (APB_SPI_spi_sdo2),
        .spi_sdo3            (APB_SPI_spi_sdo3));

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:apb_uart:1.0
    apb_uart APB_UART(
        // Interface: APB
        .PADDR               (APB_UART_PADDR),
        .PENABLE             (APB_UART_PENABLE),
        .PSEL                (APB_UART_PSEL),
        .PWDATA              (APB_UART_PWDATA),
        .PWRITE              (APB_UART_PWRITE),
        .PRDATA              (APB_UART_PRDATA),
        .PREADY              (APB_UART_PREADY),
        .PSLVERR             (APB_UART_PSLVERR),
        // Interface: Clock
        .CLK                 (APB_UART_CLK),
        // Interface: IRQ
        .INT                 (APB_UART_INT),
        // Interface: Reset
        .RSTN                (APB_UART_RSTN),
        // Interface: UART
        .SIN                 (APB_UART_SIN),
        .SOUT                (APB_UART_SOUT),
        // These ports are not in any interface
        .CTSN                (1'b0),
        .DCDN                (1'b0),
        .DSRN                (1'b0),
        .RIN                 (1'b0),
        .DTRN                (),
        .OUT1N               (),
        .OUT2N               (),
        .RTSN                ());

    // IP-XACT VLNV: tuni.fi:communication:AX4LITE_APB_converter_wrapper:1.0
    AX4LITE_APB_converter_wrapper     AX4LITE_APB_converter_wrapper(
        // Interface: AXI4LITE
        .ar_addr             (AX4LITE_APB_converter_wrapper_ar_addr),
        .ar_prot             (AX4LITE_APB_converter_wrapper_ar_prot),
        .ar_valid            (AX4LITE_APB_converter_wrapper_ar_valid),
        .aw_addr             (AX4LITE_APB_converter_wrapper_aw_addr),
        .aw_prot             (AX4LITE_APB_converter_wrapper_aw_prot),
        .aw_valid            (AX4LITE_APB_converter_wrapper_aw_valid),
        .b_ready             (AX4LITE_APB_converter_wrapper_b_ready),
        .r_ready             (AX4LITE_APB_converter_wrapper_r_ready),
        .w_data              (AX4LITE_APB_converter_wrapper_w_data),
        .w_strb              (AX4LITE_APB_converter_wrapper_w_strb),
        .w_valid             (AX4LITE_APB_converter_wrapper_w_valid),
        .ar_ready            (AX4LITE_APB_converter_wrapper_ar_ready),
        .aw_ready            (AX4LITE_APB_converter_wrapper_aw_ready),
        .b_resp              (AX4LITE_APB_converter_wrapper_b_resp),
        .b_valid             (AX4LITE_APB_converter_wrapper_b_valid),
        .r_data              (AX4LITE_APB_converter_wrapper_r_data),
        .r_resp              (AX4LITE_APB_converter_wrapper_r_resp),
        .r_valid             (AX4LITE_APB_converter_wrapper_r_valid),
        .w_ready             (AX4LITE_APB_converter_wrapper_w_ready),
        // Interface: Clock
        .clk                 (AX4LITE_APB_converter_wrapper_clk),
        // Interface: Reset_n
        .rst_n               (AX4LITE_APB_converter_wrapper_rst_n),
        // There ports are contained in many interfaces
        .PRDATA              (AX4LITE_APB_converter_wrapper_PRDATA),
        .PREADY              (AX4LITE_APB_converter_wrapper_PREADY),
        .PSLVERR             (AX4LITE_APB_converter_wrapper_PSLVERR),
        .PADDR               (AX4LITE_APB_converter_wrapper_PADDR),
        .PENABLE             (AX4LITE_APB_converter_wrapper_PENABLE),
        .PSEL                (AX4LITE_APB_converter_wrapper_PSEL),
        .PWDATA              (AX4LITE_APB_converter_wrapper_PWDATA),
        .PWRITE              (AX4LITE_APB_converter_wrapper_PWRITE));


endmodule
