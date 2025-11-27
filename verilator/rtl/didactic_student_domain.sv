module didactic_student_domain #(
    parameter int unsigned ApbAddrWidth = 32'd12,
    parameter int unsigned ApbDataWidth = 32'd32
) (
    input  logic                    clk_i,
    input  logic                    rst_ni,
    output logic                    irq_o,
    input  logic                    penable_i,
    input  logic                    psel_i,
    output logic                    pready_o,
    output logic                    pslverr_o,
    input  logic [ApbAddrWidth-1:0] paddr_i,
    input  logic [ApbDataWidth-1:0] pwdata_i,
    output logic [ApbDataWidth-1:0] prdata_o
);

always  @(posedge clk_i ) begin
  pready_o <= penable_i;
end

endmodule : didactic_student_domain

