/*
Fixed-size uint8 2x2 matrix multiplier for COMP.CE.250
author: Antti Nurmi <antti.nurmi@tuni.fi>
*/

module matmul #(
  parameter bit       OutputReg    = 0
)(
  input  logic        clk_i,
  input  logic        rst_ni,
  input  logic [31:0] operand_a_i,
  input  logic [31:0] operand_b_i,
  output logic [63:0] result_o
);

logic [7:0][15:0] mul_res;
logic [3:0][15:0] mul_sum;

assign result_o = {mul_sum[0],
                   mul_sum[1],
                   mul_sum[2],
                   mul_sum[3]};

generate
  for (genvar mult = 0; mult < 8; mult++) begin : gen_mults

    localparam int unsigned IdxA = get_a_idx(mult);
    localparam int unsigned IdxB = get_b_idx(mult);
    multiplier #(
      .OperandWidth (8),
      .OutputReg    (OutputReg)
    ) i_mult (
      .clk_i,
      .rst_ni,
      .operand_a_i (operand_a_i[8*(IdxA+1)-1 : 8*IdxA]),
      .operand_b_i (operand_b_i[8*(IdxB+1)-1 : 8*IdxB]),
      .result_o    (mul_res[mult])
    );
  end
endgenerate

generate
  for (genvar sum = 0; sum < 4; sum++)
    assign mul_sum[sum] = mul_res[sum*2] + mul_res[(sum*2)+1];
endgenerate

function automatic int get_a_idx (int idx);
  int result = 0;
  unique case (idx) inside
    0, 2:    result = 3;
    1, 3:    result = 2;
    4, 6:    result = 1;
    default: result = 0;
  endcase
  return result;
endfunction

function automatic int get_b_idx (int idx);
  int result = 0;
    unique case (idx) inside
    0, 4:    result = 3;
    1, 5:    result = 1;
    2, 6:    result = 2;
    default: result = 0;
  endcase
  return result;
endfunction


endmodule : matmul
