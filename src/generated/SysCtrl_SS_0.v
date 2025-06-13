//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_0.v
// Creation date : 13.06.2025
// Creation time : 14:24:42
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.5 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:SysCtrl_SS:1.1
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem/SysCtrl_SS/1.1/SysCtrl_SS.1.1.xml
//-----------------------------------------------------------------------------

module SysCtrl_SS_0 #(
    parameter                              IOCELL_CFG_W     = 10,
    parameter                              IOCELL_COUNT     = 25,    // update this value manually to match cell numbers
    parameter                              NUM_GPIO         = 16,
    parameter                              SS_CTRL_W        = 8,
    parameter                              OBI_IDW          = 1,
    parameter                              OBI_CHKW         = 1,
    parameter                              OBI_USERW        = 1,
    parameter                              OBI_AW           = 32,
    parameter                              OBI_DW           = 32,
    parameter                              NUM_SS           = 5,
    parameter                              IO_CFG_W         = 10
) (
    // Interface: Clk
    input  logic                        clk_internal,

    // Interface: GPIO
    input  logic         [15:0]         gpio_to_core,
    output logic         [15:0]         gpio_from_core,

    // Interface: ICN_SS_Ctrl
    output logic         [7:0]          ss_ctrl_icn,

    // Interface: IRQ
    input  logic         [4:0]          sysctrl_irq_i,

    // Interface: JTAG
    input  logic                        jtag_tck_internal,
    input  logic                        jtag_tdi_internal,
    input  logic                        jtag_tms_internal,
    input  logic                        jtag_trst_internal,
    output logic                        jtag_tdo_internal,

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
    input  logic                        reset_internal,

    // Interface: Reset_ICN
    output logic                        reset_icn,

    // Interface: Reset_SS
    output logic         [4:0]          reset_ss,

    // Interface: SPI
    input  logic         [3:0]          spim_miso_internal,
    output logic         [1:0]          spim_csn_internal,
    output logic         [3:0]          spim_mosi_internal,
    output logic                        spim_sck_internal,

    // Interface: SS_Ctrl_0
    output logic                        irq_en_0,
    output logic         [7:0]          ss_ctrl_0,

    // Interface: SS_Ctrl_1
    output logic                        irq_en_1,
    output logic         [7:0]          ss_ctrl_1,

    // Interface: SS_Ctrl_2
    output logic                        irq_en_2,
    output logic         [7:0]          ss_ctrl_2,

    // Interface: SS_Ctrl_3
    output logic                        irq_en_3,
    output logic         [7:0]          ss_ctrl_3,

    // Interface: UART
    input  logic                        uart_rx_internal,
    output logic                        uart_tx_internal,

    // Interface: io_cell_cfg
    output logic         [249:0]        cell_cfg,

    // Interface: pmod_sel
    output logic         [15:0]         pmod_sel,

    // Interface: ss_ctrl_4
    output logic                        irq_en_4,
    output logic         [7:0]          ss_ctrl_4,

    // These ports are not in any interface
    input  logic         [14:0]         irq_upper_tieoff
);

    // ctrl_reg_array_rst_icn_to_Reset_ICN wires:
    wire       ctrl_reg_array_rst_icn_to_Reset_ICN_reset;
    // ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl wires:
    wire [7:0] ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl_clk_ctrl;
    // ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0 wires:
    wire [7:0] ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_clk_ctrl;
    wire       ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_irq_en;
    // ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1 wires:
    wire [7:0] ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_clk_ctrl;
    wire       ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_irq_en;
    // ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2 wires:
    wire [7:0] ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_clk_ctrl;
    wire       ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_irq_en;
    // ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3 wires:
    wire [7:0] ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_clk_ctrl;
    wire       ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_irq_en;
    // ctrl_reg_array_io_cfg_to_io_cell_cfg wires:
    wire [249:0] ctrl_reg_array_io_cfg_to_io_cell_cfg_cfg;
    // jtag_dbg_wrapper_JTAG_to_JTAG wires:
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tck;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tdi;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tdo;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tms;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_trst;
    // jtag_dbg_wrapper_Clock_to_Clk wires:
    wire       jtag_dbg_wrapper_Clock_to_Clk_clk;
    // ctrl_reg_array_Reset_to_Reset wires:
    wire       ctrl_reg_array_Reset_to_Reset_reset;
    // jtag_dbg_wrapper_core_reset_to_i_ibex_wrapper_Reset wires:
    wire       jtag_dbg_wrapper_core_reset_to_i_ibex_wrapper_Reset_reset;
    // jtag_dbg_wrapper_Debug_to_i_ibex_wrapper_Debug wires:
    wire       jtag_dbg_wrapper_Debug_to_i_ibex_wrapper_Debug_debug_req;
    // ctrl_reg_array_pmod_sel_to_pmod_sel wires:
    wire [15:0] ctrl_reg_array_pmod_sel_to_pmod_sel_gpo;
    // ctrl_reg_array_fetch_en_to_i_ibex_wrapper_FetchEn wires:
    wire [3:0] ctrl_reg_array_fetch_en_to_i_ibex_wrapper_FetchEn_gpo;
    // ctrl_reg_array_rst_ss_to_Reset_SS wires:
    wire [4:0] ctrl_reg_array_rst_ss_to_Reset_SS_reset;
    // apb_gpio_GPIO_to_GPIO wires:
    wire [15:0] apb_gpio_GPIO_to_GPIO_gpi;
    wire [15:0] apb_gpio_GPIO_to_GPIO_gpio_oe;
    wire [15:0] apb_gpio_GPIO_to_GPIO_gpo;
    // apb_spi_master_SPI_to_SPI wires:
    wire [3:0] apb_spi_master_SPI_to_SPI_csn;
    wire [1:0] apb_spi_master_SPI_to_SPI_data_oe;
    wire [3:0] apb_spi_master_SPI_to_SPI_miso;
    wire [3:0] apb_spi_master_SPI_to_SPI_mosi;
    wire       apb_spi_master_SPI_to_SPI_sck;
    // apb_uart_UART_to_UART wires:
    wire       apb_uart_UART_to_UART_uart_rx;
    wire       apb_uart_UART_to_UART_uart_tx;
    // sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi wires:
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_achk;
    wire [31:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_addr;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_aid;
    wire [5:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_atop;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_auser;
    wire [3:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_be;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_dbg;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_err;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_exokay;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_gnt;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_gntpar;
    wire [1:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_memtype;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_mid;
    wire [2:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_prot;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rchk;
    wire [31:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rdata;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_req;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_reqpar;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rid;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rready;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rreadypar;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_ruser;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rvalid;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_wdata;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_we;
    wire       sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_wuser;
    // peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB wires:
    wire [11:0] peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PADDR;
    wire       peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PENABLE;
    wire [31:0] peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PRDATA;
    wire       peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PREADY;
    wire       peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PSEL;
    wire       peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PSLVERR;
    wire [31:0] peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PWDATA;
    wire       peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PWRITE;
    // peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB wires:
    wire [11:0] peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PADDR;
    wire       peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PENABLE;
    wire [31:0] peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PRDATA;
    wire       peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PREADY;
    wire       peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PSEL;
    wire       peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PSLVERR;
    wire [31:0] peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PWDATA;
    wire       peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PWRITE;
    // peripherals_obi_to_apb_apb_uart_to_apb_uart_APB wires:
    wire [11:0] peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PADDR;
    wire       peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PENABLE;
    wire [31:0] peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PRDATA;
    wire       peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PREADY;
    wire       peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PSEL;
    wire       peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PSLVERR;
    wire [31:0] peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PWDATA;
    wire       peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PWRITE;
    // jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target wires:
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_achk;
    wire [31:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_addr;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_aid;
    wire [5:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_atop;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_auser;
    wire [3:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_be;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_dbg;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_err;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_exokay;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_gnt;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_gntpar;
    wire [1:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_memtype;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_mid;
    wire [2:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_prot;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rchk;
    wire [31:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rdata;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_req;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_reqpar;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rid;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rready;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rreadypar;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_ruser;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rvalid;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rvalidpar;
    wire [31:0] jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_wdata;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_we;
    wire       jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_wuser;
    // jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init wires:
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_achk;
    wire [31:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_addr;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_aid;
    wire [5:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_atop;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_auser;
    wire [3:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_be;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_dbg;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_err;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_exokay;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_gnt;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_gntpar;
    wire [1:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_memtype;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_mid;
    wire [2:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_prot;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rchk;
    wire [31:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rdata;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_req;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_reqpar;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rid;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rready;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rreadypar;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_ruser;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rvalid;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rvalidpar;
    wire [31:0] jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_wdata;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_we;
    wire       jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_wuser;
    // i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem wires:
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_achk;
    wire [31:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_addr;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_aid;
    wire [5:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_atop;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_auser;
    wire [3:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_be;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_dbg;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_err;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_exokay;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_gnt;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_gntpar;
    wire [1:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_memtype;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_mid;
    wire [2:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_prot;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rchk;
    wire [31:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rdata;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_req;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_reqpar;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rid;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rready;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rreadypar;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_ruser;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rvalid;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rvalidpar;
    wire [31:0] i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_wdata;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_we;
    wire       i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_wuser;
    // i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem wires:
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_achk;
    wire [31:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_addr;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_aid;
    wire [5:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_atop;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_auser;
    wire [3:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_be;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_dbg;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_err;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_exokay;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_gnt;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_gntpar;
    wire [1:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_memtype;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_mid;
    wire [2:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_prot;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rchk;
    wire [31:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rdata;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_req;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_reqpar;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rid;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rready;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rreadypar;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_ruser;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rvalid;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rvalidpar;
    wire [31:0] i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_wdata;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_we;
    wire       i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_wuser;
    // i_imem_mem_to_sysctrl_obi_xbar_obi_imem wires:
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_achk;
    wire [31:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_addr;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_aid;
    wire [5:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_atop;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_auser;
    wire [3:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_be;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_dbg;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_err;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_exokay;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_gnt;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_gntpar;
    wire [1:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_memtype;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_mid;
    wire [2:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_prot;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rchk;
    wire [31:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rdata;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_req;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_reqpar;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rid;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rready;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rreadypar;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_ruser;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rvalid;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rvalidpar;
    wire [31:0] i_imem_mem_to_sysctrl_obi_xbar_obi_imem_wdata;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_we;
    wire       i_imem_mem_to_sysctrl_obi_xbar_obi_imem_wuser;
    // i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem wires:
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_achk;
    wire [31:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_addr;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_aid;
    wire [5:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_atop;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_auser;
    wire [3:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_be;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_dbg;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_err;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_exokay;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_gnt;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_gntpar;
    wire [1:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_memtype;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_mid;
    wire [2:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_prot;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rchk;
    wire [31:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rdata;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_req;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_reqpar;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rid;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rready;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rreadypar;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_ruser;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rvalid;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rvalidpar;
    wire [31:0] i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_wdata;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_we;
    wire       i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_wuser;
    // sysctrl_obi_xbar_obi_chip_top_to_OBI wires:
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_achk;
    wire [31:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_addr;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_aid;
    wire [5:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_atop;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_auser;
    wire [3:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_be;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_dbg;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_err;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_exokay;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_gnt;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_gntpar;
    wire [1:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_memtype;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_mid;
    wire [2:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_prot;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_rchk;
    wire [31:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_rdata;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_req;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_reqpar;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_rid;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_rready;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_rreadypar;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_ruser;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_rvalid;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_obi_chip_top_to_OBI_wdata;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_we;
    wire       sysctrl_obi_xbar_obi_chip_top_to_OBI_wuser;
    // ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl wires:
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_achk;
    wire [31:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_addr;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_aid;
    wire [5:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_atop;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_auser;
    wire [3:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_be;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_dbg;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_err;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_exokay;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_gnt;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_gntpar;
    wire [1:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_memtype;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_mid;
    wire [2:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_prot;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rchk;
    wire [31:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rdata;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_req;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_reqpar;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rid;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rready;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rreadypar;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_ruser;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rvalid;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rvalidpar;
    wire [31:0] ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_wdata;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_we;
    wire       ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_wuser;
    // ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4 wires:
    wire [7:0] ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4_clk_ctrl;
    wire       ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4_irq_en;

    // Ad-hoc wires:
    wire       apb_gpio_interrupt_to_i_ibex_wrapper_irq_fast_i;
    wire       apb_uart_INT_to_i_ibex_wrapper_irq_fast_i;
    wire [1:0] apb_spi_master_events_o_to_i_ibex_wrapper_irq_fast_i;
    wire [4:0] i_ibex_wrapper_irq_fast_i_to_sysctrl_irq_i;
    wire [5:0] i_ibex_wrapper_irq_fast_i_to_irq_upper_tieoff;

    // apb_gpio port wires:
    wire       apb_gpio_HCLK;
    wire       apb_gpio_HRESETn;
    wire [11:0] apb_gpio_PADDR;
    wire       apb_gpio_PENABLE;
    wire [31:0] apb_gpio_PRDATA;
    wire       apb_gpio_PREADY;
    wire       apb_gpio_PSEL;
    wire       apb_gpio_PSLVERR;
    wire [31:0] apb_gpio_PWDATA;
    wire       apb_gpio_PWRITE;
    wire [15:0] apb_gpio_gpio_in;
    wire [15:0] apb_gpio_gpio_out;
    wire       apb_gpio_interrupt;
    // apb_spi_master port wires:
    wire       apb_spi_master_HCLK;
    wire       apb_spi_master_HRESETn;
    wire [11:0] apb_spi_master_PADDR;
    wire       apb_spi_master_PENABLE;
    wire [31:0] apb_spi_master_PRDATA;
    wire       apb_spi_master_PREADY;
    wire       apb_spi_master_PSEL;
    wire       apb_spi_master_PSLVERR;
    wire [31:0] apb_spi_master_PWDATA;
    wire       apb_spi_master_PWRITE;
    wire [1:0] apb_spi_master_events_o;
    wire       apb_spi_master_spi_clk;
    wire       apb_spi_master_spi_csn0;
    wire       apb_spi_master_spi_csn1;
    wire       apb_spi_master_spi_csn2;
    wire       apb_spi_master_spi_csn3;
    wire       apb_spi_master_spi_sdi0;
    wire       apb_spi_master_spi_sdi1;
    wire       apb_spi_master_spi_sdi2;
    wire       apb_spi_master_spi_sdi3;
    wire       apb_spi_master_spi_sdo0;
    wire       apb_spi_master_spi_sdo1;
    wire       apb_spi_master_spi_sdo2;
    wire       apb_spi_master_spi_sdo3;
    // apb_uart port wires:
    wire       apb_uart_CLK;
    wire       apb_uart_INT;
    wire [2:0] apb_uart_PADDR;
    wire       apb_uart_PENABLE;
    wire [31:0] apb_uart_PRDATA;
    wire       apb_uart_PREADY;
    wire       apb_uart_PSEL;
    wire       apb_uart_PSLVERR;
    wire [31:0] apb_uart_PWDATA;
    wire       apb_uart_PWRITE;
    wire       apb_uart_RSTN;
    wire       apb_uart_SIN;
    wire       apb_uart_SOUT;
    // ctrl_reg_array port wires:
    wire [31:0] ctrl_reg_array_addr_i;
    wire [3:0] ctrl_reg_array_be_i;
    wire [249:0] ctrl_reg_array_cell_cfg;
    wire       ctrl_reg_array_clk;
    wire [3:0] ctrl_reg_array_fetch_en;
    wire       ctrl_reg_array_gnt_o;
    wire       ctrl_reg_array_gntpar_o;
    wire       ctrl_reg_array_irq_en_0;
    wire       ctrl_reg_array_irq_en_1;
    wire       ctrl_reg_array_irq_en_2;
    wire       ctrl_reg_array_irq_en_3;
    wire       ctrl_reg_array_irq_en_4;
    wire [7:0] ctrl_reg_array_pmod_sel;
    wire [31:0] ctrl_reg_array_rdata_o;
    wire       ctrl_reg_array_req_i;
    wire       ctrl_reg_array_reset_icn;
    wire       ctrl_reg_array_reset_n;
    wire [4:0] ctrl_reg_array_reset_ss;
    wire       ctrl_reg_array_rready_i;
    wire       ctrl_reg_array_rvalid_o;
    wire       ctrl_reg_array_rvalidpar_o;
    wire [7:0] ctrl_reg_array_ss_ctrl_0;
    wire [7:0] ctrl_reg_array_ss_ctrl_1;
    wire [7:0] ctrl_reg_array_ss_ctrl_2;
    wire [7:0] ctrl_reg_array_ss_ctrl_3;
    wire [7:0] ctrl_reg_array_ss_ctrl_4;
    wire [7:0] ctrl_reg_array_ss_ctrl_icn;
    wire [31:0] ctrl_reg_array_wdata_i;
    wire       ctrl_reg_array_we_i;
    // i_dmem port wires:
    wire [11:0] i_dmem_addr_i;
    wire [3:0] i_dmem_be_i;
    wire       i_dmem_clk_i;
    wire       i_dmem_gnt_o;
    wire       i_dmem_gntpar_o;
    wire [31:0] i_dmem_rdata_o;
    wire       i_dmem_req_i;
    wire       i_dmem_rready_i;
    wire       i_dmem_rst_ni;
    wire       i_dmem_rvalid_o;
    wire       i_dmem_rvalidpar_o;
    wire [31:0] i_dmem_wdata_i;
    wire       i_dmem_we_i;
    // i_ibex_wrapper port wires:
    wire       i_ibex_wrapper_clk_i;
    wire [31:0] i_ibex_wrapper_data_addr_o;
    wire [3:0] i_ibex_wrapper_data_be_o;
    wire       i_ibex_wrapper_data_err_i;
    wire       i_ibex_wrapper_data_gnt_i;
    wire [31:0] i_ibex_wrapper_data_rdata_i;
    wire       i_ibex_wrapper_data_req_o;
    wire       i_ibex_wrapper_data_reqpar_o;
    wire       i_ibex_wrapper_data_rvalid_i;
    wire [31:0] i_ibex_wrapper_data_wdata_o;
    wire       i_ibex_wrapper_data_we_o;
    wire       i_ibex_wrapper_debug_req_i;
    wire [3:0] i_ibex_wrapper_fetch_enable_i;
    wire [31:0] i_ibex_wrapper_instr_addr_o;
    wire       i_ibex_wrapper_instr_err_i;
    wire       i_ibex_wrapper_instr_gnt_i;
    wire [31:0] i_ibex_wrapper_instr_rdata_i;
    wire       i_ibex_wrapper_instr_req_o;
    wire       i_ibex_wrapper_instr_reqpar_o;
    wire       i_ibex_wrapper_instr_rvalid_i;
    wire [14:0] i_ibex_wrapper_irq_fast_i;
    wire       i_ibex_wrapper_rst_ni;
    // i_imem port wires:
    wire [11:0] i_imem_addr_i;
    wire [3:0] i_imem_be_i;
    wire       i_imem_clk_i;
    wire       i_imem_gnt_o;
    wire       i_imem_gntpar_o;
    wire [31:0] i_imem_rdata_o;
    wire       i_imem_req_i;
    wire       i_imem_rready_i;
    wire       i_imem_rst_ni;
    wire       i_imem_rvalid_o;
    wire       i_imem_rvalidpar_o;
    wire [31:0] i_imem_wdata_i;
    wire       i_imem_we_i;
    // jtag_dbg_wrapper port wires:
    wire       jtag_dbg_wrapper_clk_i;
    wire       jtag_dbg_wrapper_core_reset;
    wire       jtag_dbg_wrapper_debug_req_irq_o;
    wire [31:0] jtag_dbg_wrapper_initiator_addr_o;
    wire [3:0] jtag_dbg_wrapper_initiator_be_o;
    wire       jtag_dbg_wrapper_initiator_err_i;
    wire       jtag_dbg_wrapper_initiator_gnt_i;
    wire [31:0] jtag_dbg_wrapper_initiator_rdata_i;
    wire       jtag_dbg_wrapper_initiator_req_o;
    wire       jtag_dbg_wrapper_initiator_reqpar_o;
    wire       jtag_dbg_wrapper_initiator_rvalid_i;
    wire [31:0] jtag_dbg_wrapper_initiator_wdata_o;
    wire       jtag_dbg_wrapper_initiator_we_o;
    wire       jtag_dbg_wrapper_jtag_tck_i;
    wire       jtag_dbg_wrapper_jtag_td_i;
    wire       jtag_dbg_wrapper_jtag_td_o;
    wire       jtag_dbg_wrapper_jtag_tms_i;
    wire       jtag_dbg_wrapper_jtag_trst_ni;
    wire       jtag_dbg_wrapper_rstn_i;
    wire [31:0] jtag_dbg_wrapper_target_addr_i;
    wire       jtag_dbg_wrapper_target_aid_i;
    wire [3:0] jtag_dbg_wrapper_target_be_i;
    wire       jtag_dbg_wrapper_target_gnt_o;
    wire       jtag_dbg_wrapper_target_gntpar_o;
    wire [31:0] jtag_dbg_wrapper_target_rdata_o;
    wire       jtag_dbg_wrapper_target_req_i;
    wire       jtag_dbg_wrapper_target_rid_o;
    wire       jtag_dbg_wrapper_target_rvalid_o;
    wire       jtag_dbg_wrapper_target_rvalidpar_o;
    wire [31:0] jtag_dbg_wrapper_target_wdata_i;
    wire       jtag_dbg_wrapper_target_we_i;
    // peripherals_obi_to_apb port wires:
    wire [11:0] peripherals_obi_to_apb_APB_GPIO_PADDR;
    wire       peripherals_obi_to_apb_APB_GPIO_PENABLE;
    wire [31:0] peripherals_obi_to_apb_APB_GPIO_PRDATA;
    wire       peripherals_obi_to_apb_APB_GPIO_PREADY;
    wire       peripherals_obi_to_apb_APB_GPIO_PSEL;
    wire       peripherals_obi_to_apb_APB_GPIO_PSLVERR;
    wire [31:0] peripherals_obi_to_apb_APB_GPIO_PWDATA;
    wire       peripherals_obi_to_apb_APB_GPIO_PWRITE;
    wire [11:0] peripherals_obi_to_apb_APB_SPI_PADDR;
    wire       peripherals_obi_to_apb_APB_SPI_PENABLE;
    wire [31:0] peripherals_obi_to_apb_APB_SPI_PRDATA;
    wire       peripherals_obi_to_apb_APB_SPI_PREADY;
    wire       peripherals_obi_to_apb_APB_SPI_PSEL;
    wire       peripherals_obi_to_apb_APB_SPI_PSLVERR;
    wire [31:0] peripherals_obi_to_apb_APB_SPI_PWDATA;
    wire       peripherals_obi_to_apb_APB_SPI_PWRITE;
    wire [11:0] peripherals_obi_to_apb_APB_UART_PADDR;
    wire       peripherals_obi_to_apb_APB_UART_PENABLE;
    wire [31:0] peripherals_obi_to_apb_APB_UART_PRDATA;
    wire       peripherals_obi_to_apb_APB_UART_PREADY;
    wire       peripherals_obi_to_apb_APB_UART_PSEL;
    wire       peripherals_obi_to_apb_APB_UART_PSLVERR;
    wire [31:0] peripherals_obi_to_apb_APB_UART_PWDATA;
    wire       peripherals_obi_to_apb_APB_UART_PWRITE;
    wire       peripherals_obi_to_apb_achk;
    wire [31:0] peripherals_obi_to_apb_addr;
    wire       peripherals_obi_to_apb_aid;
    wire [5:0] peripherals_obi_to_apb_atop;
    wire       peripherals_obi_to_apb_auser;
    wire [3:0] peripherals_obi_to_apb_be;
    wire       peripherals_obi_to_apb_clk;
    wire       peripherals_obi_to_apb_dbg;
    wire       peripherals_obi_to_apb_err;
    wire       peripherals_obi_to_apb_exokay;
    wire       peripherals_obi_to_apb_gnt;
    wire       peripherals_obi_to_apb_gntpar;
    wire [1:0] peripherals_obi_to_apb_memtype;
    wire       peripherals_obi_to_apb_mid;
    wire [2:0] peripherals_obi_to_apb_prot;
    wire       peripherals_obi_to_apb_rchk;
    wire [31:0] peripherals_obi_to_apb_rdata;
    wire       peripherals_obi_to_apb_req;
    wire       peripherals_obi_to_apb_reqpar;
    wire       peripherals_obi_to_apb_reset_n;
    wire       peripherals_obi_to_apb_rid;
    wire       peripherals_obi_to_apb_rready;
    wire       peripherals_obi_to_apb_rreadypar;
    wire       peripherals_obi_to_apb_ruser;
    wire       peripherals_obi_to_apb_rvalid;
    wire       peripherals_obi_to_apb_rvalidpar;
    wire [31:0] peripherals_obi_to_apb_wdata;
    wire       peripherals_obi_to_apb_we;
    wire       peripherals_obi_to_apb_wuser;
    // sysctrl_obi_xbar port wires:
    wire       sysctrl_obi_xbar_clk;
    wire [31:0] sysctrl_obi_xbar_ctrl_addr;
    wire       sysctrl_obi_xbar_ctrl_aid;
    wire [5:0] sysctrl_obi_xbar_ctrl_atop;
    wire       sysctrl_obi_xbar_ctrl_auser;
    wire [3:0] sysctrl_obi_xbar_ctrl_be;
    wire       sysctrl_obi_xbar_ctrl_dbg;
    wire       sysctrl_obi_xbar_ctrl_err;
    wire       sysctrl_obi_xbar_ctrl_exokay;
    wire       sysctrl_obi_xbar_ctrl_gnt;
    wire       sysctrl_obi_xbar_ctrl_gntpar;
    wire [1:0] sysctrl_obi_xbar_ctrl_memtype;
    wire       sysctrl_obi_xbar_ctrl_mid;
    wire [2:0] sysctrl_obi_xbar_ctrl_prot;
    wire [31:0] sysctrl_obi_xbar_ctrl_rdata;
    wire       sysctrl_obi_xbar_ctrl_req;
    wire       sysctrl_obi_xbar_ctrl_rid;
    wire       sysctrl_obi_xbar_ctrl_rready;
    wire       sysctrl_obi_xbar_ctrl_rreadypar;
    wire       sysctrl_obi_xbar_ctrl_ruser;
    wire       sysctrl_obi_xbar_ctrl_rvalid;
    wire       sysctrl_obi_xbar_ctrl_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_ctrl_wdata;
    wire       sysctrl_obi_xbar_ctrl_we;
    wire       sysctrl_obi_xbar_ctrl_wuser;
    wire [31:0] sysctrl_obi_xbar_data_addr;
    wire       sysctrl_obi_xbar_data_aid;
    wire [5:0] sysctrl_obi_xbar_data_atop;
    wire       sysctrl_obi_xbar_data_auser;
    wire [3:0] sysctrl_obi_xbar_data_be;
    wire       sysctrl_obi_xbar_data_dbg;
    wire       sysctrl_obi_xbar_data_err;
    wire       sysctrl_obi_xbar_data_exokay;
    wire       sysctrl_obi_xbar_data_gnt;
    wire [1:0] sysctrl_obi_xbar_data_memtype;
    wire       sysctrl_obi_xbar_data_mid;
    wire [2:0] sysctrl_obi_xbar_data_prot;
    wire [31:0] sysctrl_obi_xbar_data_rdata;
    wire       sysctrl_obi_xbar_data_req;
    wire       sysctrl_obi_xbar_data_reqpar;
    wire       sysctrl_obi_xbar_data_rid;
    wire       sysctrl_obi_xbar_data_rready;
    wire       sysctrl_obi_xbar_data_rreadypar;
    wire       sysctrl_obi_xbar_data_ruser;
    wire       sysctrl_obi_xbar_data_rvalid;
    wire [31:0] sysctrl_obi_xbar_data_wdata;
    wire       sysctrl_obi_xbar_data_we;
    wire       sysctrl_obi_xbar_data_wuser;
    wire [31:0] sysctrl_obi_xbar_dm_init_addr;
    wire       sysctrl_obi_xbar_dm_init_aid;
    wire [5:0] sysctrl_obi_xbar_dm_init_atop;
    wire       sysctrl_obi_xbar_dm_init_auser;
    wire [3:0] sysctrl_obi_xbar_dm_init_be;
    wire       sysctrl_obi_xbar_dm_init_dbg;
    wire       sysctrl_obi_xbar_dm_init_err;
    wire       sysctrl_obi_xbar_dm_init_exokay;
    wire       sysctrl_obi_xbar_dm_init_gnt;
    wire [1:0] sysctrl_obi_xbar_dm_init_memtype;
    wire       sysctrl_obi_xbar_dm_init_mid;
    wire [2:0] sysctrl_obi_xbar_dm_init_prot;
    wire [31:0] sysctrl_obi_xbar_dm_init_rdata;
    wire       sysctrl_obi_xbar_dm_init_req;
    wire       sysctrl_obi_xbar_dm_init_reqpar;
    wire       sysctrl_obi_xbar_dm_init_rid;
    wire       sysctrl_obi_xbar_dm_init_rready;
    wire       sysctrl_obi_xbar_dm_init_rreadypar;
    wire       sysctrl_obi_xbar_dm_init_ruser;
    wire       sysctrl_obi_xbar_dm_init_rvalid;
    wire [31:0] sysctrl_obi_xbar_dm_init_wdata;
    wire       sysctrl_obi_xbar_dm_init_we;
    wire       sysctrl_obi_xbar_dm_init_wuser;
    wire [31:0] sysctrl_obi_xbar_dm_target_addr;
    wire       sysctrl_obi_xbar_dm_target_aid;
    wire [5:0] sysctrl_obi_xbar_dm_target_atop;
    wire       sysctrl_obi_xbar_dm_target_auser;
    wire [3:0] sysctrl_obi_xbar_dm_target_be;
    wire       sysctrl_obi_xbar_dm_target_dbg;
    wire       sysctrl_obi_xbar_dm_target_err;
    wire       sysctrl_obi_xbar_dm_target_exokay;
    wire       sysctrl_obi_xbar_dm_target_gnt;
    wire       sysctrl_obi_xbar_dm_target_gntpar;
    wire [1:0] sysctrl_obi_xbar_dm_target_memtype;
    wire       sysctrl_obi_xbar_dm_target_mid;
    wire [2:0] sysctrl_obi_xbar_dm_target_prot;
    wire [31:0] sysctrl_obi_xbar_dm_target_rdata;
    wire       sysctrl_obi_xbar_dm_target_req;
    wire       sysctrl_obi_xbar_dm_target_rid;
    wire       sysctrl_obi_xbar_dm_target_rready;
    wire       sysctrl_obi_xbar_dm_target_rreadypar;
    wire       sysctrl_obi_xbar_dm_target_ruser;
    wire       sysctrl_obi_xbar_dm_target_rvalid;
    wire       sysctrl_obi_xbar_dm_target_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_dm_target_wdata;
    wire       sysctrl_obi_xbar_dm_target_we;
    wire       sysctrl_obi_xbar_dm_target_wuser;
    wire [31:0] sysctrl_obi_xbar_dmem_addr;
    wire       sysctrl_obi_xbar_dmem_aid;
    wire [5:0] sysctrl_obi_xbar_dmem_atop;
    wire       sysctrl_obi_xbar_dmem_auser;
    wire [3:0] sysctrl_obi_xbar_dmem_be;
    wire       sysctrl_obi_xbar_dmem_dbg;
    wire       sysctrl_obi_xbar_dmem_err;
    wire       sysctrl_obi_xbar_dmem_exokay;
    wire       sysctrl_obi_xbar_dmem_gnt;
    wire       sysctrl_obi_xbar_dmem_gntpar;
    wire [1:0] sysctrl_obi_xbar_dmem_memtype;
    wire       sysctrl_obi_xbar_dmem_mid;
    wire [2:0] sysctrl_obi_xbar_dmem_prot;
    wire [31:0] sysctrl_obi_xbar_dmem_rdata;
    wire       sysctrl_obi_xbar_dmem_req;
    wire       sysctrl_obi_xbar_dmem_rid;
    wire       sysctrl_obi_xbar_dmem_rready;
    wire       sysctrl_obi_xbar_dmem_rreadypar;
    wire       sysctrl_obi_xbar_dmem_ruser;
    wire       sysctrl_obi_xbar_dmem_rvalid;
    wire       sysctrl_obi_xbar_dmem_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_dmem_wdata;
    wire       sysctrl_obi_xbar_dmem_we;
    wire       sysctrl_obi_xbar_dmem_wuser;
    wire [31:0] sysctrl_obi_xbar_imem_addr;
    wire       sysctrl_obi_xbar_imem_aid;
    wire [5:0] sysctrl_obi_xbar_imem_atop;
    wire       sysctrl_obi_xbar_imem_auser;
    wire [3:0] sysctrl_obi_xbar_imem_be;
    wire       sysctrl_obi_xbar_imem_dbg;
    wire       sysctrl_obi_xbar_imem_err;
    wire       sysctrl_obi_xbar_imem_exokay;
    wire       sysctrl_obi_xbar_imem_gnt;
    wire       sysctrl_obi_xbar_imem_gntpar;
    wire [1:0] sysctrl_obi_xbar_imem_memtype;
    wire       sysctrl_obi_xbar_imem_mid;
    wire [2:0] sysctrl_obi_xbar_imem_prot;
    wire [31:0] sysctrl_obi_xbar_imem_rdata;
    wire       sysctrl_obi_xbar_imem_req;
    wire       sysctrl_obi_xbar_imem_rid;
    wire       sysctrl_obi_xbar_imem_rready;
    wire       sysctrl_obi_xbar_imem_rreadypar;
    wire       sysctrl_obi_xbar_imem_ruser;
    wire       sysctrl_obi_xbar_imem_rvalid;
    wire       sysctrl_obi_xbar_imem_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_imem_wdata;
    wire       sysctrl_obi_xbar_imem_we;
    wire       sysctrl_obi_xbar_imem_wuser;
    wire [31:0] sysctrl_obi_xbar_instr_addr;
    wire       sysctrl_obi_xbar_instr_aid;
    wire [5:0] sysctrl_obi_xbar_instr_atop;
    wire       sysctrl_obi_xbar_instr_auser;
    wire [3:0] sysctrl_obi_xbar_instr_be;
    wire       sysctrl_obi_xbar_instr_dbg;
    wire       sysctrl_obi_xbar_instr_err;
    wire       sysctrl_obi_xbar_instr_exokay;
    wire       sysctrl_obi_xbar_instr_gnt;
    wire [1:0] sysctrl_obi_xbar_instr_memtype;
    wire       sysctrl_obi_xbar_instr_mid;
    wire [2:0] sysctrl_obi_xbar_instr_prot;
    wire [31:0] sysctrl_obi_xbar_instr_rdata;
    wire       sysctrl_obi_xbar_instr_req;
    wire       sysctrl_obi_xbar_instr_reqpar;
    wire       sysctrl_obi_xbar_instr_rid;
    wire       sysctrl_obi_xbar_instr_rready;
    wire       sysctrl_obi_xbar_instr_rreadypar;
    wire       sysctrl_obi_xbar_instr_ruser;
    wire       sysctrl_obi_xbar_instr_rvalid;
    wire [31:0] sysctrl_obi_xbar_instr_wdata;
    wire       sysctrl_obi_xbar_instr_we;
    wire       sysctrl_obi_xbar_instr_wuser;
    wire       sysctrl_obi_xbar_periph_achk;
    wire [31:0] sysctrl_obi_xbar_periph_addr;
    wire       sysctrl_obi_xbar_periph_aid;
    wire [5:0] sysctrl_obi_xbar_periph_atop;
    wire       sysctrl_obi_xbar_periph_auser;
    wire [3:0] sysctrl_obi_xbar_periph_be;
    wire       sysctrl_obi_xbar_periph_dbg;
    wire       sysctrl_obi_xbar_periph_err;
    wire       sysctrl_obi_xbar_periph_exokay;
    wire       sysctrl_obi_xbar_periph_gnt;
    wire       sysctrl_obi_xbar_periph_gntpar;
    wire [1:0] sysctrl_obi_xbar_periph_memtype;
    wire       sysctrl_obi_xbar_periph_mid;
    wire [2:0] sysctrl_obi_xbar_periph_prot;
    wire       sysctrl_obi_xbar_periph_rchk;
    wire [31:0] sysctrl_obi_xbar_periph_rdata;
    wire       sysctrl_obi_xbar_periph_req;
    wire       sysctrl_obi_xbar_periph_reqpar;
    wire       sysctrl_obi_xbar_periph_rid;
    wire       sysctrl_obi_xbar_periph_rready;
    wire       sysctrl_obi_xbar_periph_rreadypar;
    wire       sysctrl_obi_xbar_periph_ruser;
    wire       sysctrl_obi_xbar_periph_rvalid;
    wire       sysctrl_obi_xbar_periph_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_periph_wdata;
    wire       sysctrl_obi_xbar_periph_we;
    wire       sysctrl_obi_xbar_periph_wuser;
    wire       sysctrl_obi_xbar_reset_n;
    wire       sysctrl_obi_xbar_top_achk;
    wire [31:0] sysctrl_obi_xbar_top_addr;
    wire       sysctrl_obi_xbar_top_aid;
    wire [5:0] sysctrl_obi_xbar_top_atop;
    wire       sysctrl_obi_xbar_top_auser;
    wire [3:0] sysctrl_obi_xbar_top_be;
    wire       sysctrl_obi_xbar_top_dbg;
    wire       sysctrl_obi_xbar_top_err;
    wire       sysctrl_obi_xbar_top_exokay;
    wire       sysctrl_obi_xbar_top_gnt;
    wire       sysctrl_obi_xbar_top_gntpar;
    wire [1:0] sysctrl_obi_xbar_top_memtype;
    wire       sysctrl_obi_xbar_top_mid;
    wire [2:0] sysctrl_obi_xbar_top_prot;
    wire       sysctrl_obi_xbar_top_rchk;
    wire [31:0] sysctrl_obi_xbar_top_rdata;
    wire       sysctrl_obi_xbar_top_req;
    wire       sysctrl_obi_xbar_top_reqpar;
    wire       sysctrl_obi_xbar_top_rid;
    wire       sysctrl_obi_xbar_top_rready;
    wire       sysctrl_obi_xbar_top_rreadypar;
    wire       sysctrl_obi_xbar_top_ruser;
    wire       sysctrl_obi_xbar_top_rvalid;
    wire       sysctrl_obi_xbar_top_rvalidpar;
    wire [31:0] sysctrl_obi_xbar_top_wdata;
    wire       sysctrl_obi_xbar_top_we;
    wire       sysctrl_obi_xbar_top_wuser;

    // Assignments for the ports of the encompassing component:
    assign cell_cfg = ctrl_reg_array_io_cfg_to_io_cell_cfg_cfg;
    assign jtag_dbg_wrapper_Clock_to_Clk_clk = clk_internal;
    assign gpio_from_core = apb_gpio_GPIO_to_GPIO_gpo;
    assign apb_gpio_GPIO_to_GPIO_gpi = gpio_to_core;
    assign irq_en_0 = ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_irq_en;
    assign irq_en_1 = ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_irq_en;
    assign irq_en_2 = ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_irq_en;
    assign irq_en_3 = ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_irq_en;
    assign irq_en_4 = ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4_irq_en;
    assign i_ibex_wrapper_irq_fast_i_to_irq_upper_tieoff = irq_upper_tieoff[14:9];
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tck = jtag_tck_internal;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tdi = jtag_tdi_internal;
    assign jtag_tdo_internal = jtag_dbg_wrapper_JTAG_to_JTAG_tdo;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tms = jtag_tms_internal;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_trst = jtag_trst_internal;
    assign obi_addr = sysctrl_obi_xbar_obi_chip_top_to_OBI_addr;
    assign obi_aid = sysctrl_obi_xbar_obi_chip_top_to_OBI_aid;
    assign obi_be = sysctrl_obi_xbar_obi_chip_top_to_OBI_be;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_err = obi_err;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_gnt = obi_gnt;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_gntpar = obi_gntpar;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_rdata = obi_rdata;
    assign obi_req = sysctrl_obi_xbar_obi_chip_top_to_OBI_req;
    assign obi_reqpar = sysctrl_obi_xbar_obi_chip_top_to_OBI_reqpar;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_rid = obi_rid;
    assign obi_rready = sysctrl_obi_xbar_obi_chip_top_to_OBI_rready;
    assign obi_rreadypar = sysctrl_obi_xbar_obi_chip_top_to_OBI_rreadypar;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_rvalid = obi_rvalid;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_rvalidpar = obi_rvalidpar;
    assign obi_wdata = sysctrl_obi_xbar_obi_chip_top_to_OBI_wdata;
    assign obi_we = sysctrl_obi_xbar_obi_chip_top_to_OBI_we;
    assign pmod_sel = ctrl_reg_array_pmod_sel_to_pmod_sel_gpo;
    assign reset_icn = ctrl_reg_array_rst_icn_to_Reset_ICN_reset;
    assign ctrl_reg_array_Reset_to_Reset_reset = reset_internal;
    assign reset_ss = ctrl_reg_array_rst_ss_to_Reset_SS_reset;
    assign spim_csn_internal = apb_spi_master_SPI_to_SPI_csn[1:0];
    assign apb_spi_master_SPI_to_SPI_miso = spim_miso_internal;
    assign spim_mosi_internal = apb_spi_master_SPI_to_SPI_mosi;
    assign spim_sck_internal = apb_spi_master_SPI_to_SPI_sck;
    assign ss_ctrl_0 = ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_clk_ctrl;
    assign ss_ctrl_1 = ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_clk_ctrl;
    assign ss_ctrl_2 = ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_clk_ctrl;
    assign ss_ctrl_3 = ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_clk_ctrl;
    assign ss_ctrl_4 = ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4_clk_ctrl;
    assign ss_ctrl_icn = ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl_clk_ctrl;
    assign i_ibex_wrapper_irq_fast_i_to_sysctrl_irq_i = sysctrl_irq_i;
    assign apb_uart_UART_to_UART_uart_rx = uart_rx_internal;
    assign uart_tx_internal = apb_uart_UART_to_UART_uart_tx;

    // apb_gpio assignments:
    assign apb_gpio_HCLK = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign apb_gpio_HRESETn = ctrl_reg_array_Reset_to_Reset_reset;
    assign apb_gpio_PADDR = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PADDR;
    assign apb_gpio_PENABLE = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PENABLE;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PRDATA = apb_gpio_PRDATA;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PREADY = apb_gpio_PREADY;
    assign apb_gpio_PSEL = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PSEL;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PSLVERR = apb_gpio_PSLVERR;
    assign apb_gpio_PWDATA = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PWDATA;
    assign apb_gpio_PWRITE = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PWRITE;
    assign apb_gpio_gpio_in = apb_gpio_GPIO_to_GPIO_gpi;
    assign apb_gpio_GPIO_to_GPIO_gpo = apb_gpio_gpio_out;
    assign apb_gpio_interrupt_to_i_ibex_wrapper_irq_fast_i = apb_gpio_interrupt;
    // apb_spi_master assignments:
    assign apb_spi_master_HCLK = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign apb_spi_master_HRESETn = ctrl_reg_array_Reset_to_Reset_reset;
    assign apb_spi_master_PADDR = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PADDR;
    assign apb_spi_master_PENABLE = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PENABLE;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PRDATA = apb_spi_master_PRDATA;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PREADY = apb_spi_master_PREADY;
    assign apb_spi_master_PSEL = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PSEL;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PSLVERR = apb_spi_master_PSLVERR;
    assign apb_spi_master_PWDATA = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PWDATA;
    assign apb_spi_master_PWRITE = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PWRITE;
    assign apb_spi_master_events_o_to_i_ibex_wrapper_irq_fast_i = apb_spi_master_events_o;
    assign apb_spi_master_SPI_to_SPI_sck = apb_spi_master_spi_clk;
    assign apb_spi_master_SPI_to_SPI_csn[0] = apb_spi_master_spi_csn0;
    assign apb_spi_master_SPI_to_SPI_csn[1] = apb_spi_master_spi_csn1;
    assign apb_spi_master_SPI_to_SPI_csn[2] = apb_spi_master_spi_csn2;
    assign apb_spi_master_SPI_to_SPI_csn[3] = apb_spi_master_spi_csn3;
    assign apb_spi_master_spi_sdi0 = apb_spi_master_SPI_to_SPI_miso[0];
    assign apb_spi_master_spi_sdi1 = apb_spi_master_SPI_to_SPI_miso[1];
    assign apb_spi_master_spi_sdi2 = apb_spi_master_SPI_to_SPI_miso[2];
    assign apb_spi_master_spi_sdi3 = apb_spi_master_SPI_to_SPI_miso[3];
    assign apb_spi_master_SPI_to_SPI_mosi[0] = apb_spi_master_spi_sdo0;
    assign apb_spi_master_SPI_to_SPI_mosi[1] = apb_spi_master_spi_sdo1;
    assign apb_spi_master_SPI_to_SPI_mosi[2] = apb_spi_master_spi_sdo2;
    assign apb_spi_master_SPI_to_SPI_mosi[3] = apb_spi_master_spi_sdo3;
    // apb_uart assignments:
    assign apb_uart_CLK = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign apb_uart_INT_to_i_ibex_wrapper_irq_fast_i = apb_uart_INT;
    assign apb_uart_PADDR[2:0] = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PADDR[4:2];
    assign apb_uart_PENABLE = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PENABLE;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PRDATA = apb_uart_PRDATA;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PREADY = apb_uart_PREADY;
    assign apb_uart_PSEL = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PSEL;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PSLVERR = apb_uart_PSLVERR;
    assign apb_uart_PWDATA = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PWDATA;
    assign apb_uart_PWRITE = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PWRITE;
    assign apb_uart_RSTN = ctrl_reg_array_Reset_to_Reset_reset;
    assign apb_uart_SIN = apb_uart_UART_to_UART_uart_rx;
    assign apb_uart_UART_to_UART_uart_tx = apb_uart_SOUT;
    // ctrl_reg_array assignments:
    assign ctrl_reg_array_addr_i = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_addr;
    assign ctrl_reg_array_be_i = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_be;
    assign ctrl_reg_array_io_cfg_to_io_cell_cfg_cfg = ctrl_reg_array_cell_cfg;
    assign ctrl_reg_array_clk = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign ctrl_reg_array_fetch_en_to_i_ibex_wrapper_FetchEn_gpo = ctrl_reg_array_fetch_en;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_gnt = ctrl_reg_array_gnt_o;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_gntpar = ctrl_reg_array_gntpar_o;
    assign ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_irq_en = ctrl_reg_array_irq_en_0;
    assign ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_irq_en = ctrl_reg_array_irq_en_1;
    assign ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_irq_en = ctrl_reg_array_irq_en_2;
    assign ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_irq_en = ctrl_reg_array_irq_en_3;
    assign ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4_irq_en = ctrl_reg_array_irq_en_4;
    assign ctrl_reg_array_pmod_sel_to_pmod_sel_gpo[7:0] = ctrl_reg_array_pmod_sel;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rdata = ctrl_reg_array_rdata_o;
    assign ctrl_reg_array_req_i = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_req;
    assign ctrl_reg_array_rst_icn_to_Reset_ICN_reset = ctrl_reg_array_reset_icn;
    assign ctrl_reg_array_reset_n = ctrl_reg_array_Reset_to_Reset_reset;
    assign ctrl_reg_array_rst_ss_to_Reset_SS_reset = ctrl_reg_array_reset_ss;
    assign ctrl_reg_array_rready_i = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rready;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rvalid = ctrl_reg_array_rvalid_o;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rvalidpar = ctrl_reg_array_rvalidpar_o;
    assign ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_clk_ctrl = ctrl_reg_array_ss_ctrl_0;
    assign ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_clk_ctrl = ctrl_reg_array_ss_ctrl_1;
    assign ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_clk_ctrl = ctrl_reg_array_ss_ctrl_2;
    assign ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_clk_ctrl = ctrl_reg_array_ss_ctrl_3;
    assign ctrl_reg_array_ss_ctrl_4_to_ss_ctrl_4_clk_ctrl = ctrl_reg_array_ss_ctrl_4;
    assign ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl_clk_ctrl = ctrl_reg_array_ss_ctrl_icn;
    assign ctrl_reg_array_wdata_i = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_wdata;
    assign ctrl_reg_array_we_i = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_we;
    // i_dmem assignments:
    assign i_dmem_addr_i = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_addr[11:0];
    assign i_dmem_be_i = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_be;
    assign i_dmem_clk_i = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_gnt = i_dmem_gnt_o;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_gntpar = i_dmem_gntpar_o;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rdata = i_dmem_rdata_o;
    assign i_dmem_req_i = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_req;
    assign i_dmem_rready_i = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rready;
    assign i_dmem_rst_ni = ctrl_reg_array_Reset_to_Reset_reset;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rvalid = i_dmem_rvalid_o;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rvalidpar = i_dmem_rvalidpar_o;
    assign i_dmem_wdata_i = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_wdata;
    assign i_dmem_we_i = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_we;
    // i_ibex_wrapper assignments:
    assign i_ibex_wrapper_clk_i = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_addr = i_ibex_wrapper_data_addr_o;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_be = i_ibex_wrapper_data_be_o;
    assign i_ibex_wrapper_data_err_i = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_err;
    assign i_ibex_wrapper_data_gnt_i = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_gnt;
    assign i_ibex_wrapper_data_rdata_i = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rdata;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_req = i_ibex_wrapper_data_req_o;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_reqpar = i_ibex_wrapper_data_reqpar_o;
    assign i_ibex_wrapper_data_rvalid_i = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rvalid;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_wdata = i_ibex_wrapper_data_wdata_o;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_we = i_ibex_wrapper_data_we_o;
    assign i_ibex_wrapper_debug_req_i = jtag_dbg_wrapper_Debug_to_i_ibex_wrapper_Debug_debug_req;
    assign i_ibex_wrapper_fetch_enable_i = ctrl_reg_array_fetch_en_to_i_ibex_wrapper_FetchEn_gpo;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_addr = i_ibex_wrapper_instr_addr_o;
    assign i_ibex_wrapper_instr_err_i = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_err;
    assign i_ibex_wrapper_instr_gnt_i = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_gnt;
    assign i_ibex_wrapper_instr_rdata_i = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rdata;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_req = i_ibex_wrapper_instr_req_o;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_reqpar = i_ibex_wrapper_instr_reqpar_o;
    assign i_ibex_wrapper_instr_rvalid_i = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rvalid;
    assign i_ibex_wrapper_irq_fast_i[0] = apb_gpio_interrupt_to_i_ibex_wrapper_irq_fast_i;
    assign i_ibex_wrapper_irq_fast_i[3:2] = apb_spi_master_events_o_to_i_ibex_wrapper_irq_fast_i;
    assign i_ibex_wrapper_irq_fast_i[1] = apb_uart_INT_to_i_ibex_wrapper_irq_fast_i;
    assign i_ibex_wrapper_irq_fast_i[14:9] = i_ibex_wrapper_irq_fast_i_to_irq_upper_tieoff;
    assign i_ibex_wrapper_irq_fast_i[8:4] = i_ibex_wrapper_irq_fast_i_to_sysctrl_irq_i;
    assign i_ibex_wrapper_rst_ni = jtag_dbg_wrapper_core_reset_to_i_ibex_wrapper_Reset_reset;
    // i_imem assignments:
    assign i_imem_addr_i = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_addr[11:0];
    assign i_imem_be_i = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_be;
    assign i_imem_clk_i = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_gnt = i_imem_gnt_o;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_gntpar = i_imem_gntpar_o;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rdata = i_imem_rdata_o;
    assign i_imem_req_i = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_req;
    assign i_imem_rready_i = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rready;
    assign i_imem_rst_ni = ctrl_reg_array_Reset_to_Reset_reset;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rvalid = i_imem_rvalid_o;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rvalidpar = i_imem_rvalidpar_o;
    assign i_imem_wdata_i = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_wdata;
    assign i_imem_we_i = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_we;
    // jtag_dbg_wrapper assignments:
    assign jtag_dbg_wrapper_clk_i = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign jtag_dbg_wrapper_core_reset_to_i_ibex_wrapper_Reset_reset = jtag_dbg_wrapper_core_reset;
    assign jtag_dbg_wrapper_Debug_to_i_ibex_wrapper_Debug_debug_req = jtag_dbg_wrapper_debug_req_irq_o;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_addr = jtag_dbg_wrapper_initiator_addr_o;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_be = jtag_dbg_wrapper_initiator_be_o;
    assign jtag_dbg_wrapper_initiator_err_i = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_err;
    assign jtag_dbg_wrapper_initiator_gnt_i = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_gnt;
    assign jtag_dbg_wrapper_initiator_rdata_i = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rdata;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_req = jtag_dbg_wrapper_initiator_req_o;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_reqpar = jtag_dbg_wrapper_initiator_reqpar_o;
    assign jtag_dbg_wrapper_initiator_rvalid_i = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rvalid;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_wdata = jtag_dbg_wrapper_initiator_wdata_o;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_we = jtag_dbg_wrapper_initiator_we_o;
    assign jtag_dbg_wrapper_jtag_tck_i = jtag_dbg_wrapper_JTAG_to_JTAG_tck;
    assign jtag_dbg_wrapper_jtag_td_i = jtag_dbg_wrapper_JTAG_to_JTAG_tdi;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tdo = jtag_dbg_wrapper_jtag_td_o;
    assign jtag_dbg_wrapper_jtag_tms_i = jtag_dbg_wrapper_JTAG_to_JTAG_tms;
    assign jtag_dbg_wrapper_jtag_trst_ni = jtag_dbg_wrapper_JTAG_to_JTAG_trst;
    assign jtag_dbg_wrapper_rstn_i = ctrl_reg_array_Reset_to_Reset_reset;
    assign jtag_dbg_wrapper_target_addr_i = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_addr;
    assign jtag_dbg_wrapper_target_aid_i = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_aid;
    assign jtag_dbg_wrapper_target_be_i = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_be;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_gnt = jtag_dbg_wrapper_target_gnt_o;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_gntpar = jtag_dbg_wrapper_target_gntpar_o;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rdata = jtag_dbg_wrapper_target_rdata_o;
    assign jtag_dbg_wrapper_target_req_i = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_req;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rid = jtag_dbg_wrapper_target_rid_o;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rvalid = jtag_dbg_wrapper_target_rvalid_o;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rvalidpar = jtag_dbg_wrapper_target_rvalidpar_o;
    assign jtag_dbg_wrapper_target_wdata_i = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_wdata;
    assign jtag_dbg_wrapper_target_we_i = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_we;
    // peripherals_obi_to_apb assignments:
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PADDR = peripherals_obi_to_apb_APB_GPIO_PADDR;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PENABLE = peripherals_obi_to_apb_APB_GPIO_PENABLE;
    assign peripherals_obi_to_apb_APB_GPIO_PRDATA = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PRDATA;
    assign peripherals_obi_to_apb_APB_GPIO_PREADY = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PREADY;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PSEL = peripherals_obi_to_apb_APB_GPIO_PSEL;
    assign peripherals_obi_to_apb_APB_GPIO_PSLVERR = peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PSLVERR;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PWDATA = peripherals_obi_to_apb_APB_GPIO_PWDATA;
    assign peripherals_obi_to_apb_apb_gpio_to_apb_gpio_APB_PWRITE = peripherals_obi_to_apb_APB_GPIO_PWRITE;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PADDR = peripherals_obi_to_apb_APB_SPI_PADDR;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PENABLE = peripherals_obi_to_apb_APB_SPI_PENABLE;
    assign peripherals_obi_to_apb_APB_SPI_PRDATA = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PRDATA;
    assign peripherals_obi_to_apb_APB_SPI_PREADY = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PREADY;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PSEL = peripherals_obi_to_apb_APB_SPI_PSEL;
    assign peripherals_obi_to_apb_APB_SPI_PSLVERR = peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PSLVERR;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PWDATA = peripherals_obi_to_apb_APB_SPI_PWDATA;
    assign peripherals_obi_to_apb_apb_spi_to_apb_spi_master_APB_PWRITE = peripherals_obi_to_apb_APB_SPI_PWRITE;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PADDR = peripherals_obi_to_apb_APB_UART_PADDR;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PENABLE = peripherals_obi_to_apb_APB_UART_PENABLE;
    assign peripherals_obi_to_apb_APB_UART_PRDATA = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PRDATA;
    assign peripherals_obi_to_apb_APB_UART_PREADY = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PREADY;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PSEL = peripherals_obi_to_apb_APB_UART_PSEL;
    assign peripherals_obi_to_apb_APB_UART_PSLVERR = peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PSLVERR;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PWDATA = peripherals_obi_to_apb_APB_UART_PWDATA;
    assign peripherals_obi_to_apb_apb_uart_to_apb_uart_APB_PWRITE = peripherals_obi_to_apb_APB_UART_PWRITE;
    assign peripherals_obi_to_apb_addr = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_addr;
    assign peripherals_obi_to_apb_aid = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_aid;
    assign peripherals_obi_to_apb_be = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_be;
    assign peripherals_obi_to_apb_clk = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_err = peripherals_obi_to_apb_err;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_gnt = peripherals_obi_to_apb_gnt;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_gntpar = peripherals_obi_to_apb_gntpar;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rdata = peripherals_obi_to_apb_rdata;
    assign peripherals_obi_to_apb_req = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_req;
    assign peripherals_obi_to_apb_reqpar = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_reqpar;
    assign peripherals_obi_to_apb_reset_n = ctrl_reg_array_Reset_to_Reset_reset;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rid = peripherals_obi_to_apb_rid;
    assign peripherals_obi_to_apb_rready = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rready;
    assign peripherals_obi_to_apb_rreadypar = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rreadypar;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rvalid = peripherals_obi_to_apb_rvalid;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rvalidpar = peripherals_obi_to_apb_rvalidpar;
    assign peripherals_obi_to_apb_wdata = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_wdata;
    assign peripherals_obi_to_apb_we = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_we;
    // sysctrl_obi_xbar assignments:
    assign sysctrl_obi_xbar_clk = jtag_dbg_wrapper_Clock_to_Clk_clk;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_addr = sysctrl_obi_xbar_ctrl_addr;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_be = sysctrl_obi_xbar_ctrl_be;
    assign sysctrl_obi_xbar_ctrl_err = 1'b0;
    assign sysctrl_obi_xbar_ctrl_gnt = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_gnt;
    assign sysctrl_obi_xbar_ctrl_gntpar = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_gntpar;
    assign sysctrl_obi_xbar_ctrl_rdata = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rdata;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_req = sysctrl_obi_xbar_ctrl_req;
    assign sysctrl_obi_xbar_ctrl_rid = 'h0;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rready = sysctrl_obi_xbar_ctrl_rready;
    assign sysctrl_obi_xbar_ctrl_rvalid = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rvalid;
    assign sysctrl_obi_xbar_ctrl_rvalidpar = ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_rvalidpar;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_wdata = sysctrl_obi_xbar_ctrl_wdata;
    assign ctrl_reg_array_obi_target_to_sysctrl_obi_xbar_obi_ctrl_we = sysctrl_obi_xbar_ctrl_we;
    assign sysctrl_obi_xbar_data_addr = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_addr;
    assign sysctrl_obi_xbar_data_aid = 'h0;
    assign sysctrl_obi_xbar_data_be = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_be;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_err = sysctrl_obi_xbar_data_err;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_gnt = sysctrl_obi_xbar_data_gnt;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rdata = sysctrl_obi_xbar_data_rdata;
    assign sysctrl_obi_xbar_data_req = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_req;
    assign sysctrl_obi_xbar_data_reqpar = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_reqpar;
    assign sysctrl_obi_xbar_data_rready = 1'b1;
    assign sysctrl_obi_xbar_data_rreadypar = 1'b0;
    assign i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_rvalid = sysctrl_obi_xbar_data_rvalid;
    assign sysctrl_obi_xbar_data_wdata = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_wdata;
    assign sysctrl_obi_xbar_data_we = i_ibex_wrapper_dmem_to_sysctrl_obi_xbar_obi_core_dmem_we;
    assign sysctrl_obi_xbar_dm_init_addr = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_addr;
    assign sysctrl_obi_xbar_dm_init_aid = 'h0;
    assign sysctrl_obi_xbar_dm_init_be = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_be;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_err = sysctrl_obi_xbar_dm_init_err;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_gnt = sysctrl_obi_xbar_dm_init_gnt;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rdata = sysctrl_obi_xbar_dm_init_rdata;
    assign sysctrl_obi_xbar_dm_init_req = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_req;
    assign sysctrl_obi_xbar_dm_init_reqpar = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_reqpar;
    assign sysctrl_obi_xbar_dm_init_rready = 1'b1;
    assign sysctrl_obi_xbar_dm_init_rreadypar = 1'b0;
    assign jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_rvalid = sysctrl_obi_xbar_dm_init_rvalid;
    assign sysctrl_obi_xbar_dm_init_wdata = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_wdata;
    assign sysctrl_obi_xbar_dm_init_we = jtag_dbg_wrapper_OBI_I_to_sysctrl_obi_xbar_obi_jtag_dm_init_we;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_addr = sysctrl_obi_xbar_dm_target_addr;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_aid = sysctrl_obi_xbar_dm_target_aid;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_be = sysctrl_obi_xbar_dm_target_be;
    assign sysctrl_obi_xbar_dm_target_err = 1'b0;
    assign sysctrl_obi_xbar_dm_target_gnt = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_gnt;
    assign sysctrl_obi_xbar_dm_target_gntpar = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_gntpar;
    assign sysctrl_obi_xbar_dm_target_rdata = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rdata;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_req = sysctrl_obi_xbar_dm_target_req;
    assign sysctrl_obi_xbar_dm_target_rid = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rid;
    assign sysctrl_obi_xbar_dm_target_rvalid = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rvalid;
    assign sysctrl_obi_xbar_dm_target_rvalidpar = jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_rvalidpar;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_wdata = sysctrl_obi_xbar_dm_target_wdata;
    assign jtag_dbg_wrapper_OBI_T_to_sysctrl_obi_xbar_obi_jtag_dm_target_we = sysctrl_obi_xbar_dm_target_we;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_addr = sysctrl_obi_xbar_dmem_addr;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_be = sysctrl_obi_xbar_dmem_be;
    assign sysctrl_obi_xbar_dmem_err = 1'b0;
    assign sysctrl_obi_xbar_dmem_gnt = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_gnt;
    assign sysctrl_obi_xbar_dmem_gntpar = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_gntpar;
    assign sysctrl_obi_xbar_dmem_rdata = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rdata;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_req = sysctrl_obi_xbar_dmem_req;
    assign sysctrl_obi_xbar_dmem_rid = 'h0;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rready = sysctrl_obi_xbar_dmem_rready;
    assign sysctrl_obi_xbar_dmem_rvalid = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rvalid;
    assign sysctrl_obi_xbar_dmem_rvalidpar = i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_rvalidpar;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_wdata = sysctrl_obi_xbar_dmem_wdata;
    assign i_dmem_mem_to_sysctrl_obi_xbar_obi_dmem_we = sysctrl_obi_xbar_dmem_we;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_addr = sysctrl_obi_xbar_imem_addr;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_be = sysctrl_obi_xbar_imem_be;
    assign sysctrl_obi_xbar_imem_err = 1'b0;
    assign sysctrl_obi_xbar_imem_gnt = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_gnt;
    assign sysctrl_obi_xbar_imem_gntpar = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_gntpar;
    assign sysctrl_obi_xbar_imem_rdata = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rdata;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_req = sysctrl_obi_xbar_imem_req;
    assign sysctrl_obi_xbar_imem_rid = 'h0;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rready = sysctrl_obi_xbar_imem_rready;
    assign sysctrl_obi_xbar_imem_rvalid = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rvalid;
    assign sysctrl_obi_xbar_imem_rvalidpar = i_imem_mem_to_sysctrl_obi_xbar_obi_imem_rvalidpar;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_wdata = sysctrl_obi_xbar_imem_wdata;
    assign i_imem_mem_to_sysctrl_obi_xbar_obi_imem_we = sysctrl_obi_xbar_imem_we;
    assign sysctrl_obi_xbar_instr_addr = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_addr;
    assign sysctrl_obi_xbar_instr_aid = 'h0;
    assign sysctrl_obi_xbar_instr_be = ~0;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_err = sysctrl_obi_xbar_instr_err;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_gnt = sysctrl_obi_xbar_instr_gnt;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rdata = sysctrl_obi_xbar_instr_rdata;
    assign sysctrl_obi_xbar_instr_req = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_req;
    assign sysctrl_obi_xbar_instr_reqpar = i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_reqpar;
    assign sysctrl_obi_xbar_instr_rready = 1'b1;
    assign sysctrl_obi_xbar_instr_rreadypar = 1'b0;
    assign i_ibex_wrapper_imem_to_sysctrl_obi_xbar_obi_core_imem_rvalid = sysctrl_obi_xbar_instr_rvalid;
    assign sysctrl_obi_xbar_instr_wdata = 'h0;
    assign sysctrl_obi_xbar_instr_we = 1'b0;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_addr = sysctrl_obi_xbar_periph_addr;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_aid = sysctrl_obi_xbar_periph_aid;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_be = sysctrl_obi_xbar_periph_be;
    assign sysctrl_obi_xbar_periph_err = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_err;
    assign sysctrl_obi_xbar_periph_gnt = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_gnt;
    assign sysctrl_obi_xbar_periph_gntpar = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_gntpar;
    assign sysctrl_obi_xbar_periph_rdata = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rdata;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_req = sysctrl_obi_xbar_periph_req;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_reqpar = sysctrl_obi_xbar_periph_reqpar;
    assign sysctrl_obi_xbar_periph_rid = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rid;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rready = sysctrl_obi_xbar_periph_rready;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rreadypar = sysctrl_obi_xbar_periph_rreadypar;
    assign sysctrl_obi_xbar_periph_rvalid = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rvalid;
    assign sysctrl_obi_xbar_periph_rvalidpar = sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_rvalidpar;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_wdata = sysctrl_obi_xbar_periph_wdata;
    assign sysctrl_obi_xbar_obi_peripherals_to_peripherals_obi_to_apb_obi_we = sysctrl_obi_xbar_periph_we;
    assign sysctrl_obi_xbar_reset_n = ctrl_reg_array_Reset_to_Reset_reset;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_addr = sysctrl_obi_xbar_top_addr;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_aid = sysctrl_obi_xbar_top_aid;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_be = sysctrl_obi_xbar_top_be;
    assign sysctrl_obi_xbar_top_err = sysctrl_obi_xbar_obi_chip_top_to_OBI_err;
    assign sysctrl_obi_xbar_top_gnt = sysctrl_obi_xbar_obi_chip_top_to_OBI_gnt;
    assign sysctrl_obi_xbar_top_gntpar = sysctrl_obi_xbar_obi_chip_top_to_OBI_gntpar;
    assign sysctrl_obi_xbar_top_rdata = sysctrl_obi_xbar_obi_chip_top_to_OBI_rdata;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_req = sysctrl_obi_xbar_top_req;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_reqpar = sysctrl_obi_xbar_top_reqpar;
    assign sysctrl_obi_xbar_top_rid = sysctrl_obi_xbar_obi_chip_top_to_OBI_rid;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_rready = sysctrl_obi_xbar_top_rready;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_rreadypar = sysctrl_obi_xbar_top_rreadypar;
    assign sysctrl_obi_xbar_top_rvalid = sysctrl_obi_xbar_obi_chip_top_to_OBI_rvalid;
    assign sysctrl_obi_xbar_top_rvalidpar = sysctrl_obi_xbar_obi_chip_top_to_OBI_rvalidpar;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_wdata = sysctrl_obi_xbar_top_wdata;
    assign sysctrl_obi_xbar_obi_chip_top_to_OBI_we = sysctrl_obi_xbar_top_we;

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:APB_GPIO:1.0
    apb_gpio #(
        .APB_ADDR_WIDTH      (12),
        .PAD_NUM             (16),
        .NBIT_PADCFG         (0))
    apb_gpio(
        // Interface: APB
        .PADDR               (apb_gpio_PADDR),
        .PENABLE             (apb_gpio_PENABLE),
        .PSEL                (apb_gpio_PSEL),
        .PWDATA              (apb_gpio_PWDATA),
        .PWRITE              (apb_gpio_PWRITE),
        .PRDATA              (apb_gpio_PRDATA),
        .PREADY              (apb_gpio_PREADY),
        .PSLVERR             (apb_gpio_PSLVERR),
        // Interface: Clock
        .HCLK                (apb_gpio_HCLK),
        // Interface: GPIO
        .gpio_in             (apb_gpio_gpio_in),
        .gpio_dir            (),
        .gpio_out            (apb_gpio_gpio_out),
        // Interface: IRQ
        .interrupt           (apb_gpio_interrupt),
        // Interface: Reset_n
        .HRESETn             (apb_gpio_HRESETn),
        // These ports are not in any interface
        .dft_cg_enable_i     (1'b0),
        .gpio_in_sync        (),
        .gpio_padcfg         ());

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:apb_spi_master:1.0
    apb_spi_master #(
        .APB_ADDR_WIDTH      (12))
    apb_spi_master(
        // Interface: APB
        .PADDR               (apb_spi_master_PADDR),
        .PENABLE             (apb_spi_master_PENABLE),
        .PSEL                (apb_spi_master_PSEL),
        .PWDATA              (apb_spi_master_PWDATA),
        .PWRITE              (apb_spi_master_PWRITE),
        .PRDATA              (apb_spi_master_PRDATA),
        .PREADY              (apb_spi_master_PREADY),
        .PSLVERR             (apb_spi_master_PSLVERR),
        // Interface: Clock
        .HCLK                (apb_spi_master_HCLK),
        // Interface: IRQ
        .events_o            (apb_spi_master_events_o),
        // Interface: Reset_n
        .HRESETn             (apb_spi_master_HRESETn),
        // Interface: SPI
        .spi_sdi0            (apb_spi_master_spi_sdi0),
        .spi_sdi1            (apb_spi_master_spi_sdi1),
        .spi_sdi2            (apb_spi_master_spi_sdi2),
        .spi_sdi3            (apb_spi_master_spi_sdi3),
        .spi_clk             (apb_spi_master_spi_clk),
        .spi_csn0            (apb_spi_master_spi_csn0),
        .spi_csn1            (apb_spi_master_spi_csn1),
        .spi_csn2            (apb_spi_master_spi_csn2),
        .spi_csn3            (apb_spi_master_spi_csn3),
        .spi_mode            (),
        .spi_sdo0            (apb_spi_master_spi_sdo0),
        .spi_sdo1            (apb_spi_master_spi_sdo1),
        .spi_sdo2            (apb_spi_master_spi_sdo2),
        .spi_sdo3            (apb_spi_master_spi_sdo3));

    // IP-XACT VLNV: tuni.fi:pulp.peripheral:apb_uart:1.0
    apb_uart apb_uart(
        // Interface: APB
        .PADDR               (apb_uart_PADDR),
        .PENABLE             (apb_uart_PENABLE),
        .PSEL                (apb_uart_PSEL),
        .PWDATA              (apb_uart_PWDATA),
        .PWRITE              (apb_uart_PWRITE),
        .PRDATA              (apb_uart_PRDATA),
        .PREADY              (apb_uart_PREADY),
        .PSLVERR             (apb_uart_PSLVERR),
        // Interface: Clock
        .CLK                 (apb_uart_CLK),
        // Interface: IRQ
        .INT                 (apb_uart_INT),
        // Interface: Reset
        .RSTN                (apb_uart_RSTN),
        // Interface: UART
        .SIN                 (apb_uart_SIN),
        .SOUT                (apb_uart_SOUT),
        // These ports are not in any interface
        .CTSN                (1'b0),
        .DCDN                (1'b0),
        .DSRN                (1'b0),
        .RIN                 (1'b0),
        .DTRN                (),
        .OUT1N               (),
        .OUT2N               (),
        .RTSN                ());

    // IP-XACT VLNV: tuni.fi:ip:SS_Ctrl_reg_array:1.1
    SS_Ctrl_reg_array #(
        .IOCELL_COUNT        (25),
        .IOCELL_CFG_W        (10),
        .AW                  (32),
        .DW                  (32),
        .SS_CTRL_W           (8),
        .NUM_SS              (5))
    ctrl_reg_array(
        // Interface: Clock
        .clk                 (ctrl_reg_array_clk),
        // Interface: Reset
        .reset_n             (ctrl_reg_array_reset_n),
        // Interface: fetch_en
        .fetch_en            (ctrl_reg_array_fetch_en),
        // Interface: icn_ss_ctrl
        .ss_ctrl_icn         (ctrl_reg_array_ss_ctrl_icn),
        // Interface: io_cfg
        .cell_cfg            (ctrl_reg_array_cell_cfg),
        // Interface: obi_target
        .addr_i              (ctrl_reg_array_addr_i),
        .be_i                (ctrl_reg_array_be_i),
        .req_i               (ctrl_reg_array_req_i),
        .rready_i            (ctrl_reg_array_rready_i),
        .wdata_i             (ctrl_reg_array_wdata_i),
        .we_i                (ctrl_reg_array_we_i),
        .gnt_o               (ctrl_reg_array_gnt_o),
        .gntpar_o            (ctrl_reg_array_gntpar_o),
        .rdata_o             (ctrl_reg_array_rdata_o),
        .rvalid_o            (ctrl_reg_array_rvalid_o),
        .rvalidpar_o         (ctrl_reg_array_rvalidpar_o),
        // Interface: pmod_sel
        .pmod_sel            (ctrl_reg_array_pmod_sel),
        // Interface: rst_icn
        .reset_icn           (ctrl_reg_array_reset_icn),
        // Interface: rst_ss
        .reset_ss            (ctrl_reg_array_reset_ss),
        // Interface: ss_ctrl_0
        .irq_en_0            (ctrl_reg_array_irq_en_0),
        .ss_ctrl_0           (ctrl_reg_array_ss_ctrl_0),
        // Interface: ss_ctrl_1
        .irq_en_1            (ctrl_reg_array_irq_en_1),
        .ss_ctrl_1           (ctrl_reg_array_ss_ctrl_1),
        // Interface: ss_ctrl_2
        .irq_en_2            (ctrl_reg_array_irq_en_2),
        .ss_ctrl_2           (ctrl_reg_array_ss_ctrl_2),
        // Interface: ss_ctrl_3
        .irq_en_3            (ctrl_reg_array_irq_en_3),
        .ss_ctrl_3           (ctrl_reg_array_ss_ctrl_3),
        // Interface: ss_ctrl_4
        .irq_en_4            (ctrl_reg_array_irq_en_4),
        .ss_ctrl_4           (ctrl_reg_array_ss_ctrl_4));

    // IP-XACT VLNV: tuni.fi:memory.simulation:sp_sram:1.1
    sp_sram #(
        .DATA_WIDTH          (32),
        .NUM_WORDS           (4096))
    i_dmem(
        // Interface: Clock
        .clk_i               (i_dmem_clk_i),
        // Interface: Reset
        .rst_ni              (i_dmem_rst_ni),
        // Interface: mem
        .addr_i              (i_dmem_addr_i),
        .be_i                (i_dmem_be_i),
        .req_i               (i_dmem_req_i),
        .rready_i            (i_dmem_rready_i),
        .wdata_i             (i_dmem_wdata_i),
        .we_i                (i_dmem_we_i),
        .gnt_o               (i_dmem_gnt_o),
        .gntpar_o            (i_dmem_gntpar_o),
        .rdata_o             (i_dmem_rdata_o),
        .rvalid_o            (i_dmem_rvalid_o),
        .rvalidpar_o         (i_dmem_rvalidpar_o));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex:1.1
    ibex_wrapper #(
        .DmHaltAddr          (16910336),
        .DmExceptionAddr     (16910358),
        .DmBaseAddr          (16908288))
    i_ibex_wrapper(
        // Interface: Clock
        .clk_i               (i_ibex_wrapper_clk_i),
        // Interface: Debug
        .debug_req_i         (i_ibex_wrapper_debug_req_i),
        // Interface: FetchEn
        .fetch_enable_i      (i_ibex_wrapper_fetch_enable_i),
        // Interface: IRQ_fast
        .irq_fast_i          (i_ibex_wrapper_irq_fast_i),
        // Interface: Reset
        .rst_ni              (i_ibex_wrapper_rst_ni),
        // Interface: dmem
        .data_err_i          (i_ibex_wrapper_data_err_i),
        .data_gnt_i          (i_ibex_wrapper_data_gnt_i),
        .data_rdata_i        (i_ibex_wrapper_data_rdata_i),
        .data_rvalid_i       (i_ibex_wrapper_data_rvalid_i),
        .data_addr_o         (i_ibex_wrapper_data_addr_o),
        .data_be_o           (i_ibex_wrapper_data_be_o),
        .data_req_o          (i_ibex_wrapper_data_req_o),
        .data_reqpar_o       (i_ibex_wrapper_data_reqpar_o),
        .data_wdata_o        (i_ibex_wrapper_data_wdata_o),
        .data_we_o           (i_ibex_wrapper_data_we_o),
        // Interface: imem
        .instr_err_i         (i_ibex_wrapper_instr_err_i),
        .instr_gnt_i         (i_ibex_wrapper_instr_gnt_i),
        .instr_rdata_i       (i_ibex_wrapper_instr_rdata_i),
        .instr_rvalid_i      (i_ibex_wrapper_instr_rvalid_i),
        .instr_addr_o        (i_ibex_wrapper_instr_addr_o),
        .instr_req_o         (i_ibex_wrapper_instr_req_o),
        .instr_reqpar_o      (i_ibex_wrapper_instr_reqpar_o),
        // These ports are not in any interface
        .boot_addr_i         (32'h1040100),
        .data_rdata_intg_i   (7'h0),
        .hart_id_i           (32'h0),
        .instr_rdata_intg_i  (7'h0),
        .irq_external_i      (1'b0),
        .irq_nm_i            (1'b0),
        .irq_software_i      (1'b0),
        .irq_timer_i         (1'b0),
        .ram_cfg_i           ('h0),
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
        .data_wdata_intg_o   (),
        .double_fault_seen_o (),
        .scramble_req_o      ());

    // IP-XACT VLNV: tuni.fi:memory.simulation:sp_sram:1.1
    sp_sram #(
        .DATA_WIDTH          (32),
        .NUM_WORDS           (4096))
    i_imem(
        // Interface: Clock
        .clk_i               (i_imem_clk_i),
        // Interface: Reset
        .rst_ni              (i_imem_rst_ni),
        // Interface: mem
        .addr_i              (i_imem_addr_i),
        .be_i                (i_imem_be_i),
        .req_i               (i_imem_req_i),
        .rready_i            (i_imem_rready_i),
        .wdata_i             (i_imem_wdata_i),
        .we_i                (i_imem_we_i),
        .gnt_o               (i_imem_gnt_o),
        .gntpar_o            (i_imem_gntpar_o),
        .rdata_o             (i_imem_rdata_o),
        .rvalid_o            (i_imem_rvalid_o),
        .rvalidpar_o         (i_imem_rvalidpar_o));

    // IP-XACT VLNV: tuni.fi:ip:jtag_dbg_wrapper_obi:1.0
    jtag_dbg_wrapper_obi #(
        .DM_BASE_ADDRESS     (16908288),
        .DM_ID_VALUE         (470810337))
    jtag_dbg_wrapper(
        // Interface: Clock
        .clk_i               (jtag_dbg_wrapper_clk_i),
        // Interface: Debug
        .debug_req_irq_o     (jtag_dbg_wrapper_debug_req_irq_o),
        // Interface: JTAG
        .jtag_tck_i          (jtag_dbg_wrapper_jtag_tck_i),
        .jtag_td_i           (jtag_dbg_wrapper_jtag_td_i),
        .jtag_tms_i          (jtag_dbg_wrapper_jtag_tms_i),
        .jtag_trst_ni        (jtag_dbg_wrapper_jtag_trst_ni),
        .jtag_td_o           (jtag_dbg_wrapper_jtag_td_o),
        // Interface: OBI_I
        .initiator_err_i     (jtag_dbg_wrapper_initiator_err_i),
        .initiator_gnt_i     (jtag_dbg_wrapper_initiator_gnt_i),
        .initiator_rdata_i   (jtag_dbg_wrapper_initiator_rdata_i),
        .initiator_rvalid_i  (jtag_dbg_wrapper_initiator_rvalid_i),
        .initiator_addr_o    (jtag_dbg_wrapper_initiator_addr_o),
        .initiator_be_o      (jtag_dbg_wrapper_initiator_be_o),
        .initiator_req_o     (jtag_dbg_wrapper_initiator_req_o),
        .initiator_reqpar_o  (jtag_dbg_wrapper_initiator_reqpar_o),
        .initiator_wdata_o   (jtag_dbg_wrapper_initiator_wdata_o),
        .initiator_we_o      (jtag_dbg_wrapper_initiator_we_o),
        // Interface: OBI_T
        .target_addr_i       (jtag_dbg_wrapper_target_addr_i),
        .target_aid_i        (jtag_dbg_wrapper_target_aid_i),
        .target_be_i         (jtag_dbg_wrapper_target_be_i),
        .target_req_i        (jtag_dbg_wrapper_target_req_i),
        .target_wdata_i      (jtag_dbg_wrapper_target_wdata_i),
        .target_we_i         (jtag_dbg_wrapper_target_we_i),
        .target_gnt_o        (jtag_dbg_wrapper_target_gnt_o),
        .target_gntpar_o     (jtag_dbg_wrapper_target_gntpar_o),
        .target_rdata_o      (jtag_dbg_wrapper_target_rdata_o),
        .target_rid_o        (jtag_dbg_wrapper_target_rid_o),
        .target_rvalid_o     (jtag_dbg_wrapper_target_rvalid_o),
        .target_rvalidpar_o  (jtag_dbg_wrapper_target_rvalidpar_o),
        // Interface: Reset
        .rstn_i              (jtag_dbg_wrapper_rstn_i),
        // Interface: core_reset
        .core_reset          (jtag_dbg_wrapper_core_reset),
        // These ports are not in any interface
        .ndmreset_o          ());

    // IP-XACT VLNV: tuni.fi:interconnect:peripherals_obi_to_apb:1.0
    peripherals_obi_to_apb #(
        .OBI_DW              (32),
        .OBI_AW              (32),
        .OBI_CHKW            (1),
        .OBI_USERW           (1),
        .OBI_IDW             (1))
    peripherals_obi_to_apb(
        // Interface: apb_gpio
        .APB_GPIO_PRDATA     (peripherals_obi_to_apb_APB_GPIO_PRDATA),
        .APB_GPIO_PREADY     (peripherals_obi_to_apb_APB_GPIO_PREADY),
        .APB_GPIO_PSLVERR    (peripherals_obi_to_apb_APB_GPIO_PSLVERR),
        .APB_GPIO_PADDR      (peripherals_obi_to_apb_APB_GPIO_PADDR),
        .APB_GPIO_PENABLE    (peripherals_obi_to_apb_APB_GPIO_PENABLE),
        .APB_GPIO_PSEL       (peripherals_obi_to_apb_APB_GPIO_PSEL),
        .APB_GPIO_PWDATA     (peripherals_obi_to_apb_APB_GPIO_PWDATA),
        .APB_GPIO_PWRITE     (peripherals_obi_to_apb_APB_GPIO_PWRITE),
        // Interface: apb_spi
        .APB_SPI_PRDATA      (peripherals_obi_to_apb_APB_SPI_PRDATA),
        .APB_SPI_PREADY      (peripherals_obi_to_apb_APB_SPI_PREADY),
        .APB_SPI_PSLVERR     (peripherals_obi_to_apb_APB_SPI_PSLVERR),
        .APB_SPI_PADDR       (peripherals_obi_to_apb_APB_SPI_PADDR),
        .APB_SPI_PENABLE     (peripherals_obi_to_apb_APB_SPI_PENABLE),
        .APB_SPI_PSEL        (peripherals_obi_to_apb_APB_SPI_PSEL),
        .APB_SPI_PWDATA      (peripherals_obi_to_apb_APB_SPI_PWDATA),
        .APB_SPI_PWRITE      (peripherals_obi_to_apb_APB_SPI_PWRITE),
        // Interface: apb_uart
        .APB_UART_PRDATA     (peripherals_obi_to_apb_APB_UART_PRDATA),
        .APB_UART_PREADY     (peripherals_obi_to_apb_APB_UART_PREADY),
        .APB_UART_PSLVERR    (peripherals_obi_to_apb_APB_UART_PSLVERR),
        .APB_UART_PADDR      (peripherals_obi_to_apb_APB_UART_PADDR),
        .APB_UART_PENABLE    (peripherals_obi_to_apb_APB_UART_PENABLE),
        .APB_UART_PSEL       (peripherals_obi_to_apb_APB_UART_PSEL),
        .APB_UART_PWDATA     (peripherals_obi_to_apb_APB_UART_PWDATA),
        .APB_UART_PWRITE     (peripherals_obi_to_apb_APB_UART_PWRITE),
        // Interface: clock
        .clk                 (peripherals_obi_to_apb_clk),
        // Interface: obi
        .addr                (peripherals_obi_to_apb_addr),
        .aid                 (peripherals_obi_to_apb_aid),
        .be                  (peripherals_obi_to_apb_be),
        .req                 (peripherals_obi_to_apb_req),
        .reqpar              (peripherals_obi_to_apb_reqpar),
        .rready              (peripherals_obi_to_apb_rready),
        .rreadypar           (peripherals_obi_to_apb_rreadypar),
        .wdata               (peripherals_obi_to_apb_wdata),
        .we                  (peripherals_obi_to_apb_we),
        .err                 (peripherals_obi_to_apb_err),
        .gnt                 (peripherals_obi_to_apb_gnt),
        .gntpar              (peripherals_obi_to_apb_gntpar),
        .rdata               (peripherals_obi_to_apb_rdata),
        .rid                 (peripherals_obi_to_apb_rid),
        .rvalid              (peripherals_obi_to_apb_rvalid),
        .rvalidpar           (peripherals_obi_to_apb_rvalidpar),
        // Interface: reset
        .reset_n             (peripherals_obi_to_apb_reset_n));

    // IP-XACT VLNV: tuni.fi:interconnect:sysctrl_obi_xbar:1.0
    sysctrl_obi_xbar #(
        .OBI_AW              (32),
        .OBI_CHKW            (1),
        .OBI_DW              (32),
        .OBI_IDW             (1),
        .OBI_USERW           (1))
    sysctrl_obi_xbar(
        // Interface: clock
        .clk                 (sysctrl_obi_xbar_clk),
        // Interface: obi_chip_top
        .top_err             (sysctrl_obi_xbar_top_err),
        .top_gnt             (sysctrl_obi_xbar_top_gnt),
        .top_gntpar          (sysctrl_obi_xbar_top_gntpar),
        .top_rdata           (sysctrl_obi_xbar_top_rdata),
        .top_rid             (sysctrl_obi_xbar_top_rid),
        .top_rvalid          (sysctrl_obi_xbar_top_rvalid),
        .top_rvalidpar       (sysctrl_obi_xbar_top_rvalidpar),
        .top_addr            (sysctrl_obi_xbar_top_addr),
        .top_aid             (sysctrl_obi_xbar_top_aid),
        .top_be              (sysctrl_obi_xbar_top_be),
        .top_req             (sysctrl_obi_xbar_top_req),
        .top_reqpar          (sysctrl_obi_xbar_top_reqpar),
        .top_rready          (sysctrl_obi_xbar_top_rready),
        .top_rreadypar       (sysctrl_obi_xbar_top_rreadypar),
        .top_wdata           (sysctrl_obi_xbar_top_wdata),
        .top_we              (sysctrl_obi_xbar_top_we),
        // Interface: obi_core_dmem
        .data_addr           (sysctrl_obi_xbar_data_addr),
        .data_aid            (sysctrl_obi_xbar_data_aid),
        .data_be             (sysctrl_obi_xbar_data_be),
        .data_req            (sysctrl_obi_xbar_data_req),
        .data_reqpar         (sysctrl_obi_xbar_data_reqpar),
        .data_rready         (sysctrl_obi_xbar_data_rready),
        .data_rreadypar      (sysctrl_obi_xbar_data_rreadypar),
        .data_wdata          (sysctrl_obi_xbar_data_wdata),
        .data_we             (sysctrl_obi_xbar_data_we),
        .data_err            (sysctrl_obi_xbar_data_err),
        .data_gnt            (sysctrl_obi_xbar_data_gnt),
        .data_gntpar         (),
        .data_rdata          (sysctrl_obi_xbar_data_rdata),
        .data_rid            (sysctrl_obi_xbar_data_rid),
        .data_rvalid         (sysctrl_obi_xbar_data_rvalid),
        .data_rvalidpar      (),
        // Interface: obi_core_imem
        .instr_addr          (sysctrl_obi_xbar_instr_addr),
        .instr_aid           (sysctrl_obi_xbar_instr_aid),
        .instr_be            (sysctrl_obi_xbar_instr_be),
        .instr_req           (sysctrl_obi_xbar_instr_req),
        .instr_reqpar        (sysctrl_obi_xbar_instr_reqpar),
        .instr_rready        (sysctrl_obi_xbar_instr_rready),
        .instr_rreadypar     (sysctrl_obi_xbar_instr_rreadypar),
        .instr_wdata         (sysctrl_obi_xbar_instr_wdata),
        .instr_we            (sysctrl_obi_xbar_instr_we),
        .instr_err           (sysctrl_obi_xbar_instr_err),
        .instr_gnt           (sysctrl_obi_xbar_instr_gnt),
        .instr_gntpar        (),
        .instr_rdata         (sysctrl_obi_xbar_instr_rdata),
        .instr_rid           (sysctrl_obi_xbar_instr_rid),
        .instr_rvalid        (sysctrl_obi_xbar_instr_rvalid),
        .instr_rvalidpar     (),
        // Interface: obi_ctrl
        .ctrl_err            (sysctrl_obi_xbar_ctrl_err),
        .ctrl_gnt            (sysctrl_obi_xbar_ctrl_gnt),
        .ctrl_gntpar         (sysctrl_obi_xbar_ctrl_gntpar),
        .ctrl_rdata          (sysctrl_obi_xbar_ctrl_rdata),
        .ctrl_rid            (sysctrl_obi_xbar_ctrl_rid),
        .ctrl_rvalid         (sysctrl_obi_xbar_ctrl_rvalid),
        .ctrl_rvalidpar      (sysctrl_obi_xbar_ctrl_rvalidpar),
        .ctrl_addr           (sysctrl_obi_xbar_ctrl_addr),
        .ctrl_aid            (sysctrl_obi_xbar_ctrl_aid),
        .ctrl_be             (sysctrl_obi_xbar_ctrl_be),
        .ctrl_req            (sysctrl_obi_xbar_ctrl_req),
        .ctrl_reqpar         (),
        .ctrl_rready         (sysctrl_obi_xbar_ctrl_rready),
        .ctrl_rreadypar      (sysctrl_obi_xbar_ctrl_rreadypar),
        .ctrl_wdata          (sysctrl_obi_xbar_ctrl_wdata),
        .ctrl_we             (sysctrl_obi_xbar_ctrl_we),
        // Interface: obi_dmem
        .dmem_err            (sysctrl_obi_xbar_dmem_err),
        .dmem_gnt            (sysctrl_obi_xbar_dmem_gnt),
        .dmem_gntpar         (sysctrl_obi_xbar_dmem_gntpar),
        .dmem_rdata          (sysctrl_obi_xbar_dmem_rdata),
        .dmem_rid            (sysctrl_obi_xbar_dmem_rid),
        .dmem_rvalid         (sysctrl_obi_xbar_dmem_rvalid),
        .dmem_rvalidpar      (sysctrl_obi_xbar_dmem_rvalidpar),
        .dmem_addr           (sysctrl_obi_xbar_dmem_addr),
        .dmem_aid            (sysctrl_obi_xbar_dmem_aid),
        .dmem_be             (sysctrl_obi_xbar_dmem_be),
        .dmem_req            (sysctrl_obi_xbar_dmem_req),
        .dmem_reqpar         (),
        .dmem_rready         (sysctrl_obi_xbar_dmem_rready),
        .dmem_rreadypar      (sysctrl_obi_xbar_dmem_rreadypar),
        .dmem_wdata          (sysctrl_obi_xbar_dmem_wdata),
        .dmem_we             (sysctrl_obi_xbar_dmem_we),
        // Interface: obi_imem
        .imem_err            (sysctrl_obi_xbar_imem_err),
        .imem_gnt            (sysctrl_obi_xbar_imem_gnt),
        .imem_gntpar         (sysctrl_obi_xbar_imem_gntpar),
        .imem_rdata          (sysctrl_obi_xbar_imem_rdata),
        .imem_rid            (sysctrl_obi_xbar_imem_rid),
        .imem_rvalid         (sysctrl_obi_xbar_imem_rvalid),
        .imem_rvalidpar      (sysctrl_obi_xbar_imem_rvalidpar),
        .imem_addr           (sysctrl_obi_xbar_imem_addr),
        .imem_aid            (sysctrl_obi_xbar_imem_aid),
        .imem_be             (sysctrl_obi_xbar_imem_be),
        .imem_req            (sysctrl_obi_xbar_imem_req),
        .imem_reqpar         (),
        .imem_rready         (sysctrl_obi_xbar_imem_rready),
        .imem_rreadypar      (sysctrl_obi_xbar_imem_rreadypar),
        .imem_wdata          (sysctrl_obi_xbar_imem_wdata),
        .imem_we             (sysctrl_obi_xbar_imem_we),
        // Interface: obi_jtag_dm_init
        .dm_init_addr        (sysctrl_obi_xbar_dm_init_addr),
        .dm_init_aid         (sysctrl_obi_xbar_dm_init_aid),
        .dm_init_be          (sysctrl_obi_xbar_dm_init_be),
        .dm_init_req         (sysctrl_obi_xbar_dm_init_req),
        .dm_init_reqpar      (sysctrl_obi_xbar_dm_init_reqpar),
        .dm_init_rready      (sysctrl_obi_xbar_dm_init_rready),
        .dm_init_rreadypar   (sysctrl_obi_xbar_dm_init_rreadypar),
        .dm_init_wdata       (sysctrl_obi_xbar_dm_init_wdata),
        .dm_init_we          (sysctrl_obi_xbar_dm_init_we),
        .dm_init_err         (sysctrl_obi_xbar_dm_init_err),
        .dm_init_gnt         (sysctrl_obi_xbar_dm_init_gnt),
        .dm_init_gntpar      (),
        .dm_init_rdata       (sysctrl_obi_xbar_dm_init_rdata),
        .dm_init_rid         (sysctrl_obi_xbar_dm_init_rid),
        .dm_init_rvalid      (sysctrl_obi_xbar_dm_init_rvalid),
        .dm_init_rvalidpar   (),
        // Interface: obi_jtag_dm_target
        .dm_target_err       (sysctrl_obi_xbar_dm_target_err),
        .dm_target_gnt       (sysctrl_obi_xbar_dm_target_gnt),
        .dm_target_gntpar    (sysctrl_obi_xbar_dm_target_gntpar),
        .dm_target_rdata     (sysctrl_obi_xbar_dm_target_rdata),
        .dm_target_rid       (sysctrl_obi_xbar_dm_target_rid),
        .dm_target_rvalid    (sysctrl_obi_xbar_dm_target_rvalid),
        .dm_target_rvalidpar (sysctrl_obi_xbar_dm_target_rvalidpar),
        .dm_target_addr      (sysctrl_obi_xbar_dm_target_addr),
        .dm_target_aid       (sysctrl_obi_xbar_dm_target_aid),
        .dm_target_be        (sysctrl_obi_xbar_dm_target_be),
        .dm_target_req       (sysctrl_obi_xbar_dm_target_req),
        .dm_target_reqpar    (),
        .dm_target_rready    (sysctrl_obi_xbar_dm_target_rready),
        .dm_target_rreadypar (sysctrl_obi_xbar_dm_target_rreadypar),
        .dm_target_wdata     (sysctrl_obi_xbar_dm_target_wdata),
        .dm_target_we        (sysctrl_obi_xbar_dm_target_we),
        // Interface: obi_peripherals
        .periph_err          (sysctrl_obi_xbar_periph_err),
        .periph_gnt          (sysctrl_obi_xbar_periph_gnt),
        .periph_gntpar       (sysctrl_obi_xbar_periph_gntpar),
        .periph_rdata        (sysctrl_obi_xbar_periph_rdata),
        .periph_rid          (sysctrl_obi_xbar_periph_rid),
        .periph_rvalid       (sysctrl_obi_xbar_periph_rvalid),
        .periph_rvalidpar    (sysctrl_obi_xbar_periph_rvalidpar),
        .periph_addr         (sysctrl_obi_xbar_periph_addr),
        .periph_aid          (sysctrl_obi_xbar_periph_aid),
        .periph_be           (sysctrl_obi_xbar_periph_be),
        .periph_req          (sysctrl_obi_xbar_periph_req),
        .periph_reqpar       (sysctrl_obi_xbar_periph_reqpar),
        .periph_rready       (sysctrl_obi_xbar_periph_rready),
        .periph_rreadypar    (sysctrl_obi_xbar_periph_rreadypar),
        .periph_wdata        (sysctrl_obi_xbar_periph_wdata),
        .periph_we           (sysctrl_obi_xbar_periph_we),
        // Interface: reset
        .reset_n             (sysctrl_obi_xbar_reset_n));


endmodule
