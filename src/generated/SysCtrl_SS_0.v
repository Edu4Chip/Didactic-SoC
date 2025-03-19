//-----------------------------------------------------------------------------
// File          : SysCtrl_SS_0.v
// Creation date : 07.03.2025
// Creation time : 09:00:35
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:SysCtrl_SS:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/subsystem/SysCtrl_SS/1.0/SysCtrl_SS.1.0.xml
//-----------------------------------------------------------------------------

`ifdef VERILATOR
    `include "verification/verilator/src/hdl/nms/SysCtrl_SS_0.sv"
`endif
module SysCtrl_SS_0 #(
    parameter                              AXI4LITE_AW      = 32,
    parameter                              AXI4LITE_DW      = 32,
    parameter                              IOCELL_CFG_W     = 5,
    parameter                              IOCELL_COUNT     = 17,    // update this value manually to match cell numbers
    parameter                              NUM_GPIO         = 8,
    parameter                              SS_CTRL_W        = 8,
    parameter                              IO_CFG_W         = 5
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
    output logic         [3:0]          icn_ar_prot_out,
    output logic                        icn_ar_valid_out,
    output logic         [31:0]         icn_aw_addr_out,
    output logic         [3:0]          icn_aw_prot_out,
    output logic                        icn_aw_valid_out,
    output logic                        icn_b_ready_out,
    output logic                        icn_r_ready_out,
    output logic         [31:0]         icn_w_data_out,
    output logic         [3:0]          icn_w_strb_out,
    output logic                        icn_w_valid_out,

    // Interface: Clk
    input  logic                        clk_internal,

    // Interface: GPIO
    input  logic         [7:0]          gpio_to_core,
    output logic         [7:0]          gpio_from_core,

    // Interface: ICN_SS_Ctrl
    output logic         [7:0]          ss_ctrl_icn,

    // Interface: IRQ
    input  logic         [3:0]          sysctrl_irq_i,

    // Interface: JTAG
    input  logic                        jtag_tck_internal,
    input  logic                        jtag_tdi_internal,
    input  logic                        jtag_tms_internal,
    input  logic                        jtag_trst_internal,
    output logic                        jtag_tdo_internal,

    // Interface: Reset
    input  logic                        reset_internal,

    // Interface: Reset_ICN
    output logic                        reset_icn,

    // Interface: Reset_SS
    output logic         [3:0]          reset_ss,

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
    output logic         [84:0]         cell_cfg,

    // Interface: pmod_sel
    output logic         [7:0]          pmod_sel,

    // These ports are not in any interface
    input  logic         [14:0]         irq_upper_tieoff
);
    `ifdef VERILATOR
      `include "verification/verilator/src/hdl/ms/SysCtrl_SS_0.sv"
    `endif

    // i_SysCtrl_peripherals_GPIO_to_GPIO wires:
    wire [7:0] i_SysCtrl_peripherals_GPIO_to_GPIO_gpi;
    wire [7:0] i_SysCtrl_peripherals_GPIO_to_GPIO_gpo;
    // i_SysCtrl_peripherals_SPI_to_SPI wires:
    wire [1:0] i_SysCtrl_peripherals_SPI_to_SPI_csn;
    wire [3:0] i_SysCtrl_peripherals_SPI_to_SPI_miso;
    wire [3:0] i_SysCtrl_peripherals_SPI_to_SPI_mosi;
    wire       i_SysCtrl_peripherals_SPI_to_SPI_sck;
    // i_SysCtrl_peripherals_UART_to_UART wires:
    wire       i_SysCtrl_peripherals_UART_to_UART_uart_rx;
    wire       i_SysCtrl_peripherals_UART_to_UART_uart_tx;
    // i_SysCtrl_peripherals_Clock_to_Clk wires:
    wire       i_SysCtrl_peripherals_Clock_to_Clk_clk;
    // i_SysCtrl_peripherals_Reset_to_Reset wires:
    wire       i_SysCtrl_peripherals_Reset_to_Reset_reset;
    // i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph wires:
    wire [31:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_ADDR;
    wire [3:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_PROT;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_READY;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_VALID;
    wire [31:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_ADDR;
    wire [3:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_PROT;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_READY;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_VALID;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_READY;
    wire [1:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_RESP;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_VALID;
    wire [31:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_DATA;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_READY;
    wire [1:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_RESP;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_VALID;
    wire [31:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_DATA;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_READY;
    wire [3:0] i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_STRB;
    wire       i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_VALID;
    // SS_Ctrl_reg_array_rst_icn_to_Reset_ICN wires:
    wire       SS_Ctrl_reg_array_rst_icn_to_Reset_ICN_reset;
    // SS_Ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl wires:
    wire [7:0] SS_Ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl_clk_ctrl;
    // SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0 wires:
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_clk_ctrl;
    wire       SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_irq_en;
    // SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1 wires:
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_clk_ctrl;
    wire       SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_irq_en;
    // SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2 wires:
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_clk_ctrl;
    wire       SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_irq_en;
    // SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3 wires:
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_clk_ctrl;
    wire       SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_irq_en;
    // SS_Ctrl_reg_array_io_cfg_to_io_cell_cfg wires:
    wire [84:0] SS_Ctrl_reg_array_io_cfg_to_io_cell_cfg_cfg;
    // jtag_dbg_wrapper_JTAG_to_JTAG wires:
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tck;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tdi;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tdo;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_tms;
    wire       jtag_dbg_wrapper_JTAG_to_JTAG_trst;
    // Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL wires:
    wire [31:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_ADDR;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_READY;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_VALID;
    wire [31:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_ADDR;
    wire [2:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_PROT;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_READY;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_VALID;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_READY;
    wire [1:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_RESP;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_VALID;
    wire [31:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_DATA;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_READY;
    wire [1:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_RESP;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_VALID;
    wire [31:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_DATA;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_READY;
    wire [3:0] Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_STRB;
    wire       Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_VALID;
    // core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM wires:
    wire [31:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_ADDR;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_READY;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_VALID;
    wire [31:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_ADDR;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_READY;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_VALID;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_READY;
    wire [1:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_RESP;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_VALID;
    wire [31:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_DATA;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_READY;
    wire [1:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_RESP;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_VALID;
    wire [31:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_DATA;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_READY;
    wire [3:0] core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_STRB;
    wire       core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_VALID;
    // Ibex_Core_imem_to_core_imem_bridge_mem wires:
    wire [31:0] Ibex_Core_imem_to_core_imem_bridge_mem_ADDR;
    wire [3:0] Ibex_Core_imem_to_core_imem_bridge_mem_BE;
    wire       Ibex_Core_imem_to_core_imem_bridge_mem_ERR;
    wire       Ibex_Core_imem_to_core_imem_bridge_mem_GNT;
    wire [31:0] Ibex_Core_imem_to_core_imem_bridge_mem_RDATA;
    wire [6:0] Ibex_Core_imem_to_core_imem_bridge_mem_RDATA_INTG;
    wire       Ibex_Core_imem_to_core_imem_bridge_mem_REQ;
    wire       Ibex_Core_imem_to_core_imem_bridge_mem_RVALID;
    wire [31:0] Ibex_Core_imem_to_core_imem_bridge_mem_WDATA;
    wire       Ibex_Core_imem_to_core_imem_bridge_mem_WE;
    // Ibex_Core_dmem_to_core_dmem_bridge_mem wires:
    wire [31:0] Ibex_Core_dmem_to_core_dmem_bridge_mem_ADDR;
    wire [3:0] Ibex_Core_dmem_to_core_dmem_bridge_mem_BE;
    wire       Ibex_Core_dmem_to_core_dmem_bridge_mem_ERR;
    wire       Ibex_Core_dmem_to_core_dmem_bridge_mem_GNT;
    wire [31:0] Ibex_Core_dmem_to_core_dmem_bridge_mem_RDATA;
    wire [6:0] Ibex_Core_dmem_to_core_dmem_bridge_mem_RDATA_INTG;
    wire       Ibex_Core_dmem_to_core_dmem_bridge_mem_REQ;
    wire       Ibex_Core_dmem_to_core_dmem_bridge_mem_RVALID;
    wire [31:0] Ibex_Core_dmem_to_core_dmem_bridge_mem_WDATA;
    wire [6:0] Ibex_Core_dmem_to_core_dmem_bridge_mem_WDATA_INTG;
    wire       Ibex_Core_dmem_to_core_dmem_bridge_mem_WE;
    // i_dmem_mem_to_axi_dmem_bridge_Mem wires:
    wire [31:0] i_dmem_mem_to_axi_dmem_bridge_Mem_ADDR;
    wire [3:0] i_dmem_mem_to_axi_dmem_bridge_Mem_BE;
    wire [31:0] i_dmem_mem_to_axi_dmem_bridge_Mem_RDATA;
    wire       i_dmem_mem_to_axi_dmem_bridge_Mem_REQ;
    wire [31:0] i_dmem_mem_to_axi_dmem_bridge_Mem_WDATA;
    wire       i_dmem_mem_to_axi_dmem_bridge_Mem_WE;
    // axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM wires:
    wire [31:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_ADDR;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_READY;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_VALID;
    wire [31:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_ADDR;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_READY;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_VALID;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_READY;
    wire [1:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_RESP;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_VALID;
    wire [31:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_DATA;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_READY;
    wire [1:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_RESP;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_VALID;
    wire [31:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_DATA;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_READY;
    wire [3:0] axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_STRB;
    wire       axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_VALID;
    // axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM wires:
    wire [31:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_ADDR;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_READY;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_VALID;
    wire [31:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_ADDR;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_READY;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_VALID;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_READY;
    wire [1:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_RESP;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_VALID;
    wire [31:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_DATA;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_READY;
    wire [1:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_RESP;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_VALID;
    wire [31:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_DATA;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_READY;
    wire [3:0] axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_STRB;
    wire       axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_VALID;
    // axi_imem_bridge_Mem_to_i_imem_mem wires:
    wire [31:0] axi_imem_bridge_Mem_to_i_imem_mem_ADDR;
    wire [3:0] axi_imem_bridge_Mem_to_i_imem_mem_BE;
    wire [31:0] axi_imem_bridge_Mem_to_i_imem_mem_RDATA;
    wire       axi_imem_bridge_Mem_to_i_imem_mem_REQ;
    wire [31:0] axi_imem_bridge_Mem_to_i_imem_mem_WDATA;
    wire       axi_imem_bridge_Mem_to_i_imem_mem_WE;
    // core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM wires:
    wire [31:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_ADDR;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_READY;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_VALID;
    wire [31:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_ADDR;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_READY;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_VALID;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_READY;
    wire [1:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_RESP;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_VALID;
    wire [31:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_DATA;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_READY;
    wire [1:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_RESP;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_VALID;
    wire [31:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_DATA;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_READY;
    wire [3:0] core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_STRB;
    wire       core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_VALID;
    // jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T wires:
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_ADDR;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_READY;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_VALID;
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_ADDR;
    wire [2:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_PROT;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_READY;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_VALID;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_READY;
    wire [1:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_RESP;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_VALID;
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_DATA;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_READY;
    wire [1:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_RESP;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_VALID;
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_DATA;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_READY;
    wire [3:0] jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_STRB;
    wire       jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_VALID;
    // jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I wires:
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_ADDR;
    wire [3:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_PROT;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_READY;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_VALID;
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_ADDR;
    wire [3:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_PROT;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_READY;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_VALID;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_READY;
    wire [1:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_RESP;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_VALID;
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_DATA;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_READY;
    wire [1:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_RESP;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_VALID;
    wire [31:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_DATA;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_READY;
    wire [3:0] jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_STRB;
    wire       jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_VALID;
    // jtag_dbg_wrapper_core_reset_to_Ibex_Core_Reset wires:
    wire       jtag_dbg_wrapper_core_reset_to_Ibex_Core_Reset_reset;
    // jtag_dbg_wrapper_Debug_to_Ibex_Core_Debug wires:
    wire       jtag_dbg_wrapper_Debug_to_Ibex_Core_Debug_debug_req;
    // Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if wires:
    wire [31:0] Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_ADDR;
    wire [3:0] Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_BE;
    wire [31:0] Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_RDATA;
    wire       Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_REQ;
    wire [31:0] Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_WDATA;
    wire       Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_WE;
    // SS_Ctrl_reg_array_pmod_sel_to_bus wires:
    wire [7:0] SS_Ctrl_reg_array_pmod_sel_to_bus_gpo;
    // Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn wires:
    wire [31:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_ADDR;
    wire [3:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_PROT;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_READY;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_VALID;
    wire [31:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_ADDR;
    wire [3:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_PROT;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_READY;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_VALID;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_READY;
    wire [1:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_RESP;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_VALID;
    wire [31:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_DATA;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_READY;
    wire [1:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_RESP;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_VALID;
    wire [31:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_DATA;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_READY;
    wire [3:0] Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_STRB;
    wire       Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_VALID;
    // SS_Ctrl_reg_array_fetch_en_to_Ibex_Core_FetchEn wires:
    wire [4:0] SS_Ctrl_reg_array_fetch_en_to_Ibex_Core_FetchEn_gpo;
    // SS_Ctrl_reg_array_rst_ss_to_Reset_SS wires:
    wire [3:0] SS_Ctrl_reg_array_rst_ss_to_Reset_SS_reset;

    // Ad-hoc wires:
    wire       i_SysCtrl_peripherals_irq_uart_to_Ibex_Core_irq_fast_i;
    wire       i_SysCtrl_peripherals_irq_gpio_to_Ibex_Core_irq_fast_i;
    wire [1:0] i_SysCtrl_peripherals_irq_spi_to_Ibex_Core_irq_fast_i;
    wire [6:0] Ibex_Core_irq_fast_i_to_irq_upper_tieoff;
    wire [3:0] Ibex_Core_irq_fast_i_to_sysctrl_irq_i;

    // Ctrl_reg_bridge port wires:
    wire [31:0] Ctrl_reg_bridge_addr_o;
    wire [31:0] Ctrl_reg_bridge_ar_addr_i;
    wire       Ctrl_reg_bridge_ar_ready_o;
    wire       Ctrl_reg_bridge_ar_valid_i;
    wire [31:0] Ctrl_reg_bridge_aw_addr_i;
    wire       Ctrl_reg_bridge_aw_ready_o;
    wire       Ctrl_reg_bridge_aw_valid_i;
    wire       Ctrl_reg_bridge_b_ready_i;
    wire [1:0] Ctrl_reg_bridge_b_resp_o;
    wire       Ctrl_reg_bridge_b_valid_o;
    wire [3:0] Ctrl_reg_bridge_be_o;
    wire       Ctrl_reg_bridge_clk_i;
    wire [31:0] Ctrl_reg_bridge_r_data_o;
    wire       Ctrl_reg_bridge_r_ready_i;
    wire [1:0] Ctrl_reg_bridge_r_resp_o;
    wire       Ctrl_reg_bridge_r_valid_o;
    wire [31:0] Ctrl_reg_bridge_rdata_i;
    wire       Ctrl_reg_bridge_req_o;
    wire       Ctrl_reg_bridge_rst_ni;
    wire [31:0] Ctrl_reg_bridge_w_data_i;
    wire       Ctrl_reg_bridge_w_ready_o;
    wire [3:0] Ctrl_reg_bridge_w_strb_i;
    wire       Ctrl_reg_bridge_w_valid_i;
    wire [31:0] Ctrl_reg_bridge_wdata_o;
    wire       Ctrl_reg_bridge_we_o;
    // Ctrl_xbar port wires:
    wire [31:0] Ctrl_xbar_CoreDMEM_ar_addr_in;
    wire       Ctrl_xbar_CoreDMEM_ar_ready_out;
    wire       Ctrl_xbar_CoreDMEM_ar_valid_in;
    wire [31:0] Ctrl_xbar_CoreDMEM_aw_addr_in;
    wire       Ctrl_xbar_CoreDMEM_aw_ready_out;
    wire       Ctrl_xbar_CoreDMEM_aw_valid_in;
    wire       Ctrl_xbar_CoreDMEM_b_ready_in;
    wire [1:0] Ctrl_xbar_CoreDMEM_b_resp_out;
    wire       Ctrl_xbar_CoreDMEM_b_valid_out;
    wire [31:0] Ctrl_xbar_CoreDMEM_r_data_out;
    wire       Ctrl_xbar_CoreDMEM_r_ready_in;
    wire [1:0] Ctrl_xbar_CoreDMEM_r_resp_out;
    wire       Ctrl_xbar_CoreDMEM_r_valid_out;
    wire [31:0] Ctrl_xbar_CoreDMEM_w_data_in;
    wire       Ctrl_xbar_CoreDMEM_w_ready_out;
    wire [3:0] Ctrl_xbar_CoreDMEM_w_strb_in;
    wire       Ctrl_xbar_CoreDMEM_w_valid_in;
    wire [31:0] Ctrl_xbar_CoreIMEM_ar_addr_in;
    wire       Ctrl_xbar_CoreIMEM_ar_ready_out;
    wire       Ctrl_xbar_CoreIMEM_ar_valid_in;
    wire [31:0] Ctrl_xbar_CoreIMEM_aw_addr_in;
    wire       Ctrl_xbar_CoreIMEM_aw_ready_out;
    wire       Ctrl_xbar_CoreIMEM_aw_valid_in;
    wire       Ctrl_xbar_CoreIMEM_b_ready_in;
    wire [1:0] Ctrl_xbar_CoreIMEM_b_resp_out;
    wire       Ctrl_xbar_CoreIMEM_b_valid_out;
    wire [31:0] Ctrl_xbar_CoreIMEM_r_data_out;
    wire       Ctrl_xbar_CoreIMEM_r_ready_in;
    wire [1:0] Ctrl_xbar_CoreIMEM_r_resp_out;
    wire       Ctrl_xbar_CoreIMEM_r_valid_out;
    wire [31:0] Ctrl_xbar_CoreIMEM_w_data_in;
    wire       Ctrl_xbar_CoreIMEM_w_ready_out;
    wire [3:0] Ctrl_xbar_CoreIMEM_w_strb_in;
    wire       Ctrl_xbar_CoreIMEM_w_valid_in;
    wire [31:0] Ctrl_xbar_CtrlReg_ar_addr_out;
    wire       Ctrl_xbar_CtrlReg_ar_ready_in;
    wire       Ctrl_xbar_CtrlReg_ar_valid_out;
    wire [31:0] Ctrl_xbar_CtrlReg_aw_addr_out;
    wire       Ctrl_xbar_CtrlReg_aw_ready_in;
    wire       Ctrl_xbar_CtrlReg_aw_valid_out;
    wire       Ctrl_xbar_CtrlReg_b_ready_out;
    wire [1:0] Ctrl_xbar_CtrlReg_b_resp_in;
    wire       Ctrl_xbar_CtrlReg_b_valid_in;
    wire [31:0] Ctrl_xbar_CtrlReg_r_data_in;
    wire       Ctrl_xbar_CtrlReg_r_ready_out;
    wire [1:0] Ctrl_xbar_CtrlReg_r_resp_in;
    wire       Ctrl_xbar_CtrlReg_r_valid_in;
    wire [31:0] Ctrl_xbar_CtrlReg_w_data_out;
    wire       Ctrl_xbar_CtrlReg_w_ready_in;
    wire [3:0] Ctrl_xbar_CtrlReg_w_strb_out;
    wire       Ctrl_xbar_CtrlReg_w_valid_out;
    wire [31:0] Ctrl_xbar_DMEM_ar_addr_out;
    wire       Ctrl_xbar_DMEM_ar_ready_in;
    wire       Ctrl_xbar_DMEM_ar_valid_out;
    wire [31:0] Ctrl_xbar_DMEM_aw_addr_out;
    wire       Ctrl_xbar_DMEM_aw_ready_in;
    wire       Ctrl_xbar_DMEM_aw_valid_out;
    wire       Ctrl_xbar_DMEM_b_ready_out;
    wire [1:0] Ctrl_xbar_DMEM_b_resp_in;
    wire       Ctrl_xbar_DMEM_b_valid_in;
    wire [31:0] Ctrl_xbar_DMEM_r_data_in;
    wire       Ctrl_xbar_DMEM_r_ready_out;
    wire [1:0] Ctrl_xbar_DMEM_r_resp_in;
    wire       Ctrl_xbar_DMEM_r_valid_in;
    wire [31:0] Ctrl_xbar_DMEM_w_data_out;
    wire       Ctrl_xbar_DMEM_w_ready_in;
    wire [3:0] Ctrl_xbar_DMEM_w_strb_out;
    wire       Ctrl_xbar_DMEM_w_valid_out;
    wire [31:0] Ctrl_xbar_DbgI_ar_addr;
    wire [3:0] Ctrl_xbar_DbgI_ar_prot;
    wire       Ctrl_xbar_DbgI_ar_ready;
    wire       Ctrl_xbar_DbgI_ar_valid;
    wire [31:0] Ctrl_xbar_DbgI_aw_addr;
    wire [3:0] Ctrl_xbar_DbgI_aw_prot;
    wire       Ctrl_xbar_DbgI_aw_ready;
    wire       Ctrl_xbar_DbgI_aw_valid;
    wire       Ctrl_xbar_DbgI_b_ready;
    wire [1:0] Ctrl_xbar_DbgI_b_resp;
    wire       Ctrl_xbar_DbgI_b_valid;
    wire [31:0] Ctrl_xbar_DbgI_r_data;
    wire       Ctrl_xbar_DbgI_r_ready;
    wire [1:0] Ctrl_xbar_DbgI_r_resp;
    wire       Ctrl_xbar_DbgI_r_valid;
    wire [31:0] Ctrl_xbar_DbgI_w_data;
    wire       Ctrl_xbar_DbgI_w_ready;
    wire [3:0] Ctrl_xbar_DbgI_w_strb;
    wire       Ctrl_xbar_DbgI_w_valid;
    wire [31:0] Ctrl_xbar_DbgT_ar_addr_out;
    wire       Ctrl_xbar_DbgT_ar_ready_in;
    wire       Ctrl_xbar_DbgT_ar_valid_out;
    wire [31:0] Ctrl_xbar_DbgT_aw_addr_out;
    wire       Ctrl_xbar_DbgT_aw_ready_in;
    wire       Ctrl_xbar_DbgT_aw_valid_out;
    wire       Ctrl_xbar_DbgT_b_ready_out;
    wire [1:0] Ctrl_xbar_DbgT_b_resp_in;
    wire       Ctrl_xbar_DbgT_b_valid_in;
    wire [31:0] Ctrl_xbar_DbgT_r_data_in;
    wire       Ctrl_xbar_DbgT_r_ready_out;
    wire [1:0] Ctrl_xbar_DbgT_r_resp_in;
    wire       Ctrl_xbar_DbgT_r_valid_in;
    wire [31:0] Ctrl_xbar_DbgT_w_data_out;
    wire       Ctrl_xbar_DbgT_w_ready_in;
    wire [3:0] Ctrl_xbar_DbgT_w_strb_out;
    wire       Ctrl_xbar_DbgT_w_valid_out;
    wire [31:0] Ctrl_xbar_IMEM_ar_addr_out;
    wire       Ctrl_xbar_IMEM_ar_ready_in;
    wire       Ctrl_xbar_IMEM_ar_valid_out;
    wire [31:0] Ctrl_xbar_IMEM_aw_addr_out;
    wire       Ctrl_xbar_IMEM_aw_ready_in;
    wire       Ctrl_xbar_IMEM_aw_valid_out;
    wire       Ctrl_xbar_IMEM_b_ready_out;
    wire [1:0] Ctrl_xbar_IMEM_b_resp_in;
    wire       Ctrl_xbar_IMEM_b_valid_in;
    wire [31:0] Ctrl_xbar_IMEM_r_data_in;
    wire       Ctrl_xbar_IMEM_r_ready_out;
    wire [1:0] Ctrl_xbar_IMEM_r_resp_in;
    wire       Ctrl_xbar_IMEM_r_valid_in;
    wire [31:0] Ctrl_xbar_IMEM_w_data_out;
    wire       Ctrl_xbar_IMEM_w_ready_in;
    wire [3:0] Ctrl_xbar_IMEM_w_strb_out;
    wire       Ctrl_xbar_IMEM_w_valid_out;
    wire       Ctrl_xbar_clk_i;
    wire [31:0] Ctrl_xbar_icn_ar_addr_out;
    wire [3:0] Ctrl_xbar_icn_ar_prot_out;
    wire       Ctrl_xbar_icn_ar_ready_in;
    wire       Ctrl_xbar_icn_ar_valid_out;
    wire [31:0] Ctrl_xbar_icn_aw_addr_out;
    wire [3:0] Ctrl_xbar_icn_aw_prot_out;
    wire       Ctrl_xbar_icn_aw_ready_in;
    wire       Ctrl_xbar_icn_aw_valid_out;
    wire       Ctrl_xbar_icn_b_ready_out;
    wire [1:0] Ctrl_xbar_icn_b_resp_in;
    wire       Ctrl_xbar_icn_b_valid_in;
    wire [31:0] Ctrl_xbar_icn_r_data_in;
    wire       Ctrl_xbar_icn_r_ready_out;
    wire [1:0] Ctrl_xbar_icn_r_resp_in;
    wire       Ctrl_xbar_icn_r_valid_in;
    wire [31:0] Ctrl_xbar_icn_w_data_out;
    wire       Ctrl_xbar_icn_w_ready_in;
    wire [3:0] Ctrl_xbar_icn_w_strb_out;
    wire       Ctrl_xbar_icn_w_valid_out;
    wire [31:0] Ctrl_xbar_periph_ar_addr_out;
    wire [3:0] Ctrl_xbar_periph_ar_prot_out;
    wire       Ctrl_xbar_periph_ar_ready_in;
    wire       Ctrl_xbar_periph_ar_valid_out;
    wire [31:0] Ctrl_xbar_periph_aw_addr_out;
    wire [3:0] Ctrl_xbar_periph_aw_prot_out;
    wire       Ctrl_xbar_periph_aw_ready_in;
    wire       Ctrl_xbar_periph_aw_valid_out;
    wire       Ctrl_xbar_periph_b_ready_out;
    wire [1:0] Ctrl_xbar_periph_b_resp_in;
    wire       Ctrl_xbar_periph_b_valid_in;
    wire [31:0] Ctrl_xbar_periph_r_data_in;
    wire       Ctrl_xbar_periph_r_ready_out;
    wire [1:0] Ctrl_xbar_periph_r_resp_in;
    wire       Ctrl_xbar_periph_r_valid_in;
    wire [31:0] Ctrl_xbar_periph_w_data_out;
    wire       Ctrl_xbar_periph_w_ready_in;
    wire [3:0] Ctrl_xbar_periph_w_strb_out;
    wire       Ctrl_xbar_periph_w_valid_out;
    wire       Ctrl_xbar_reset_ni;
    // Ibex_Core port wires:
    wire       Ibex_Core_clk_i;
    wire [31:0] Ibex_Core_data_addr_o;
    wire [3:0] Ibex_Core_data_be_o;
    wire       Ibex_Core_data_err_i;
    wire       Ibex_Core_data_gnt_i;
    wire [31:0] Ibex_Core_data_rdata_i;
    wire       Ibex_Core_data_req_o;
    wire       Ibex_Core_data_rvalid_i;
    wire [31:0] Ibex_Core_data_wdata_o;
    wire       Ibex_Core_data_we_o;
    wire       Ibex_Core_debug_req_i;
    wire [3:0] Ibex_Core_fetch_enable_i;
    wire [31:0] Ibex_Core_instr_addr_o;
    wire       Ibex_Core_instr_err_i;
    wire       Ibex_Core_instr_gnt_i;
    wire [31:0] Ibex_Core_instr_rdata_i;
    wire       Ibex_Core_instr_req_o;
    wire       Ibex_Core_instr_rvalid_i;
    wire [14:0] Ibex_Core_irq_fast_i;
    wire       Ibex_Core_rst_ni;
    // SS_Ctrl_reg_array port wires:
    wire [31:0] SS_Ctrl_reg_array_addr_in;
    wire [3:0] SS_Ctrl_reg_array_be_in;
    wire [84:0] SS_Ctrl_reg_array_cell_cfg;
    wire       SS_Ctrl_reg_array_clk;
    wire [4:0] SS_Ctrl_reg_array_fetch_en;
    wire       SS_Ctrl_reg_array_irq_en_0;
    wire       SS_Ctrl_reg_array_irq_en_1;
    wire       SS_Ctrl_reg_array_irq_en_2;
    wire       SS_Ctrl_reg_array_irq_en_3;
    wire [7:0] SS_Ctrl_reg_array_pmod_sel;
    wire [31:0] SS_Ctrl_reg_array_rdata_out;
    wire       SS_Ctrl_reg_array_req_in;
    wire       SS_Ctrl_reg_array_reset;
    wire       SS_Ctrl_reg_array_reset_icn;
    wire       SS_Ctrl_reg_array_reset_ss_0;
    wire       SS_Ctrl_reg_array_reset_ss_1;
    wire       SS_Ctrl_reg_array_reset_ss_2;
    wire       SS_Ctrl_reg_array_reset_ss_3;
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_0;
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_1;
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_2;
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_3;
    wire [7:0] SS_Ctrl_reg_array_ss_ctrl_icn;
    wire [31:0] SS_Ctrl_reg_array_wdata_in;
    wire       SS_Ctrl_reg_array_we_in;
    // axi_dmem_bridge port wires:
    wire [31:0] axi_dmem_bridge_addr_o;
    wire [31:0] axi_dmem_bridge_ar_addr_i;
    wire       axi_dmem_bridge_ar_ready_o;
    wire       axi_dmem_bridge_ar_valid_i;
    wire [31:0] axi_dmem_bridge_aw_addr_i;
    wire       axi_dmem_bridge_aw_ready_o;
    wire       axi_dmem_bridge_aw_valid_i;
    wire       axi_dmem_bridge_b_ready_i;
    wire [1:0] axi_dmem_bridge_b_resp_o;
    wire       axi_dmem_bridge_b_valid_o;
    wire [3:0] axi_dmem_bridge_be_o;
    wire       axi_dmem_bridge_clk_i;
    wire [31:0] axi_dmem_bridge_r_data_o;
    wire       axi_dmem_bridge_r_ready_i;
    wire [1:0] axi_dmem_bridge_r_resp_o;
    wire       axi_dmem_bridge_r_valid_o;
    wire [31:0] axi_dmem_bridge_rdata_i;
    wire       axi_dmem_bridge_req_o;
    wire       axi_dmem_bridge_rst_ni;
    wire [31:0] axi_dmem_bridge_w_data_i;
    wire       axi_dmem_bridge_w_ready_o;
    wire [3:0] axi_dmem_bridge_w_strb_i;
    wire       axi_dmem_bridge_w_valid_i;
    wire [31:0] axi_dmem_bridge_wdata_o;
    wire       axi_dmem_bridge_we_o;
    // axi_imem_bridge port wires:
    wire [31:0] axi_imem_bridge_addr_o;
    wire [31:0] axi_imem_bridge_ar_addr_i;
    wire       axi_imem_bridge_ar_ready_o;
    wire       axi_imem_bridge_ar_valid_i;
    wire [31:0] axi_imem_bridge_aw_addr_i;
    wire       axi_imem_bridge_aw_ready_o;
    wire       axi_imem_bridge_aw_valid_i;
    wire       axi_imem_bridge_b_ready_i;
    wire [1:0] axi_imem_bridge_b_resp_o;
    wire       axi_imem_bridge_b_valid_o;
    wire [3:0] axi_imem_bridge_be_o;
    wire       axi_imem_bridge_clk_i;
    wire [31:0] axi_imem_bridge_r_data_o;
    wire       axi_imem_bridge_r_ready_i;
    wire [1:0] axi_imem_bridge_r_resp_o;
    wire       axi_imem_bridge_r_valid_o;
    wire [31:0] axi_imem_bridge_rdata_i;
    wire       axi_imem_bridge_req_o;
    wire       axi_imem_bridge_rst_ni;
    wire [31:0] axi_imem_bridge_w_data_i;
    wire       axi_imem_bridge_w_ready_o;
    wire [3:0] axi_imem_bridge_w_strb_i;
    wire       axi_imem_bridge_w_valid_i;
    wire [31:0] axi_imem_bridge_wdata_o;
    wire       axi_imem_bridge_we_o;
    // core_dmem_bridge port wires:
    wire [31:0] core_dmem_bridge_addr_i;
    wire [31:0] core_dmem_bridge_ar_addr_o;
    wire       core_dmem_bridge_ar_ready_i;
    wire       core_dmem_bridge_ar_valid_o;
    wire [31:0] core_dmem_bridge_aw_addr_o;
    wire       core_dmem_bridge_aw_ready_i;
    wire       core_dmem_bridge_aw_valid_o;
    wire       core_dmem_bridge_b_ready_o;
    wire [1:0] core_dmem_bridge_b_resp_i;
    wire       core_dmem_bridge_b_valid_i;
    wire [3:0] core_dmem_bridge_be_i;
    wire       core_dmem_bridge_clk_i;
    wire       core_dmem_bridge_err_o;
    wire       core_dmem_bridge_gnt_o;
    wire [31:0] core_dmem_bridge_r_data_i;
    wire       core_dmem_bridge_r_ready_o;
    wire [1:0] core_dmem_bridge_r_resp_i;
    wire       core_dmem_bridge_r_valid_i;
    wire [31:0] core_dmem_bridge_rdata_o;
    wire       core_dmem_bridge_req_i;
    wire       core_dmem_bridge_rst_ni;
    wire       core_dmem_bridge_rvalid_o;
    wire [31:0] core_dmem_bridge_w_data_o;
    wire       core_dmem_bridge_w_ready_i;
    wire [3:0] core_dmem_bridge_w_strb_o;
    wire       core_dmem_bridge_w_valid_o;
    wire [31:0] core_dmem_bridge_wdata_i;
    wire       core_dmem_bridge_we_i;
    // core_imem_bridge port wires:
    wire [31:0] core_imem_bridge_addr_i;
    wire [31:0] core_imem_bridge_ar_addr_o;
    wire       core_imem_bridge_ar_ready_i;
    wire       core_imem_bridge_ar_valid_o;
    wire [31:0] core_imem_bridge_aw_addr_o;
    wire       core_imem_bridge_aw_ready_i;
    wire       core_imem_bridge_aw_valid_o;
    wire       core_imem_bridge_b_ready_o;
    wire [1:0] core_imem_bridge_b_resp_i;
    wire       core_imem_bridge_b_valid_i;
    wire       core_imem_bridge_clk_i;
    wire       core_imem_bridge_err_o;
    wire       core_imem_bridge_gnt_o;
    wire [31:0] core_imem_bridge_r_data_i;
    wire       core_imem_bridge_r_ready_o;
    wire [1:0] core_imem_bridge_r_resp_i;
    wire       core_imem_bridge_r_valid_i;
    wire [31:0] core_imem_bridge_rdata_o;
    wire       core_imem_bridge_req_i;
    wire       core_imem_bridge_rst_ni;
    wire       core_imem_bridge_rvalid_o;
    wire [31:0] core_imem_bridge_w_data_o;
    wire       core_imem_bridge_w_ready_i;
    wire [3:0] core_imem_bridge_w_strb_o;
    wire       core_imem_bridge_w_valid_o;
    // i_SysCtrl_peripherals port wires:
    wire [31:0] i_SysCtrl_peripherals_ar_addr;
    wire [3:0] i_SysCtrl_peripherals_ar_prot;
    wire       i_SysCtrl_peripherals_ar_ready;
    wire       i_SysCtrl_peripherals_ar_valid;
    wire [31:0] i_SysCtrl_peripherals_aw_addr;
    wire [3:0] i_SysCtrl_peripherals_aw_prot;
    wire       i_SysCtrl_peripherals_aw_ready;
    wire       i_SysCtrl_peripherals_aw_valid;
    wire       i_SysCtrl_peripherals_b_ready;
    wire [1:0] i_SysCtrl_peripherals_b_resp;
    wire       i_SysCtrl_peripherals_b_valid;
    wire       i_SysCtrl_peripherals_clk;
    wire [7:0] i_SysCtrl_peripherals_gpio_from_core;
    wire [7:0] i_SysCtrl_peripherals_gpio_to_core;
    wire       i_SysCtrl_peripherals_irq_gpio;
    wire [1:0] i_SysCtrl_peripherals_irq_spi;
    wire       i_SysCtrl_peripherals_irq_uart;
    wire [31:0] i_SysCtrl_peripherals_r_data;
    wire       i_SysCtrl_peripherals_r_ready;
    wire [1:0] i_SysCtrl_peripherals_r_resp;
    wire       i_SysCtrl_peripherals_r_valid;
    wire       i_SysCtrl_peripherals_rst_n;
    wire [1:0] i_SysCtrl_peripherals_spim_csn_internal;
    wire [3:0] i_SysCtrl_peripherals_spim_miso_internal;
    wire [3:0] i_SysCtrl_peripherals_spim_mosi_internal;
    wire       i_SysCtrl_peripherals_spim_sck_internal;
    wire       i_SysCtrl_peripherals_uart_rx_internal;
    wire       i_SysCtrl_peripherals_uart_tx_internal;
    wire [31:0] i_SysCtrl_peripherals_w_data;
    wire       i_SysCtrl_peripherals_w_ready;
    wire [3:0] i_SysCtrl_peripherals_w_strb;
    wire       i_SysCtrl_peripherals_w_valid;
    // i_dmem port wires:
    wire [9:0] i_dmem_addr_i;
    wire [3:0] i_dmem_be_i;
    wire       i_dmem_clk_i;
    wire [31:0] i_dmem_rdata_o;
    wire       i_dmem_req_i;
    wire       i_dmem_rst_ni;
    wire [31:0] i_dmem_wdata_i;
    wire       i_dmem_we_i;
    // i_imem port wires:
    wire [9:0] i_imem_addr_i;
    wire [3:0] i_imem_be_i;
    wire       i_imem_clk_i;
    wire [31:0] i_imem_rdata_o;
    wire       i_imem_req_i;
    wire       i_imem_rst_ni;
    wire [31:0] i_imem_wdata_i;
    wire       i_imem_we_i;
    // jtag_dbg_wrapper port wires:
    wire       jtag_dbg_wrapper_clk_i;
    wire       jtag_dbg_wrapper_core_reset;
    wire       jtag_dbg_wrapper_debug_req_irq_o;
    wire [31:0] jtag_dbg_wrapper_init_ar_addr;
    wire [3:0] jtag_dbg_wrapper_init_ar_prot;
    wire       jtag_dbg_wrapper_init_ar_ready;
    wire       jtag_dbg_wrapper_init_ar_valid;
    wire [31:0] jtag_dbg_wrapper_init_aw_addr;
    wire [3:0] jtag_dbg_wrapper_init_aw_prot;
    wire       jtag_dbg_wrapper_init_aw_ready;
    wire       jtag_dbg_wrapper_init_aw_valid;
    wire       jtag_dbg_wrapper_init_b_ready;
    wire [1:0] jtag_dbg_wrapper_init_b_resp;
    wire       jtag_dbg_wrapper_init_b_valid;
    wire [31:0] jtag_dbg_wrapper_init_r_data;
    wire       jtag_dbg_wrapper_init_r_ready;
    wire [1:0] jtag_dbg_wrapper_init_r_resp;
    wire       jtag_dbg_wrapper_init_r_valid;
    wire [31:0] jtag_dbg_wrapper_init_w_data;
    wire       jtag_dbg_wrapper_init_w_ready;
    wire [3:0] jtag_dbg_wrapper_init_w_strb;
    wire       jtag_dbg_wrapper_init_w_valid;
    wire       jtag_dbg_wrapper_jtag_tck_i;
    wire       jtag_dbg_wrapper_jtag_td_i;
    wire       jtag_dbg_wrapper_jtag_td_o;
    wire       jtag_dbg_wrapper_jtag_tms_i;
    wire       jtag_dbg_wrapper_jtag_trst_ni;
    wire       jtag_dbg_wrapper_rstn_i;
    wire [31:0] jtag_dbg_wrapper_target_ar_addr;
    wire       jtag_dbg_wrapper_target_ar_ready;
    wire       jtag_dbg_wrapper_target_ar_valid;
    wire [31:0] jtag_dbg_wrapper_target_aw_addr;
    wire       jtag_dbg_wrapper_target_aw_ready;
    wire       jtag_dbg_wrapper_target_aw_valid;
    wire       jtag_dbg_wrapper_target_b_ready;
    wire [1:0] jtag_dbg_wrapper_target_b_resp;
    wire       jtag_dbg_wrapper_target_b_valid;
    wire [31:0] jtag_dbg_wrapper_target_r_data;
    wire       jtag_dbg_wrapper_target_r_ready;
    wire [1:0] jtag_dbg_wrapper_target_r_resp;
    wire       jtag_dbg_wrapper_target_r_valid;
    wire [31:0] jtag_dbg_wrapper_target_w_data;
    wire       jtag_dbg_wrapper_target_w_ready;
    wire [3:0] jtag_dbg_wrapper_target_w_strb;
    wire       jtag_dbg_wrapper_target_w_valid;

    // Assignments for the ports of the encompassing component:
    assign cell_cfg = SS_Ctrl_reg_array_io_cfg_to_io_cell_cfg_cfg;
    assign i_SysCtrl_peripherals_Clock_to_Clk_clk = clk_internal;
    assign gpio_from_core = i_SysCtrl_peripherals_GPIO_to_GPIO_gpo;
    assign i_SysCtrl_peripherals_GPIO_to_GPIO_gpi = gpio_to_core;
    assign icn_ar_addr_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_ADDR;
    assign icn_ar_prot_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_PROT;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_READY = icn_ar_ready_in;
    assign icn_ar_valid_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_VALID;
    assign icn_aw_addr_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_ADDR;
    assign icn_aw_prot_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_PROT;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_READY = icn_aw_ready_in;
    assign icn_aw_valid_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_VALID;
    assign icn_b_ready_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_READY;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_RESP = icn_b_resp_in;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_VALID = icn_b_valid_in;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_DATA = icn_r_data_in;
    assign icn_r_ready_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_READY;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_RESP = icn_r_resp_in;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_VALID = icn_r_valid_in;
    assign icn_w_data_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_DATA;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_READY = icn_w_ready_in;
    assign icn_w_strb_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_STRB;
    assign icn_w_valid_out = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_VALID;
    assign irq_en_0 = SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_irq_en;
    assign irq_en_1 = SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_irq_en;
    assign irq_en_2 = SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_irq_en;
    assign irq_en_3 = SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_irq_en;
    assign Ibex_Core_irq_fast_i_to_irq_upper_tieoff = irq_upper_tieoff[14:8];
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tck = jtag_tck_internal;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tdi = jtag_tdi_internal;
    assign jtag_tdo_internal = jtag_dbg_wrapper_JTAG_to_JTAG_tdo;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tms = jtag_tms_internal;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_trst = jtag_trst_internal;
    assign pmod_sel = SS_Ctrl_reg_array_pmod_sel_to_bus_gpo;
    assign reset_icn = SS_Ctrl_reg_array_rst_icn_to_Reset_ICN_reset;
    assign i_SysCtrl_peripherals_Reset_to_Reset_reset = reset_internal;
    assign reset_ss = SS_Ctrl_reg_array_rst_ss_to_Reset_SS_reset;
    assign spim_csn_internal = i_SysCtrl_peripherals_SPI_to_SPI_csn;
    assign i_SysCtrl_peripherals_SPI_to_SPI_miso = spim_miso_internal;
    assign spim_mosi_internal = i_SysCtrl_peripherals_SPI_to_SPI_mosi;
    assign spim_sck_internal = i_SysCtrl_peripherals_SPI_to_SPI_sck;
    assign ss_ctrl_0 = SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_clk_ctrl;
    assign ss_ctrl_1 = SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_clk_ctrl;
    assign ss_ctrl_2 = SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_clk_ctrl;
    assign ss_ctrl_3 = SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_clk_ctrl;
    assign ss_ctrl_icn = SS_Ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl_clk_ctrl;
    assign Ibex_Core_irq_fast_i_to_sysctrl_irq_i = sysctrl_irq_i;
    assign i_SysCtrl_peripherals_UART_to_UART_uart_rx = uart_rx_internal;
    assign uart_tx_internal = i_SysCtrl_peripherals_UART_to_UART_uart_tx;

    // Ctrl_reg_bridge assignments:
    assign Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_ADDR = Ctrl_reg_bridge_addr_o;
    assign Ctrl_reg_bridge_ar_addr_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_ADDR;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_READY = Ctrl_reg_bridge_ar_ready_o;
    assign Ctrl_reg_bridge_ar_valid_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_VALID;
    assign Ctrl_reg_bridge_aw_addr_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_ADDR;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_READY = Ctrl_reg_bridge_aw_ready_o;
    assign Ctrl_reg_bridge_aw_valid_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_VALID;
    assign Ctrl_reg_bridge_b_ready_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_READY;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_RESP = Ctrl_reg_bridge_b_resp_o;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_VALID = Ctrl_reg_bridge_b_valid_o;
    assign Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_BE = Ctrl_reg_bridge_be_o;
    assign Ctrl_reg_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_DATA = Ctrl_reg_bridge_r_data_o;
    assign Ctrl_reg_bridge_r_ready_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_READY;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_RESP = Ctrl_reg_bridge_r_resp_o;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_VALID = Ctrl_reg_bridge_r_valid_o;
    assign Ctrl_reg_bridge_rdata_i = Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_RDATA;
    assign Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_REQ = Ctrl_reg_bridge_req_o;
    assign Ctrl_reg_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign Ctrl_reg_bridge_w_data_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_DATA;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_READY = Ctrl_reg_bridge_w_ready_o;
    assign Ctrl_reg_bridge_w_strb_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_STRB;
    assign Ctrl_reg_bridge_w_valid_i = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_VALID;
    assign Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_WDATA = Ctrl_reg_bridge_wdata_o;
    assign Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_WE = Ctrl_reg_bridge_we_o;
    // Ctrl_xbar assignments:
    assign Ctrl_xbar_CoreDMEM_ar_addr_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_ADDR;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_READY = Ctrl_xbar_CoreDMEM_ar_ready_out;
    assign Ctrl_xbar_CoreDMEM_ar_valid_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_VALID;
    assign Ctrl_xbar_CoreDMEM_aw_addr_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_ADDR;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_READY = Ctrl_xbar_CoreDMEM_aw_ready_out;
    assign Ctrl_xbar_CoreDMEM_aw_valid_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_VALID;
    assign Ctrl_xbar_CoreDMEM_b_ready_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_READY;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_RESP = Ctrl_xbar_CoreDMEM_b_resp_out;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_VALID = Ctrl_xbar_CoreDMEM_b_valid_out;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_DATA = Ctrl_xbar_CoreDMEM_r_data_out;
    assign Ctrl_xbar_CoreDMEM_r_ready_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_READY;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_RESP = Ctrl_xbar_CoreDMEM_r_resp_out;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_VALID = Ctrl_xbar_CoreDMEM_r_valid_out;
    assign Ctrl_xbar_CoreDMEM_w_data_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_DATA;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_READY = Ctrl_xbar_CoreDMEM_w_ready_out;
    assign Ctrl_xbar_CoreDMEM_w_strb_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_STRB;
    assign Ctrl_xbar_CoreDMEM_w_valid_in = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_VALID;
    assign Ctrl_xbar_CoreIMEM_ar_addr_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_ADDR;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_READY = Ctrl_xbar_CoreIMEM_ar_ready_out;
    assign Ctrl_xbar_CoreIMEM_ar_valid_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_VALID;
    assign Ctrl_xbar_CoreIMEM_aw_addr_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_ADDR;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_READY = Ctrl_xbar_CoreIMEM_aw_ready_out;
    assign Ctrl_xbar_CoreIMEM_aw_valid_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_VALID;
    assign Ctrl_xbar_CoreIMEM_b_ready_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_READY;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_RESP = Ctrl_xbar_CoreIMEM_b_resp_out;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_VALID = Ctrl_xbar_CoreIMEM_b_valid_out;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_DATA = Ctrl_xbar_CoreIMEM_r_data_out;
    assign Ctrl_xbar_CoreIMEM_r_ready_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_READY;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_RESP = Ctrl_xbar_CoreIMEM_r_resp_out;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_VALID = Ctrl_xbar_CoreIMEM_r_valid_out;
    assign Ctrl_xbar_CoreIMEM_w_data_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_DATA;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_READY = Ctrl_xbar_CoreIMEM_w_ready_out;
    assign Ctrl_xbar_CoreIMEM_w_strb_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_STRB;
    assign Ctrl_xbar_CoreIMEM_w_valid_in = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_VALID;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_ADDR = Ctrl_xbar_CtrlReg_ar_addr_out;
    assign Ctrl_xbar_CtrlReg_ar_ready_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_READY;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AR_VALID = Ctrl_xbar_CtrlReg_ar_valid_out;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_ADDR = Ctrl_xbar_CtrlReg_aw_addr_out;
    assign Ctrl_xbar_CtrlReg_aw_ready_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_READY;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_AW_VALID = Ctrl_xbar_CtrlReg_aw_valid_out;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_READY = Ctrl_xbar_CtrlReg_b_ready_out;
    assign Ctrl_xbar_CtrlReg_b_resp_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_RESP;
    assign Ctrl_xbar_CtrlReg_b_valid_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_B_VALID;
    assign Ctrl_xbar_CtrlReg_r_data_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_DATA;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_READY = Ctrl_xbar_CtrlReg_r_ready_out;
    assign Ctrl_xbar_CtrlReg_r_resp_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_RESP;
    assign Ctrl_xbar_CtrlReg_r_valid_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_R_VALID;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_DATA = Ctrl_xbar_CtrlReg_w_data_out;
    assign Ctrl_xbar_CtrlReg_w_ready_in = Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_READY;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_STRB = Ctrl_xbar_CtrlReg_w_strb_out;
    assign Ctrl_reg_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_CTRL_W_VALID = Ctrl_xbar_CtrlReg_w_valid_out;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_ADDR = Ctrl_xbar_DMEM_ar_addr_out;
    assign Ctrl_xbar_DMEM_ar_ready_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_READY;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_VALID = Ctrl_xbar_DMEM_ar_valid_out;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_ADDR = Ctrl_xbar_DMEM_aw_addr_out;
    assign Ctrl_xbar_DMEM_aw_ready_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_READY;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_VALID = Ctrl_xbar_DMEM_aw_valid_out;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_READY = Ctrl_xbar_DMEM_b_ready_out;
    assign Ctrl_xbar_DMEM_b_resp_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_RESP;
    assign Ctrl_xbar_DMEM_b_valid_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_VALID;
    assign Ctrl_xbar_DMEM_r_data_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_DATA;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_READY = Ctrl_xbar_DMEM_r_ready_out;
    assign Ctrl_xbar_DMEM_r_resp_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_RESP;
    assign Ctrl_xbar_DMEM_r_valid_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_VALID;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_DATA = Ctrl_xbar_DMEM_w_data_out;
    assign Ctrl_xbar_DMEM_w_ready_in = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_READY;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_STRB = Ctrl_xbar_DMEM_w_strb_out;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_VALID = Ctrl_xbar_DMEM_w_valid_out;
    assign Ctrl_xbar_DbgI_ar_addr = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_ADDR;
    assign Ctrl_xbar_DbgI_ar_prot[2:0] = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_PROT[2:0];
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_READY = Ctrl_xbar_DbgI_ar_ready;
    assign Ctrl_xbar_DbgI_ar_valid = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_VALID;
    assign Ctrl_xbar_DbgI_aw_addr = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_ADDR;
    assign Ctrl_xbar_DbgI_aw_prot[2:0] = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_PROT[2:0];
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_READY = Ctrl_xbar_DbgI_aw_ready;
    assign Ctrl_xbar_DbgI_aw_valid = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_VALID;
    assign Ctrl_xbar_DbgI_b_ready = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_READY;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_RESP = Ctrl_xbar_DbgI_b_resp;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_VALID = Ctrl_xbar_DbgI_b_valid;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_DATA = Ctrl_xbar_DbgI_r_data;
    assign Ctrl_xbar_DbgI_r_ready = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_READY;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_RESP = Ctrl_xbar_DbgI_r_resp;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_VALID = Ctrl_xbar_DbgI_r_valid;
    assign Ctrl_xbar_DbgI_w_data = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_DATA;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_READY = Ctrl_xbar_DbgI_w_ready;
    assign Ctrl_xbar_DbgI_w_strb = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_STRB;
    assign Ctrl_xbar_DbgI_w_valid = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_VALID;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_ADDR = Ctrl_xbar_DbgT_ar_addr_out;
    assign Ctrl_xbar_DbgT_ar_ready_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_READY;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_VALID = Ctrl_xbar_DbgT_ar_valid_out;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_ADDR = Ctrl_xbar_DbgT_aw_addr_out;
    assign Ctrl_xbar_DbgT_aw_ready_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_READY;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_VALID = Ctrl_xbar_DbgT_aw_valid_out;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_READY = Ctrl_xbar_DbgT_b_ready_out;
    assign Ctrl_xbar_DbgT_b_resp_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_RESP;
    assign Ctrl_xbar_DbgT_b_valid_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_VALID;
    assign Ctrl_xbar_DbgT_r_data_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_DATA;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_READY = Ctrl_xbar_DbgT_r_ready_out;
    assign Ctrl_xbar_DbgT_r_resp_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_RESP;
    assign Ctrl_xbar_DbgT_r_valid_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_VALID;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_DATA = Ctrl_xbar_DbgT_w_data_out;
    assign Ctrl_xbar_DbgT_w_ready_in = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_READY;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_STRB = Ctrl_xbar_DbgT_w_strb_out;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_VALID = Ctrl_xbar_DbgT_w_valid_out;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_ADDR = Ctrl_xbar_IMEM_ar_addr_out;
    assign Ctrl_xbar_IMEM_ar_ready_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_READY;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_VALID = Ctrl_xbar_IMEM_ar_valid_out;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_ADDR = Ctrl_xbar_IMEM_aw_addr_out;
    assign Ctrl_xbar_IMEM_aw_ready_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_READY;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_VALID = Ctrl_xbar_IMEM_aw_valid_out;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_READY = Ctrl_xbar_IMEM_b_ready_out;
    assign Ctrl_xbar_IMEM_b_resp_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_RESP;
    assign Ctrl_xbar_IMEM_b_valid_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_VALID;
    assign Ctrl_xbar_IMEM_r_data_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_DATA;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_READY = Ctrl_xbar_IMEM_r_ready_out;
    assign Ctrl_xbar_IMEM_r_resp_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_RESP;
    assign Ctrl_xbar_IMEM_r_valid_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_VALID;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_DATA = Ctrl_xbar_IMEM_w_data_out;
    assign Ctrl_xbar_IMEM_w_ready_in = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_READY;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_STRB = Ctrl_xbar_IMEM_w_strb_out;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_VALID = Ctrl_xbar_IMEM_w_valid_out;
    assign Ctrl_xbar_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_ADDR = Ctrl_xbar_icn_ar_addr_out;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_PROT = Ctrl_xbar_icn_ar_prot_out;
    assign Ctrl_xbar_icn_ar_ready_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_READY;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AR_VALID = Ctrl_xbar_icn_ar_valid_out;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_ADDR = Ctrl_xbar_icn_aw_addr_out;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_PROT = Ctrl_xbar_icn_aw_prot_out;
    assign Ctrl_xbar_icn_aw_ready_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_READY;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_AW_VALID = Ctrl_xbar_icn_aw_valid_out;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_READY = Ctrl_xbar_icn_b_ready_out;
    assign Ctrl_xbar_icn_b_resp_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_RESP;
    assign Ctrl_xbar_icn_b_valid_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_B_VALID;
    assign Ctrl_xbar_icn_r_data_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_DATA;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_READY = Ctrl_xbar_icn_r_ready_out;
    assign Ctrl_xbar_icn_r_resp_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_RESP;
    assign Ctrl_xbar_icn_r_valid_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_R_VALID;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_DATA = Ctrl_xbar_icn_w_data_out;
    assign Ctrl_xbar_icn_w_ready_in = Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_READY;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_STRB = Ctrl_xbar_icn_w_strb_out;
    assign Ctrl_xbar_AXI4LITE_icn_to_AXI4LITE_icn_W_VALID = Ctrl_xbar_icn_w_valid_out;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_ADDR = Ctrl_xbar_periph_ar_addr_out;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_PROT = Ctrl_xbar_periph_ar_prot_out;
    assign Ctrl_xbar_periph_ar_ready_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_READY;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_VALID = Ctrl_xbar_periph_ar_valid_out;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_ADDR = Ctrl_xbar_periph_aw_addr_out;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_PROT = Ctrl_xbar_periph_aw_prot_out;
    assign Ctrl_xbar_periph_aw_ready_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_READY;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_VALID = Ctrl_xbar_periph_aw_valid_out;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_READY = Ctrl_xbar_periph_b_ready_out;
    assign Ctrl_xbar_periph_b_resp_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_RESP;
    assign Ctrl_xbar_periph_b_valid_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_VALID;
    assign Ctrl_xbar_periph_r_data_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_DATA;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_READY = Ctrl_xbar_periph_r_ready_out;
    assign Ctrl_xbar_periph_r_resp_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_RESP;
    assign Ctrl_xbar_periph_r_valid_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_VALID;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_DATA = Ctrl_xbar_periph_w_data_out;
    assign Ctrl_xbar_periph_w_ready_in = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_READY;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_STRB = Ctrl_xbar_periph_w_strb_out;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_VALID = Ctrl_xbar_periph_w_valid_out;
    assign Ctrl_xbar_reset_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    // Ibex_Core assignments:
    assign Ibex_Core_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_ADDR = Ibex_Core_data_addr_o;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_BE = Ibex_Core_data_be_o;
    assign Ibex_Core_data_err_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_ERR;
    assign Ibex_Core_data_gnt_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_GNT;
    assign Ibex_Core_data_rdata_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_RDATA;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_REQ = Ibex_Core_data_req_o;
    assign Ibex_Core_data_rvalid_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_RVALID;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_WDATA = Ibex_Core_data_wdata_o;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_WE = Ibex_Core_data_we_o;
    assign Ibex_Core_debug_req_i = jtag_dbg_wrapper_Debug_to_Ibex_Core_Debug_debug_req;
    assign Ibex_Core_fetch_enable_i = SS_Ctrl_reg_array_fetch_en_to_Ibex_Core_FetchEn_gpo[3:0];
    assign Ibex_Core_imem_to_core_imem_bridge_mem_ADDR = Ibex_Core_instr_addr_o;
    assign Ibex_Core_instr_err_i = Ibex_Core_imem_to_core_imem_bridge_mem_ERR;
    assign Ibex_Core_instr_gnt_i = Ibex_Core_imem_to_core_imem_bridge_mem_GNT;
    assign Ibex_Core_instr_rdata_i = Ibex_Core_imem_to_core_imem_bridge_mem_RDATA;
    assign Ibex_Core_imem_to_core_imem_bridge_mem_REQ = Ibex_Core_instr_req_o;
    assign Ibex_Core_instr_rvalid_i = Ibex_Core_imem_to_core_imem_bridge_mem_RVALID;
    assign Ibex_Core_irq_fast_i[14:8] = Ibex_Core_irq_fast_i_to_irq_upper_tieoff;
    assign Ibex_Core_irq_fast_i[7:4] = Ibex_Core_irq_fast_i_to_sysctrl_irq_i;
    assign Ibex_Core_irq_fast_i[1] = i_SysCtrl_peripherals_irq_gpio_to_Ibex_Core_irq_fast_i;
    assign Ibex_Core_irq_fast_i[3:2] = i_SysCtrl_peripherals_irq_spi_to_Ibex_Core_irq_fast_i;
    assign Ibex_Core_irq_fast_i[0] = i_SysCtrl_peripherals_irq_uart_to_Ibex_Core_irq_fast_i;
    assign Ibex_Core_rst_ni = jtag_dbg_wrapper_core_reset_to_Ibex_Core_Reset_reset;
    // SS_Ctrl_reg_array assignments:
    assign SS_Ctrl_reg_array_addr_in = Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_ADDR;
    assign SS_Ctrl_reg_array_be_in = Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_BE;
    assign SS_Ctrl_reg_array_io_cfg_to_io_cell_cfg_cfg = SS_Ctrl_reg_array_cell_cfg;
    assign SS_Ctrl_reg_array_clk = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign SS_Ctrl_reg_array_fetch_en_to_Ibex_Core_FetchEn_gpo = SS_Ctrl_reg_array_fetch_en;
    assign SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_irq_en = SS_Ctrl_reg_array_irq_en_0;
    assign SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_irq_en = SS_Ctrl_reg_array_irq_en_1;
    assign SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_irq_en = SS_Ctrl_reg_array_irq_en_2;
    assign SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_irq_en = SS_Ctrl_reg_array_irq_en_3;
    assign SS_Ctrl_reg_array_pmod_sel_to_bus_gpo = SS_Ctrl_reg_array_pmod_sel;
    assign Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_RDATA = SS_Ctrl_reg_array_rdata_out;
    assign SS_Ctrl_reg_array_req_in = Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_REQ;
    assign SS_Ctrl_reg_array_reset = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign SS_Ctrl_reg_array_rst_icn_to_Reset_ICN_reset = SS_Ctrl_reg_array_reset_icn;
    assign SS_Ctrl_reg_array_rst_ss_to_Reset_SS_reset[0] = SS_Ctrl_reg_array_reset_ss_0;
    assign SS_Ctrl_reg_array_rst_ss_to_Reset_SS_reset[1] = SS_Ctrl_reg_array_reset_ss_1;
    assign SS_Ctrl_reg_array_rst_ss_to_Reset_SS_reset[2] = SS_Ctrl_reg_array_reset_ss_2;
    assign SS_Ctrl_reg_array_rst_ss_to_Reset_SS_reset[3] = SS_Ctrl_reg_array_reset_ss_3;
    assign SS_Ctrl_reg_array_ss_ctrl_0_to_SS_Ctrl_0_clk_ctrl = SS_Ctrl_reg_array_ss_ctrl_0;
    assign SS_Ctrl_reg_array_ss_ctrl_1_to_SS_Ctrl_1_clk_ctrl = SS_Ctrl_reg_array_ss_ctrl_1;
    assign SS_Ctrl_reg_array_ss_ctrl_2_to_SS_Ctrl_2_clk_ctrl = SS_Ctrl_reg_array_ss_ctrl_2;
    assign SS_Ctrl_reg_array_ss_ctrl_3_to_SS_Ctrl_3_clk_ctrl = SS_Ctrl_reg_array_ss_ctrl_3;
    assign SS_Ctrl_reg_array_icn_ss_ctrl_to_ICN_SS_Ctrl_clk_ctrl = SS_Ctrl_reg_array_ss_ctrl_icn;
    assign SS_Ctrl_reg_array_wdata_in = Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_WDATA;
    assign SS_Ctrl_reg_array_we_in = Ctrl_reg_bridge_Mem_to_SS_Ctrl_reg_array_mem_reg_if_WE;
    // axi_dmem_bridge assignments:
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_ADDR = axi_dmem_bridge_addr_o;
    assign axi_dmem_bridge_ar_addr_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_ADDR;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_READY = axi_dmem_bridge_ar_ready_o;
    assign axi_dmem_bridge_ar_valid_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AR_VALID;
    assign axi_dmem_bridge_aw_addr_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_ADDR;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_READY = axi_dmem_bridge_aw_ready_o;
    assign axi_dmem_bridge_aw_valid_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_AW_VALID;
    assign axi_dmem_bridge_b_ready_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_READY;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_RESP = axi_dmem_bridge_b_resp_o;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_B_VALID = axi_dmem_bridge_b_valid_o;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_BE = axi_dmem_bridge_be_o;
    assign axi_dmem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_DATA = axi_dmem_bridge_r_data_o;
    assign axi_dmem_bridge_r_ready_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_READY;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_RESP = axi_dmem_bridge_r_resp_o;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_R_VALID = axi_dmem_bridge_r_valid_o;
    assign axi_dmem_bridge_rdata_i = i_dmem_mem_to_axi_dmem_bridge_Mem_RDATA;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_REQ = axi_dmem_bridge_req_o;
    assign axi_dmem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign axi_dmem_bridge_w_data_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_DATA;
    assign axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_READY = axi_dmem_bridge_w_ready_o;
    assign axi_dmem_bridge_w_strb_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_STRB;
    assign axi_dmem_bridge_w_valid_i = axi_dmem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_DMEM_W_VALID;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_WDATA = axi_dmem_bridge_wdata_o;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_WE = axi_dmem_bridge_we_o;
    // axi_imem_bridge assignments:
    assign axi_imem_bridge_Mem_to_i_imem_mem_ADDR = axi_imem_bridge_addr_o;
    assign axi_imem_bridge_ar_addr_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_ADDR;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_READY = axi_imem_bridge_ar_ready_o;
    assign axi_imem_bridge_ar_valid_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AR_VALID;
    assign axi_imem_bridge_aw_addr_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_ADDR;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_READY = axi_imem_bridge_aw_ready_o;
    assign axi_imem_bridge_aw_valid_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_AW_VALID;
    assign axi_imem_bridge_b_ready_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_READY;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_RESP = axi_imem_bridge_b_resp_o;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_B_VALID = axi_imem_bridge_b_valid_o;
    assign axi_imem_bridge_Mem_to_i_imem_mem_BE = axi_imem_bridge_be_o;
    assign axi_imem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_DATA = axi_imem_bridge_r_data_o;
    assign axi_imem_bridge_r_ready_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_READY;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_RESP = axi_imem_bridge_r_resp_o;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_R_VALID = axi_imem_bridge_r_valid_o;
    assign axi_imem_bridge_rdata_i = axi_imem_bridge_Mem_to_i_imem_mem_RDATA;
    assign axi_imem_bridge_Mem_to_i_imem_mem_REQ = axi_imem_bridge_req_o;
    assign axi_imem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign axi_imem_bridge_w_data_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_DATA;
    assign axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_READY = axi_imem_bridge_w_ready_o;
    assign axi_imem_bridge_w_strb_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_STRB;
    assign axi_imem_bridge_w_valid_i = axi_imem_bridge_AXI4LITE_to_Ctrl_xbar_AXI4LITE_IMEM_W_VALID;
    assign axi_imem_bridge_Mem_to_i_imem_mem_WDATA = axi_imem_bridge_wdata_o;
    assign axi_imem_bridge_Mem_to_i_imem_mem_WE = axi_imem_bridge_we_o;
    // core_dmem_bridge assignments:
    assign core_dmem_bridge_addr_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_ADDR;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_ADDR = core_dmem_bridge_ar_addr_o;
    assign core_dmem_bridge_ar_ready_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_READY;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AR_VALID = core_dmem_bridge_ar_valid_o;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_ADDR = core_dmem_bridge_aw_addr_o;
    assign core_dmem_bridge_aw_ready_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_READY;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_AW_VALID = core_dmem_bridge_aw_valid_o;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_READY = core_dmem_bridge_b_ready_o;
    assign core_dmem_bridge_b_resp_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_RESP;
    assign core_dmem_bridge_b_valid_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_B_VALID;
    assign core_dmem_bridge_be_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_BE;
    assign core_dmem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_ERR = core_dmem_bridge_err_o;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_GNT = core_dmem_bridge_gnt_o;
    assign core_dmem_bridge_r_data_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_DATA;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_READY = core_dmem_bridge_r_ready_o;
    assign core_dmem_bridge_r_resp_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_RESP;
    assign core_dmem_bridge_r_valid_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_R_VALID;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_RDATA = core_dmem_bridge_rdata_o;
    assign core_dmem_bridge_req_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_REQ;
    assign core_dmem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign Ibex_Core_dmem_to_core_dmem_bridge_mem_RVALID = core_dmem_bridge_rvalid_o;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_DATA = core_dmem_bridge_w_data_o;
    assign core_dmem_bridge_w_ready_i = core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_READY;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_STRB = core_dmem_bridge_w_strb_o;
    assign core_dmem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_DMEM_W_VALID = core_dmem_bridge_w_valid_o;
    assign core_dmem_bridge_wdata_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_WDATA;
    assign core_dmem_bridge_we_i = Ibex_Core_dmem_to_core_dmem_bridge_mem_WE;
    // core_imem_bridge assignments:
    assign core_imem_bridge_addr_i = Ibex_Core_imem_to_core_imem_bridge_mem_ADDR;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_ADDR = core_imem_bridge_ar_addr_o;
    assign core_imem_bridge_ar_ready_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_READY;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AR_VALID = core_imem_bridge_ar_valid_o;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_ADDR = core_imem_bridge_aw_addr_o;
    assign core_imem_bridge_aw_ready_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_READY;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_AW_VALID = core_imem_bridge_aw_valid_o;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_READY = core_imem_bridge_b_ready_o;
    assign core_imem_bridge_b_resp_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_RESP;
    assign core_imem_bridge_b_valid_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_B_VALID;
    assign core_imem_bridge_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign Ibex_Core_imem_to_core_imem_bridge_mem_ERR = core_imem_bridge_err_o;
    assign Ibex_Core_imem_to_core_imem_bridge_mem_GNT = core_imem_bridge_gnt_o;
    assign core_imem_bridge_r_data_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_DATA;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_READY = core_imem_bridge_r_ready_o;
    assign core_imem_bridge_r_resp_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_RESP;
    assign core_imem_bridge_r_valid_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_R_VALID;
    assign Ibex_Core_imem_to_core_imem_bridge_mem_RDATA = core_imem_bridge_rdata_o;
    assign core_imem_bridge_req_i = Ibex_Core_imem_to_core_imem_bridge_mem_REQ;
    assign core_imem_bridge_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign Ibex_Core_imem_to_core_imem_bridge_mem_RVALID = core_imem_bridge_rvalid_o;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_DATA = core_imem_bridge_w_data_o;
    assign core_imem_bridge_w_ready_i = core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_READY;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_STRB = core_imem_bridge_w_strb_o;
    assign core_imem_bridge_axi4lite_to_Ctrl_xbar_AXI4LITE_CORE_IMEM_W_VALID = core_imem_bridge_w_valid_o;
    // i_SysCtrl_peripherals assignments:
    assign i_SysCtrl_peripherals_ar_addr = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_ADDR;
    assign i_SysCtrl_peripherals_ar_prot = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_PROT;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_READY = i_SysCtrl_peripherals_ar_ready;
    assign i_SysCtrl_peripherals_ar_valid = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AR_VALID;
    assign i_SysCtrl_peripherals_aw_addr = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_ADDR;
    assign i_SysCtrl_peripherals_aw_prot = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_PROT;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_READY = i_SysCtrl_peripherals_aw_ready;
    assign i_SysCtrl_peripherals_aw_valid = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_AW_VALID;
    assign i_SysCtrl_peripherals_b_ready = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_READY;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_RESP = i_SysCtrl_peripherals_b_resp;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_B_VALID = i_SysCtrl_peripherals_b_valid;
    assign i_SysCtrl_peripherals_clk = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign i_SysCtrl_peripherals_GPIO_to_GPIO_gpo = i_SysCtrl_peripherals_gpio_from_core;
    assign i_SysCtrl_peripherals_gpio_to_core = i_SysCtrl_peripherals_GPIO_to_GPIO_gpi;
    assign i_SysCtrl_peripherals_irq_gpio_to_Ibex_Core_irq_fast_i = i_SysCtrl_peripherals_irq_gpio;
    assign i_SysCtrl_peripherals_irq_spi_to_Ibex_Core_irq_fast_i = i_SysCtrl_peripherals_irq_spi;
    assign i_SysCtrl_peripherals_irq_uart_to_Ibex_Core_irq_fast_i = i_SysCtrl_peripherals_irq_uart;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_DATA = i_SysCtrl_peripherals_r_data;
    assign i_SysCtrl_peripherals_r_ready = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_READY;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_RESP = i_SysCtrl_peripherals_r_resp;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_R_VALID = i_SysCtrl_peripherals_r_valid;
    assign i_SysCtrl_peripherals_rst_n = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_SysCtrl_peripherals_SPI_to_SPI_csn = i_SysCtrl_peripherals_spim_csn_internal;
    assign i_SysCtrl_peripherals_spim_miso_internal = i_SysCtrl_peripherals_SPI_to_SPI_miso;
    assign i_SysCtrl_peripherals_SPI_to_SPI_mosi = i_SysCtrl_peripherals_spim_mosi_internal;
    assign i_SysCtrl_peripherals_SPI_to_SPI_sck = i_SysCtrl_peripherals_spim_sck_internal;
    assign i_SysCtrl_peripherals_uart_rx_internal = i_SysCtrl_peripherals_UART_to_UART_uart_rx;
    assign i_SysCtrl_peripherals_UART_to_UART_uart_tx = i_SysCtrl_peripherals_uart_tx_internal;
    assign i_SysCtrl_peripherals_w_data = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_DATA;
    assign i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_READY = i_SysCtrl_peripherals_w_ready;
    assign i_SysCtrl_peripherals_w_strb = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_STRB;
    assign i_SysCtrl_peripherals_w_valid = i_SysCtrl_peripherals_AXI4LITE_to_Ctrl_xbar_AXI4LITE_periph_W_VALID;
    // i_dmem assignments:
    assign i_dmem_addr_i[9:0] = i_dmem_mem_to_axi_dmem_bridge_Mem_ADDR[11:2];
    assign i_dmem_be_i = i_dmem_mem_to_axi_dmem_bridge_Mem_BE;
    assign i_dmem_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign i_dmem_mem_to_axi_dmem_bridge_Mem_RDATA = i_dmem_rdata_o;
    assign i_dmem_req_i = i_dmem_mem_to_axi_dmem_bridge_Mem_REQ;
    assign i_dmem_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_dmem_wdata_i = i_dmem_mem_to_axi_dmem_bridge_Mem_WDATA;
    assign i_dmem_we_i = i_dmem_mem_to_axi_dmem_bridge_Mem_WE;
    // i_imem assignments:
    assign i_imem_addr_i[9:0] = axi_imem_bridge_Mem_to_i_imem_mem_ADDR[11:2];
    assign i_imem_be_i = axi_imem_bridge_Mem_to_i_imem_mem_BE;
    assign i_imem_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign axi_imem_bridge_Mem_to_i_imem_mem_RDATA = i_imem_rdata_o;
    assign i_imem_req_i = axi_imem_bridge_Mem_to_i_imem_mem_REQ;
    assign i_imem_rst_ni = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign i_imem_wdata_i = axi_imem_bridge_Mem_to_i_imem_mem_WDATA;
    assign i_imem_we_i = axi_imem_bridge_Mem_to_i_imem_mem_WE;
    // jtag_dbg_wrapper assignments:
    assign jtag_dbg_wrapper_clk_i = i_SysCtrl_peripherals_Clock_to_Clk_clk;
    assign jtag_dbg_wrapper_core_reset_to_Ibex_Core_Reset_reset = jtag_dbg_wrapper_core_reset;
    assign jtag_dbg_wrapper_Debug_to_Ibex_Core_Debug_debug_req = jtag_dbg_wrapper_debug_req_irq_o;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_ADDR = jtag_dbg_wrapper_init_ar_addr;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_PROT = jtag_dbg_wrapper_init_ar_prot;
    assign jtag_dbg_wrapper_init_ar_ready = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_READY;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AR_VALID = jtag_dbg_wrapper_init_ar_valid;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_ADDR = jtag_dbg_wrapper_init_aw_addr;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_PROT = jtag_dbg_wrapper_init_aw_prot;
    assign jtag_dbg_wrapper_init_aw_ready = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_READY;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_AW_VALID = jtag_dbg_wrapper_init_aw_valid;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_READY = jtag_dbg_wrapper_init_b_ready;
    assign jtag_dbg_wrapper_init_b_resp = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_RESP;
    assign jtag_dbg_wrapper_init_b_valid = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_B_VALID;
    assign jtag_dbg_wrapper_init_r_data = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_DATA;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_READY = jtag_dbg_wrapper_init_r_ready;
    assign jtag_dbg_wrapper_init_r_resp = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_RESP;
    assign jtag_dbg_wrapper_init_r_valid = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_R_VALID;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_DATA = jtag_dbg_wrapper_init_w_data;
    assign jtag_dbg_wrapper_init_w_ready = jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_READY;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_STRB = jtag_dbg_wrapper_init_w_strb;
    assign jtag_dbg_wrapper_AXI4LITE_I_to_Ctrl_xbar_AXI4LITE_DBG_I_W_VALID = jtag_dbg_wrapper_init_w_valid;
    assign jtag_dbg_wrapper_jtag_tck_i = jtag_dbg_wrapper_JTAG_to_JTAG_tck;
    assign jtag_dbg_wrapper_jtag_td_i = jtag_dbg_wrapper_JTAG_to_JTAG_tdi;
    assign jtag_dbg_wrapper_JTAG_to_JTAG_tdo = jtag_dbg_wrapper_jtag_td_o;
    assign jtag_dbg_wrapper_jtag_tms_i = jtag_dbg_wrapper_JTAG_to_JTAG_tms;
    assign jtag_dbg_wrapper_jtag_trst_ni = jtag_dbg_wrapper_JTAG_to_JTAG_trst;
    assign jtag_dbg_wrapper_rstn_i = i_SysCtrl_peripherals_Reset_to_Reset_reset;
    assign jtag_dbg_wrapper_target_ar_addr = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_ADDR;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_READY = jtag_dbg_wrapper_target_ar_ready;
    assign jtag_dbg_wrapper_target_ar_valid = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AR_VALID;
    assign jtag_dbg_wrapper_target_aw_addr = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_ADDR;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_READY = jtag_dbg_wrapper_target_aw_ready;
    assign jtag_dbg_wrapper_target_aw_valid = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_AW_VALID;
    assign jtag_dbg_wrapper_target_b_ready = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_READY;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_RESP = jtag_dbg_wrapper_target_b_resp;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_B_VALID = jtag_dbg_wrapper_target_b_valid;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_DATA = jtag_dbg_wrapper_target_r_data;
    assign jtag_dbg_wrapper_target_r_ready = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_READY;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_RESP = jtag_dbg_wrapper_target_r_resp;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_R_VALID = jtag_dbg_wrapper_target_r_valid;
    assign jtag_dbg_wrapper_target_w_data = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_DATA;
    assign jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_READY = jtag_dbg_wrapper_target_w_ready;
    assign jtag_dbg_wrapper_target_w_strb = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_STRB;
    assign jtag_dbg_wrapper_target_w_valid = jtag_dbg_wrapper_AXI4LITE_T_to_Ctrl_xbar_AXI4LITE_DBG_T_W_VALID;

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge #(
        .MEM_AW              (32),
        .MEM_DW              (32),
        .AXI_AW              (32),
        .AXI_DW              (32))
    Ctrl_reg_bridge(
        // Interface: AXI4LITE
        .ar_addr_i           (Ctrl_reg_bridge_ar_addr_i),
        .ar_valid_i          (Ctrl_reg_bridge_ar_valid_i),
        .aw_addr_i           (Ctrl_reg_bridge_aw_addr_i),
        .aw_valid_i          (Ctrl_reg_bridge_aw_valid_i),
        .b_ready_i           (Ctrl_reg_bridge_b_ready_i),
        .r_ready_i           (Ctrl_reg_bridge_r_ready_i),
        .w_data_i            (Ctrl_reg_bridge_w_data_i),
        .w_strb_i            (Ctrl_reg_bridge_w_strb_i),
        .w_valid_i           (Ctrl_reg_bridge_w_valid_i),
        .ar_ready_o          (Ctrl_reg_bridge_ar_ready_o),
        .aw_ready_o          (Ctrl_reg_bridge_aw_ready_o),
        .b_resp_o            (Ctrl_reg_bridge_b_resp_o),
        .b_valid_o           (Ctrl_reg_bridge_b_valid_o),
        .r_data_o            (Ctrl_reg_bridge_r_data_o),
        .r_resp_o            (Ctrl_reg_bridge_r_resp_o),
        .r_valid_o           (Ctrl_reg_bridge_r_valid_o),
        .w_ready_o           (Ctrl_reg_bridge_w_ready_o),
        // Interface: Clock
        .clk_i               (Ctrl_reg_bridge_clk_i),
        // Interface: Mem
        .rdata_i             (Ctrl_reg_bridge_rdata_i),
        .addr_o              (Ctrl_reg_bridge_addr_o),
        .be_o                (Ctrl_reg_bridge_be_o),
        .req_o               (Ctrl_reg_bridge_req_o),
        .wdata_o             (Ctrl_reg_bridge_wdata_o),
        .we_o                (Ctrl_reg_bridge_we_o),
        // Interface: Reset
        .rst_ni              (Ctrl_reg_bridge_rst_ni));

    // IP-XACT VLNV: tuni.fi:ip:SysCtrl_xbar:1.0
    SysCtrl_xbar #(
        .AXI4LITE_DW         (32),
        .AXI4LITE_AW         (32))
    Ctrl_xbar(
        // Interface: AXI4LITE_CORE_DMEM
        .CoreDMEM_ar_addr_in (Ctrl_xbar_CoreDMEM_ar_addr_in),
        .CoreDMEM_ar_valid_in(Ctrl_xbar_CoreDMEM_ar_valid_in),
        .CoreDMEM_aw_addr_in (Ctrl_xbar_CoreDMEM_aw_addr_in),
        .CoreDMEM_aw_valid_in(Ctrl_xbar_CoreDMEM_aw_valid_in),
        .CoreDMEM_b_ready_in (Ctrl_xbar_CoreDMEM_b_ready_in),
        .CoreDMEM_r_ready_in (Ctrl_xbar_CoreDMEM_r_ready_in),
        .CoreDMEM_w_data_in  (Ctrl_xbar_CoreDMEM_w_data_in),
        .CoreDMEM_w_strb_in  (Ctrl_xbar_CoreDMEM_w_strb_in),
        .CoreDMEM_w_valid_in (Ctrl_xbar_CoreDMEM_w_valid_in),
        .CoreDMEM_ar_ready_out(Ctrl_xbar_CoreDMEM_ar_ready_out),
        .CoreDMEM_aw_ready_out(Ctrl_xbar_CoreDMEM_aw_ready_out),
        .CoreDMEM_b_resp_out (Ctrl_xbar_CoreDMEM_b_resp_out),
        .CoreDMEM_b_valid_out(Ctrl_xbar_CoreDMEM_b_valid_out),
        .CoreDMEM_r_data_out (Ctrl_xbar_CoreDMEM_r_data_out),
        .CoreDMEM_r_resp_out (Ctrl_xbar_CoreDMEM_r_resp_out),
        .CoreDMEM_r_valid_out(Ctrl_xbar_CoreDMEM_r_valid_out),
        .CoreDMEM_w_ready_out(Ctrl_xbar_CoreDMEM_w_ready_out),
        // Interface: AXI4LITE_CORE_IMEM
        .CoreIMEM_ar_addr_in (Ctrl_xbar_CoreIMEM_ar_addr_in),
        .CoreIMEM_ar_valid_in(Ctrl_xbar_CoreIMEM_ar_valid_in),
        .CoreIMEM_aw_addr_in (Ctrl_xbar_CoreIMEM_aw_addr_in),
        .CoreIMEM_aw_valid_in(Ctrl_xbar_CoreIMEM_aw_valid_in),
        .CoreIMEM_b_ready_in (Ctrl_xbar_CoreIMEM_b_ready_in),
        .CoreIMEM_r_ready_in (Ctrl_xbar_CoreIMEM_r_ready_in),
        .CoreIMEM_w_data_in  (Ctrl_xbar_CoreIMEM_w_data_in),
        .CoreIMEM_w_strb_in  (Ctrl_xbar_CoreIMEM_w_strb_in),
        .CoreIMEM_w_valid_in (Ctrl_xbar_CoreIMEM_w_valid_in),
        .CoreIMEM_ar_ready_out(Ctrl_xbar_CoreIMEM_ar_ready_out),
        .CoreIMEM_aw_ready_out(Ctrl_xbar_CoreIMEM_aw_ready_out),
        .CoreIMEM_b_resp_out (Ctrl_xbar_CoreIMEM_b_resp_out),
        .CoreIMEM_b_valid_out(Ctrl_xbar_CoreIMEM_b_valid_out),
        .CoreIMEM_r_data_out (Ctrl_xbar_CoreIMEM_r_data_out),
        .CoreIMEM_r_resp_out (Ctrl_xbar_CoreIMEM_r_resp_out),
        .CoreIMEM_r_valid_out(Ctrl_xbar_CoreIMEM_r_valid_out),
        .CoreIMEM_w_ready_out(Ctrl_xbar_CoreIMEM_w_ready_out),
        // Interface: AXI4LITE_CTRL
        .CtrlReg_ar_ready_in (Ctrl_xbar_CtrlReg_ar_ready_in),
        .CtrlReg_aw_ready_in (Ctrl_xbar_CtrlReg_aw_ready_in),
        .CtrlReg_b_resp_in   (Ctrl_xbar_CtrlReg_b_resp_in),
        .CtrlReg_b_valid_in  (Ctrl_xbar_CtrlReg_b_valid_in),
        .CtrlReg_r_data_in   (Ctrl_xbar_CtrlReg_r_data_in),
        .CtrlReg_r_resp_in   (Ctrl_xbar_CtrlReg_r_resp_in),
        .CtrlReg_r_valid_in  (Ctrl_xbar_CtrlReg_r_valid_in),
        .CtrlReg_w_ready_in  (Ctrl_xbar_CtrlReg_w_ready_in),
        .CtrlReg_ar_addr_out (Ctrl_xbar_CtrlReg_ar_addr_out),
        .CtrlReg_ar_valid_out(Ctrl_xbar_CtrlReg_ar_valid_out),
        .CtrlReg_aw_addr_out (Ctrl_xbar_CtrlReg_aw_addr_out),
        .CtrlReg_aw_valid_out(Ctrl_xbar_CtrlReg_aw_valid_out),
        .CtrlReg_b_ready_out (Ctrl_xbar_CtrlReg_b_ready_out),
        .CtrlReg_r_ready_out (Ctrl_xbar_CtrlReg_r_ready_out),
        .CtrlReg_w_data_out  (Ctrl_xbar_CtrlReg_w_data_out),
        .CtrlReg_w_strb_out  (Ctrl_xbar_CtrlReg_w_strb_out),
        .CtrlReg_w_valid_out (Ctrl_xbar_CtrlReg_w_valid_out),
        // Interface: AXI4LITE_DBG_I
        .DbgI_ar_addr        (Ctrl_xbar_DbgI_ar_addr),
        .DbgI_ar_prot        (Ctrl_xbar_DbgI_ar_prot),
        .DbgI_ar_valid       (Ctrl_xbar_DbgI_ar_valid),
        .DbgI_aw_addr        (Ctrl_xbar_DbgI_aw_addr),
        .DbgI_aw_prot        (Ctrl_xbar_DbgI_aw_prot),
        .DbgI_aw_valid       (Ctrl_xbar_DbgI_aw_valid),
        .DbgI_b_ready        (Ctrl_xbar_DbgI_b_ready),
        .DbgI_r_ready        (Ctrl_xbar_DbgI_r_ready),
        .DbgI_w_data         (Ctrl_xbar_DbgI_w_data),
        .DbgI_w_strb         (Ctrl_xbar_DbgI_w_strb),
        .DbgI_w_valid        (Ctrl_xbar_DbgI_w_valid),
        .DbgI_ar_ready       (Ctrl_xbar_DbgI_ar_ready),
        .DbgI_aw_ready       (Ctrl_xbar_DbgI_aw_ready),
        .DbgI_b_resp         (Ctrl_xbar_DbgI_b_resp),
        .DbgI_b_valid        (Ctrl_xbar_DbgI_b_valid),
        .DbgI_r_data         (Ctrl_xbar_DbgI_r_data),
        .DbgI_r_resp         (Ctrl_xbar_DbgI_r_resp),
        .DbgI_r_valid        (Ctrl_xbar_DbgI_r_valid),
        .DbgI_w_ready        (Ctrl_xbar_DbgI_w_ready),
        // Interface: AXI4LITE_DBG_T
        .DbgT_ar_ready_in    (Ctrl_xbar_DbgT_ar_ready_in),
        .DbgT_aw_ready_in    (Ctrl_xbar_DbgT_aw_ready_in),
        .DbgT_b_resp_in      (Ctrl_xbar_DbgT_b_resp_in),
        .DbgT_b_valid_in     (Ctrl_xbar_DbgT_b_valid_in),
        .DbgT_r_data_in      (Ctrl_xbar_DbgT_r_data_in),
        .DbgT_r_resp_in      (Ctrl_xbar_DbgT_r_resp_in),
        .DbgT_r_valid_in     (Ctrl_xbar_DbgT_r_valid_in),
        .DbgT_w_ready_in     (Ctrl_xbar_DbgT_w_ready_in),
        .DbgT_ar_addr_out    (Ctrl_xbar_DbgT_ar_addr_out),
        .DbgT_ar_valid_out   (Ctrl_xbar_DbgT_ar_valid_out),
        .DbgT_aw_addr_out    (Ctrl_xbar_DbgT_aw_addr_out),
        .DbgT_aw_valid_out   (Ctrl_xbar_DbgT_aw_valid_out),
        .DbgT_b_ready_out    (Ctrl_xbar_DbgT_b_ready_out),
        .DbgT_r_ready_out    (Ctrl_xbar_DbgT_r_ready_out),
        .DbgT_w_data_out     (Ctrl_xbar_DbgT_w_data_out),
        .DbgT_w_strb_out     (Ctrl_xbar_DbgT_w_strb_out),
        .DbgT_w_valid_out    (Ctrl_xbar_DbgT_w_valid_out),
        // Interface: AXI4LITE_DMEM
        .DMEM_ar_ready_in    (Ctrl_xbar_DMEM_ar_ready_in),
        .DMEM_aw_ready_in    (Ctrl_xbar_DMEM_aw_ready_in),
        .DMEM_b_resp_in      (Ctrl_xbar_DMEM_b_resp_in),
        .DMEM_b_valid_in     (Ctrl_xbar_DMEM_b_valid_in),
        .DMEM_r_data_in      (Ctrl_xbar_DMEM_r_data_in),
        .DMEM_r_resp_in      (Ctrl_xbar_DMEM_r_resp_in),
        .DMEM_r_valid_in     (Ctrl_xbar_DMEM_r_valid_in),
        .DMEM_w_ready_in     (Ctrl_xbar_DMEM_w_ready_in),
        .DMEM_ar_addr_out    (Ctrl_xbar_DMEM_ar_addr_out),
        .DMEM_ar_valid_out   (Ctrl_xbar_DMEM_ar_valid_out),
        .DMEM_aw_addr_out    (Ctrl_xbar_DMEM_aw_addr_out),
        .DMEM_aw_valid_out   (Ctrl_xbar_DMEM_aw_valid_out),
        .DMEM_b_ready_out    (Ctrl_xbar_DMEM_b_ready_out),
        .DMEM_r_ready_out    (Ctrl_xbar_DMEM_r_ready_out),
        .DMEM_w_data_out     (Ctrl_xbar_DMEM_w_data_out),
        .DMEM_w_strb_out     (Ctrl_xbar_DMEM_w_strb_out),
        .DMEM_w_valid_out    (Ctrl_xbar_DMEM_w_valid_out),
        // Interface: AXI4LITE_IMEM
        .IMEM_ar_ready_in    (Ctrl_xbar_IMEM_ar_ready_in),
        .IMEM_aw_ready_in    (Ctrl_xbar_IMEM_aw_ready_in),
        .IMEM_b_resp_in      (Ctrl_xbar_IMEM_b_resp_in),
        .IMEM_b_valid_in     (Ctrl_xbar_IMEM_b_valid_in),
        .IMEM_r_data_in      (Ctrl_xbar_IMEM_r_data_in),
        .IMEM_r_resp_in      (Ctrl_xbar_IMEM_r_resp_in),
        .IMEM_r_valid_in     (Ctrl_xbar_IMEM_r_valid_in),
        .IMEM_w_ready_in     (Ctrl_xbar_IMEM_w_ready_in),
        .IMEM_ar_addr_out    (Ctrl_xbar_IMEM_ar_addr_out),
        .IMEM_ar_valid_out   (Ctrl_xbar_IMEM_ar_valid_out),
        .IMEM_aw_addr_out    (Ctrl_xbar_IMEM_aw_addr_out),
        .IMEM_aw_valid_out   (Ctrl_xbar_IMEM_aw_valid_out),
        .IMEM_b_ready_out    (Ctrl_xbar_IMEM_b_ready_out),
        .IMEM_r_ready_out    (Ctrl_xbar_IMEM_r_ready_out),
        .IMEM_w_data_out     (Ctrl_xbar_IMEM_w_data_out),
        .IMEM_w_strb_out     (Ctrl_xbar_IMEM_w_strb_out),
        .IMEM_w_valid_out    (Ctrl_xbar_IMEM_w_valid_out),
        // Interface: AXI4LITE_icn
        .icn_ar_ready_in     (Ctrl_xbar_icn_ar_ready_in),
        .icn_aw_ready_in     (Ctrl_xbar_icn_aw_ready_in),
        .icn_b_resp_in       (Ctrl_xbar_icn_b_resp_in),
        .icn_b_valid_in      (Ctrl_xbar_icn_b_valid_in),
        .icn_r_data_in       (Ctrl_xbar_icn_r_data_in),
        .icn_r_resp_in       (Ctrl_xbar_icn_r_resp_in),
        .icn_r_valid_in      (Ctrl_xbar_icn_r_valid_in),
        .icn_w_ready_in      (Ctrl_xbar_icn_w_ready_in),
        .icn_ar_addr_out     (Ctrl_xbar_icn_ar_addr_out),
        .icn_ar_prot_out     (Ctrl_xbar_icn_ar_prot_out),
        .icn_ar_valid_out    (Ctrl_xbar_icn_ar_valid_out),
        .icn_aw_addr_out     (Ctrl_xbar_icn_aw_addr_out),
        .icn_aw_prot_out     (Ctrl_xbar_icn_aw_prot_out),
        .icn_aw_valid_out    (Ctrl_xbar_icn_aw_valid_out),
        .icn_b_ready_out     (Ctrl_xbar_icn_b_ready_out),
        .icn_r_ready_out     (Ctrl_xbar_icn_r_ready_out),
        .icn_w_data_out      (Ctrl_xbar_icn_w_data_out),
        .icn_w_strb_out      (Ctrl_xbar_icn_w_strb_out),
        .icn_w_valid_out     (Ctrl_xbar_icn_w_valid_out),
        // Interface: AXI4LITE_periph
        .periph_ar_ready_in  (Ctrl_xbar_periph_ar_ready_in),
        .periph_aw_ready_in  (Ctrl_xbar_periph_aw_ready_in),
        .periph_b_resp_in    (Ctrl_xbar_periph_b_resp_in),
        .periph_b_valid_in   (Ctrl_xbar_periph_b_valid_in),
        .periph_r_data_in    (Ctrl_xbar_periph_r_data_in),
        .periph_r_resp_in    (Ctrl_xbar_periph_r_resp_in),
        .periph_r_valid_in   (Ctrl_xbar_periph_r_valid_in),
        .periph_w_ready_in   (Ctrl_xbar_periph_w_ready_in),
        .periph_ar_addr_out  (Ctrl_xbar_periph_ar_addr_out),
        .periph_ar_prot_out  (Ctrl_xbar_periph_ar_prot_out),
        .periph_ar_valid_out (Ctrl_xbar_periph_ar_valid_out),
        .periph_aw_addr_out  (Ctrl_xbar_periph_aw_addr_out),
        .periph_aw_prot_out  (Ctrl_xbar_periph_aw_prot_out),
        .periph_aw_valid_out (Ctrl_xbar_periph_aw_valid_out),
        .periph_b_ready_out  (Ctrl_xbar_periph_b_ready_out),
        .periph_r_ready_out  (Ctrl_xbar_periph_r_ready_out),
        .periph_w_data_out   (Ctrl_xbar_periph_w_data_out),
        .periph_w_strb_out   (Ctrl_xbar_periph_w_strb_out),
        .periph_w_valid_out  (Ctrl_xbar_periph_w_valid_out),
        // Interface: Clock
        .clk_i               (Ctrl_xbar_clk_i),
        // Interface: Reset
        .reset_ni            (Ctrl_xbar_reset_ni));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex:1.0
`ifndef SYNTHESIS
    ibex_top_tracing  #(
`else
    ibex_top #(
`endif
        .DmBaseAddr        ('h01020000),
        .DmHaltAddr          (16910336),
        .DmExceptionAddr     (16910358))
    Ibex_Core(
        // Interface: Clock
        .clk_i               (Ibex_Core_clk_i),
        // Interface: Debug
        .debug_req_i         (Ibex_Core_debug_req_i),
        // Interface: FetchEn
        .fetch_enable_i      (Ibex_Core_fetch_enable_i),
        // Interface: IRQ_fast
        .irq_fast_i          (Ibex_Core_irq_fast_i),
        // Interface: Reset
        .rst_ni              (Ibex_Core_rst_ni),
        // Interface: dmem
        .data_err_i          (Ibex_Core_data_err_i),
        .data_gnt_i          (Ibex_Core_data_gnt_i),
        .data_rdata_i        (Ibex_Core_data_rdata_i),
        .data_rdata_intg_i   (7'h0),
        .data_rvalid_i       (Ibex_Core_data_rvalid_i),
        .data_addr_o         (Ibex_Core_data_addr_o),
        .data_be_o           (Ibex_Core_data_be_o),
        .data_req_o          (Ibex_Core_data_req_o),
        .data_wdata_intg_o   (),
        .data_wdata_o        (Ibex_Core_data_wdata_o),
        .data_we_o           (Ibex_Core_data_we_o),
        // Interface: imem
        .instr_err_i         (Ibex_Core_instr_err_i),
        .instr_gnt_i         (Ibex_Core_instr_gnt_i),
        .instr_rdata_i       (Ibex_Core_instr_rdata_i),
        .instr_rdata_intg_i  (7'h0),
        .instr_rvalid_i      (Ibex_Core_instr_rvalid_i),
        .instr_addr_o        (Ibex_Core_instr_addr_o),
        .instr_req_o         (Ibex_Core_instr_req_o),
        // These ports are not in any interface
        .boot_addr_i         (32'h01040100),
        .hart_id_i           (32'h0),
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
        .double_fault_seen_o (),
        .scramble_req_o      ());

    // IP-XACT VLNV: tuni.fi:ip:SS_Ctrl_reg_array:1.0
    SS_Ctrl_reg_array #(
        .IOCELL_COUNT        (17),
        .IOCELL_CFG_W        (5),
        .AW                  (32),
        .DW                  (32),
        .SS_CTRL_W           (8))
    SS_Ctrl_reg_array(
        // Interface: Clock
        .clk                 (SS_Ctrl_reg_array_clk),
        // Interface: Reset
        .reset               (SS_Ctrl_reg_array_reset),
        // Interface: fetch_en
        .fetch_en            (SS_Ctrl_reg_array_fetch_en),
        // Interface: icn_ss_ctrl
        .ss_ctrl_icn         (SS_Ctrl_reg_array_ss_ctrl_icn),
        // Interface: io_cfg
        .cell_cfg            (SS_Ctrl_reg_array_cell_cfg),
        // Interface: mem_reg_if
        .addr_in             (SS_Ctrl_reg_array_addr_in),
        .be_in               (SS_Ctrl_reg_array_be_in),
        .req_in              (SS_Ctrl_reg_array_req_in),
        .wdata_in            (SS_Ctrl_reg_array_wdata_in),
        .we_in               (SS_Ctrl_reg_array_we_in),
        .rdata_out           (SS_Ctrl_reg_array_rdata_out),
        // Interface: pmod_sel
        .pmod_sel            (SS_Ctrl_reg_array_pmod_sel),
        // Interface: rst_icn
        .reset_icn           (SS_Ctrl_reg_array_reset_icn),
        // Interface: rst_ss
        .reset_ss_0          (SS_Ctrl_reg_array_reset_ss_0),
        .reset_ss_1          (SS_Ctrl_reg_array_reset_ss_1),
        .reset_ss_2          (SS_Ctrl_reg_array_reset_ss_2),
        .reset_ss_3          (SS_Ctrl_reg_array_reset_ss_3),
        // Interface: ss_ctrl_0
        .irq_en_0            (SS_Ctrl_reg_array_irq_en_0),
        .ss_ctrl_0           (SS_Ctrl_reg_array_ss_ctrl_0),
        // Interface: ss_ctrl_1
        .irq_en_1            (SS_Ctrl_reg_array_irq_en_1),
        .ss_ctrl_1           (SS_Ctrl_reg_array_ss_ctrl_1),
        // Interface: ss_ctrl_2
        .irq_en_2            (SS_Ctrl_reg_array_irq_en_2),
        .ss_ctrl_2           (SS_Ctrl_reg_array_ss_ctrl_2),
        // Interface: ss_ctrl_3
        .irq_en_3            (SS_Ctrl_reg_array_irq_en_3),
        .ss_ctrl_3           (SS_Ctrl_reg_array_ss_ctrl_3));

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge #(
        .MEM_AW              (32),
        .MEM_DW              (32),
        .AXI_AW              (32),
        .AXI_DW              (32))
    axi_dmem_bridge(
        // Interface: AXI4LITE
        .ar_addr_i           (axi_dmem_bridge_ar_addr_i),
        .ar_valid_i          (axi_dmem_bridge_ar_valid_i),
        .aw_addr_i           (axi_dmem_bridge_aw_addr_i),
        .aw_valid_i          (axi_dmem_bridge_aw_valid_i),
        .b_ready_i           (axi_dmem_bridge_b_ready_i),
        .r_ready_i           (axi_dmem_bridge_r_ready_i),
        .w_data_i            (axi_dmem_bridge_w_data_i),
        .w_strb_i            (axi_dmem_bridge_w_strb_i),
        .w_valid_i           (axi_dmem_bridge_w_valid_i),
        .ar_ready_o          (axi_dmem_bridge_ar_ready_o),
        .aw_ready_o          (axi_dmem_bridge_aw_ready_o),
        .b_resp_o            (axi_dmem_bridge_b_resp_o),
        .b_valid_o           (axi_dmem_bridge_b_valid_o),
        .r_data_o            (axi_dmem_bridge_r_data_o),
        .r_resp_o            (axi_dmem_bridge_r_resp_o),
        .r_valid_o           (axi_dmem_bridge_r_valid_o),
        .w_ready_o           (axi_dmem_bridge_w_ready_o),
        // Interface: Clock
        .clk_i               (axi_dmem_bridge_clk_i),
        // Interface: Mem
        .rdata_i             (axi_dmem_bridge_rdata_i),
        .addr_o              (axi_dmem_bridge_addr_o),
        .be_o                (axi_dmem_bridge_be_o),
        .req_o               (axi_dmem_bridge_req_o),
        .wdata_o             (axi_dmem_bridge_wdata_o),
        .we_o                (axi_dmem_bridge_we_o),
        // Interface: Reset
        .rst_ni              (axi_dmem_bridge_rst_ni));

    // IP-XACT VLNV: tuni.fi:ip:mem_axi_bridge:1.0
    mem_axi_bridge #(
        .MEM_AW              (32),
        .MEM_DW              (32),
        .AXI_AW              (32),
        .AXI_DW              (32))
    axi_imem_bridge(
        // Interface: AXI4LITE
        .ar_addr_i           (axi_imem_bridge_ar_addr_i),
        .ar_valid_i          (axi_imem_bridge_ar_valid_i),
        .aw_addr_i           (axi_imem_bridge_aw_addr_i),
        .aw_valid_i          (axi_imem_bridge_aw_valid_i),
        .b_ready_i           (axi_imem_bridge_b_ready_i),
        .r_ready_i           (axi_imem_bridge_r_ready_i),
        .w_data_i            (axi_imem_bridge_w_data_i),
        .w_strb_i            (axi_imem_bridge_w_strb_i),
        .w_valid_i           (axi_imem_bridge_w_valid_i),
        .ar_ready_o          (axi_imem_bridge_ar_ready_o),
        .aw_ready_o          (axi_imem_bridge_aw_ready_o),
        .b_resp_o            (axi_imem_bridge_b_resp_o),
        .b_valid_o           (axi_imem_bridge_b_valid_o),
        .r_data_o            (axi_imem_bridge_r_data_o),
        .r_resp_o            (axi_imem_bridge_r_resp_o),
        .r_valid_o           (axi_imem_bridge_r_valid_o),
        .w_ready_o           (axi_imem_bridge_w_ready_o),
        // Interface: Clock
        .clk_i               (axi_imem_bridge_clk_i),
        // Interface: Mem
        .rdata_i             (axi_imem_bridge_rdata_i),
        .addr_o              (axi_imem_bridge_addr_o),
        .be_o                (axi_imem_bridge_be_o),
        .req_o               (axi_imem_bridge_req_o),
        .wdata_o             (axi_imem_bridge_wdata_o),
        .we_o                (axi_imem_bridge_we_o),
        // Interface: Reset
        .rst_ni              (axi_imem_bridge_rst_ni));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex_axi_bridge:1.0
    ibex_axi_bridge #(
        .AXI_DW              (32),
        .AXI_AW              (32),
        .IBEX_AW             (32),
        .IBEX_DW             (32))
    core_dmem_bridge(
        // Interface: Clock
        .clk_i               (core_dmem_bridge_clk_i),
        // Interface: Reset
        .rst_ni              (core_dmem_bridge_rst_ni),
        // Interface: axi4lite
        .ar_ready_i          (core_dmem_bridge_ar_ready_i),
        .aw_ready_i          (core_dmem_bridge_aw_ready_i),
        .b_resp_i            (core_dmem_bridge_b_resp_i),
        .b_valid_i           (core_dmem_bridge_b_valid_i),
        .r_data_i            (core_dmem_bridge_r_data_i),
        .r_resp_i            (core_dmem_bridge_r_resp_i),
        .r_valid_i           (core_dmem_bridge_r_valid_i),
        .w_ready_i           (core_dmem_bridge_w_ready_i),
        .ar_addr_o           (core_dmem_bridge_ar_addr_o),
        .ar_valid_o          (core_dmem_bridge_ar_valid_o),
        .aw_addr_o           (core_dmem_bridge_aw_addr_o),
        .aw_valid_o          (core_dmem_bridge_aw_valid_o),
        .b_ready_o           (core_dmem_bridge_b_ready_o),
        .r_ready_o           (core_dmem_bridge_r_ready_o),
        .w_data_o            (core_dmem_bridge_w_data_o),
        .w_strb_o            (core_dmem_bridge_w_strb_o),
        .w_valid_o           (core_dmem_bridge_w_valid_o),
        // Interface: mem
        .addr_i              (core_dmem_bridge_addr_i),
        .be_i                (core_dmem_bridge_be_i),
        .req_i               (core_dmem_bridge_req_i),
        .wdata_i             (core_dmem_bridge_wdata_i),
        .we_i                (core_dmem_bridge_we_i),
        .err_o               (core_dmem_bridge_err_o),
        .gnt_o               (core_dmem_bridge_gnt_o),
        .rdata_o             (core_dmem_bridge_rdata_o),
        .rvalid_o            (core_dmem_bridge_rvalid_o));

    // IP-XACT VLNV: tuni.fi:lowRISC:ibex_axi_bridge:1.0
    ibex_axi_bridge #(
        .AXI_DW              (32),
        .AXI_AW              (32),
        .IBEX_AW             (32),
        .IBEX_DW             (32))
    core_imem_bridge(
        // Interface: Clock
        .clk_i               (core_imem_bridge_clk_i),
        // Interface: Reset
        .rst_ni              (core_imem_bridge_rst_ni),
        // Interface: axi4lite
        .ar_ready_i          (core_imem_bridge_ar_ready_i),
        .aw_ready_i          (core_imem_bridge_aw_ready_i),
        .b_resp_i            (core_imem_bridge_b_resp_i),
        .b_valid_i           (core_imem_bridge_b_valid_i),
        .r_data_i            (core_imem_bridge_r_data_i),
        .r_resp_i            (core_imem_bridge_r_resp_i),
        .r_valid_i           (core_imem_bridge_r_valid_i),
        .w_ready_i           (core_imem_bridge_w_ready_i),
        .ar_addr_o           (core_imem_bridge_ar_addr_o),
        .ar_valid_o          (core_imem_bridge_ar_valid_o),
        .aw_addr_o           (core_imem_bridge_aw_addr_o),
        .aw_valid_o          (core_imem_bridge_aw_valid_o),
        .b_ready_o           (core_imem_bridge_b_ready_o),
        .r_ready_o           (core_imem_bridge_r_ready_o),
        .w_data_o            (core_imem_bridge_w_data_o),
        .w_strb_o            (core_imem_bridge_w_strb_o),
        .w_valid_o           (core_imem_bridge_w_valid_o),
        // Interface: mem
        .addr_i              (core_imem_bridge_addr_i),
        .be_i                (4'd0),
        .req_i               (core_imem_bridge_req_i),
        .wdata_i             (32'd0),
        .we_i                (1'd0),
        .err_o               (core_imem_bridge_err_o),
        .gnt_o               (core_imem_bridge_gnt_o),
        .rdata_o             (core_imem_bridge_rdata_o),
        .rvalid_o            (core_imem_bridge_rvalid_o));

    // IP-XACT VLNV: tuni.fi:ip:SysCtrl_peripherals:1.0
    SysCtrl_peripherals_0 #(
        .AXI4LITE_DW         (32),
        .AXI4LITE_AW         (32),
        .NUM_GPIO            (8))
    i_SysCtrl_peripherals(
        // Interface: AXI4LITE
        .ar_addr             (i_SysCtrl_peripherals_ar_addr),
        .ar_prot             (i_SysCtrl_peripherals_ar_prot),
        .ar_valid            (i_SysCtrl_peripherals_ar_valid),
        .aw_addr             (i_SysCtrl_peripherals_aw_addr),
        .aw_prot             (i_SysCtrl_peripherals_aw_prot),
        .aw_valid            (i_SysCtrl_peripherals_aw_valid),
        .b_ready             (i_SysCtrl_peripherals_b_ready),
        .r_ready             (i_SysCtrl_peripherals_r_ready),
        .w_data              (i_SysCtrl_peripherals_w_data),
        .w_strb              (i_SysCtrl_peripherals_w_strb),
        .w_valid             (i_SysCtrl_peripherals_w_valid),
        .ar_ready            (i_SysCtrl_peripherals_ar_ready),
        .aw_ready            (i_SysCtrl_peripherals_aw_ready),
        .b_resp              (i_SysCtrl_peripherals_b_resp),
        .b_valid             (i_SysCtrl_peripherals_b_valid),
        .r_data              (i_SysCtrl_peripherals_r_data),
        .r_resp              (i_SysCtrl_peripherals_r_resp),
        .r_valid             (i_SysCtrl_peripherals_r_valid),
        .w_ready             (i_SysCtrl_peripherals_w_ready),
        // Interface: Clock
        .clk                 (i_SysCtrl_peripherals_clk),
        // Interface: GPIO
        .gpio_to_core        (i_SysCtrl_peripherals_gpio_to_core),
        .gpio_from_core      (i_SysCtrl_peripherals_gpio_from_core),
        // Interface: IRQ_GPIO
        .irq_gpio            (i_SysCtrl_peripherals_irq_gpio),
        // Interface: IRQ_SPI
        .irq_spi             (i_SysCtrl_peripherals_irq_spi),
        // Interface: IRQ_UART
        .irq_uart            (i_SysCtrl_peripherals_irq_uart),
        // Interface: Reset
        .rst_n               (i_SysCtrl_peripherals_rst_n),
        // Interface: SPI
        .spim_miso_internal  (i_SysCtrl_peripherals_spim_miso_internal),
        .spim_csn_internal   (i_SysCtrl_peripherals_spim_csn_internal),
        .spim_mosi_internal  (i_SysCtrl_peripherals_spim_mosi_internal),
        .spim_sck_internal   (i_SysCtrl_peripherals_spim_sck_internal),
        // Interface: UART
        .uart_rx_internal    (i_SysCtrl_peripherals_uart_rx_internal),
        .uart_tx_internal    (i_SysCtrl_peripherals_uart_tx_internal));

    // IP-XACT VLNV: tuni.fi:memory.simulation:sp_sram:1.0
    sp_sram #(
        .DATA_WIDTH          (32),
        .NUM_WORDS           (1024))
    i_dmem(
        // Interface: Clock
        .clk_i               (i_dmem_clk_i),
        // Interface: Reset
        .rst_ni              (i_dmem_rst_ni),
        // Interface: mem
        .addr_i              (i_dmem_addr_i),
        .be_i                (i_dmem_be_i),
        .req_i               (i_dmem_req_i),
        .wdata_i             (i_dmem_wdata_i),
        .we_i                (i_dmem_we_i),
        .rdata_o             (i_dmem_rdata_o),
        // These ports are not in any interface
        .wuser_i             (1'b0),
        .ruser_o             ());

    // IP-XACT VLNV: tuni.fi:memory.simulation:sp_sram:1.0
    sp_sram #(
        .DATA_WIDTH          (32),
        .NUM_WORDS           (1024))
    i_imem(
        // Interface: Clock
        .clk_i               (i_imem_clk_i),
        // Interface: Reset
        .rst_ni              (i_imem_rst_ni),
        // Interface: mem
        .addr_i              (i_imem_addr_i),
        .be_i                (i_imem_be_i),
        .req_i               (i_imem_req_i),
        .wdata_i             (i_imem_wdata_i),
        .we_i                (i_imem_we_i),
        .rdata_o             (i_imem_rdata_o),
        // These ports are not in any interface
        .wuser_i             (1'b0),
        .ruser_o             ());

    // IP-XACT VLNV: tuni.fi:ip:jtag_dbg_wrapper:1.0
    jtag_dbg_wrapper #(
        .AXI_AW              (32),
        .DM_BASE_ADDRESS     ('h01020000),
        .AXI_DW              (32),
        .DM_ID_VALUE         (470810337))
    jtag_dbg_wrapper(
        // Interface: AXI4LITE_I
        .init_ar_ready       (jtag_dbg_wrapper_init_ar_ready),
        .init_aw_ready       (jtag_dbg_wrapper_init_aw_ready),
        .init_b_resp         (jtag_dbg_wrapper_init_b_resp),
        .init_b_valid        (jtag_dbg_wrapper_init_b_valid),
        .init_r_data         (jtag_dbg_wrapper_init_r_data),
        .init_r_resp         (jtag_dbg_wrapper_init_r_resp),
        .init_r_valid        (jtag_dbg_wrapper_init_r_valid),
        .init_w_ready        (jtag_dbg_wrapper_init_w_ready),
        .init_ar_addr        (jtag_dbg_wrapper_init_ar_addr),
        .init_ar_prot        (jtag_dbg_wrapper_init_ar_prot),
        .init_ar_valid       (jtag_dbg_wrapper_init_ar_valid),
        .init_aw_addr        (jtag_dbg_wrapper_init_aw_addr),
        .init_aw_prot        (jtag_dbg_wrapper_init_aw_prot),
        .init_aw_valid       (jtag_dbg_wrapper_init_aw_valid),
        .init_b_ready        (jtag_dbg_wrapper_init_b_ready),
        .init_r_ready        (jtag_dbg_wrapper_init_r_ready),
        .init_w_data         (jtag_dbg_wrapper_init_w_data),
        .init_w_strb         (jtag_dbg_wrapper_init_w_strb),
        .init_w_valid        (jtag_dbg_wrapper_init_w_valid),
        // Interface: AXI4LITE_T
        .target_ar_addr      (jtag_dbg_wrapper_target_ar_addr),
        .target_ar_valid     (jtag_dbg_wrapper_target_ar_valid),
        .target_aw_addr      (jtag_dbg_wrapper_target_aw_addr),
        .target_aw_valid     (jtag_dbg_wrapper_target_aw_valid),
        .target_b_ready      (jtag_dbg_wrapper_target_b_ready),
        .target_r_ready      (jtag_dbg_wrapper_target_r_ready),
        .target_w_data       (jtag_dbg_wrapper_target_w_data),
        .target_w_strb       (jtag_dbg_wrapper_target_w_strb),
        .target_w_valid      (jtag_dbg_wrapper_target_w_valid),
        .target_ar_ready     (jtag_dbg_wrapper_target_ar_ready),
        .target_aw_ready     (jtag_dbg_wrapper_target_aw_ready),
        .target_b_resp       (jtag_dbg_wrapper_target_b_resp),
        .target_b_valid      (jtag_dbg_wrapper_target_b_valid),
        .target_r_data       (jtag_dbg_wrapper_target_r_data),
        .target_r_resp       (jtag_dbg_wrapper_target_r_resp),
        .target_r_valid      (jtag_dbg_wrapper_target_r_valid),
        .target_w_ready      (jtag_dbg_wrapper_target_w_ready),
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
        // Interface: Reset
        .rstn_i              (jtag_dbg_wrapper_rstn_i),
        // Interface: core_reset
        .core_reset          (jtag_dbg_wrapper_core_reset),
        // These ports are not in any interface
        .ndmreset_o          ());


endmodule
