`include "verification/verilator/src/common.v"
`INCREMENT_CYCLE_COUNT(clk_in)

import "DPI-C" function void check_signal_propagation(input string path, input real itime, input string name1, input int value1, input string name2, input int value2);

`CHECK_SIGNAL_PROPAGATION(boot_sel, BootSel_internal)
`CHECK_SIGNAL_PROPAGATION(clk_in, clk_internal)
`CHECK_SIGNAL_PROPAGATION(fetch_en, fetchEn_internal)
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
  assign BootSel_internal = boot_sel;
  assign clk_internal = clk_in;
  assign fetchEn_internal = fetch_en;
`endif
