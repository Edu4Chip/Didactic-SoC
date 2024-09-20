`INCREMENT_CYCLE_COUNT(clk_in)
`include "verification/verilator/src/generated/hdl/ms/io_cell_frame_sysctrl.sv"

// TODO: cell_cfg
//`CHECK_SIGNAL_PROPAGATION(boot_sel, BootSel_internal)
`CHECK_SIGNAL_PROPAGATION(clk_in, clk_internal)
// TODO: GPIO
`CHECK_SIGNAL_PROPAGATION(jtag_tck, jtag_tck_internal)
`CHECK_SIGNAL_PROPAGATION(jtag_tdi, jtag_tdi_internal)
`CHECK_SIGNAL_PROPAGATION(jtag_tdo, jtag_tdo_internal)
`CHECK_SIGNAL_PROPAGATION(jtag_tms, jtag_tms_internal)
`CHECK_SIGNAL_PROPAGATION(jtag_trst, jtag_trst_internal)
`CHECK_SIGNAL_PROPAGATION(reset, reset_internal)
// TODO: SPI
`CHECK_SIGNAL_PROPAGATION(uart_rx, uart_tx_internal)
`CHECK_SIGNAL_PROPAGATION(uart_tx, uart_rx_internal)

`ifdef FIX_SIGNAL_PROPAGATION
  // FIXME: temporary solution to fix signal propagation, remove when fixed in HDL
  assign clk_internal = clk_in;
`endif
