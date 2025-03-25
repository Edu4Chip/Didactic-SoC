//-----------------------------------------------------------------------------
// File          : ibex_wrapper.v
// Creation date : 21.03.2025
// Creation time : 10:54:00
// Description   : IBEX cpu top ipxact interface model. Core by lowRISC. IPXACT by TUNI.
//                 
//                 ibex commit sha: <changing while in development>
// Created by    : 
// Tool : Kactus2 3.13.3 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:lowRISC:ibex:1.1
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/lowRISC/ibex/1.1/ibex.1.1.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Integration wrapper for ibex core to insert tracer/normal top defines.
*/

module ibex_wrapper #(
    parameter                              DmBaseAddr       = 32'h01020000,
    parameter unsigned                     DmExceptionAddr  = 32'h1A110808,
    parameter unsigned                     DmHaltAddr       = 32'h1A110800,
    parameter bit                          ICache           = 1'b0,
    parameter bit                          ICacheECC        = 1'b0,
    parameter bit                          ICacheScramble   = 1'b0,
    parameter unsigned                     MHPMCounterNum   = 0,
    parameter unsigned                     MHPMCounterWidth = 40,
    parameter bit                          PMPEnable        = 1'b0,
    parameter unsigned                     PMPGranularity   = 0,
    parameter unsigned                     PMPNumRegions    = 4,
    parameter bit                          RV32E            = 1'b0,
    parameter                              RndCnstIbexKey   = 128'h14e8cecae3040d5e12286bb3cc113298,
    parameter                              RndCnstIbexNonce = 64'hf79780bc735f3843,
    parameter bit                          SecureIbex       = 1'b0,
    parameter ibex_pkg::rv32b_e            RV32B            = ibex_pkg::RV32BNone,
    parameter ibex_pkg::rv32m_e            RV32M            = ibex_pkg::RV32MNone,
    parameter ibex_pkg::regfile_e          RegFile          = ibex_pkg::RegFileFF,
    parameter ibex_pkg::lfsr_perm_t        RndCnstLfsrPerm  = ibex_pkg::RndCnstLfsrPermDefault,
    parameter ibex_pkg::lfsr_seed_t        RndCnstLfsrSeed  = ibex_pkg::RndCnstLfsrSeedDefault,
    parameter bit                          WritebackStage   = 1'b0
  )(
    // Interface: Clock
    input  logic                         clk_i,

    // Interface: Debug
    input  logic                         debug_req_i,

    // Interface: FetchEn
    input  logic         [3:0]           fetch_enable_i,    // actual type and width are typecasted from ibex_mubi_t. Trialing now with set
    // values for kactus2 integrability

    // Interface: IRQ_fast
    input  logic         [14:0]          irq_fast_i,

    // Interface: Reset
    input  logic                         rst_ni,

    // Interface: dmem
    input  logic                         data_err_i,
    input  logic                         data_gnt_i,
    input  logic         [31:0]          data_rdata_i,
    input  logic                         data_rvalid_i,
    output logic         [31:0]          data_addr_o,
    output logic         [3:0]           data_be_o,
    output logic                         data_req_o,
    output logic         [31:0]          data_wdata_o,
    output logic                         data_we_o,

    // Interface: imem
    input  logic                         instr_err_i,
    input  logic                         instr_gnt_i,
    input  logic         [31:0]          instr_rdata_i,
    input  logic                         instr_rvalid_i,
    output logic         [31:0]          instr_addr_o,
    output logic                         instr_req_o,

    // These ports are not in any interface
    input  logic         [6:0]           instr_rdata_intg_i,
    output logic         [6:0]           data_wdata_intg_o,
    input  logic         [6:0]           data_rdata_intg_i,
    input  logic         [31:0]          boot_addr_i,
    input  logic         [31:0]          hart_id_i,
    input  logic                         irq_external_i,
    input  logic                         irq_nm_i,    // non-maskeable interrupt
    input  logic                         irq_software_i,
    input  logic                         irq_timer_i,
    input  prim_ram_1p_pkg::ram_1p_cfg_t ram_cfg_i,
    input  logic                         scan_rst_ni,
    input  logic [ibex_pkg::SCRAMBLE_KEY_W-1:0]    scramble_key_i,
    input  logic                         scramble_key_valid_i,
    input  logic [ibex_pkg::SCRAMBLE_NONCE_W-1:0]  scramble_nonce_i,
    input  logic                         test_en_i,    // enable all clock gates for testing
    output logic                         alert_major_bus_o,
    output logic                         alert_major_internal_o,
    output logic                         alert_minor_o,
    output logic                         core_sleep_o,
    output ibex_pkg::crash_dump_t                  crash_dump_o,
    output logic                         double_fault_seen_o,
    output logic                         scramble_req_o
);

  // If desirable, one can use:
  // IP-XACT VLNV: tuni.fi:lowRISC:ibex:1.0
  // to allow core selection by views instead of this extra hierarchy
  `ifdef SYNTHESIS
    ibex_top #(
  `else
    ibex_top_tracing  #(
  `endif
      .DmBaseAddr      ( DmBaseAddr ),
      .DmExceptionAddr ( DmExceptionAddr ),
      .DmHaltAddr      ( DmHaltAddr ),
      .ICache          ( ICache ),
      .ICacheECC       ( ICacheECC ),
      .ICacheScramble  ( ICacheScramble ),
      .MHPMCounterNum  ( MHPMCounterNum),
      .MHPMCounterWidth( MHPMCounterWidth),
      .PMPEnable       ( PMPEnable),
      .PMPGranularity  ( PMPGranularity),
      .PMPNumRegions   ( PMPNumRegions),
      .RV32B           ( RV32B),
      .RV32E           ( RV32E),
      .RV32M           ( RV32M),
      .RegFile         ( RegFile),
  `ifdef SYNTHESIS
      .RndCnstIbexKey  ( RndCnstIbexKey),
      .RndCnstIbexNonce( RndCnstIbexNonce),
  `endif
      .RndCnstLfsrPerm ( RndCnstLfsrPerm),
      .RndCnstLfsrSeed ( RndCnstLfsrSeed),
      .SecureIbex      ( SecureIbex),
      .WritebackStage  ( WritebackStage)
    )
    Ibex_Core(
      // Interface: Clock
      .clk_i               (clk_i),
      // Interface: Debug
      .debug_req_i         (debug_req_i),
      // Interface: FetchEn
      .fetch_enable_i      (fetch_enable_i),
      // Interface: IRQ_fast
      .irq_fast_i          (irq_fast_i),
      // Interface: Reset
      .rst_ni              (rst_ni),
      // Interface: dmem
      .data_err_i          (data_err_i),
      .data_gnt_i          (data_gnt_i),
      .data_rdata_i        (data_rdata_i),
      .data_rdata_intg_i   (data_rdata_intg_i),
      .data_rvalid_i       (data_rvalid_i),
      .data_addr_o         (data_addr_o),
      .data_be_o           (data_be_o),
      .data_req_o          (data_req_o),
      .data_wdata_intg_o   (data_wdata_intg_o),
      .data_wdata_o        (data_wdata_o),
      .data_we_o           (data_we_o),
      // Interface: imem
      .instr_err_i          (instr_err_i),
      .instr_gnt_i          (instr_gnt_i),
      .instr_rdata_i        (instr_rdata_i),
      .instr_rdata_intg_i   (instr_rdata_intg_i),
      .instr_rvalid_i       (instr_rvalid_i),
      .instr_addr_o         (instr_addr_o),
      .instr_req_o          (instr_req_o),
      // These ports are not in any interface
      .boot_addr_i          (boot_addr_i),
      .hart_id_i            (hart_id_i),
      .irq_external_i       (irq_external_i),
      .irq_nm_i             (irq_nm_i),
      .irq_software_i       (irq_software_i),
      .irq_timer_i          (irq_timer_i),
      .ram_cfg_i            (ram_cfg_i),
      .scan_rst_ni          (scan_rst_ni),
      .scramble_key_i       (scramble_key_i),
      .scramble_key_valid_i (scramble_key_valid_i),
      .scramble_nonce_i     (scramble_nonce_i),
      .test_en_i            (test_en_i),
      .alert_major_bus_o    (alert_major_bus_o),
      .alert_major_internal_o(alert_major_internal_o),
      .alert_minor_o        (alert_minor_o),
      .core_sleep_o         (core_sleep_o),
      .crash_dump_o         (crash_dump_o),
      .double_fault_seen_o  (double_fault_seen_o),
      .scramble_req_o       (scramble_req_o)
    );


endmodule
