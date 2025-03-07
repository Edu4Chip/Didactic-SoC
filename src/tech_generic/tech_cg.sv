/*
  Project: Edu4Chip
  Module(s): tech_cg
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * Simulation model for clock gate
*/

module tech_cg
  (
    input  logic clk,
    input  logic en,
    output logic clk_out
  );

  logic en_latched;

  `ifdef FPGA   
    BUFGCE i_bufgce (
      .O(clk_out),
      .CE(en), // CE = 0, clock disabled
      .I(clk)
    );
  `else

    always_latch begin
      if (clk == 1'b0) begin
        en_latched <= en;
      end
    end

    assign clk_out = clk & en_latched;

  `endif

endmodule