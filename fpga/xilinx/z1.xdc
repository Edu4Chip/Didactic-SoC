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
create_clock -period 125.000 -name clk_p -waveform {0.000 62.500} -add [get_ports high_speed_clk_p_in]
create_clock -period 125.000 -name clk_n -waveform {0.000 62.500} -add [get_ports high_speed_clk_n_in]

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
set_false_path -to [get_ports uart_tx]

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
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {gpio[4]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {gpio[5]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {gpio[6]}]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {gpio[7]}]

##Pmod Header JB
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {gpio[8]}]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports {gpio[9]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {gpio[10]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {gpio[11]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {gpio[12]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {gpio[13]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {gpio[14]}]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {gpio[15]}]

# btn
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports high_speed_clk_n_in]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports high_speed_clk_p_in]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {ana_core_in[0]}]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports {ana_core_in[1]}]

# led
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {ana_core_out[0]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {ana_core_out[1]}]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {ana_core_out[2]}]

# digital header
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {ana_core_io[0]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {ana_core_io[1]}]