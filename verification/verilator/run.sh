#!/bin/bash

which verilator
verilator --version
echo ""

# Start with the easy task first.
# Attempt to just process the input files.
# No compilation is performed.
# When this succeeds, implement more complex script.
verilator \
    --lint-only \
    --top-module Didactic \
    -I./src/generated \
    -I./src/reuse \
    -I./src/tb \
    -I./src/tech_generic \
    -I./ips/riscv-dbg/src \
    -I./ips/riscv-dbg/debug_rom \
    -I./ips/common_cells \
    -I./ips/common_cells/include \
    -I./ips/common_cells/src \
    -I./ips/common_cells/src/deprecated \
    -I./ips/axi/include \
    ips/riscv-dbg/src/dm_pkg.sv \
    ips/common_cells/src/cdc_reset_ctrlr_pkg.sv \
    ips/common_cells/src/cdc_4phase.sv \
    ips/tech_cells_generic/src/rtl/tc_clk.sv \
    ips/apb_gpio/rtl/apb_gpio.sv \
    src/rtl/APB_SDIO_tieoff.v \
    ips/apb_spi_master/apb_spi_master.sv \
    ips/apb_spi_master/spi_master_apb_if.sv \
    ips/axi_spi_master/spi_master_fifo.sv \
    ips/axi_spi_master/spi_master_controller.sv \
    ips/axi_spi_master/spi_master_clkgen.sv \
    ips/axi_spi_master/spi_master_tx.sv \
    ips/axi_spi_master/spi_master_rx.sv \
    ips/apb_uart/src/apb_uart.sv \
    ips/apb_uart/src/slib_input_sync.sv \
    ips/apb_uart/src/slib_input_filter.sv \
    ips/apb_uart/src/uart_interrupt.sv \
    ips/apb_uart/src/slib_edge_detect.sv \
    ips/apb_uart/src/uart_baudgen.sv \
    ips/apb_uart/src/slib_clock_div.sv \
    ips/apb_uart/src/slib_fifo.sv \
    ips/apb_uart/src/uart_transmitter.sv \
    ips/apb_uart/src/uart_receiver.sv \
    ips/apb_uart/src/slib_counter.sv \
    ips/apb_uart/src/slib_mv_filter.sv \
    ips/axi/src/axi_pkg.sv \
    ips/axi/src/axi_intf.sv \
    src/rtl/AX4LITE_APB_converter_wrapper.sv \
    ips/common_cells/src/cf_math_pkg.sv \
    ips/axi/src/axi_lite_to_apb.sv \
    src/rtl/SysCtrl_xbar.sv \
    ips/axi/src/axi_lite_to_axi.sv \
    ips/axi/src/axi_lite_xbar.sv \
    ips/axi/src/axi_lite_demux.sv \
    ips/axi/src/axi_err_slv.sv \
    ips/axi/src/axi_lite_mux.sv \
    src/generated/Didactic.v
verilator_exit_code=$?
echo ""

if [ ${verilator_exit_code} -eq 0 ]; then
    echo "OK"
    exit 0
else
    echo "FAIL"
    exit ${verilator_exit_code}
fi
