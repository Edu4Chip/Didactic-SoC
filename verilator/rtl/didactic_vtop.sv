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

  localparam int unsigned SimCycles = 10000;

  localparam int unsigned AddrWidth = 32;
  localparam int unsigned DataWidth = 64;
  localparam int unsigned IdWidth = 5;
  localparam int unsigned UserWidth = 9;

  AXI_BUS #(
      .AXI_ADDR_WIDTH(AddrWidth),
      .AXI_DATA_WIDTH(DataWidth),
      .AXI_ID_WIDTH  (IdWidth),
      .AXI_USER_WIDTH(UserWidth)
  ) axi_bus ();

  OBI_BUS obi_bus ();

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
      .obi_gnt           (obi_bus.gnt),
      .obi_gntpar        (),
      .obi_rdata         (obi_bus.rdata),
      .obi_rid           (),
      .obi_rvalid        (obi_bus.rvalid),
      .obi_rvalidpar     (),
      .obi_addr          (obi_bus.addr),
      .obi_aid           (),
      .obi_be            (obi_bus.be),
      .obi_req           (obi_bus.req),
      .obi_reqpar        (),
      .obi_rready        (),
      .obi_rreadypar     (),
      .obi_wdata         (obi_bus.wdata),
      .obi_we            (obi_bus.we),
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

  obi_to_axi_intf #() i_obi_to_axi (
      .clk_i,
      .rst_ni,
      .obi_i(obi_bus),
      .axi_o(axi_bus)
  );

  didactic_student_domain #(
      .AxiAddrWidth(32'd12),
      .AxiDataWidth(32'd32)
  ) i_student_domain (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .irq_o (),
      .axi_s (axi_bus)
  );

  /// SIMULATION-ONLY UTILITIES ///

  `define STR(s) `"s`"
  string RepoRoot = `STR(`ROOT);

  initial begin : sim_loader
    @(posedge rst_ni);
    $display("[DUT:SimLoader] Initializing program with $readmemh");
    $display("[DUT:SimLoader] APPLICABLE TO SIMULATED DESIGNS ONLY");
    $readmemh({RepoRoot, "/build/verilator_build/imem_stim.hex"}, SysCtrl_SS.i_imem.ram);
    $readmemh({RepoRoot, "/build/verilator_build/dmem_stim.hex"}, SysCtrl_SS.i_dmem.ram);
  end : sim_loader


  sim_timeout #(
      .Cycles(SimCycles)
  ) i_timeout (
      .clk_i,
      .rst_ni
  );


endmodule : didactic_vtop

