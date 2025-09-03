/*
  Project: Edu4Chip
  Module(s): io_cell, o_cell, i_cell, clk_cell
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Simulation model for simple IO cells
    * cfg[0] direction select, rest reserved for additional CFG based on cell
    * 

*/

module io_cell #(
    parameter CONF_WIDTH = 3
  )(
    // CFG
    input  logic [CONF_WIDTH-1:0] io_cell_cfg,
    // On-chip
    input  logic FROM_CORE,
    output logic TO_CORE,
    // Off-chip
    inout  wire  PAD
  );

  assign PAD     = ( ~io_cell_cfg[0] ) ? FROM_CORE : 1'bz;
  assign TO_CORE = ( ~io_cell_cfg[0] ) ? 1'b0      :  PAD;

endmodule

module o_cell (
    // On-chip
    input logic FROM_CORE,
    // Off-chip
    inout  wire  PAD
  );

  assign PAD = FROM_CORE;

endmodule

module i_cell (
    // On-chip
    output logic TO_CORE,
    // Off-chip
    inout  wire  PAD
  );

  assign TO_CORE = PAD;

endmodule

module clk_cell (
    // On-chip
    output logic CLK_TO_CORE,
    // Off-chip
    inout  wire  CLK_P_PAD,
    inout  wire  CLK_N_PAD
  );

  assign CLK_TO_CORE = CLK_P_PAD;
  assign CLK_N_PAD = ~CLK_P_PAD;
  
endmodule
