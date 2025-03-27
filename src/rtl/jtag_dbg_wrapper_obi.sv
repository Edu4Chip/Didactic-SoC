//-----------------------------------------------------------------------------
// File          : jtag_dbg_wrapper.v
// Creation date : 16.02.2024
// Creation time : 12:34:42
// Description   :
// Created by    :
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:jtag_dbg_wrapper:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/ip/jtag_dbg_wrapper/1.0/jtag_dbg_wrapper.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Antti Nurmi    (antti.nurmi@tuni.fi)
    * Tom Szymkowiak (thomas.szymkowiak@tuni.fi)
    * Matti Käyrä    (matti.kayra@tuni.fi)
  Description:
    * debug module intergration wrapper
    * based on ../reuse/jtag_dbg_wrapper.sv
    * obi interface conversion
*/

module jtag_dbg_wrapper_obi #(
    parameter                     DM_BASE_ADDRESS  = 'h1000,
    parameter                     DM_ID_VALUE      = 32'hf007ba11,
    localparam                    OBI_ID_WIDTH     = 1,
    localparam                    OBI_AW           = 32,
    localparam                    OBI_DW           = 32,
    localparam                    DBG_BUS_WIDTH    = 32,
    localparam                    NrHarts          = 1
  )(
    // Interface: OBI_I
    input  logic                    initiator_gnt_i,
    input  logic                    initiator_rvalid_i,
    input  logic                    initiator_err_i,
    input  logic [OBI_DW-1:0]       initiator_rdata_i,
    output logic                    initiator_req_o,
    output logic                    initiator_reqpar_o,
    output logic [OBI_AW-1:0]       initiator_addr_o,
    output logic                    initiator_we_o,
    output logic [OBI_DW-1:0]       initiator_wdata_o,
    output logic [OBI_DW/8-1:0]     initiator_be_o,

    // Interface: OBI_T
    input  logic                    target_req_i,
    input  logic                    target_we_i,
    input  logic [OBI_AW-1:0]       target_addr_i,
    input  logic [OBI_DW/8-1:0]     target_be_i,
    input  logic [OBI_DW-1:0]       target_wdata_i,
    input  logic [OBI_ID_WIDTH-1:0] target_aid_i,
    output logic                    target_gnt_o,
    output logic                    target_gntpar_o,
    output logic                    target_rvalid_o,
    output logic                    target_rvalidpar_o,
    output logic [OBI_DW-1:0]       target_rdata_o,
    output logic [OBI_ID_WIDTH-1:0] target_rid_o,
    //
    // Interface: Clock
    input  logic                    clk_i,

    // Interface: Debug
    output logic                    debug_req_irq_o,

    // Interface: JTAG
    input  logic                    jtag_tck_i,
    input  logic                    jtag_td_i,
    input  logic                    jtag_tms_i,
    input  logic                    jtag_trst_ni,
    output logic                    jtag_td_o,

    // Interface: Reset
    input  logic                    rstn_i,

    // Interface: core_reset
    output logic                    core_reset,

    // These ports are not in any interface
    output logic                    ndmreset_o
  );

/****** LOCAL VARIABLES AND CONSTANTS *****************************************/


// static debug hartinfo
localparam dm::hartinfo_t DebugHartInfo = '{
  zero1:                 '0,
  nscratch:               2, // Debug module needs at least two scratch regs
  zero0:                 '0,
  dataaccess:          1'b1, // data registers are memory mapped in the debugger
  datasize:   dm::DataCount,
  dataaddr:   dm::DataAddr
};

// JTAG TAP <-> DMI signals
dm::dmi_req_t                 dmi_req_s;
dm::dmi_resp_t                dmi_resp_s;
logic                         dmi_req_valid_s;
logic                         dmi_req_ready_s;
logic                         dmi_resp_valid_s;
logic                         dmi_resp_ready_s;

/************ PARITY SIGNALS ***********/

logic target_gnt_s;
assign target_gnt_o = target_gnt_s;
assign target_gntpar_o = ~target_gnt_s;

logic target_rvalid_s;
assign target_rvalid_o = target_rvalid_s;
assign target_rvalidpar_o = ~target_rvalid_s;

logic initiator_req_s;
assign initiator_req_o = initiator_req_s;
assign initiator_reqpar_o = ~initiator_req_s;


/****** COMPONENT + INTERFACE INSTANTIATIONS **********************************/

  dmi_jtag #(
    .IdcodeValue (DM_ID_VALUE)
  ) i_dmi_jtag (
    .clk_i                ( clk_i            ),
    .rst_ni               ( rstn_i           ),
    .testmode_i           ( '0               ),
    .dmi_rst_no           ( /*nc*/           ),
    .dmi_req_valid_o      ( dmi_req_valid_s  ),
    .dmi_req_ready_i      ( dmi_req_ready_s  ),
    .dmi_req_o            ( dmi_req_s        ),
    .dmi_resp_valid_i     ( dmi_resp_valid_s ),
    .dmi_resp_ready_o     ( dmi_resp_ready_s ),
    .dmi_resp_i           ( dmi_resp_s       ),
    .tck_i                ( jtag_tck_i       ),
    .tms_i                ( jtag_tms_i       ),
    .trst_ni              ( jtag_trst_ni     ),
    .td_i                 ( jtag_td_i        ),
    .td_o                 ( jtag_td_o        ),
    .tdo_oe_o             ( /*nc*/           )
  );

  dm_obi_top #(
    .IdWidth              ( OBI_ID_WIDTH        ),
    .NrHarts              ( NrHarts             ),
    .BusWidth             ( DBG_BUS_WIDTH       ),
    .DmBaseAddress        ( DM_BASE_ADDRESS     ),
    .SelectableHarts      ( {NrHarts{1'b1}}     )
  ) i_dm_top (
    .clk_i                ( clk_i               ),
    .rst_ni               ( rstn_i              ),
    .testmode_i           ( 1'b0                ),
    .ndmreset_o           ( ndmreset_o          ),
    .dmactive_o           ( /*nc*/              ),
    .debug_req_o          ( debug_req_irq_o     ),
    .unavailable_i        ( {NrHarts{1'b0}}     ),
    .hartinfo_i           ( DebugHartInfo       ),
    //
    .slave_req_i          ( target_req_i        ),
    .slave_gnt_o          ( target_gnt_s        ),
    .slave_we_i           ( target_we_i         ),
    .slave_addr_i         ( target_addr_i       ),
    .slave_be_i           ( target_be_i         ),
    .slave_wdata_i        ( target_wdata_i      ),
    .slave_aid_i          ( target_aid_i        ),
    .slave_rvalid_o       ( target_rvalid_s     ),
    .slave_rdata_o        ( target_rdata_o      ),
    .slave_rid_o          ( target_rid_o        ),
    //
    .master_req_o         ( initiator_req_s     ),
    .master_addr_o        ( initiator_addr_o    ),
    .master_we_o          ( initiator_we_o      ),
    .master_wdata_o       ( initiator_wdata_o   ),
    .master_be_o          ( initiator_be_o      ),
    .master_gnt_i         ( initiator_gnt_i     ),
    .master_rvalid_i      ( initiator_rvalid_i  ),
    .master_err_i         ( initiator_err_i     ),
    .master_other_err_i   ( '0                  ),
    .master_rdata_i       ( initiator_rdata_i   ),
    //
    .dmi_rst_ni           ( rstn_i              ),
    .dmi_req_valid_i      ( dmi_req_valid_s     ),
    .dmi_req_ready_o      ( dmi_req_ready_s     ),
    .dmi_req_i            ( dmi_req_s           ),
    .dmi_resp_valid_o     ( dmi_resp_valid_s    ),
    .dmi_resp_ready_i     ( dmi_resp_ready_s    ),
    .dmi_resp_o           ( dmi_resp_s          )
  );


  // ibex core reset control with debug module
  assign core_reset = rstn_i & ~(ndmreset_o);

endmodule
