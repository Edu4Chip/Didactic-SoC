/*
  Project: Edu4Chip
  Module(s): io_cell, o_cell, i_cell
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Simulation model for simple IO cells
    * cfg[0] direction select, rest reserved
*/

module io_cell #(
    parameter CONF_WIDTH = 3
  )
  (
    input  logic [CONF_WIDTH-1:0] io_cell_cfg

    input  logic FROM_CORE,
    output logic TO_CORE,
    inout  wire  PAD
  );

  assign PAD     = ( ~pad_cfg[0] ) ? FROM_CORE : 1'bz;
  assign TO_CORE = ( ~pad_cfg[0] ) ? 1'b0      :  PAD;

endmodule

module o_cell (
    output logic TO_CORE,
    inout  wire  PAD
  )

  assign TO_CORE = PAD;

endmodule

module i_cell (
    output logic FROM_CORE,
    inout  wire  PAD
  )

  assign PAD = FROM_CORE;

endmodule

