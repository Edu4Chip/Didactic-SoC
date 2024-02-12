//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_0.v
// Creation date : 12.02.2024
// Creation time : 14:45:20
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
    output               [49:0]         cell_cfg,

    // These ports are not in any interface
    input                [9:0]          irq_4_14
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
    // Core_FetchEn_to_FetchEn wires:
    wire       Core_FetchEn_to_FetchEn_gpo;
    // Core_imem_to_core_imem_bridge_mem wires:
    wire [31:0] Core_imem_to_core_imem_bridge_mem_ADDR;
    wire [3:0] Core_imem_to_core_imem_bridge_mem_BE;
    wire       Core_imem_to_core_imem_bridge_mem_ERR;
    wire       Core_imem_to_core_imem_bridge_mem_GNT;
    wire [31:0] Core_imem_to_core_imem_bridge_mem_RDATA;
    wire [6:0] Core_imem_to_core_imem_bridge_mem_RDATA_INTG;
    wire       Core_imem_to_core_imem_bridge_mem_REQ;
    wire       Core_imem_to_core_imem_bridge_mem_RVALID;
    wire [31:0] Core_imem_to_core_imem_bridge_mem_WDATA;
    wire [6:0] Core_imem_to_core_imem_bridge_mem_WDATA_INTG;
    wire       Core_imem_to_core_imem_bridge_mem_WE;
    // Core_dmem_to_core_dmem_bridge_mem wires:
    wire [31:0] Core_dmem_to_core_dmem_bridge_mem_ADDR;
    wire [3:0] Core_dmem_to_core_dmem_bridge_mem_BE;
    wire       Core_dmem_to_core_dmem_bridge_mem_ERR;
    wire       Core_dmem_to_core_dmem_bridge_mem_GNT;
    wire [31:0] Core_dmem_to_core_dmem_bridge_mem_RDATA;
    wire [6:0] Core_dmem_to_core_dmem_bridge_mem_RDATA_INTG;
    wire       Core_dmem_to_core_dmem_bridge_mem_REQ;
    wire       Core_dmem_to_core_dmem_bridge_mem_RVALID;
    wire [31:0] Core_dmem_to_core_dmem_bridge_mem_WDATA;
    wire       Core_dmem_to_core_dmem_bridge_mem_WE;
    // i_dmem_mem_to_axi_dmem_bridge_Mem wires:
    wire [31:0] i_dmem_mem_to_axi_dmem_bridge_Mem_ADDR;
    wire [3:0] i_dmem_mem_to_axi_dmem_bridge_Mem_BE;
    wire [31:0] i_dmem_mem_to_axi_dmem_bridge_Mem_RDATA;
    wire       i_dmem_mem_to_axi_dmem_bridge_Mem_REQ;
    wire [31:0] i_dmem_mem_to_axi_dmem_bridge_Mem_WDATA;
    wire       i_dmem_mem_to_axi_dmem_bridge_Mem_WE;
    // BootRom_axi_bridge_Mem_to_BootRom_mem wires:
    wire [31:0] BootRom_axi_bridge_Mem_to_BootRom_mem_ADDR;
    wire [3:0] BootRom_axi_bridge_Mem_to_BootRom_mem_BE;
    wire [31:0] BootRom_axi_bridge_Mem_to_BootRom_mem_RDATA;
    wire       BootRom_axi_bridge_Mem_to_BootRom_mem_REQ;
    wire [31:0] BootRom_axi_bridge_Mem_to_BootRom_mem_WDATA;
    wire       BootRom_axi_bridge_Mem_to_BootRom_mem_WE;
    // axi_imem_bridge_Mem_to_i_imem_mem wires:
    wire [31:0] axi_imem_bridge_Mem_to_i_imem_mem_ADDR;
    wire [3:0] axi_imem_bridge_Mem_to_i_imem_mem_BE;
    wire [31:0] axi_imem_bridge_Mem_to_i_imem_mem_RDATA;
    wire       axi_imem_bridge_Mem_to_i_imem_mem_REQ;
    wire [31:0] axi_imem_bridge_Mem_to_i_imem_mem_WDATA;
    wire       axi_imem_bridge_Mem_to_i_imem_mem_WE;

    // Ad-hoc wires:
    wire       Core_irq_fast_i_to_irq_1;
    wire       Core_irq_fast_i_to_irq_0;
    wire       Core_irq_fast_i_to_irq_3;
    wire [10:0] Core_irq_fast_i_to_irq_4_14;
    wire       Core_irq_fast_i_to_irq_2;

    // AXI_reg_if port wires:
    wire       AXI_reg_if_clk_i;
    wire       AXI_reg_if_rst_ni;
    // BootRom port wires:
    wire [31:0] BootRom_addr_i;
    wire [3:0] BootRom_be_i;
    wire       BootRom_clk_i;
    wire [31:0] BootRom_rdata_o;
    wire       BootRom_req_i;
    wire       BootRom_rst_ni;
    wire [31:0] BootRom_wdata_i;
    wire       BootRom_we_i;
    // BootRom_axi_bridge port wires:
    wire [31:0] BootRom_axi_bridge_addr_o;
    wire [3:0] BootRom_axi_bridge_be_o;
    wire       BootRom_axi_bridge_clk_i;
    wire [31:0] BootRom_axi_bridge_rdata_i;
    wire       BootRom_axi_bridge_req_o;
    wire       BootRom_axi_bridge_rst_ni;
    wire [31:0] BootRom_axi_bridge_wdata_o;
    wire       BootRom_axi_bridge_we_o;
    // Core port wires:
    wire       Core_clk_i;
    wire [31:0] Core_data_addr_o;
    wire [3:0] Core_data_be_o;
    wire       Core_data_err_i;
    wire       Core_data_gnt_i;
    wire [31:0] Core_data_rdata_i;
    wire       Core_data_req_o;
    wire       Core_data_rvalid_i;
    wire [31:0] Core_data_wdata_o;
    wire       Core_data_we_o;
    wire       Core_fetch_enable_i;
    wire [31:0] Core_instr_addr_o;
    wire       Core_instr_err_i;
    wire       Core_instr_gnt_i;
    wire [31:0] Core_instr_rdata_i;
    wire       Core_instr_req_o;
    wire       Core_instr_rvalid_i;
    wire [14:0] Core_irq_fast_i;
    wire       Core_rst_ni;
    // axi_dmem_bridge port wires:
    wire [31:0] axi_dmem_bridge_addr_o;
    wire [3:0] axi_dmem_bridge_be_o;
    wire       axi_dmem_bridge_clk_i;
    wire [31:0] axi_dmem_bridge_rdata_i;
    wire       axi_dmem_bridge_req_o;
    wire       axi_dmem_bridge_rst_ni;
    wire       axi_dmem_bridge_we_o;
    // axi_imem_bridge port wires:
    wire [31:0] axi_imem_bridge_addr_o;
    wire [3:0] axi_imem_bridge_be_o;
    wire       axi_imem_bridge_clk_i;
    wire [31:0] axi_imem_bridge_rdata_i;
    wire       axi_imem_bridge_req_o;
    wire       axi_imem_bridge_rst_ni;
    wire       axi_imem_bridge_we_o;
    // core_dmem_bridge port wires:
    wire [31:0] core_dmem_bridge_addr_i;
    wire       core_dmem_bridge_clk_i;
    wire       core_dmem_bridge_err_o;
    wire       core_dmem_bridge_gnt_o;
    wire [31:0] core_dmem_bridge_rdata_o;
    wire       core_dmem_bridge_req_i;
    wire       core_dmem_bridge_rst_ni;
    wire       core_dmem_bridge_rvalid_o;
    // core_imem_bridge port wires:
    wire [31:0] core_imem_bridge_addr_i;
    wire [3:0] core_imem_bridge_be_i;
    wire       core_imem_bridge_clk_i;
    wire       core_imem_bridge_err_o;
    wire       core_imem_bridge_gnt_o;
    wire [31:0] core_imem_bridge_rdata_o;
    wire       core_imem_bridge_req_i;
    wire       core_imem_bridge_rst_ni;
    wire       core_imem_bridge_rvalid_o;
    wire [31:0] core_imem_bridge_wdata_i;
    wire       core_imem_bridge_we_i;
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
    // i_dmem port wires:
    wire [31:0] i_dmem_addr_i;
    wire [3:0] i_dmem_be_i;
    wire       i_dmem_clk_i;
    wire [31:0] i_dmem_rdata_o;
    wire       i_dmem_req_i;
    wire       i_dmem_rst_ni;
    wire       i_dmem_we_i;
    // i_imem port wires:
    wire [31:0] i_imem_addr_i;
    wire [3:0] i_imem_be_i;
    wire       i_imem_clk_i;
    wire [31:0] i_imem_rdata_o;
    wire       i_imem_req_i;
    wire       i_imem_rst_ni;
    wire       i_imem_we_i;

    // Assignments for the ports of the encompassing component:
    assign i_SysCtrl_peripherals_Clock_to_Clk_clk = clk_internal;
    assign Core_FetchEn_to_FetchEn_gpo = fetchEn_internal;
    assign gpio_from_core = i_SysCtrl_peripherals_GPIO_to_GPIO_gpo;
    assign i_SysCtrl_peripherals_GPIO_to_GPIO_gpi = gpio_to_core;
    assign Core_irq_fast_i_to_irq_0 = irq_0;
    assign Core_irq_fast_i_to_irq_1 = irq_1;
    assign Core_irq_fast_i_to_irq_2 = irq_2;
    assign Core_irq_fast_i_to_irq_3 = irq_3;
    assign Core_irq_fast_i_to_irq_4_14[9:0] = irq_4_14;
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


    // AXI_reg_if assignments:
    assign AXI_reg_if_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign AXI_reg_if_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    // BootRom assignments:
    assign BootRom_addr_i = BootRom_axi_bridge_Mem_to_BootRom_mem_ADDR;
    assign BootRom_be_i = BootRom_axi_bridge_Mem_to_BootRom_mem_BE;
    assign BootRom_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign BootRom_axi_bridge_Mem_to_BootRom_mem_RDATA = BootRom_rdata_o;
    assign BootRom_req_i = BootRom_axi_bridge_Mem_to_BootRom_mem_REQ;
    assign BootRom_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign BootRom_wdata_i = BootRom_axi_bridge_Mem_to_BootRom_mem_WDATA;
    assign BootRom_we_i = BootRom_axi_bridge_Mem_to_BootRom_mem_WE;
    // BootRom_axi_bridge assignments:
    assign BootRom_axi_bridge_Mem_to_BootRom_mem_ADDR = BootRom_axi_bridge_addr_o;
    assign BootRom_axi_bridge_Mem_to_BootRom_mem_BE = BootRom_axi_bridge_be_o;
    assign BootRom_axi_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign BootRom_axi_bridge_rdata_i = BootRom_axi_bridge_Mem_to_BootRom_mem_RDATA;
    assign BootRom_axi_bridge_Mem_to_BootRom_mem_REQ = BootRom_axi_bridge_req_o;
    assign BootRom_axi_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign BootRom_axi_bridge_Mem_to_BootRom_mem_WDATA = BootRom_axi_bridge_wdata_o;
    assign BootRom_axi_bridge_Mem_to_BootRom_mem_WE = BootRom_axi_bridge_we_o;
    // Core assignments:
    assign Core_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Core_imem_to_core_imem_bridge_mem_ADDR = Core_data_addr_o;
    assign Core_imem_to_core_imem_bridge_mem_BE = Core_data_be_o;
    assign Core_data_err_i = Core_imem_to_core_imem_bridge_mem_ERR;
    assign Core_data_gnt_i = Core_imem_to_core_imem_bridge_mem_GNT;
    assign Core_data_rdata_i = Core_imem_to_core_imem_bridge_mem_RDATA;
    assign Core_imem_to_core_imem_bridge_mem_REQ = Core_data_req_o;
    assign Core_data_rvalid_i = Core_imem_to_core_imem_bridge_mem_RVALID;
    assign Core_imem_to_core_imem_bridge_mem_WDATA = Core_data_wdata_o;
    assign Core_imem_to_core_imem_bridge_mem_WE = Core_data_we_o;
    assign Core_fetch_enable_i = Core_FetchEn_to_FetchEn_gpo;
    assign Core_dmem_to_core_dmem_bridge_mem_ADDR = Core_instr_addr_o;
    assign Core_instr_err_i = Core_dmem_to_core_dmem_bridge_mem_ERR;
    assign Core_instr_gnt_i = Core_dmem_to_core_dmem_bridge_mem_GNT;
    assign Core_instr_rdata_i = Core_dmem_to_core_dmem_bridge_mem_RDATA;
    assign Core_dmem_to_core_dmem_bridge_mem_REQ = Core_instr_req_o;
    assign Core_instr_rvalid_i = Core_dmem_to_core_dmem_bridge_mem_RVALID;
    assign Core_irq_fast_i[0] = Core_irq_fast_i_to_irq_0;
    assign Core_irq_fast_i[1] = Core_irq_fast_i_to_irq_1;
    assign Core_irq_fast_i[2] = Core_irq_fast_i_to_irq_2;
    assign Core_irq_fast_i[3] = Core_irq_fast_i_to_irq_3;
    assign Core_irq_fast_i[14:4] = Core_irq_fast_i_to_irq_4_14;
    assign Core_irq_fast_i = 0;
    assign Core_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    // axi_dmem_bridge assignments:
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_ADDR = axi_dmem_bridge_addr_o;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_BE = axi_dmem_bridge_be_o;
    assign axi_dmem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign axi_dmem_bridge_rdata_i = i_dmem_mem_to_axi_dmem_bridge_Mem_RDATA;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_REQ = axi_dmem_bridge_req_o;
    assign axi_dmem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_WE = axi_dmem_bridge_we_o;
    // axi_imem_bridge assignments:
    assign axi_imem_bridge_Mem_to_i_imem_mem_ADDR = axi_imem_bridge_addr_o;
    assign axi_imem_bridge_Mem_to_i_imem_mem_BE = axi_imem_bridge_be_o;
    assign axi_imem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign axi_imem_bridge_rdata_i = axi_imem_bridge_Mem_to_i_imem_mem_RDATA;
    assign axi_imem_bridge_Mem_to_i_imem_mem_REQ = axi_imem_bridge_req_o;
    assign axi_imem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign axi_imem_bridge_Mem_to_i_imem_mem_WE = axi_imem_bridge_we_o;
    // core_dmem_bridge assignments:
    assign core_dmem_bridge_addr_i = Core_dmem_to_core_dmem_bridge_mem_ADDR;
    assign core_dmem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Core_dmem_to_core_dmem_bridge_mem_ERR = core_dmem_bridge_err_o;
    assign Core_dmem_to_core_dmem_bridge_mem_GNT = core_dmem_bridge_gnt_o;
    assign Core_dmem_to_core_dmem_bridge_mem_RDATA = core_dmem_bridge_rdata_o;
    assign core_dmem_bridge_req_i = Core_dmem_to_core_dmem_bridge_mem_REQ;
    assign core_dmem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign Core_dmem_to_core_dmem_bridge_mem_RVALID = core_dmem_bridge_rvalid_o;
    // core_imem_bridge assignments:
    assign core_imem_bridge_addr_i = Core_imem_to_core_imem_bridge_mem_ADDR;
    assign core_imem_bridge_be_i = Core_imem_to_core_imem_bridge_mem_BE;
    assign core_imem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Core_imem_to_core_imem_bridge_mem_ERR = core_imem_bridge_err_o;
    assign Core_imem_to_core_imem_bridge_mem_GNT = core_imem_bridge_gnt_o;
    assign Core_imem_to_core_imem_bridge_mem_RDATA = core_imem_bridge_rdata_o;
    assign core_imem_bridge_req_i = Core_imem_to_core_imem_bridge_mem_REQ;
    assign core_imem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign Core_imem_to_core_imem_bridge_mem_RVALID = core_imem_bridge_rvalid_o;
    assign core_imem_bridge_wdata_i = Core_imem_to_core_imem_bridge_mem_WDATA;
    assign core_imem_bridge_we_i = Core_imem_to_core_imem_bridge_mem_WE;
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
    // i_dmem assignments:
    assign i_dmem_addr_i = i_dmem_mem_to_axi_dmem_bridge_Mem_ADDR;
    assign i_dmem_be_i = i_dmem_mem_to_axi_dmem_bridge_Mem_BE;
    assign i_dmem_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_RDATA = i_dmem_rdata_o;
    assign i_dmem_req_i = i_dmem_mem_to_axi_dmem_bridge_Mem_REQ;
    assign i_dmem_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_dmem_we_i = i_dmem_mem_to_axi_dmem_bridge_Mem_WE;
    // i_imem assignments:
    assign i_imem_addr_i = axi_imem_bridge_Mem_to_i_imem_mem_ADDR;
    assign i_imem_be_i = axi_imem_bridge_Mem_to_i_imem_mem_BE;
    assign i_imem_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign axi_imem_bridge_Mem_to_i_imem_mem_RDATA = i_imem_rdata_o;
    assign i_imem_req_i = axi_imem_bridge_Mem_to_i_imem_mem_REQ;
    assign i_imem_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_imem_we_i = axi_imem_bridge_Mem_to_i_imem_mem_WE;

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge     AXI_reg_if(
        // Interface: AXI4LITE
        .ar_addr_i           (),
        .ar_valid_i          (),
        .aw_addr_i           (),
        .aw_valid_i          (),
        .b_ready_i           (),
        .r_ready_i           (),
        .w_data_i            (),
        .w_strb_i            (),
        .w_valid_i           (),
        .ar_ready_o          (),
        .aw_ready_o          (),
        .b_resp_o            (),
        .b_valid_o           (),
        .r_data_o            (),
        .r_resp_o            (),
        .r_valid_o           (),
        .w_ready_o           (),
        // Interface: Clock
        .clk_i               (AXI_reg_if_clk_i),
        // Interface: Mem
        .rdata_i             (),
        .addr_o              (),
        .be_o                (),
        .req_o               (),
        .wdata_o             (),
        .we_o                (),
        // Interface: Reset
        .rst_ni              (AXI_reg_if_rst_ni));

    // IP-XACT VLNV: tuni.fi:ip:BootRom:1.0
    BootRom     BootRom(
        // Interface: Clock
        .clk_i               (BootRom_clk_i),
        // Interface: Reset
        .rst_ni              (BootRom_rst_ni),
        // Interface: mem
        .addr_i              (BootRom_addr_i),
        .be_i                (BootRom_be_i),
        .req_i               (BootRom_req_i),
        .wdata_i             (BootRom_wdata_i),
        .we_i                (BootRom_we_i),
        .rdata_o             (BootRom_rdata_o));

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge     BootRom_axi_bridge(
        // Interface: AXI4LITE
        .ar_addr_i           (),
        .ar_valid_i          (),
        .aw_addr_i           (),
        .aw_valid_i          (),
        .b_ready_i           (),
        .r_ready_i           (),
        .w_data_i            (),
        .w_strb_i            (),
        .w_valid_i           (),
        .ar_ready_o          (),
        .aw_ready_o          (),
        .b_resp_o            (),
        .b_valid_o           (),
        .r_data_o            (),
        .r_resp_o            (),
        .r_valid_o           (),
        .w_ready_o           (),
        // Interface: Clock
        .clk_i               (BootRom_axi_bridge_clk_i),
        // Interface: Mem
        .rdata_i             (BootRom_axi_bridge_rdata_i),
        .addr_o              (BootRom_axi_bridge_addr_o),
        .be_o                (BootRom_axi_bridge_be_o),
        .req_o               (BootRom_axi_bridge_req_o),
        .wdata_o             (BootRom_axi_bridge_wdata_o),
        .we_o                (BootRom_axi_bridge_we_o),
        // Interface: Reset
        .rst_ni              (BootRom_axi_bridge_rst_ni));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex:1.0
    ibex_top     Core(
        // Interface: Clock
        .clk_i               (Core_clk_i),
        // Interface: FetchEn
        .fetch_enable_i      (Core_fetch_enable_i),
        // Interface: IRQ_fast
        .irq_fast_i          (Core_irq_fast_i),
        // Interface: Reset
        .rst_ni              (Core_rst_ni),
        // Interface: dmem
        .instr_err_i         (Core_instr_err_i),
        .instr_gnt_i         (Core_instr_gnt_i),
        .instr_rdata_i       (Core_instr_rdata_i),
        .instr_rdata_intg_i  (),
        .instr_rvalid_i      (Core_instr_rvalid_i),
        .instr_addr_o        (Core_instr_addr_o),
        .instr_req_o         (Core_instr_req_o),
        // Interface: imem
        .data_err_i          (Core_data_err_i),
        .data_gnt_i          (Core_data_gnt_i),
        .data_rdata_i        (Core_data_rdata_i),
        .data_rdata_intg_i   (),
        .data_rvalid_i       (Core_data_rvalid_i),
        .data_addr_o         (Core_data_addr_o),
        .data_be_o           (Core_data_be_o),
        .data_req_o          (Core_data_req_o),
        .data_wdata_intg_o   (),
        .data_wdata_o        (Core_data_wdata_o),
        .data_we_o           (Core_data_we_o),
        // These ports are not in any interface
        .boot_addr_i         (32'h4000),
        .debug_req_i         (),
        .hart_id_i           (1'b0),
        .irq_external_i      (1'b0),
        .irq_nm_i            (1'b0),
        .irq_software_i      (1'b0),
        .irq_timer_i         (1'b0),
        .ram_cfg_i           (),
        .scan_rst_ni         (1'b1),
        .scramble_key_i      (128'd0),
        .scramble_key_valid_i(1'b0),
        .scramble_nonce_i    (64'd0),
        .test_en_i           (1'b0),
        .alert_major_bus_o   (),
        .alert_major_internal_o(),
        .alert_minor_o       (),
        .core_sleep_o        (),
        .crash_dump_o        (),
        .double_fault_seen_o (),
        .scramble_req_o      ());

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge     axi_dmem_bridge(
        // Interface: AXI4LITE
        .ar_addr_i           (),
        .ar_valid_i          (),
        .aw_addr_i           (),
        .aw_valid_i          (),
        .b_ready_i           (),
        .r_ready_i           (),
        .w_data_i            (),
        .w_strb_i            (),
        .w_valid_i           (),
        .ar_ready_o          (),
        .aw_ready_o          (),
        .b_resp_o            (),
        .b_valid_o           (),
        .r_data_o            (),
        .r_resp_o            (),
        .r_valid_o           (),
        .w_ready_o           (),
        // Interface: Clock
        .clk_i               (axi_dmem_bridge_clk_i),
        // Interface: Mem
        .rdata_i             (axi_dmem_bridge_rdata_i),
        .addr_o              (axi_dmem_bridge_addr_o),
        .be_o                (axi_dmem_bridge_be_o),
        .req_o               (axi_dmem_bridge_req_o),
        .wdata_o             (),
        .we_o                (axi_dmem_bridge_we_o),
        // Interface: Reset
        .rst_ni              (axi_dmem_bridge_rst_ni));

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge     axi_imem_bridge(
        // Interface: AXI4LITE
        .ar_addr_i           (),
        .ar_valid_i          (),
        .aw_addr_i           (),
        .aw_valid_i          (),
        .b_ready_i           (),
        .r_ready_i           (),
        .w_data_i            (),
        .w_strb_i            (),
        .w_valid_i           (),
        .ar_ready_o          (),
        .aw_ready_o          (),
        .b_resp_o            (),
        .b_valid_o           (),
        .r_data_o            (),
        .r_resp_o            (),
        .r_valid_o           (),
        .w_ready_o           (),
        // Interface: Clock
        .clk_i               (axi_imem_bridge_clk_i),
        // Interface: Mem
        .rdata_i             (axi_imem_bridge_rdata_i),
        .addr_o              (axi_imem_bridge_addr_o),
        .be_o                (axi_imem_bridge_be_o),
        .req_o               (axi_imem_bridge_req_o),
        .wdata_o             (),
        .we_o                (axi_imem_bridge_we_o),
        // Interface: Reset
        .rst_ni              (axi_imem_bridge_rst_ni));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex_axi_bridge:1.0
    ibex_axi_bridge     core_dmem_bridge(
        // Interface: Clock
        .clk_i               (core_dmem_bridge_clk_i),
        // Interface: Reset
        .rst_ni              (core_dmem_bridge_rst_ni),
        // Interface: axi4lite
        .ar_ready_o          (),
        .aw_ready_o          (),
        .b_resp_o            (),
        .b_valid_o           (),
        .r_data_o            (),
        .r_resp_o            (),
        .r_valid_o           (),
        .w_ready_o           (),
        .ar_addr_i           (),
        .ar_valid_i          (),
        .aw_addr_i           (),
        .aw_valid_i          (),
        .b_ready_i           (),
        .r_ready_i           (),
        .w_data_i            (),
        .w_strb_i            (),
        .w_valid_i           (),
        // Interface: mem
        .addr_i              (core_dmem_bridge_addr_i),
        .be_i                (),
        .req_i               (core_dmem_bridge_req_i),
        .wdata_i             (),
        .we_i                (),
        .err_o               (core_dmem_bridge_err_o),
        .gnt_o               (core_dmem_bridge_gnt_o),
        .rdata_o             (core_dmem_bridge_rdata_o),
        .rvalid_o            (core_dmem_bridge_rvalid_o));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex_axi_bridge:1.0
    ibex_axi_bridge     core_imem_bridge(
        // Interface: Clock
        .clk_i               (core_imem_bridge_clk_i),
        // Interface: Reset
        .rst_ni              (core_imem_bridge_rst_ni),
        // Interface: axi4lite
        .ar_ready_o          (),
        .aw_ready_o          (),
        .b_resp_o            (),
        .b_valid_o           (),
        .r_data_o            (),
        .r_resp_o            (),
        .r_valid_o           (),
        .w_ready_o           (),
        .ar_addr_i           (),
        .ar_valid_i          (),
        .aw_addr_i           (),
        .aw_valid_i          (),
        .b_ready_i           (),
        .r_ready_i           (),
        .w_data_i            (),
        .w_strb_i            (),
        .w_valid_i           (),
        // Interface: mem
        .addr_i              (core_imem_bridge_addr_i),
        .be_i                (core_imem_bridge_be_i),
        .req_i               (core_imem_bridge_req_i),
        .wdata_i             (core_imem_bridge_wdata_i),
        .we_i                (core_imem_bridge_we_i),
        .err_o               (core_imem_bridge_err_o),
        .gnt_o               (core_imem_bridge_gnt_o),
        .rdata_o             (core_imem_bridge_rdata_o),
        .rvalid_o            (core_imem_bridge_rvalid_o));

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

    // IP-XACT VLNV: tuni.fi:memory.simulation:sp_sram:1.0
    sp_sram     i_dmem(
        // Interface: Clock
        .clk_i               (i_dmem_clk_i),
        // Interface: Reset
        .rst_ni              (i_dmem_rst_ni),
        // Interface: mem
        .addr_i              (i_dmem_addr_i),
        .be_i                (i_dmem_be_i),
        .req_i               (i_dmem_req_i),
        .we_i                (i_dmem_we_i),
        .rdata_o             (i_dmem_rdata_o));

    // IP-XACT VLNV: tuni.fi:memory.simulation:sp_sram:1.0
    sp_sram     i_imem(
        // Interface: Clock
        .clk_i               (i_imem_clk_i),
        // Interface: Reset
        .rst_ni              (i_imem_rst_ni),
        // Interface: mem
        .addr_i              (i_imem_addr_i),
        .be_i                (i_imem_be_i),
        .req_i               (i_imem_req_i),
        .we_i                (i_imem_we_i),
        .rdata_o             (i_imem_rdata_o));


endmodule
