/*
  Project: Edu4Chip
  Module(s): tech_sync
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * simulation model for depth-parameterized
      signal synchronizer
*/

module tech_sync #(
    parameter SYNC_DEPTH = 2
  )(
    input  logic clk,
    input  logic rst_n,
    input  logic signal_i,
    output logic signal_sync_o
  );

  logic [SYNC_DEPTH-1:0] sync_reg;

  always_ff @(posedge clk, negedge rst_n) begin : sync_proc
    if (!rst_n) begin
      sync_reg = 'h0;
    end
    else begin
      sync_reg[0] = signal_i;
      if (SYNC_DEPTH > 1) begin
        for(int i = 1; i < SYNC_DEPTH; i++) begin
          sync_reg[i] = sync_reg[i-1];
        end
      end
    end
  end

  assign signal_sync_o = sync_reg[SYNC_DEPTH-1];

endmodule