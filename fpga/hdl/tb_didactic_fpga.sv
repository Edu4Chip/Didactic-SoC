module tb_didactic_fpga ();

  localparam time RunTime = 1us;

  logic clk, rst;

  initial begin
    $display("### STARTING SIMULATION ###");
  end

  final begin
    $display("### ENDING SIMULATION, TIME: %0d ns", $time);
  end

  VipDidactic #() i_vip ();

  Didactic #(
  // no top params allowed
  )i_didactic (
    // Interface: Clock
    .clk_in(),
    .clk_out(),
    // Interface: GPIO
    .gpio(),
    // Interface: JTAG
    .jtag_tck(),
    .jtag_tdi(),
    .jtag_tdo(),
    .jtag_tms(),
    .jtag_trst(),
    // Interface: Reset
    .reset(),
    // Interface: SPI
    .spi_csn(),
    .spi_data(),
    .spi_sck(),
    // Interface: UART
    .uart_rx(),
    .uart_tx(),
    // Interface: analog_if
    .ana_core_in(),
    .ana_core_out(),
    .ana_core_io(),
    .high_speed_clk_n_in(),
    .high_speed_clk_p_in()
  );

endmodule : tb_didactic_fpga
