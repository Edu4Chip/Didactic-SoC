/*
 * Contributors:
 *   - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *   - tb for didactic soc
 *   - extent of behavior defined later
 *   - this testbench is based partially on pulp repository module:
 *     ../ips/pulp/rtl/tb/tb_pulp.sv
 * Notes:
 *   - 
 */

// modelsim exit codes 
`define EXIT_SUCCESS  0
`define EXIT_FAIL     1
`define EXIT_ERROR   -1

`define CLK_PERIOD 83ns // 12 MHz generic quartz oscillator?
`define FAST_CLK_PERIOD 1ns // fast input
// fast clk makes sim run very slow, disable it by default
//`define ACTIVE_FAST_CLK 1

`timescale 1ns/1ps

module tb_didactic();
  // no top ports. params and defines used to control tb

/////////////////////////////
// parameters 
////////////////////////////////
  parameter DM_SANITY_TESTCASES = 1;

  // default paths
  parameter string TESTCASE = "blink";
  parameter string HEX_LOCATION = "../build/sw/";

  parameter BAUDRATE = 115200;
/////////////////////////////
// test setup
////////////////////////////////

  int          num_stim;
  logic [31:0] stimuli [100000:0]; // array for the stimulus vectors

  logic [31:0]   jtag_data;

  logic [9:0]  FC_CORE_ID = 'd0;

  // xbar base h0100_0000
  // imem offset h_0000
  // binary offset h80
  logic [31:0] begin_imem = 32'h0100_0000;
  logic [31:0] boot_addr  = begin_imem +'h80;

  int   exit_status = `EXIT_ERROR; // default
  int   num_err = 0;
  logic error = 'd0;

/////////////////////////////
// wiring
////////////////////////////////
  logic clk = 1'b0;
  logic reset = 1'b0;
  logic fast_clk = 1'b0;
  
  tri0 dut_clk;
  tri0 dut_fast_clk;
  tri0 dut_fast_clk_neg;
  tri0 dut_reset;

  assign dut_clk      = clk;
  assign dut_reset    = reset;
  assign dut_fast_clk = fast_clk;
  assign dut_fast_clk_neg = ~fast_clk;

  tri0 dut_uart_rx;
  tri0 dut_uart_tx;
  
  tri1 dut_spi_csn0;
  tri1 dut_spi_csn1;
  tri1 dut_spi_sck;
  tri1 dut_spi_data0;
  tri1 dut_spi_data1;
  tri1 dut_spi_data2;
  tri1 dut_spi_data3;

  tri0 dut_gpio_0;
  tri1 dut_gpio_1;
  tri0 dut_gpio_2;
  tri1 dut_gpio_3;
  tri0 dut_gpio_4;
  tri1 dut_gpio_5;
  tri0 dut_gpio_6;
  tri1 dut_gpio_7;
  tri0 dut_gpio_8;
  tri1 dut_gpio_9;
  tri0 dut_gpio_10;
  tri1 dut_gpio_11;
  tri0 dut_gpio_12;
  tri1 dut_gpio_13;
  tri0 dut_gpio_14;
  tri1 dut_gpio_15;

  tri1 dut_jtag_trstn;
  tri1 dut_jtag_tck;
  tri1 dut_jtag_tdi;
  tri1 dut_jtag_tms;
  wire dut_jtag_tdo;

  logic jtag_trstn = 1'b0;
  logic jtag_tck   = 1'b0;
  logic jtag_tdi   = 1'b0;
  logic jtag_tms   = 1'b0;
  logic jtag_tdo;

  assign dut_jtag_trstn = jtag_trstn;
  assign dut_jtag_tck   = jtag_tck;
  assign dut_jtag_tdi   = jtag_tdi;
  assign dut_jtag_tms   = jtag_tms;
  assign jtag_tdo       = dut_jtag_tdo;

  tri1 dut_ana_in_0;
  tri1 dut_ana_in_1;
  tri1 dut_ana_out_0;
  tri1 dut_ana_out_1;
  tri1 dut_ana_out_2;
  tri1 dut_ana_io_0;
  tri1 dut_ana_io_1;

////////////////////////////////
// PKG init
////////////////////////////////

  jtag_pkg::test_mode_if_t   test_mode_if = new;
  jtag_pkg::debug_mode_if_t  debug_mode_if = new;

/////////////////////////////
// clk process
////////////////////////////////
  initial
  begin
    #(`CLK_PERIOD/2);
    clk = 1'b1;
    forever clk = #(`CLK_PERIOD/2) ~clk;
  end

`ifdef ACTIVE_FAST_CLK
  initial
  begin
    #(`FAST_CLK_PERIOD/2);
    fast_clk = 1'b1;
    forever fast_clk = #(`FAST_CLK_PERIOD/2) ~fast_clk;
  end
`endif
/////////////////////////////
// TB behavioral
////////////////////////////////
  initial
  begin
    //asserting global reset
    reset = 1'b0;
    $display("[TB] Time %g ns - Reset on, start wait 3ms", $time);
    #3ms;

    $display("[TB] Time %g ns - Reset is about to be lifted", $time);
    reset = 1'b1;

    $display("[TB] Time %g ns - Reset lift", $time);
    #3ms;

    $display("[TB] Time %g ns - execute for 3ms", $time);

    // light testing jtag features
    jtag_pkg::jtag_reset      (jtag_tck, jtag_tms, jtag_trstn, jtag_tdi);
    jtag_pkg::jtag_softreset  (jtag_tck, jtag_tms, jtag_trstn, jtag_tdi);
    #5us;
    jtag_pkg::jtag_bypass_test(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
    #5us;
    jtag_pkg::jtag_get_idcode (jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
    #5us;
    
    // init
    test_mode_if.init(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi);

    debug_mode_if.init_dmi_access(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi);

    debug_mode_if.set_dmactive(1'b1, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
    debug_mode_if.set_hartsel(FC_CORE_ID, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);

    $display("[TB] Time %g ns - Halting the Core", $time);
    debug_mode_if.halt_harts(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);

    $display("[TB] Time %g ns - Writing the boot address into dpc", $time);
    debug_mode_if.write_reg_abstract_cmd(riscv::CSR_DPC, boot_addr, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);



    if(DM_SANITY_TESTCASES == 1) begin


      debug_mode_if.run_dm_tests(FC_CORE_ID, boot_addr, error, num_err, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
       
      // check DM test status
      if (num_err == 0) begin
        exit_status = `EXIT_SUCCESS;
        $display("[TB] Time %g ns -  All Debug module tests Success", $time);
      end else begin
        exit_status = `EXIT_FAIL;
        $error("[TB] Time %g ns - FAILURE: %d Debug Module tests failed", $time, num_err);
      end
      $stop;


    end
    else if (DM_SANITY_TESTCASES == 0) begin
    
    // program load & execute

      $readmemh({HEX_LOCATION,TESTCASE,".hex"}, stimuli);

      // start program upload
      debug_mode_if.load_L2(num_stim, begin_imem, stimuli, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
    

      debug_mode_if.init_dmi_access(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi);
      // we have set dpc and loaded the binary, we can go now
      $display("[TB] Time %g ns - Resuming the CORE", $time);
      debug_mode_if.resume_harts(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);

      //-------------------------------Wait sysctrl program finish-----------------------
      debug_mode_if.init_dmi_access(jtag_tck, jtag_tms, jtag_trstn, jtag_tdi);
      // enable sb access for subsequent readMem calls
      debug_mode_if.set_sbreadonaddr(1'b1, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
      // wait for end of computation signal
      $display("[TB] Time %g ns - Waiting for end of computation", $time);

      jtag_data = 0;

      // poll
      while(jtag_data[31] == 0) begin
        // todo: wire core status register
        debug_mode_if.readMem(32'h01020380, jtag_data, jtag_tck, jtag_tms, jtag_trstn, jtag_tdi, jtag_tdo);
        #100us;
      end

      // Check exit status
      if (jtag_data[30:0] == 0) begin
        exit_status = `EXIT_SUCCESS;
        $display("[TB] Time %g ns - JTAG RETURN OK: Received status core: 0x%h", $time, jtag_data[30:0]);
      end
      else begin
        exit_status = `EXIT_FAIL;
        $display("[TB] Time %g ns - JTAG RETURN FAILURE: core status: 0x%h", $time, jtag_data[30:0]);
      end
      #1ms;//wait to get prints etc out of the tb
      $stop;


    end

    #1ms;//wait to get prints etc out of the tb

    $stop;

  end
/////////////////////////////////////////////////////
// dut
/////////////////////////////////////////////////////

 Didactic #(
  // no top params allowed
  )i_didactic (
    // Interface: Clock
    .clk_in(dut_clk),
    .clk_out(),
    // Interface: GPIO
    .gpio({dut_gpio_15,dut_gpio_14,dut_gpio_13,dut_gpio_12,
           dut_gpio_11,dut_gpio_10,dut_gpio_9,dut_gpio_8,
           dut_gpio_7,dut_gpio_6,dut_gpio_5,dut_gpio_4,
           dut_gpio_3,dut_gpio_2,dut_gpio_1,dut_gpio_0}),
    // Interface: JTAG
    .jtag_tck(dut_jtag_tck),
    .jtag_tdi(dut_jtag_tdi),
    .jtag_tdo(dut_jtag_tdo),
    .jtag_tms(dut_jtag_tms),
    .jtag_trst(dut_jtag_trstn),
    // Interface: Reset
    .reset(dut_reset),
    // Interface: SPI
    .spi_csn({dut_spi_csn1,dut_spi_csn0}),
    .spi_data({dut_spi_data3, dut_spi_data2, dut_spi_data1, dut_spi_data0}),
    .spi_sck(dut_spi_sck),
    // Interface: UART
    .uart_rx(dut_uart_rx),
    .uart_tx(dut_uart_tx),
    // Interface: analog_if
    .ana_core_in({dut_ana_in_1, dut_ana_in_0}),
    .ana_core_out({dut_ana_out_2, dut_ana_out_1, dut_ana_out_0}),
    .ana_core_io({dut_ana_io_1, dut_ana_io_0}),
    .high_speed_clk_n_in(dut_fast_clk_neg),
    .high_speed_clk_p_in(dut_fast_clk)
  );

///////////////////////////////////////////////////////////////
// periph sim models 
///////////////////////////////////////////////////////////////
// if tb module is not in use, loopback uart
`ifdef USE_UART
  uart_tb_rx #(
    .BAUD_RATE ( 38400      ),
    .PARITY_EN ( 0          )
  ) i_uart_rx (
    .rx        ( dut_uart_tx),
    .rx_en     ( 1'b1       ),//if included by define, always en
    .word_done (            )
 );
`else
  assign dut_uart_rx = dut_uart_tx;
`endif

// this spi model utilizes only single lane
// replicate pulpino spi data return from:
// https://github.com/pulp-platform/pulpino/blob/master/tb/tb.sv#L364
`ifdef USE_SPI

  spi_slave tb_if_spi_slave();

  assign tb_if_spi_slave.csn = dut_spi_csn0;
  assign tb_if_spi_slave.clk = dut_spi_sck;
  assign dut_spi_data0 = tb_if_spi_slave.sdi[0];

  initial begin
    // do two returns of data
    for (int i = 0; i < 2; i++) begin
      tb_if_spi_slave.wait_csn(0);
      tb_if_spi_slave.send(0,{>>{8'h38}});
    end
  end

`endif

endmodule