module analog_clk_cell (
    // On-chip
    output logic CLK_TO_CORE,
    // Off-chip
    inout  wire  CLK_P_PAD,
    inout  wire  CLK_N_PAD
  );

  `ifdef FPGA
    IOBUF i_clk_p_iobuf(
      .T (1'b1), 
      .I (1'b0),
      .O (CLK_TO_CORE),
      .IO(CLK_P_PAD)
    );
    IOBUF i_clk_n_iobuf(
      .T (1'b1), 
      .I (1'b0),
      .O (),
      .IO(CLK_N_PAD)
    );
  `else
    assign CLK_TO_CORE = CLK_P_PAD;
  `endif
  
endmodule