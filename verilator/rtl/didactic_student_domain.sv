module didactic_student_domain #(
    parameter int unsigned AxiAddrWidth = 32'd12,
    parameter int unsigned AxiDataWidth = 32'd32
) (
    input  logic         clk_i,
    input  logic         rst_ni,
    output logic         irq_o,
           AXI_BUS.Slave axi_s
);


endmodule : didactic_student_domain

