module didactic_vtop #(
) (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic jtag_tck_i,
    input  logic jtag_tms_i,
    input  logic jtag_trst_ni,
    input  logic jtag_td_i,
    output logic jtag_td_o
);

  SysCtrl_SS_wrapper_0 #(
      .OBI_AW      (32),
      .OBI_DW      (32),
      .SS_CTRL_W   (8),
      .NUM_GPIO    (16),
      .IOCELL_COUNT(25),
      .IOCELL_CFGW (10),
      .NUM_SS      (5),
      .OBI_IDW     (1)
  ) SystemControl_SS (
      // Interface: Clock
      .clock_in               (clk_in),
      .clock_out              (clk_out),
      // Interface: Clock_int
      .clk                    (SystemControl_SS_clk),
      // Interface: GPIO
      .gpio                   (gpio[15:0]),
      // Interface: ICN_SS_Ctrl
      .ss_ctrl_icn            (SystemControl_SS_ss_ctrl_icn),
      // Interface: IRQ
      .irq_i                  (SystemControl_SS_irq_i),
      // Interface: JTAG
      .jtag_tck               (jtag_tck),
      .jtag_tdi               (jtag_tdi),
      .jtag_tdo               (jtag_tdo),
      .jtag_tms               (jtag_tms),
      .jtag_trst              (jtag_trst),
      // Interface: OBI
      .obi_err                (SystemControl_SS_obi_err),
      .obi_gnt                (SystemControl_SS_obi_gnt),
      .obi_gntpar             (SystemControl_SS_obi_gntpar),
      .obi_rdata              (SystemControl_SS_obi_rdata),
      .obi_rid                (SystemControl_SS_obi_rid),
      .obi_rvalid             (SystemControl_SS_obi_rvalid),
      .obi_rvalidpar          (SystemControl_SS_obi_rvalidpar),
      .obi_addr               (SystemControl_SS_obi_addr),
      .obi_aid                (SystemControl_SS_obi_aid),
      .obi_be                 (SystemControl_SS_obi_be),
      .obi_req                (SystemControl_SS_obi_req),
      .obi_reqpar             (SystemControl_SS_obi_reqpar),
      .obi_rready             (SystemControl_SS_obi_rready),
      .obi_rreadypar          (SystemControl_SS_obi_rreadypar),
      .obi_wdata              (SystemControl_SS_obi_wdata),
      .obi_we                 (SystemControl_SS_obi_we),
      // Interface: Reset
      .reset                  (reset),
      // Interface: Reset_SS
      .reset_ss               (SystemControl_SS_reset_ss),
      // Interface: Reset_icn
      .reset_int              (SystemControl_SS_reset_int),
      // Interface: SPI
      .spi_csn                (spi_csn[1:0]),
      .spi_data               (spi_data[3:0]),
      .spi_sck                (spi_sck),
      // Interface: SS_0_Ctrl
      .irq_en_0               (SystemControl_SS_irq_en_0),
      .ss_ctrl_0              (SystemControl_SS_ss_ctrl_0),
      // Interface: SS_1_Ctrl
      .irq_en_1               (SystemControl_SS_irq_en_1),
      .ss_ctrl_1              (SystemControl_SS_ss_ctrl_1),
      // Interface: SS_2_Ctrl
      .irq_en_2               (SystemControl_SS_irq_en_2),
      .ss_ctrl_2              (SystemControl_SS_ss_ctrl_2),
      // Interface: SS_3_Ctrl
      .irq_en_3               (SystemControl_SS_irq_en_3),
      .ss_ctrl_3              (SystemControl_SS_ss_ctrl_3),
      // Interface: UART
      .uart_rx                (uart_rx),
      .uart_tx                (uart_tx),
      // Interface: high_speed_clock
      .high_speed_clk_n_in    (high_speed_clk_n_in),
      .high_speed_clk_p_in    (high_speed_clk_p_in),
      // Interface: high_speed_clock_internal
      .high_speed_clk_internal(SystemControl_SS_high_speed_clk_internal),
      // Interface: ss_0_pmod_gpio
      .ss_0_pmod_gpio_oe      (SystemControl_SS_ss_0_pmod_gpio_oe),
      .ss_0_pmod_gpo          (SystemControl_SS_ss_0_pmod_gpo),
      .ss_0_pmod_gpi          (SystemControl_SS_ss_0_pmod_gpi),
      // Interface: ss_1_pmod_gpio
      .ss_1_pmod_gpio_oe      (SystemControl_SS_ss_1_pmod_gpio_oe),
      .ss_1_pmod_gpo          (SystemControl_SS_ss_1_pmod_gpo),
      .ss_1_pmod_gpi          (SystemControl_SS_ss_1_pmod_gpi),
      // Interface: ss_2_pmod_gpio
      .ss_2_pmod_gpio_oe      (SystemControl_SS_ss_2_pmod_gpio_oe),
      .ss_2_pmod_gpo          (SystemControl_SS_ss_2_pmod_gpo),
      .ss_2_pmod_gpi          (SystemControl_SS_ss_2_pmod_gpi),
      // Interface: ss_3_pmod_gpio
      .ss_3_pmod_gpio_oe      (SystemControl_SS_ss_3_pmod_gpio_oe),
      .ss_3_pmod_gpo          (SystemControl_SS_ss_3_pmod_gpo),
      .ss_3_pmod_gpi          (SystemControl_SS_ss_3_pmod_gpi),
      // Interface: ss_4_ctrl
      .irq_en_4               (SystemControl_SS_irq_en_4),
      .ss_ctrl_4              (SystemControl_SS_ss_ctrl_4)
  );


endmodule : didactic_vtop

