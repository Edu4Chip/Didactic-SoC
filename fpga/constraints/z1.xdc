# PYNQ-Z1 constaints for Didactic SoC.

##############
# Timing
##############

## Global clk
create_clock -period 8.000 -name global_clk -waveform {0.000 4.000} -add [get_ports clk_in]

## JTAG clock
create_clock -period 125.000 -name jtag_clk -waveform {0.000 62.500} -add [get_ports jtag_tck]
set_input_jitter jtag_clk 1.000

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

# Clock crossing characteristics
set_clock_groups -logically_exclusive -group [get_clocks -include_generated_clocks global_clk] -group [get_clocks jtag_clk]

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
