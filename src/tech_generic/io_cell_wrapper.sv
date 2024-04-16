/*
  Project: Edu4Chip
  Module(s): io_cell_wrapper
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Wrapper module for IO cell selection
*/

module io_cell_wrapper #(
    parameter CELL_TYPE = 0,
    parameter IOCELL_CFG_W = 3
  )(
    input  logic [IOCELL_CFG_W-1:0] io_cell_cfg,
    input  logic FROM_CORE,
    output logic TO_CORE,
    inout  wire  PAD 
  );

  generate
    if (CELL_TYPE == 0) begin: gen_io_cell

      io_cell #(
          .CONF_WIDTH(IOCELL_CFG_W)
      ) i_io_cell(
          .io_cell_cfg(io_cell_cfg),
          .FROM_CORE(FROM_CORE),
          .TO_CORE(TO_CORE),
          .PAD(PAD)
      );

    end
    if (CELL_TYPE == 1) begin: gen_o_cell

      io_cell i_o_cell(
          .FROM_CORE(FROM_CORE),
          .PAD(PAD)
      );
      
      assign TO_CORE = 1'b0;

    end
    if (CELL_TYPE == 2) begin: gen_i_cell

      io_cell i_i_cell(
          .TO_CORE(TO_CORE),
          .PAD(PAD)
      );

    end
  endgenerate

endmodule
