#!/bin/bash

which verilator
verilator --version
echo ""

# Apply fixes to verilog files
verification/verilator/do_fix.sh

verilator \
    --cc \
    --exe \
    --top-module Didactic \
    --no-timing \
    --trace \
    -Wno-context \
    -Wno-fatal \
    -Wno-lint \
    -Wno-style \
    -Wno-BLKANDNBLK \
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
    -I./ips/ibex/vendor/lowrisc_ip/ip/prim/rtl \
    -I./ips/ibex/vendor/lowrisc_ip/dv/sv/dv_utils \
    -I./ips/ibex/rtl \
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
    src/rtl/Student_SS_3.sv \
    src/rtl/Student_SS_2.sv \
    src/rtl/io_cell_frame_ss_1.sv \
    src/rtl/student_ss_1.sv \
    src/rtl/Student_area_0.sv \
    src/rtl/ICN_SS.sv \
    ips/axi/src/axi_to_axi_lite.sv \
    ips/axi/src/axi_atop_filter.sv \
    ips/axi/src/axi_burst_splitter.sv \
    ips/axi/src/axi_demux.sv \
    ips/axi/src/axi_demux_simple.sv \
    ips/ibex/rtl/ibex_pkg.sv \
    ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_ram_1p_pkg.sv \
    ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_secded_pkg.sv \
    ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_util_pkg.sv \
    ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_cipher_pkg.sv \
    ips/ibex/syn/rtl/prim_clock_gating.v \
    ips/ibex/dv/uvm/core_ibex/common/prim/prim_buf.sv \
    ips/ibex/vendor/lowrisc_ip/ip/prim_generic/rtl/prim_generic_buf.sv \
    ips/ibex/rtl/ibex_pmp.sv \
    ips/ibex/rtl/ibex_cs_registers.sv \
    ips/ibex/rtl/ibex_core.sv \
    ips/ibex/rtl/ibex_top.sv \
    src/rtl/SS_Ctrl_reg_array.sv \
    src/rtl/io_cell_frame_sysctrl.sv \
    src/generated/Didactic.v \
    verification/verilator/sim_main.cpp
verilator_exit_code=$?
echo ""

# Remove fixes to verilog files
verification/verilator/undo_fix.sh

if [ ${verilator_exit_code} -eq 0 ]; then
    echo "OK"
    exit 0
else
    echo "FAIL"
    exit ${verilator_exit_code}
fi
