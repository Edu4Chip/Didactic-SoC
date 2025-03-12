# PYNQ-Z1 constaints for Didactic SoC.

##############
# Timing
##############

## Global clk
create_clock -period 125.000 -name global_clk -waveform {0.000 62.500} -add [get_ports clk_in]

## JTAG clock
create_clock -period 125.000 -name jtag_clk -waveform {0.000 62.500} -add [get_ports jtag_tck]
set_input_jitter jtag_clk 1.000

## Highspeed clock
create_clock -period 10.000 -name clk_p -waveform {0.000 5.000} -add [get_ports high_speed_clk_p_in]
create_clock -period 10.000 -name clk_n -waveform {0.000 5.000} -add [get_ports high_speed_clk_n_in]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets SystemControl_SS/i_io_cell_frame/i_clk_cell/i_clk_p_iobuf/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets SystemControl_SS/i_io_cell_frame/i_clk_cell/i_clk_n_iobuf/O]

set_input_jitter clk_p 1.000
set_input_jitter clk_n 1.000

## JTAG specifics
set_input_delay -clock jtag_clk -clock_fall 5.000 [get_ports jtag_tdi]
set_input_delay -clock jtag_clk -clock_fall 5.000 [get_ports jtag_tms]
set_output_delay -clock jtag_clk 5.000 [get_ports jtag_tdo]

set_max_delay -to [get_ports jtag_tdo] 20.000
set_max_delay -from [get_ports jtag_tms] 20.000
set_max_delay -from [get_ports jtag_tdi] 20.000

## Reset
set_false_path -from [get_ports reset]
set_false_path -from [get_ports jtag_trst]
set_false_path -from [get_ports uart_rx]
set_false_path -from [get_ports gpio]

#set_false_path -from [get_pins SystemControl_SS/SysCtrl_SS/SS_Ctrl_reg_array/ss_rst_reg_reg*/D]

# Clock crossing characteristics
set_clock_groups -asynchronous -group global_clk -group jtag_clk -group clk_p

##################
# IO
###############

## CLK
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports clk_in]

## RESET
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports reset]

## JTAG
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS33} [get_ports jtag_tck]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports jtag_tdi]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports jtag_tdo]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports jtag_tms]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports jtag_trst]

## UART
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports uart_rx]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports uart_tx]

## SPI
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {spi_data[0]}]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {spi_data[1]}]
set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS33} [get_ports {spi_data[2]}]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {spi_data[3]}]
set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports {spi_csn[0]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {spi_csn[1]}]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports spi_sck]

##Pmod Header JA
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports {gpio[0]}]
set_property -dict {PACKAGE_PIN Y19 IOSTANDARD LVCMOS33} [get_ports {gpio[1]}]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports {gpio[2]}]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports {gpio[3]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {ana_core_in[0]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {ana_core_in[1]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {ana_core_out[0]}]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {ana_core_out[1]}]

##Pmod Header JB
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {gpio[4]}]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports {gpio[5]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {gpio[6]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {gpio[7]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports high_speed_clk_n_in]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports high_speed_clk_p_in]
#set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { gpio[6] }]
#set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { gpio[7] }]

set_property MARK_DEBUG true [get_nets SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper_Debug_to_Ibex_Core_Debug_debug_req]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[3]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[2]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[30]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[27]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[29]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[25]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[26]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[4]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[23]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[24]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[14]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[15]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[16]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[17]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[21]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[28]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[18]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[19]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[20]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[22]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[31]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[5]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[6]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[7]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[8]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[9]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[10]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[11]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[12]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[13]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[0]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[1]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[2]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[3]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[4]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[23]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[20]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[21]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[22]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[24]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[25]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[26]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[27]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[28]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[30]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[31]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[29]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[5]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[6]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[19]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[7]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[8]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[9]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[10]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[11]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[12]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[13]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[15]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[16]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[17]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[18]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[14]}]
set_property MARK_DEBUG true [get_nets SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/debug_req_irq_o]
set_property MARK_DEBUG true [get_nets SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top_n_0]
set_property MARK_DEBUG true [get_nets SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/halted]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/debug_req_o[0]}]
set_property MARK_DEBUG true [get_nets SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/resumereq]
set_property MARK_DEBUG true [get_nets SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/ndmreset_o]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][0]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][5]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][1]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][2]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][3]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][4]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][20]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][6]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][7]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][21]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][8]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][11]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][28]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][22]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][24]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][25]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][26]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][12]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][13]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][27]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][14]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][15]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][9]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][29]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][30]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][31]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][18]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][19]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][17]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][10]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][16]}]
set_property MARK_DEBUG true [get_nets {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][23]}]
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list SystemControl_SS/SysCtrl_SS/Ibex_Core/core_clock_gate_i/gen_xilinx.u_impl_xilinx/clk_o]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/debug_req_o[0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][0]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][1]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][2]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][3]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][4]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][5]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][6]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][7]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][8]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][9]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][10]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][11]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][12]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][13]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][14]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][15]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][16]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][17]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][18]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][19]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][20]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][21]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][22]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][23]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][24]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][25]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][26]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][27]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][28]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][29]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][30]} {SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/progbuf[0][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 30 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[2]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[3]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[4]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[5]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[6]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[7]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[8]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[9]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[10]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[11]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[12]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[13]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[14]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[15]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[16]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[17]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[18]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[19]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[20]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[21]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[22]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[23]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[24]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[25]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[26]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[27]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[28]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[29]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[30]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_ADDR[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[0]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[1]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[2]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[3]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[4]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[5]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[6]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[7]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[8]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[9]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[10]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[11]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[12]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[13]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[14]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[15]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[16]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[17]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[18]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[19]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[20]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[21]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[22]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[23]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[24]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[25]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[26]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[27]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[28]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[29]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[30]} {SystemControl_SS/SysCtrl_SS/Ibex_Core_imem_to_core_imem_bridge_mem_RDATA[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/debug_req_irq_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/halted]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top_n_0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper_Debug_to_Ibex_Core_Debug_debug_req]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/ndmreset_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list SystemControl_SS/SysCtrl_SS/jtag_dbg_wrapper/i_dm_top/resumereq]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_o]
