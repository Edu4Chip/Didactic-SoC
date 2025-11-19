/*
 * A Verilator-friendly, minimal SysCtrl + student subsystem
 * wrapper for COMP.CE.250 System-on-Chip Design.
 *
 * Author: Antti Nurmi <antti.nurmi@tuni.fi>
 */

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

  logic dut_uart_tx;

  SysCtrl_SS_0 #(
      .IOCELL_CFG_W(10),
      .IOCELL_COUNT(25),
      .NUM_GPIO    (16),
      .SS_CTRL_W   (8),
      .OBI_IDW     (1),
      .OBI_CHKW    (1),
      .OBI_USERW   (1),
      .OBI_AW      (32),
      .OBI_DW      (32),
      .NUM_SS      (5)
  ) SysCtrl_SS (
      .clk_internal      (clk_i),
      .gpio_to_core      (),
      .gpio_from_core    (),
      .ss_ctrl_icn       (),
      .sysctrl_irq_i     (),
      .jtag_tck_internal (jtag_tck_i),
      .jtag_tdi_internal (jtag_td_i),
      .jtag_tms_internal (jtag_tms_i),
      .jtag_trst_internal(jtag_trst_ni),
      .jtag_tdo_internal (jtag_td_o),
      .obi_err           (),
      .obi_gnt           (),
      .obi_gntpar        (),
      .obi_rdata         (),
      .obi_rid           (),
      .obi_rvalid        (),
      .obi_rvalidpar     (),
      .obi_addr          (),
      .obi_aid           (),
      .obi_be            (),
      .obi_req           (),
      .obi_reqpar        (),
      .obi_rready        (),
      .obi_rreadypar     (),
      .obi_wdata         (),
      .obi_we            (),
      .reset_internal    (rst_ni),
      .reset_icn         (),
      .reset_ss          (),
      .spim_miso_internal(),
      .spim_csn_internal (),
      .spim_mosi_internal(),
      .spim_sck_internal (),
      .irq_en_0          (),
      .ss_ctrl_0         (),
      .irq_en_1          (),
      .ss_ctrl_1         (),
      .irq_en_2          (),
      .ss_ctrl_2         (),
      .irq_en_3          (),
      .ss_ctrl_3         (),
      .uart_rx_internal  (),
      .uart_tx_internal  (dut_uart_tx),
      .cell_cfg          (),
      .pmod_sel          (),
      .irq_en_4          (),
      .ss_ctrl_4         (),
      .irq_upper_tieoff  (15'h0)
  );

  didactic_student_domain #(
      .ApbAddrWidth(32'd12),
      .ApbDataWidth(32'd32)
  ) i_student_domain (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .irq_o    (),
      .paddr_i  (),
      .penable_i(),
      .psel_i   (),
      .pwdata_i (),
      .prdata_o (),
      .pready_o (),
      .pslverr_o()
  );

  /// SIMULATION-ONLY UTILITIES ///

  `define STR(s) `"s`"
  string RepoRoot = `STR(`ROOT);

  initial begin : sim_loader
    @(posedge rst_ni);
    $display("[DUT:SimLoader] Initializing program with $readmemh");
    $display("[DUT:SimLoader] APPLICABLE TO SIMULATED DESIGNS ONLY");
    $readmemh({RepoRoot,"/build/verilator_build/imem_stim.hex"}, SysCtrl_SS.i_imem.ram);
    $readmemh({RepoRoot,"/build/verilator_build/dmem_stim.hex"}, SysCtrl_SS.i_dmem.ram);
  end : sim_loader

endmodule : didactic_vtop

