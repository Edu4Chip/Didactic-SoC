module DidacticZ1 (
  // Interface: Clock
    input  wire                         clk_in,

    // Interface: GPIO
    inout  wire          [15:0]         gpio,

    // Interface: JTAG
    inout  wire                         jtag_tck,
    inout  wire                         jtag_tdi,
    inout  wire                         jtag_tdo,
    inout  wire                         jtag_tms,
    inout  wire                         jtag_trst,

    // Interface: Reset
    inout  wire                         reset,

    // Interface: SPI
    inout  wire          [1:0]          spi_csn,
    inout  wire          [3:0]          spi_data,
    inout  wire                         spi_sck,

    // Interface: UART
    inout  wire                         uart_rx,
    inout  wire                         uart_tx,

    // Interface: analog_if
    inout  wire          [1:0]          ana_core_in,
    inout  wire          [1:0]          ana_core_io,
    inout  wire          [2:0]          ana_core_out,

    // Interface: high_speed_clock
    inout  wire                         high_speed_clk_n_in,
    inout  wire                         high_speed_clk_p_in

);

  wire clk_8MHz;
  Pll clk_gen (
    .clk_out(clk_8MHz),
    .clk_in(clk_in)
  );
  
  Didactic didactic (
    .clk_in(clk_8MHz),
    .gpio(gpio),
    .jtag_tck(jtag_tck),
    .jtag_tdi(jtag_tdi),
    .jtag_tdo(jtag_tdo),
    .jtag_tms(jtag_tms),
    .jtag_trst(jtag_trst),
    .reset(reset),
    .spi_csn(spi_csn),
    .spi_data(spi_data),
    .spi_sck(spi_sck),
    .uart_rx(uart_rx),
    .uart_tx(uart_tx),
    .ana_core_in(ana_core_in),
    .ana_core_out(ana_core_out),
    .ana_core_io(ana_core_io),
    .high_speed_clk_n_in(1'b0),
    .high_speed_clk_p_in(1'b0)
  );

endmodule

module Pll (
  output        clk_out,
  input         clk_in
 );
 
  wire clk_in_Pll;
 
  IBUF clkin1_ibufg
   (.O (clk_in_Pll),
    .I (clk_in));

  wire        clk_out_Pll;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_Pll;
  wire        clkfbout_buf_Pll;
  wire        clkfboutb_unused;
  wire        clkout1_unused;
  wire        clkout2_unused;
  wire        clkout3_unused;
  wire        clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;

  PLLE2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT        (8),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE       (125),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (8.000))
  plle2_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_Pll),
    .CLKOUT0             (clk_out_Pll),
    .CLKOUT1             (clkout1_unused),
    .CLKOUT2             (clkout2_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_Pll),
    .CLKIN1              (clk_in_Pll),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Other control and status signals
    .LOCKED              (locked_int),
    .PWRDWN              (1'b0),
    .RST                 (1'b0));

// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG clkf_buf
   (.O (clkfbout_buf_Pll),
    .I (clkfbout_Pll));
  BUFG clkout1_buf
   (.O   (clk_out),
    .I   (clk_out_Pll));




endmodule
