/*
Generic multiplier for COMP.CE.250
author: Antti Nurmi <antti.nurmi@tuni.fi>
*/

module multiplier #(
  parameter int unsigned OperandWidth = 32,
  parameter bit          OutputReg    = 0
)(
  input  logic                        clk_i,
  input  logic                        rst_ni,
  input  logic     [OperandWidth-1:0] operand_a_i,
  input  logic     [OperandWidth-1:0] operand_b_i,
  output logic [(2*OperandWidth)-1:0] result_o
);

logic [(2*OperandWidth)-1:0] result;

assign result = operand_a_i * operand_b_i;

if (OutputReg) begin : g_output_reg

  logic [(2*OperandWidth)-1:0] result_q;

  always_ff @( posedge clk_i or negedge rst_ni )
    begin
      if (~rst_ni)
        result_q <= '0;
      else
        result_q <= result;
    end

  assign result_o = result_q;

end else begin : g_no_output_reg
  assign result_o = result;
end

endmodule : multiplier
