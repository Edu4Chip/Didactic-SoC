/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * tb for didactic soc
    * extent of behavior defined later
*/

`define CLK_PERIOD 125ns // 8 MHz generic quarts oscillator?

`timescale 1ns/1ps

module tb_didactic();
  // no top ports. params and defines used to control tb

/////////////////////////////
// parameters
////////////////////////////////
  parameter DM_SANITY_TESTCASES = 1;
/////////////////////////////
// wiring
////////////////////////////////
  logic clk = 1'b0;
  logic reset = 1'b0;

  tri0 dut_uart_rx;
  tri0 dut_uart_tx;
  
  tri1 dut_csn0;
  tri1 dut_csn1;
  tri1 dut_spi_sck;
  tri1 dut_spi_data0;
  tri1 dut_spi_data1;
  tri1 dut_spi_data2;
  tri1 dut_spi_data3;

  tri0 dut_gpio_0;
  tri1 dut_gpio_1;
  tri0 dut_gpio_2;
  tri1 dut_gpio_3;
  tri1 dut_gpio_4;
  tri1 dut_gpio_5;
  tri1 dut_gpio_6;
  tri1 dut_gpio_7;

  tri1 dut_jtag_trstn;
  tri1 dut_jtag_tck;
  tri1 dut_jtag_tdi;
  tri1 dut_jtag_tms;
  tri1 dut_jtag_tdo;

  tri0 dut_bootsel;

  tri1 dut_fetch_en;

  tri1 dut_ana_in_0;
  tri1 dut_ana_in_1;
  tri1 dut_ana_out_0;
  tri1 dut_ana_out_1;

////////////////////////////////
// PKG init
////////////////////////////////

  jtag_pkg::test_mode_if_t   test_mode_if = new;
  jtag_pkg::debug_mode_if_t  debug_mode_if = new;

  dm_pkg::dm_ctrl_t dmcontrol;

/////////////////////////////
// clk process
////////////////////////////////
  initial
  begin
    #(`CLK_PERIOD/2);
    clk = 1'b1;
    forever clk = #(`CLK_PERIOD/2) ~clk;
  end

/////////////////////////////
// TB behavioral
////////////////////////////////
  initial
  begin
    //asserting global reset
    reset = 1'b0;
    $display("[TB] Time %g ns - Reset on, start wait 3ms", $time);
    #3ms;

    $display("[TB] Time %g ns - Reset is about to be lifterd", $time);
    reset = 1'b1;

    $display("[TB] Time %g ns - Reset lift", $time);
    #3ms;

    $display("[TB] Time %g ns - execute for 3ms", $time);


    jtag_pkg::jtag_reset      (dut_jtag_tck, dut_jtag_tms, dut_jtag_trstn, dut_jtag_tdi);
    jtag_pkg::jtag_softreset  (dut_jtag_tck, dut_jtag_tms, dut_jtag_trstn, dut_jtag_tdi);
    #5us;
    jtag_pkg::jtag_bypass_test(dut_jtag_tck, dut_jtag_tms, dut_jtag_trstn, dut_jtag_tdi, dut_jtag_tdo);
    #5us;
    jtag_pkg::jtag_get_idcode (dut_jtag_tck, dut_jtag_tms, dut_jtag_trstn, dut_jtag_tdi, dut_jtag_tdo);
    #5us;


    if(DM_SANITY_TESTCASES == 1) begin



    end
    else(DM_SANITY_TESTCASES == 0) begin
    
    // program load & execute
    
    
    end

    $stop;

  end
/////////////////////////////
// dut
////////////////////////////////

 Didactic #(
  // no top params allowed
  )i_didactic (
    // Interface: BootSel
    .boot_sel(dut_bootsel),
    // Interface: Clock
    .clk_in(clk),
    // Interface: FetchEn
    .fetch_en(dut_fetch_en),
    // Interface: GPIO
    .gpio({dut_gpio_7,dut_gpio_6,dut_gpio_5,dut_gpio_4,dut_gpio_3,dut_gpio_2,dut_gpio_1,dut_gpio_0}),
    // Interface: JTAG
    .jtag_tck(dut_jtag_tck),
    .jtag_tdi(dut_jtag_tdi),    // Data can be daisy chained or routed directly back
    .jtag_tdo(dut_jtag_tdo),    // Data can be daisy chained or routed directly back
    .jtag_tms(dut_jtag_tms),
    .jtag_trst(dut_jtag_trstn),
    // Interface: Reset
    .reset(reset),
    // Interface: SPI
    .spi_csn({dut_csn1,dut_csn0}),
    .spi_data({dut_spi_data0,dut_spi_data1,dut_spi_data2,dut_spi_data3}),
    .spi_sck(dut_spi_sck),
    // Interface: SS_1_GPO
    .ss_1_gpio({dut_ss_1_gpio_1,dut_ss_1_gpio_0}),
    // Interface: UART
    .uart_rx(dut_uart_rx),
    .uart_tx(dut_uart_tx),
    // Interface: analog_if
    .ana_core_in({dut_ana_in_0,   cdut_ana_in_1}),
    .ana_core_out({dut_ana_out_0, dut_ana_out_1})
  );


endmodule