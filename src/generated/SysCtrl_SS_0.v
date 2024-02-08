//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_0.v
// Creation date : 08.02.2024
// Creation time : 15:31:52
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.0 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:SysCtrl_SS:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/subsystem/SysCtrl_SS/1.0/SysCtrl_SS.1.0.xml
//-----------------------------------------------------------------------------

module SysCtrl_SS_0(
    // Interface: AXI
    input                               AR_READY,
    input                               AW_READY,
    input                [10:0]         B_ID,
    input                [1:0]          B_RESP,
    input                               B_USER,
    input                               B_VALID,
    input                [31:0]         R_DATA,
    input                [10:0]         R_ID,
    input                               R_LAST,
    input                [1:0]          R_RESP,
    input                               R_USER,
    input                               R_VALID,
    input                               W_READY,
    output               [31:0]         AR_ADDR,
    output               [1:0]          AR_BURST,
    output               [3:0]          AR_CACHE,
    output               [9:0]          AR_ID,
    output               [7:0]          AR_LEN,
    output                              AR_LOCK,
    output               [2:0]          AR_PROT,
    output               [3:0]          AR_QOS,
    output               [2:0]          AR_REGION,
    output               [2:0]          AR_SIZE,
    output                              AR_USER,
    output                              AR_VALID,
    output               [31:0]         AW_ADDR,
    output               [5:0]          AW_ATOP,
    output               [1:0]          AW_BURST,
    output               [3:0]          AW_CACHE,
    output               [9:0]          AW_ID,
    output               [7:0]          AW_LEN,
    output                              AW_LOCK,
    output               [2:0]          AW_PROT,
    output               [3:0]          AW_QOS,
    output               [3:0]          AW_REGION,
    output               [2:0]          AW_SIZE,
    output                              AW_USER,
    output                              AW_VALID,
    output                              B_READY,
    output                              R_READY,
    output               [31:0]         W_DATA,
    output                              W_LAST,
    output               [3:0]          W_STROBE,
    output                              W_USER,
    output                              W_VALID,

    // Interface: BootSel
    input                               BootSel_internal,

    // Interface: Clk
    input                               clk_internal,

    // Interface: FetchEn
    input                               fetchEn_internal,

    // Interface: GPIO
    input                [3:0]          gpio_to_core,
    output               [3:0]          gpio_from_core,

    // Interface: ICN_SS_Ctrl
    output               [7:0]          ss_ctrl_icn,

    // Interface: IRQ0
    input                               irq_0,

    // Interface: IRQ1
    input                               irq_1,

    // Interface: IRQ2
    input                               irq_2,

    // Interface: IRQ3
    input                               irq_3,

    // Interface: JTAG
    input                               jtag_tck_internal,
    input                               jtag_tdi_internal,
    input                               jtag_tms_internal,
    input                               jtag_trst_internal,
    output                              jtag_tdo_internal,

    // Interface: Reset
    input                               reset_internal,

    // Interface: Reset_ICN
    output                              reset_icn,

    // Interface: Reset_SS_0
    output                              reset_ss_0,

    // Interface: Reset_SS_1
    output                              reset_ss_1,

    // Interface: Reset_SS_2
    output                              reset_ss_2,

    // Interface: Reset_SS_3
    output                              reset_ss_3,

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

    // Interface: SS_Ctrl_0
    output                              irq_en_0,
    output               [7:0]          ss_ctrl_0,

    // Interface: SS_Ctrl_1
    output                              irq_en_1,
    output               [7:0]          ss_ctrl_1,

    // Interface: SS_Ctrl_2
    output                              irq_en_2,
    output               [7:0]          ss_ctrl_2,

    // Interface: SS_Ctrl_3
    output                              irq_en_3,
    output               [7:0]          ss_ctrl_3,

    // Interface: UART
    input                               uart_rx_internal,
    output                              uart_tx_internal,

    // Interface: io_cell_cfg
    output               [49:0]         cell_cfg
);

    // i_SysCtrl_peripherals_GPIO_to_GPIO wires:
    wire [3:0] i_SysCtrl_peripherals_GPIO_to_GPIO_gpi;
    wire [3:0] i_SysCtrl_peripherals_GPIO_to_GPIO_gpo;
    // i_SysCtrl_peripherals_SPI_to_SPI wires:
    wire [1:0] i_SysCtrl_peripherals_SPI_to_SPI_csn;
    wire [3:0] i_SysCtrl_peripherals_SPI_to_SPI_miso;
    wire [3:0] i_SysCtrl_peripherals_SPI_to_SPI_mosi;
    wire       i_SysCtrl_peripherals_SPI_to_SPI_sck;
    // i_SysCtrl_peripherals_SDIO_to_SDIO wires:
    wire       i_SysCtrl_peripherals_SDIO_to_SDIO_clk;
    wire       i_SysCtrl_peripherals_SDIO_to_SDIO_cmd;
    wire [3:0] i_SysCtrl_peripherals_SDIO_to_SDIO_data_i;
    wire [3:0] i_SysCtrl_peripherals_SDIO_to_SDIO_data_o;
    // i_SysCtrl_peripherals_UART_to_UART wires:
    wire       i_SysCtrl_peripherals_UART_to_UART_uart_rx;
    wire       i_SysCtrl_peripherals_UART_to_UART_uart_tx;
    // i_SysCtrl_peripherals_Clock_to_Clk wires:
    wire       i_SysCtrl_peripherals_Clock_to_Clk_clk;
    // i_SysCtrl_peripherals_Reset_to_Reset wires:
    wire       i_SysCtrl_peripherals_Reset_to_Reset_reset;

    // i_SysCtrl_peripherals port wires:
    wire       i_SysCtrl_peripherals_clk;
    wire [3:0] i_SysCtrl_peripherals_gpio_from_core;
    wire [3:0] i_SysCtrl_peripherals_gpio_to_core;
    wire       i_SysCtrl_peripherals_rst_n;
    wire       i_SysCtrl_peripherals_sdio_clk_internal;
    wire       i_SysCtrl_peripherals_sdio_cmd_internal;
    wire [3:0] i_SysCtrl_peripherals_sdio_data_i_internal;
    wire [3:0] i_SysCtrl_peripherals_sdio_data_o_internal;
    wire [1:0] i_SysCtrl_peripherals_spim_csn_internal;
    wire [3:0] i_SysCtrl_peripherals_spim_miso_internal;
    wire [3:0] i_SysCtrl_peripherals_spim_mosi_internal;
    wire       i_SysCtrl_peripherals_spim_sck_internal;
    wire       i_SysCtrl_peripherals_uart_rx_internal;
    wire       i_SysCtrl_peripherals_uart_tx_internal;

    // Assignments for the ports of the encompassing component:
    assign i_SysCtrl_peripherals_Clock_to_Clk_clk = clk_internal;
    assign gpio_from_core = i_SysCtrl_peripherals_GPIO_to_GPIO_gpo;
    assign i_SysCtrl_peripherals_GPIO_to_GPIO_gpi = gpio_to_core;
    assign i_SysCtrl_peripherals_Reset_to_Reset_reset = reset_internal;
    assign sdio_clk_internal = i_SysCtrl_peripherals_SDIO_to_SDIO_clk;
    assign sdio_cmd_internal = i_SysCtrl_peripherals_SDIO_to_SDIO_cmd;
    assign i_SysCtrl_peripherals_SDIO_to_SDIO_data_i = sdio_data_i_internal;
    assign sdio_data_o_internal = i_SysCtrl_peripherals_SDIO_to_SDIO_data_o;
    assign spim_csn_internal = i_SysCtrl_peripherals_SPI_to_SPI_csn;
    assign i_SysCtrl_peripherals_SPI_to_SPI_miso = spim_miso_internal;
    assign spim_mosi_internal = i_SysCtrl_peripherals_SPI_to_SPI_mosi;
    assign spim_sck_internal = i_SysCtrl_peripherals_SPI_to_SPI_sck;
    assign i_SysCtrl_peripherals_UART_to_UART_uart_rx = uart_rx_internal;
    assign uart_tx_internal = i_SysCtrl_peripherals_UART_to_UART_uart_tx;


    // i_SysCtrl_peripherals assignments:
    assign i_SysCtrl_peripherals_clk = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign i_SysCtrl_peripherals_GPIO_to_GPIO_gpo = i_SysCtrl_peripherals_gpio_from_core;
    assign i_SysCtrl_peripherals_gpio_to_core = i_SysCtrl_peripherals_GPIO_to_GPIO_gpi;
    assign i_SysCtrl_peripherals_rst_n = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_SysCtrl_peripherals_SDIO_to_SDIO_clk = i_SysCtrl_peripherals_sdio_clk_internal;
    assign i_SysCtrl_peripherals_SDIO_to_SDIO_cmd = i_SysCtrl_peripherals_sdio_cmd_internal;
    assign i_SysCtrl_peripherals_sdio_data_i_internal = i_SysCtrl_peripherals_SDIO_to_SDIO_data_i;
    assign i_SysCtrl_peripherals_SDIO_to_SDIO_data_o = i_SysCtrl_peripherals_sdio_data_o_internal;
    assign i_SysCtrl_peripherals_SPI_to_SPI_csn = i_SysCtrl_peripherals_spim_csn_internal;
    assign i_SysCtrl_peripherals_spim_miso_internal = i_SysCtrl_peripherals_SPI_to_SPI_miso;
    assign i_SysCtrl_peripherals_SPI_to_SPI_mosi = i_SysCtrl_peripherals_spim_mosi_internal;
    assign i_SysCtrl_peripherals_SPI_to_SPI_sck = i_SysCtrl_peripherals_spim_sck_internal;
    assign i_SysCtrl_peripherals_uart_rx_internal = i_SysCtrl_peripherals_UART_to_UART_uart_rx;
    assign i_SysCtrl_peripherals_UART_to_UART_uart_tx = i_SysCtrl_peripherals_uart_tx_internal;

    // IP-XACT VLNV: tuni.fi:ip:SysCtrl_peripherals:1.0
    SysCtrl_peripherals_0 i_SysCtrl_peripherals(
        // Interface: AXI4LITE
        .ar_addr             (),
        .ar_prot             (),
        .ar_valid            (),
        .aw_addr             (),
        .aw_prot             (),
        .aw_valid            (),
        .b_ready             (),
        .r_ready             (),
        .w_data              (),
        .w_strb              (),
        .w_valid             (),
        .ar_ready            (),
        .aw_ready            (),
        .b_resp              (),
        .b_valid             (),
        .r_data              (),
        .r_resp              (),
        .r_valid             (),
        .w_ready             (),
        // Interface: Clock
        .clk                 (i_SysCtrl_peripherals_clk),
        // Interface: GPIO
        .gpio_to_core        (i_SysCtrl_peripherals_gpio_to_core),
        .gpio_from_core      (i_SysCtrl_peripherals_gpio_from_core),
        // Interface: IRQ_GPIO
        .irq_gpio            (),
        // Interface: IRQ_SPI
        .irq_spi             (),
        // Interface: IRQ_UART
        .irq_uart            (),
        // Interface: Reset
        .rst_n               (i_SysCtrl_peripherals_rst_n),
        // Interface: SDIO
        .sdio_data_i_internal(i_SysCtrl_peripherals_sdio_data_i_internal),
        .sdio_clk_internal   (i_SysCtrl_peripherals_sdio_clk_internal),
        .sdio_cmd_internal   (i_SysCtrl_peripherals_sdio_cmd_internal),
        .sdio_data_o_internal(i_SysCtrl_peripherals_sdio_data_o_internal),
        // Interface: SPI
        .spim_miso_internal  (i_SysCtrl_peripherals_spim_miso_internal),
        .spim_csn_internal   (i_SysCtrl_peripherals_spim_csn_internal),
        .spim_mosi_internal  (i_SysCtrl_peripherals_spim_mosi_internal),
        .spim_sck_internal   (i_SysCtrl_peripherals_spim_sck_internal),
        // Interface: UART
        .uart_rx_internal    (i_SysCtrl_peripherals_uart_rx_internal),
        .uart_tx_internal    (i_SysCtrl_peripherals_uart_tx_internal));


endmodule
