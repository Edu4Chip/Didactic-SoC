
module DidacticBasys3 (
  // Interface: Clock
    input  wire                         clk_in,

    // Interface: GPIO
    inout  wire          [15:0]          gpio,

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
    inout  wire                         high_speed_clk_p_in,

    input wire res,
    output wire [6:0] seg,
    output wire [3:0] an,
    output wire [15:0] leds
);

  wire clk_8MHz;
  Pll clk_gen (
    .clk_out(clk_8MHz),
    .clk_in(clk_in)
  );

  wire [15:0] gpo;
  assign gpo = didactic.SystemControl_SS.i_pmod_mux.gpio_to_io;

  sevenseg seg7 (
    .clk(clk_8MHz),
    .reset(res),
    .in(gpo[15:4]),
    .digit(seg),
    .an(an)
  );

  assign leds = gpo;
  
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
    .high_speed_clk_n_in(high_speed_clk_n_in),
    .high_speed_clk_p_in(high_speed_clk_p_in)
  );


endmodule

module Pll 

  (// Clock in ports
  // Clock out ports
  output        clk_out,
  input         clk_in
 );
  // Input buffering
  //------------------------------------
wire clk_in_Pll;
wire clk_in2_Pll;
  IBUF clkin1_ibufg
   (.O (clk_in_Pll),
    .I (clk_in));

  wire        clk_out_Pll;
  wire        clk_out2_Pll;
  wire        clk_out3_Pll;
  wire        clk_out4_Pll;
  wire        clk_out5_Pll;
  wire        clk_out6_Pll;
  wire        clk_out7_Pll;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_Pll;
  wire        clkfbout_buf_Pll;
  wire        clkfboutb_unused;
   wire clkout1_unused;
   wire clkout2_unused;
   wire clkout3_unused;
   wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;

  PLLE2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (5),
    .CLKFBOUT_MULT        (42),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE       (105),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (10.000))
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

  BUFG clkf_buf
   (.O (clkfbout_buf_Pll),
    .I (clkfbout_Pll));
  BUFG clkout1_buf
   (.O   (clk_out),
    .I   (clk_out_Pll));
endmodule


module sevenseg(
  input wire clk,
  input wire reset,
  input wire [15:0] in,
  output reg [6:0] digit,
  output reg [3:0] an
);

reg [15:0] counter;
always @(posedge clk) begin
  if (!reset) begin
    counter <= 16'd0;
    an <= 4'b1110; // Enable first digit
  end else if (counter == 16'd10000) begin
    counter <= 16'd0;
    an <= {an[2:0], an[3]}; // Rotate through the digits
  end else begin
    counter <= counter + 1;
  end
end


reg [3:0] slice;
// take 4 bit slice of input based on an
always @(*) begin
  case (an)
    4'b1110: slice = in[3:0];   // First digit
    4'b1101: slice = in[7:4];   // Second digit
    4'b1011: slice = in[11:8];  // Third digit
    4'b0111: slice = in[15:12]; // Fourth digit
    default: slice = 4'b0000; // Blank
  endcase
end

always @(*) begin
  case (slice)
    4'h0: digit = 7'b1000000; // 0
    4'h1: digit = 7'b1111001; // 1
    4'h2: digit = 7'b0100100; // 2
    4'h3: digit = 7'b0110000; // 3
    4'h4: digit = 7'b0011001; // 4
    4'h5: digit = 7'b0010010; // 5
    4'h6: digit = 7'b0000010; // 6
    4'h7: digit = 7'b1111000; // 7
    4'h8: digit = 7'b0000000; // 8
    4'h9: digit = 7'b0010000; // 9
    4'hA: digit = 7'b0001000; // A
    4'hB: digit = 7'b0000011; // B
    4'hC: digit = 7'b1000110; // C
    4'hD: digit = 7'b0100001; // D
    4'hE: digit = 7'b0000110; // E
    4'hF: digit = 7'b0001110; // F
    default: digit = 7'b1111111; // Blank
  endcase
end





endmodule