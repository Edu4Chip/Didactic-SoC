/*
  Project: Edu4Chip
  Module(s): io_cell_wrapper
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Wrapper module for IO cell selection
    * XILINX FPGA IOBUF or Simulation model
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
      `ifdef FPGA
        IOBUF i_iobuf(
          .T (io_cell_cfg[0]), 
          .I (FROM_CORE),
          .O (O),
          .IO(PAD)
        );
      `else
        io_cell #(
            .CONF_WIDTH(IOCELL_CFG_W)
        ) i_io_cell(
            .io_cell_cfg(io_cell_cfg),
            .FROM_CORE(FROM_CORE),
            .TO_CORE(TO_CORE),
            .PAD(PAD)
        );
      `endif
    end
    if (CELL_TYPE == 1) begin: gen_o_cell
      `ifdef FPGA
        IOBUF i_o_iobuf(
          .T (1'b0), 
          .I (FROM_CORE),
          .O (TO_CORE),
          .IO(PAD)
        );
      `else
        o_cell i_o_cell(
            .FROM_CORE(FROM_CORE),
            .PAD(PAD)
        );
        assign TO_CORE = 1'b0;
      `endif
    end
    if (CELL_TYPE == 2) begin: gen_i_cell
      `ifdef FPGA
        IOBUF i_i_iobuf(
          .T (1'b1), 
          .I (FROM_CORE),
          .O (TO_CORE),
          .IO(PAD)
        );
      `else
        i_cell i_i_cell(
            .TO_CORE(TO_CORE),
            .PAD(PAD)
        );
      `endif
    end

  endgenerate

endmodule
