//-----------------------------------------------------------------------------
// File          : SysCtrl_xbar.v
// Creation date : 13.02.2024
// Creation time : 11:21:36
// Description   : SysCtrl internal XBAR.
// Created by    : 
// Tool : Kactus2 3.13.0 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:SysCtrl_xbar:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/ip/SysCtrl_xbar/1.0/SysCtrl_xbar.1.0.xml
//-----------------------------------------------------------------------------

module SysCtrl_xbar #(
    parameter                              AXI4LITE_AW      = 32,
    parameter                              AXI4LITE_DW      = 32,
    parameter                              AXI_AW           = 32,
    parameter                              AXI_DW           = 32,
    parameter                              AXI_IDW          = 10,
    parameter                              AXI_USERW        = 1
) (
    // Interface: AXI4LITE_BootRom
    input  logic                        BootRom_ar_ready_in,
    input  logic                        BootRom_aw_ready_in,
    input  logic         [1:0]          BootRom_b_resp_in,
    input  logic                        BootRom_b_valid_in,
    input  logic         [AXI4LITE_DW-1:0] BootRom_r_data_in,
    input  logic         [1:0]          BootRom_r_resp_in,
    input  logic                        BootRom_r_valid_in,
    input  logic                        BootRom_w_ready_in,
    output logic         [AXI4LITE_AW:0] BootRom_ar_addr_out,
    output logic                        BootRom_ar_valid_out,
    output logic         [AXI4LITE_AW-1:0] BootRom_aw_addr_out,
    output logic                        BootRom_aw_valid_out,
    output logic                        BootRom_b_ready_out,
    output logic                        BootRom_r_ready_out,
    output logic         [AXI4LITE_DW-1:0] BootRom_w_data_out,
    output logic         [(AXI4LITE_DW/8)-1:0] BootRom_w_strb_out,
    output logic                        BootRom_w_valid_out,

    // Interface: AXI4LITE_CORE_DMEM
    input  logic         [AXI4LITE_AW-1:0] CoreIMEM_ar_addr_in,
    input  logic                        CoreIMEM_ar_valid_in,
    input  logic         [AXI4LITE_AW-1:0] CoreIMEM_aw_addr_in,
    input  logic                        CoreIMEM_aw_valid_in,
    input  logic                        CoreIMEM_b_ready_in,
    input  logic                        CoreIMEM_r_ready_in,
    input  logic         [AXI4LITE_DW-1:0] CoreIMEM_w_data_in,
    input  logic         [(AXI4LITE_DW/8)-1:0] CoreIMEM_w_strb_in,
    input  logic                        CoreIMEM_w_valid_in,
    output logic                        CoreIMEM_ar_ready_out,
    output logic                        CoreIMEM_aw_ready_out,
    output logic         [1:0]          CoreIMEM_b_resp_out,
    output logic                        CoreIMEM_b_valid_out,
    output logic         [AXI4LITE_DW-1:0] CoreIMEM_r_data_out,
    output logic         [1:0]          CoreIMEM_r_resp_out,
    output logic                        CoreIMEM_r_valid_out,
    output logic                        CoreIMEM_w_ready_out,

    // Interface: AXI4LITE_CORE_IMEM
    input  logic         [AXI4LITE_AW-1:0] CoreDMEM_ar_addr_in,
    input  logic                        CoreDMEM_ar_valid_in,
    input  logic         [AXI4LITE_AW-1:0] CoreDMEM_aw_addr_in,
    input  logic                        CoreDMEM_aw_valid_in,
    input  logic                        CoreDMEM_b_ready_in,
    input  logic                        CoreDMEM_r_ready_in,
    input  logic         [AXI4LITE_DW-1:0] CoreDMEM_w_data_in,
    input  logic         [(AXI4LITE_DW/8)-1:0] CoreDMEM_w_strb_in,
    input  logic                        CoreDMEM_w_valid_in,
    output logic                        CoreDMEM_ar_ready_out,
    output logic                        CoreDMEM_aw_ready_out,
    output logic         [1:0]          CoreDMEM_b_resp_out,
    output logic                        CoreDMEM_b_valid_out,
    output logic         [AXI4LITE_DW-1:0] CoreDMEM_r_data_out,
    output logic         [1:0]          CoreDMEM_r_resp_out,
    output logic                        CoreDMEM_r_valid_out,
    output logic                        CoreDMEM_w_ready_out,

    // Interface: AXI4LITE_CTRL
    input  logic                        CtrlReg_ar_ready_in,
    input  logic                        CtrlReg_aw_ready_in,
    input  logic         [1:0]          CtrlReg_b_resp_in,
    input  logic                        CtrlReg_b_valid_in,
    input  logic         [AXI4LITE_DW-1:0] CtrlReg_r_data_in,
    input  logic         [1:0]          CtrlReg_r_resp_in,
    input  logic                        CtrlReg_r_valid_in,
    input  logic                        CtrlReg_w_ready_in,
    output logic         [AXI4LITE_AW-1:0] CtrlReg_ar_addr_out,
    output logic                        CtrlReg_ar_valid_out,
    output logic         [AXI4LITE_AW-1:0] CtrlReg_aw_addr_out,
    output logic                        CtrlReg_aw_valid_out,
    output logic                        CtrlReg_b_ready_out,
    output logic                        CtrlReg_r_ready_out,
    output logic         [AXI4LITE_DW-1:0] CtrlReg_w_data_out,
    output logic         [(AXI4LITE_DW/8)-1:0] CtrlReg_w_strb_out,
    output logic                        CtrlReg_w_valid_out,

    // Interface: AXI4LITE_DBG_I
    input                [AXI4LITE_AW-1:0] DbgI_ar_addr,
    input                [2:0]          DbgI_ar_prot,
    input                               DbgI_ar_valid,
    input                [AXI4LITE_AW-1:0] DbgI_aw_addr,
    input                [2:0]          DbgI_aw_prot,
    input                               DbgI_aw_valid,
    input                               DbgI_b_ready,
    input                               DbgI_r_ready,
    input                [AXI4LITE_DW-1:0] DbgI_w_data,
    input                [(AXI4LITE_DW/8)-1:0] DbgI_w_strb,
    input                               DbgI_w_valid,
    output                              DbgI_ar_ready,
    output                              DbgI_aw_ready,
    output               [1:0]          DbgI_b_resp,
    output                              DbgI_b_valid,
    output               [AXI4LITE_DW-1:0] DbgI_r_data,
    output               [1:0]          DbgI_r_resp,
    output                              DbgI_r_valid,
    output                              DbgI_w_ready,

    // Interface: AXI4LITE_DBG_T
    input  logic                        DbgT_ar_ready_in,
    input  logic                        DbgT_aw_ready_in,
    input  logic         [1:0]          DbgT_b_resp_in,
    input  logic                        DbgT_b_valid_in,
    input  logic         [AXI4LITE_DW-1:0] DbgT_r_data_in,
    input  logic         [1:0]          DbgT_r_resp_in,
    input  logic                        DbgT_r_valid_in,
    input  logic                        DbgT_w_ready_in,
    output logic         [AXI4LITE_AW-1:0] DbgT_ar_addr_out,
    output logic                        DbgT_ar_valid_out,
    output logic         [AXI4LITE_AW-1:0] DbgT_aw_addr_out,
    output logic                        DbgT_aw_valid_out,
    output logic                        DbgT_b_ready_out,
    output logic                        DbgT_r_ready_out,
    output logic         [AXI4LITE_DW-1:0] DbgT_w_data_out,
    output logic         [(AXI4LITE_DW/8)-1:0] DbgT_w_strb_out,
    output logic                        DbgT_w_valid_out,

    // Interface: AXI4LITE_DMEM
    input                               DMEM_ar_ready_in,
    input                               DMEM_aw_ready_in,
    input                [1:0]          DMEM_b_resp_in,
    input                               DMEM_b_valid_in,
    input                [AXI4LITE_DW-1:0] DMEM_r_data_in,
    input                [1:0]          DMEM_r_resp_in,
    input                               DMEM_r_valid_in,
    input                               DMEM_w_ready_in,
    output               [AXI4LITE_AW-1:0] DMEM_ar_addr_out,
    output                              DMEM_ar_valid_out,
    output               [AXI4LITE_AW-1:0] DMEM_aw_addr_out,
    output                              DMEM_aw_valid_out,
    output                              DMEM_b_ready_out,
    output                              DMEM_r_ready_out,
    output               [AXI4LITE_DW-1:0] DMEM_w_data_out,
    output               [(AXI4LITE_DW/8)-1:0] DMEM_w_strb_out,
    output                              DMEM_w_valid_out,

    // Interface: AXI4LITE_IMEM
    input                               IMEM_ar_ready_in,
    input                               IMEM_aw_ready_in,
    input                [1:0]          IMEM_b_resp_in,
    input                               IMEM_b_valid_in,
    input                [AXI4LITE_DW-1:0] IMEM_r_data_in,
    input                [1:0]          IMEM_r_resp_in,
    input                               IMEM_r_valid_in,
    input                               IMEM_w_ready_in,
    output               [AXI4LITE_AW-1:0] IMEM_ar_addr_out,
    output                              IMEM_ar_valid_out,
    output               [AXI4LITE_AW-1:0] IMEM_aw_addr_out,
    output                              IMEM_aw_valid_out,
    output                              IMEM_b_ready_out,
    output                              IMEM_r_ready_out,
    output               [AXI4LITE_DW-1:0] IMEM_w_data_out,
    output               [(AXI4LITE_DW/8)-1:0] IMEM_w_strb_out,
    output                              IMEM_w_valid_out,

    // Interface: AXI4LITE_periph
    input  logic                        periph_ar_ready_in,
    input  logic                        periph_aw_ready_in,
    input  logic         [1:0]          periph_b_resp_in,
    input  logic                        periph_b_valid_in,
    input  logic         [AXI4LITE_DW-1:0] periph_r_data_in,
    input  logic         [1:0]          periph_r_resp_in,
    input  logic                        periph_r_valid_in,
    input  logic                        periph_w_ready_in,
    output logic         [AXI4LITE_AW-1:0] periph_ar_addr_out,
    output logic                        periph_ar_valid_out,
    output logic         [AXI4LITE_AW-1:0] periph_aw_addr_out,
    output logic                        periph_aw_valid_out,
    output logic                        periph_b_ready_out,
    output logic                        periph_r_ready_out,
    output logic         [AXI4LITE_DW-1:0] periph_w_data_out,
    output logic         [(AXI4LITE_DW/8)-1:0] periph_w_strb_out,
    output logic                        periph_w_valid_out,

    // Interface: AXI_ICN
    input                               AR_READY,
    input                               AW_READY,
    input                [AXI_IDW-1:0]  B_ID,
    input                [1:0]          B_RESP,
    input                               B_USER,
    input                               B_VALID,
    input                [AXI_DW-1:0]   R_DATA,
    input                [AXI_IDW-1:0]  R_ID,
    input                               R_LAST,
    input                [1:0]          R_RESP,
    input                               R_USER,
    input                               R_VALID,
    input                               W_READY,
    output               [AXI_AW-1:0]   AR_ADDR,
    output               [1:0]          AR_BURST,
    output               [3:0]          AR_CACHE,
    output               [AXI_IDW-1:0]  AR_ID,
    output               [7:0]          AR_LEN,
    output                              AR_LOCK,
    output               [2:0]          AR_PROT,
    output               [3:0]          AR_QOS,
    output               [2:0]          AR_REGION,
    output               [2:0]          AR_SIZE,
    output               [AXI_USERW-1:0] AR_USER,
    output                              AR_VALID,
    output               [AXI_AW-1:0]   AW_ADDR,
    output               [5:0]          AW_ATOP,
    output               [1:0]          AW_BURST,
    output               [3:0]          AW_CACHE,
    output               [AXI_IDW-1:0]  AW_ID,
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
    output               [AXI_DW-1:0]   W_DATA,
    output                              W_LAST,
    output               [(AXI_DW/8)-1:0] W_STROBE,
    output               [AXI_USERW-1:0] W_USER,
    output                              W_VALID,

    // Interface: Clock
    input                               clk_i,

    // Interface: Reset
    input                               reset_ni
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
endmodule