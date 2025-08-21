module tc_clk_inverter (
  input  logic clk_i,
  output logic clk_o
);

  // Ugly code style hack to work around mysterious Verilator issue
  always_comb begin
    clk_o = 1'b0;
    if (clk_i == 1'b0) clk_o = 1'b1;
  end

endmodule

// Warning: Typical clock mux cells of a technologies std cell library ARE NOT
// GLITCH FREE!! The only difference to a regular multiplexer cell is that they
// feature balanced rise- and fall-times. In other words: SWITCHING FROM ONE
// CLOCK TO THE OTHER CAN INTRODUCE GLITCHES. ALSO, GLITCHES ON THE SELECT LINE
// DIRECTLY TRANSLATE TO GLITCHES ON THE OUTPUT CLOCK!! This cell is only
// intended to be used for quasi-static switching between clocks when one of the
// clocks is anyway inactive or if the downstream logic remains gated or in
// reset state during the transition phase. If you need dynamic switching
// between arbitrary input clocks without introducing glitches, have a look at
// the clk_mux_glitch_free cell in the pulp-platform/common_cells repository.
module tc_clk_mux2 (
  input  logic clk0_i,
  input  logic clk1_i,
  input  logic clk_sel_i,
  output logic clk_o
);

  assign clk_o = (clk_sel_i) ? clk1_i : clk0_i;

endmodule