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
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Interface generated by kactus2, then manually continued and edited
    * controller cpu internal interconnect, xbar topology
*/
module SysCtrl_xbar #(
    parameter                          AXI4LITE_AW      = 32,
    parameter                          AXI4LITE_DW      = 32,
    parameter                          AXI_AW           = 32,
    parameter                          AXI_DW           = 32,
    parameter                          AXI_IDW          = 10,
    parameter                          AXI_USERW        = 1
) (
    // Interface: AXI4LITE_BootRom
    input  logic                       BootRom_ar_ready_in,
    input  logic                       BootRom_aw_ready_in,
    input  logic [1:0]                 BootRom_b_resp_in,
    input  logic                       BootRom_b_valid_in,
    input  logic [AXI4LITE_DW-1:0]     BootRom_r_data_in,
    input  logic [1:0]                 BootRom_r_resp_in,
    input  logic                       BootRom_r_valid_in,
    input  logic                       BootRom_w_ready_in,
    output logic [AXI4LITE_AW:0]       BootRom_ar_addr_out,
    output logic                       BootRom_ar_valid_out,
    output logic [AXI4LITE_AW-1:0]     BootRom_aw_addr_out,
    output logic                       BootRom_aw_valid_out,
    output logic                       BootRom_b_ready_out,
    output logic                       BootRom_r_ready_out,
    output logic [AXI4LITE_DW-1:0]     BootRom_w_data_out,
    output logic [(AXI4LITE_DW/8)-1:0] BootRom_w_strb_out,
    output logic                       BootRom_w_valid_out,

    // Interface: AXI4LITE_CORE_IMEM
    input  logic [AXI4LITE_AW-1:0]     CoreIMEM_ar_addr_in,
    input  logic                       CoreIMEM_ar_valid_in,
    input  logic [AXI4LITE_AW-1:0]     CoreIMEM_aw_addr_in,
    input  logic                       CoreIMEM_aw_valid_in,
    input  logic                       CoreIMEM_b_ready_in,
    input  logic                       CoreIMEM_r_ready_in,
    input  logic [AXI4LITE_DW-1:0]     CoreIMEM_w_data_in,
    input  logic [(AXI4LITE_DW/8)-1:0] CoreIMEM_w_strb_in,
    input  logic                       CoreIMEM_w_valid_in,
    output logic                       CoreIMEM_ar_ready_out,
    output logic                       CoreIMEM_aw_ready_out,
    output logic [1:0]                 CoreIMEM_b_resp_out,
    output logic                       CoreIMEM_b_valid_out,
    output logic [AXI4LITE_DW-1:0]     CoreIMEM_r_data_out,
    output logic [1:0]                 CoreIMEM_r_resp_out,
    output logic                       CoreIMEM_r_valid_out,
    output logic                       CoreIMEM_w_ready_out,

    // Interface: AXI4LITE_CORE_DMEM
    input  logic [AXI4LITE_AW-1:0]     CoreDMEM_ar_addr_in,
    input  logic                       CoreDMEM_ar_valid_in,
    input  logic [AXI4LITE_AW-1:0]     CoreDMEM_aw_addr_in,
    input  logic                       CoreDMEM_aw_valid_in,
    input  logic                       CoreDMEM_b_ready_in,
    input  logic                       CoreDMEM_r_ready_in,
    input  logic [AXI4LITE_DW-1:0]     CoreDMEM_w_data_in,
    input  logic [(AXI4LITE_DW/8)-1:0] CoreDMEM_w_strb_in,
    input  logic                       CoreDMEM_w_valid_in,
    output logic                       CoreDMEM_ar_ready_out,
    output logic                       CoreDMEM_aw_ready_out,
    output logic [1:0]                 CoreDMEM_b_resp_out,
    output logic                       CoreDMEM_b_valid_out,
    output logic [AXI4LITE_DW-1:0]     CoreDMEM_r_data_out,
    output logic [1:0]                 CoreDMEM_r_resp_out,
    output logic                       CoreDMEM_r_valid_out,
    output logic                       CoreDMEM_w_ready_out,

    // Interface: AXI4LITE_CTRL
    input  logic                       CtrlReg_ar_ready_in,
    input  logic                       CtrlReg_aw_ready_in,
    input  logic [1:0]                 CtrlReg_b_resp_in,
    input  logic                       CtrlReg_b_valid_in,
    input  logic [AXI4LITE_DW-1:0]     CtrlReg_r_data_in,
    input  logic [1:0]                 CtrlReg_r_resp_in,
    input  logic                       CtrlReg_r_valid_in,
    input  logic                       CtrlReg_w_ready_in,
    output logic [AXI4LITE_AW-1:0]     CtrlReg_ar_addr_out,
    output logic                       CtrlReg_ar_valid_out,
    output logic [AXI4LITE_AW-1:0]     CtrlReg_aw_addr_out,
    output logic                       CtrlReg_aw_valid_out,
    output logic                       CtrlReg_b_ready_out,
    output logic                       CtrlReg_r_ready_out,
    output logic [AXI4LITE_DW-1:0]     CtrlReg_w_data_out,
    output logic [(AXI4LITE_DW/8)-1:0] CtrlReg_w_strb_out,
    output logic                       CtrlReg_w_valid_out,

    // Interface: AXI4LITE_DBG_I
    input  logic [AXI4LITE_AW-1:0]     DbgI_ar_addr,
    input  logic [2:0]                 DbgI_ar_prot,
    input  logic                       DbgI_ar_valid,
    input  logic [AXI4LITE_AW-1:0]     DbgI_aw_addr,
    input  logic [2:0]                 DbgI_aw_prot,
    input  logic                       DbgI_aw_valid,
    input  logic                       DbgI_b_ready,
    input  logic                       DbgI_r_ready,
    input  logic [AXI4LITE_DW-1:0]     DbgI_w_data,
    input  logic [(AXI4LITE_DW/8)-1:0] DbgI_w_strb,
    input  logic                       DbgI_w_valid,
    output logic                       DbgI_ar_ready,
    output logic                       DbgI_aw_ready,
    output logic [1:0]                 DbgI_b_resp,
    output logic                       DbgI_b_valid,
    output logic [AXI4LITE_DW-1:0]     DbgI_r_data,
    output logic [1:0]                 DbgI_r_resp,
    output logic                       DbgI_r_valid,
    output logic                       DbgI_w_ready,

    // Interface: AXI4LITE_DBG_T
    input  logic                       DbgT_ar_ready_in,
    input  logic                       DbgT_aw_ready_in,
    input  logic [1:0]                 DbgT_b_resp_in,
    input  logic                       DbgT_b_valid_in,
    input  logic [AXI4LITE_DW-1:0]     DbgT_r_data_in,
    input  logic [1:0]                 DbgT_r_resp_in,
    input  logic                       DbgT_r_valid_in,
    input  logic                       DbgT_w_ready_in,
    output logic [AXI4LITE_AW-1:0]     DbgT_ar_addr_out,
    output logic                       DbgT_ar_valid_out,
    output logic [AXI4LITE_AW-1:0]     DbgT_aw_addr_out,
    output logic                       DbgT_aw_valid_out,
    output logic                       DbgT_b_ready_out,
    output logic                       DbgT_r_ready_out,
    output logic [AXI4LITE_DW-1:0]     DbgT_w_data_out,
    output logic [(AXI4LITE_DW/8)-1:0] DbgT_w_strb_out,
    output logic                       DbgT_w_valid_out,

    // Interface: AXI4LITE_DMEM
    input   logic                       DMEM_ar_ready_in,
    input   logic                       DMEM_aw_ready_in,
    input   logic [1:0]                 DMEM_b_resp_in,
    input   logic                       DMEM_b_valid_in,
    input   logic [AXI4LITE_DW-1:0]     DMEM_r_data_in,
    input   logic [1:0]                 DMEM_r_resp_in,
    input   logic                       DMEM_r_valid_in,
    input   logic                       DMEM_w_ready_in,
    output  logic [AXI4LITE_AW-1:0]     DMEM_ar_addr_out,
    output  logic                       DMEM_ar_valid_out,
    output  logic [AXI4LITE_AW-1:0]     DMEM_aw_addr_out,
    output  logic                       DMEM_aw_valid_out,
    output  logic                       DMEM_b_ready_out,
    output  logic                       DMEM_r_ready_out,
    output  logic [AXI4LITE_DW-1:0]     DMEM_w_data_out,
    output  logic [(AXI4LITE_DW/8)-1:0] DMEM_w_strb_out,
    output  logic                       DMEM_w_valid_out,

    // Interface: AXI4LITE_IMEM
    input   logic                       IMEM_ar_ready_in,
    input   logic                       IMEM_aw_ready_in,
    input   logic [1:0]                 IMEM_b_resp_in,
    input   logic                       IMEM_b_valid_in,
    input   logic [AXI4LITE_DW-1:0]     IMEM_r_data_in,
    input   logic [1:0]                 IMEM_r_resp_in,
    input   logic                       IMEM_r_valid_in,
    input   logic                       IMEM_w_ready_in,
    output  logic [AXI4LITE_AW-1:0]     IMEM_ar_addr_out,
    output  logic                       IMEM_ar_valid_out,
    output  logic [AXI4LITE_AW-1:0]     IMEM_aw_addr_out,
    output  logic                       IMEM_aw_valid_out,
    output  logic                       IMEM_b_ready_out,
    output  logic                       IMEM_r_ready_out,
    output  logic [AXI4LITE_DW-1:0]     IMEM_w_data_out,
    output  logic [(AXI4LITE_DW/8)-1:0] IMEM_w_strb_out,
    output  logic                       IMEM_w_valid_out,

    // Interface: AXI4LITE_periph
    input  logic                       periph_ar_ready_in,
    input  logic                       periph_aw_ready_in,
    input  logic [1:0]                 periph_b_resp_in,
    input  logic                       periph_b_valid_in,
    input  logic [AXI4LITE_DW-1:0]     periph_r_data_in,
    input  logic [1:0]                 periph_r_resp_in,
    input  logic                       periph_r_valid_in,
    input  logic                       periph_w_ready_in,
    output logic [AXI4LITE_AW-1:0]     periph_ar_addr_out,
    output logic                       periph_ar_valid_out,
    output logic [AXI4LITE_AW-1:0]     periph_aw_addr_out,
    output logic                       periph_aw_valid_out,
    output logic                       periph_b_ready_out,
    output logic                       periph_r_ready_out,
    output logic [AXI4LITE_DW-1:0]     periph_w_data_out,
    output logic [(AXI4LITE_DW/8)-1:0] periph_w_strb_out,
    output logic                       periph_w_valid_out,

    // Interface: AXI_ICN
    input  logic                  AR_READY,
    input  logic                  AW_READY,
    input  logic [AXI_IDW-1:0]    B_ID,
    input  logic [1:0]            B_RESP,
    input  logic                  B_USER,
    input  logic                  B_VALID,
    input  logic [AXI_DW-1:0]     R_DATA,
    input  logic [AXI_IDW-1:0]    R_ID,
    input  logic                  R_LAST,
    input  logic [1:0]            R_RESP,
    input  logic                  R_USER,
    input  logic                  R_VALID,
    input  logic                  W_READY,
    output logic [AXI_AW-1:0]     AR_ADDR,
    output logic [1:0]            AR_BURST,
    output logic [3:0]            AR_CACHE,
    output logic [AXI_IDW-1:0]    AR_ID,
    output logic [7:0]            AR_LEN,
    output logic                  AR_LOCK,
    output logic [2:0]            AR_PROT,
    output logic [3:0]            AR_QOS,
    output logic [2:0]            AR_REGION,
    output logic [2:0]            AR_SIZE,
    output logic [AXI_USERW-1:0]  AR_USER,
    output logic                  AR_VALID,
    output logic [AXI_AW-1:0]     AW_ADDR,
    output logic [5:0]            AW_ATOP,
    output logic [1:0]            AW_BURST,
    output logic [3:0]            AW_CACHE,
    output logic [AXI_IDW-1:0]    AW_ID,
    output logic [7:0]            AW_LEN,
    output logic                  AW_LOCK,
    output logic [2:0]            AW_PROT,
    output logic [3:0]            AW_QOS,
    output logic [3:0]            AW_REGION,
    output logic [2:0]            AW_SIZE,
    output logic                  AW_USER,
    output logic                  AW_VALID,
    output logic                  B_READY,
    output logic                  R_READY,
    output logic [AXI_DW-1:0]     W_DATA,
    output logic                  W_LAST,
    output logic [(AXI_DW/8)-1:0] W_STROBE,
    output logic [AXI_USERW-1:0]  W_USER,
    output logic                  W_VALID,

    // Interface: Clock
    input  logic                             clk_i,

    // Interface: Reset
    input  logic                             reset_ni
);

  // TODO: check numbers
  localparam AXI4LITE_TARGETS = 7;
  localparam AXI4LITE_INITIATORS = 3;

  // 
  AXI_BUS #(
    .AXI_ADDR_WIDTH(AXI_AW), 
    .AXI_DATA_WIDTH(AXI_DW), 
    .AXI_ID_WIDTH(AXI_IDW), 
    .AXI_USER_WIDTH(AXI_USERW)
  ) axi4bus ();

  AXI_LITE #(
   .AXI_ADDR_WIDTH(AXI4LITE_AW),
   .AXI_DATA_WIDTH(AXI4LITE_DW)
  ) axi4lite_target_bus [AXI4LITE_TARGETS-1:0]();

  AXI_LITE #(
   .AXI_ADDR_WIDTH(AXI4LITE_AW),
   .AXI_DATA_WIDTH(AXI4LITE_DW)
  ) axi4lite_init_bus [AXI4LITE_INITIATORS-1:0]();

// 
axi_lite_to_axi_intf #(
  .AXI_DATA_WIDTH(AXI4LITE_DW)
) i_axi_lite_to_axi(
  .in(axi4lite_target_bus[6]),
  .slv_aw_cache_i(4'd0),
  .slv_ar_cache_i(4'd0),
  .out(axi4bus)
);

  // TODO: Finalize rules and addresses
  localparam NoAddrRules = AXI4LITE_TARGETS;
  localparam ADDR_BASE   = 32'h0100_0000;
  localparam AXI4LITE_SIZE    = 'h10000;
  
  typedef axi_pkg::xbar_rule_32_t rule_t;
  
  rule_t [NoAddrRules-1:0] AddrMapXBAR;
  // TODO: finalize Address table based for xbar
  assign AddrMapXBAR = 
    '{
      '{idx: 32'd6, start_addr: ADDR_BASE+AXI4LITE_SIZE*3, end_addr: ADDR_BASE+AXI4LITE_SIZE*7-1},//axi
      '{idx: 32'd5, start_addr: ADDR_BASE+AXI4LITE_SIZE*3, end_addr: ADDR_BASE+AXI4LITE_SIZE*6-1},//ctrl
      '{idx: 32'd4, start_addr: ADDR_BASE+AXI4LITE_SIZE*3, end_addr: ADDR_BASE+AXI4LITE_SIZE*5-1},//periph
      '{idx: 32'd3, start_addr: ADDR_BASE+AXI4LITE_SIZE*3, end_addr: ADDR_BASE+AXI4LITE_SIZE*4-1},//dbg
      '{idx: 32'd2, start_addr: ADDR_BASE+AXI4LITE_SIZE*2, end_addr: ADDR_BASE+AXI4LITE_SIZE*3-1},//dmem
      '{idx: 32'd1, start_addr: ADDR_BASE+AXI4LITE_SIZE*1, end_addr: ADDR_BASE+AXI4LITE_SIZE*2-1},//imem
      '{idx: 32'd0, start_addr: ADDR_BASE+AXI4LITE_SIZE*0, end_addr: ADDR_BASE+AXI4LITE_SIZE*1-1}//bootrom
    };

  // check ips\axi\src\axi_pkg.sv for rule deifinitions
  localparam axi_pkg::xbar_cfg_t xbar_cfg = '{
    NoSlvPorts:         AXI4LITE_INITIATORS,
    NoMstPorts:         AXI4LITE_TARGETS,
    MaxMstTrans:        1,  
    MaxSlvTrans:        1,  
    FallThrough:        1'b0,
    LatencyMode:        axi_pkg::CUT_ALL_AX,
    PipelineStages:     0,
    AxiIdWidthSlvPorts: 10,
    AxiIdUsedSlvPorts:  8,
    UniqueIds:          1,
    AxiAddrWidth:       AXI_AW,
    AxiDataWidth:       AXI_DW,
    NoAddrRules:        AXI4LITE_TARGETS
  };
                    
axi_lite_xbar_intf #(
  .Cfg(xbar_cfg),
  .rule_t(rule_t)
) i_axi_lite_xbar(
  .clk_i(clk_i),
  .rst_ni(rst_ni),
  .test_i(1'b0),
  .slv_ports(axi4lite_init_bus),
  .mst_ports(axi4lite_target_bus),
  .addr_map_i(AddrMapXBAR),
  .en_default_mst_port_i('d0),
  .default_mst_port_i({AXI4LITE_TARGETS{'d0}})
);

// Interface: AXI4LITE_BootRom
assign axi4lite_target_bus[0].ar_ready = BootRom_ar_ready_in;
assign axi4lite_target_bus[0].aw_ready = BootRom_aw_ready_in;
assign axi4lite_target_bus[0].b_resp   = BootRom_b_resp_in;
assign axi4lite_target_bus[0].b_valid  = BootRom_b_valid_in;
assign axi4lite_target_bus[0].r_data   = BootRom_r_data_in;
assign axi4lite_target_bus[0].r_resp   = BootRom_r_resp_in;
assign axi4lite_target_bus[0].r_valid  = BootRom_r_valid_in;
assign axi4lite_target_bus[0].w_ready  = BootRom_w_ready_in;
//
assign BootRom_ar_addr_out  = axi4lite_target_bus[0].ar_addr;
assign BootRom_ar_valid_out = axi4lite_target_bus[0].ar_valid;
assign BootRom_aw_addr_out  = axi4lite_target_bus[0].aw_addr;
assign BootRom_aw_valid_out = axi4lite_target_bus[0].aw_valid;
assign BootRom_b_ready_out  = axi4lite_target_bus[0].b_ready;
assign BootRom_r_ready_out  = axi4lite_target_bus[0].r_ready;
assign BootRom_w_data_out   = axi4lite_target_bus[0].w_data;
assign BootRom_w_strb_out   = axi4lite_target_bus[0].w_strb;
assign BootRom_w_valid_out  = axi4lite_target_bus[0].w_valid;

// Interface: AXI4LITE_CORE_DMEM
assign axi4lite_init_bus[1].ar_addr  = CoreIMEM_ar_addr_in;
assign axi4lite_init_bus[1].ar_valid = CoreIMEM_ar_valid_in;
assign axi4lite_init_bus[1].aw_addr  = CoreIMEM_aw_addr_in;
assign axi4lite_init_bus[1].aw_valid = CoreIMEM_aw_valid_in;
assign axi4lite_init_bus[1].b_ready  = CoreIMEM_b_ready_in;
assign axi4lite_init_bus[1].r_ready  = CoreIMEM_r_ready_in;
assign axi4lite_init_bus[1].w_data   = CoreIMEM_w_data_in;
assign axi4lite_init_bus[1].w_strb   = CoreIMEM_w_strb_in;
assign axi4lite_init_bus[1].w_valid  = CoreIMEM_w_valid_in;
//
assign CoreIMEM_ar_ready_out = axi4lite_init_bus[1].ar_ready;
assign CoreIMEM_aw_ready_out = axi4lite_init_bus[1].aw_ready;
assign CoreIMEM_b_resp_out   = axi4lite_init_bus[1].b_resp;
assign CoreIMEM_b_valid_out  = axi4lite_init_bus[1].b_valid;
assign CoreIMEM_r_data_out   = axi4lite_init_bus[1].r_data;
assign CoreIMEM_r_resp_out   = axi4lite_init_bus[1].r_resp;
assign CoreIMEM_r_valid_out  = axi4lite_init_bus[1].r_valid;
assign CoreIMEM_w_ready_out  = axi4lite_init_bus[1].w_ready;

// Interface: AXI4LITE_CORE_IMEM
assign axi4lite_init_bus[0].ar_addr  = CoreDMEM_ar_addr_in;
assign axi4lite_init_bus[0].ar_valid = CoreDMEM_ar_valid_in;
assign axi4lite_init_bus[0].aw_addr  = CoreDMEM_aw_addr_in;
assign axi4lite_init_bus[0].aw_valid = CoreDMEM_aw_valid_in;
assign axi4lite_init_bus[0].b_ready  = CoreDMEM_b_ready_in;
assign axi4lite_init_bus[0].r_ready  = CoreDMEM_r_ready_in;
assign axi4lite_init_bus[0].w_data   = CoreDMEM_w_data_in;
assign axi4lite_init_bus[0].w_strb   = CoreDMEM_w_strb_in;
assign axi4lite_init_bus[0].w_valid  = CoreDMEM_w_valid_in;
//
assign CoreDMEM_ar_ready_out = axi4lite_init_bus[0].ar_ready;
assign CoreDMEM_aw_ready_out = axi4lite_init_bus[0].aw_ready;
assign CoreDMEM_b_resp_out   = axi4lite_init_bus[0].b_resp; 
assign CoreDMEM_b_valid_out  = axi4lite_init_bus[0].b_valid;
assign CoreDMEM_r_data_out   = axi4lite_init_bus[0].r_data; 
assign CoreDMEM_r_resp_out   = axi4lite_init_bus[0].r_resp; 
assign CoreDMEM_r_valid_out  = axi4lite_init_bus[0].r_valid;
assign CoreDMEM_w_ready_out  = axi4lite_init_bus[0].w_ready;

// Interface: AXI4LITE_CTRL
assign CtrlReg_ar_addr_out  = axi4lite_target_bus[5].ar_addr;
assign CtrlReg_ar_valid_out = axi4lite_target_bus[5].ar_valid;
assign CtrlReg_aw_addr_out  = axi4lite_target_bus[5].aw_addr;
assign CtrlReg_aw_valid_out = axi4lite_target_bus[5].aw_valid;
assign CtrlReg_b_ready_out  = axi4lite_target_bus[5].b_ready;
assign CtrlReg_r_ready_out  = axi4lite_target_bus[5].r_ready;
assign CtrlReg_w_data_out   = axi4lite_target_bus[5].w_data;
assign CtrlReg_w_strb_out   = axi4lite_target_bus[5].w_strb;
assign CtrlReg_w_valid_out  = axi4lite_target_bus[5].w_valid;
//
assign axi4lite_target_bus[5].ar_ready = CtrlReg_ar_ready_in;
assign axi4lite_target_bus[5].aw_ready = CtrlReg_aw_ready_in;
assign axi4lite_target_bus[5].b_resp   = CtrlReg_b_resp_in;
assign axi4lite_target_bus[5].b_valid  = CtrlReg_b_valid_in;
assign axi4lite_target_bus[5].r_data   = CtrlReg_r_data_in;
assign axi4lite_target_bus[5].r_resp   = CtrlReg_r_resp_in;
assign axi4lite_target_bus[5].r_valid  = CtrlReg_r_valid_in;
assign axi4lite_target_bus[5].w_ready  = CtrlReg_w_ready_in;
//

// Interface: AXI4LITE_DBG_I
assign axi4lite_init_bus[2].ar_addr  = DbgI_ar_addr;
assign axi4lite_init_bus[2].ar_valid = DbgI_ar_valid;
assign axi4lite_init_bus[2].aw_addr  = DbgI_aw_addr;
assign axi4lite_init_bus[2].aw_valid = DbgI_aw_valid;
assign axi4lite_init_bus[2].b_ready  = DbgI_b_ready;
assign axi4lite_init_bus[2].r_ready  = DbgI_r_ready;
assign axi4lite_init_bus[2].w_data   = DbgI_w_data;
assign axi4lite_init_bus[2].w_strb   = DbgI_w_strb;
assign axi4lite_init_bus[2].w_valid  = DbgI_w_valid;
//
assign axi4lite_init_bus[2].aw_prot = DbgI_aw_prot;
assign axi4lite_init_bus[2].ar_prot = DbgI_ar_prot;
//
assign DbgI_ar_ready = axi4lite_init_bus[2].ar_ready;
assign DbgI_aw_ready = axi4lite_init_bus[2].aw_ready;
assign DbgI_b_resp   = axi4lite_init_bus[2].b_resp;
assign DbgI_b_valid  = axi4lite_init_bus[2].b_valid;
assign DbgI_r_data   = axi4lite_init_bus[2].r_data;
assign DbgI_r_resp   = axi4lite_init_bus[2].r_resp;
assign DbgI_r_valid  = axi4lite_init_bus[2].r_valid;
assign DbgI_w_ready  = axi4lite_init_bus[2].w_ready;

// Interface: AXI4LITE_DBG_T
assign axi4lite_target_bus[3].ar_ready = DbgT_ar_ready_in;
assign axi4lite_target_bus[3].aw_ready = DbgT_aw_ready_in;
assign axi4lite_target_bus[3].b_resp   = DbgT_b_resp_in;
assign axi4lite_target_bus[3].b_valid  = DbgT_b_valid_in;
assign axi4lite_target_bus[3].r_data   = DbgT_r_data_in;
assign axi4lite_target_bus[3].r_resp   = DbgT_r_resp_in;
assign axi4lite_target_bus[3].r_valid  = DbgT_r_valid_in;
assign axi4lite_target_bus[3].w_ready  = DbgT_w_ready_in;
//
assign DbgT_ar_addr_out  = axi4lite_target_bus[3].ar_addr;
assign DbgT_ar_valid_out = axi4lite_target_bus[3].ar_valid;
assign DbgT_aw_addr_out  = axi4lite_target_bus[3].aw_addr;
assign DbgT_aw_valid_out = axi4lite_target_bus[3].aw_valid;
assign DbgT_b_ready_out  = axi4lite_target_bus[3].b_ready;
assign DbgT_r_ready_out  = axi4lite_target_bus[3].r_ready;
assign DbgT_w_data_out   = axi4lite_target_bus[3].w_data;
assign DbgT_w_strb_out   = axi4lite_target_bus[3].w_strb;
assign DbgT_w_valid_out  = axi4lite_target_bus[3].w_valid;

// dmem
assign axi4lite_target_bus[2].ar_ready = DMEM_ar_ready_in;
assign axi4lite_target_bus[2].aw_ready = DMEM_aw_ready_in;
assign axi4lite_target_bus[2].b_resp   = DMEM_b_resp_in;
assign axi4lite_target_bus[2].b_valid  = DMEM_b_valid_in;
assign axi4lite_target_bus[2].r_data   = DMEM_r_data_in;
assign axi4lite_target_bus[2].r_resp   = DMEM_r_resp_in;
assign axi4lite_target_bus[2].r_valid  = DMEM_r_valid_in;
assign axi4lite_target_bus[2].w_ready  = DMEM_w_ready_in;
//
assign DMEM_ar_addr_out  = axi4lite_target_bus[2].ar_addr;
assign DMEM_ar_valid_out = axi4lite_target_bus[2].ar_valid;
assign DMEM_aw_addr_out  = axi4lite_target_bus[2].aw_addr;
assign DMEM_aw_valid_out = axi4lite_target_bus[2].aw_valid;
assign DMEM_b_ready_out  = axi4lite_target_bus[2].b_ready;
assign DMEM_r_ready_out  = axi4lite_target_bus[2].r_ready;
assign DMEM_w_data_out   = axi4lite_target_bus[2].w_data;
assign DMEM_w_strb_out   = axi4lite_target_bus[2].w_strb;
assign DMEM_w_valid_out  = axi4lite_target_bus[2].w_valid;

// imem
assign axi4lite_target_bus[1].ar_ready = IMEM_ar_ready_in;
assign axi4lite_target_bus[1].aw_ready = IMEM_aw_ready_in;
assign axi4lite_target_bus[1].b_resp   = IMEM_b_resp_in;
assign axi4lite_target_bus[1].b_valid  = IMEM_b_valid_in;
assign axi4lite_target_bus[1].r_data   = IMEM_r_data_in;
assign axi4lite_target_bus[1].r_resp   = IMEM_r_resp_in;
assign axi4lite_target_bus[1].r_valid  = IMEM_r_valid_in;
assign axi4lite_target_bus[1].w_ready  = IMEM_w_ready_in;
//
assign IMEM_ar_addr_out  = axi4lite_target_bus[1].ar_addr;
assign IMEM_ar_valid_out = axi4lite_target_bus[1].ar_valid;
assign IMEM_aw_addr_out  = axi4lite_target_bus[1].aw_addr;
assign IMEM_aw_valid_out = axi4lite_target_bus[1].aw_valid;
assign IMEM_b_ready_out  = axi4lite_target_bus[1].b_ready;
assign IMEM_r_ready_out  = axi4lite_target_bus[1].r_ready;
assign IMEM_w_data_out   = axi4lite_target_bus[1].w_data;
assign IMEM_w_strb_out   = axi4lite_target_bus[1].w_strb;
assign IMEM_w_valid_out  = axi4lite_target_bus[1].w_valid;

// sysctrl periph assigns
assign axi4lite_target_bus[4].ar_ready = periph_ar_ready_in;
assign axi4lite_target_bus[4].aw_ready = periph_aw_ready_in;
assign axi4lite_target_bus[4].b_resp   = periph_b_resp_in;
assign axi4lite_target_bus[4].b_valid  = periph_b_valid_in;
assign axi4lite_target_bus[4].r_data   = periph_r_data_in;
assign axi4lite_target_bus[4].r_resp   = periph_r_resp_in;
assign axi4lite_target_bus[4].r_valid  = periph_r_valid_in;
assign axi4lite_target_bus[4].w_ready  = periph_w_ready_in;
//
assign periph_ar_addr_out  = axi4lite_target_bus[4].ar_addr;
assign periph_ar_valid_out = axi4lite_target_bus[4].ar_valid;
assign periph_aw_addr_out  = axi4lite_target_bus[4].aw_addr;
assign periph_aw_valid_out = axi4lite_target_bus[4].aw_valid;
assign periph_b_ready_out  = axi4lite_target_bus[4].b_ready;
assign periph_r_ready_out  = axi4lite_target_bus[4].r_ready;
assign periph_w_data_out   = axi4lite_target_bus[4].w_data;
assign periph_w_strb_out   = axi4lite_target_bus[4].w_strb;
assign periph_w_valid_out  = axi4lite_target_bus[4].w_valid;

// axi4 assigns
assign AR_ADDR   = axi4bus.ar_addr;
assign AR_BURST  = axi4bus.ar_burst;
assign AR_CACHE  = axi4bus.ar_cache;
assign AR_ID     = axi4bus.ar_id;
assign AR_LEN    = axi4bus.ar_len;
assign AR_LOCK   = axi4bus.ar_lock;
assign AR_PROT   = axi4bus.ar_prot;
assign AR_QOS    = axi4bus.ar_qos;
assign AR_REGION = axi4bus.ar_region;
assign AR_SIZE   = axi4bus.ar_size;
assign AR_USER   = axi4bus.ar_user;
assign AR_VALID  = axi4bus.ar_valid;
assign AW_ADDR   = axi4bus.aw_addr;
assign AW_ATOP   = axi4bus.aw_atop;
assign AW_BURST  = axi4bus.aw_burst;
assign AW_CACHE  = axi4bus.aw_cache;
assign AW_ID     = axi4bus.aw_id;
assign AW_LEN    = axi4bus.aw_len;
assign AW_LOCK   = axi4bus.aw_lock;
assign AW_PROT   = axi4bus.aw_prot;
assign AW_QOS    = axi4bus.aw_qos;
assign AW_REGION = axi4bus.aw_region;
assign AW_SIZE   = axi4bus.aw_size;
assign AW_USER   = axi4bus.aw_user;
assign AW_VALID  = axi4bus.aw_valid;
assign B_READY   = axi4bus.b_ready;
assign R_READY   = axi4bus.r_ready;
assign W_DATA    = axi4bus.w_data;
assign W_LAST    = axi4bus.w_last;
assign W_STROBE  = axi4bus.w_strb;
assign W_USER    = axi4bus.w_user;
assign W_VALID   = axi4bus.w_valid;
//
assign axi4bus.ar_ready  = AR_READY;
assign axi4bus.aw_ready  = AW_READY;
assign axi4bus.b_id      = B_ID;
assign axi4bus.b_resp    = B_RESP;
assign axi4bus.b_user    = B_USER;
assign axi4bus.b_valid   = B_VALID;
assign axi4bus.r_data    = R_DATA;
assign axi4bus.r_id      = R_ID;
assign axi4bus.r_last    = R_LAST;
assign axi4bus.r_resp    = R_RESP;
assign axi4bus.r_user    = R_USER;
assign axi4bus.r_valid   = R_VALID;
assign axi4bus.w_ready   = W_READY;

endmodule
