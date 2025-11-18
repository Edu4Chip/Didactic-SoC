module uart_rx_passive #(
    parameter int unsigned BaudRate = 115200
) (
    input logic rx_i
);

  // verilator lint_off REALCVT
  localparam time UartBaudPeriod = 1000ns * 1000 * 1000 / BaudRate;
  // verilator lint_on REALCVT
  
  logic [7:0] char;

  always @(negedge rx_i) begin
    #(UartBaudPeriod / 2);
    for (int i = 0; i < 7; i++) begin
      #UartBaudPeriod;
      char[i] = rx_i;
    end
    #UartBaudPeriod;
    $write("%c", char);
  end

endmodule : uart_rx_passive
