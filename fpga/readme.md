## xilinx vivado

Prototyping flow has been created to be automated up to bitstream generation. You can launch either batch or GUI version of the implementation. Use GUI when wanting to inspect details or ILA signals.

OpenOCD is used for connecting to FPGA board and load programs and monitor their execution.

## Prototyping requirements

OpenOCD: RISC compatible OpenOCD (https://github.com/riscv-collab/riscv-openocd).

* debug module requires old version: for example commit 28f630d24568fb3518723349df60bcd30b68bf7b should be compliant. 

* clone, checkout, build locally

Vivado: flow is developed on 24.2. There should not be any dependency on version apart from potential specific tcl commands.

* PYNQ-Z1 FPGA board

* Later full system prototyping would need larger board. Initially not supported by this flow.

RISCV Toolchain: Program binaries need to be crosscompiled and toolchain need to be available for openOCD to be able to run programs in various modes.

* FTDI board: similar to FT2232HL minimodule. Jumper wires for IO connections.

* PMOD extensions / LEDs / SD Card, if desired. 

### IO Connections on Z1

FT2232HL mini module connects USB to JTAG and UART. Pins are on top half arduino headers.

| JTAG Signal | FPGA Pin | FTDI Adapter Pin |
|-------------|----------|------------------|
| TDI         | CKIO_0   | BD1              |
| TDO         | CKIO_1   | BD2              |
| TMS         | CKIO_3   | BD3              |
| TCK         | CKIO_37  | BD0              |

| UART Signal | FPGA Pin | FTDI Adapter Pin  |
|-------------|----------|-------------------|
| RX          | CKIO_4   | AD0               |
| TX          | CKIO_5   | AD1               |

PMDO houses GPIO signals on one row and other is for triling analog IOs.

| GPIO |  PMOD |
|------|-------|
| 0    |  A    |
| 1    |  A    |
| 2    |  A    |
| 3    |  A    |
| 4    |  B    |
| 5    |  B    |
| 6    |  B    |
| 7    |  B    |

SPI signals from SoC use SPI adapter connections on FPGA board underside.

| SPI Signal  | FPGA Pin  | std SPI signals | QSPI signals |
|-------------|-----------|-----------------|--------------|
| DATA0       | CKIO_26   | MOSI            | DATA0        |
| DATA1       | CKIO_27   | MISO            | DATA1        |
| DATA2       | CKIO_28   | -               | DATA2        |
| DATA3       | CKIO_29   | -               | DATA3        |
| CSN0        | CKIO_MOSI | CS              | CS           |
| CSN1        | CKIO_MISO | -               | -            |
| SCK         | CKIO_SCLK | SCLK            | SCLK         |




## Source code requirements

While flow is automated, following special requirements should be noted.

### File type change

For vivado compiles, kactus2 generated files need to be defined as systemverilog, despite their file extension of .v (verilog). This is due to IPXACT definition for port type, which is tehnically not according to verilog standard (most tools do support it).

Easiest way to do this in Vivado:

set_property file_type SystemVerilog [get_files *.v]

Alternative is to define each file separately, but as all verilog is valid SystemVerilog, it is safe to do this.

### Includes

Open-source files require few directories set as include paths. These are defined in src/includes.list as well as start of reuse filelists (in comments). in Vivado these are specified in project settings in verilog options.

you can run following to set all:

set_property include_dirs {\<path to repository\>/Didactic-SoC/ips/axi/include \<path to repository\>/ips/common_cells/include \<path to repository\>/Didactic-SoC/ips/ibex/vendor/lowrisc_ip/ip/prim/rtl} [current_fileset]

set_property is_global_include true [get_files  \<path to repository\>/Didactic-SoC/ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_assert_dummy_macros.svh]

### Defines

when running on vivado sim or verilator, use 

set_property verilog_define VERILATOR=1 [current_fileset -simset]

(and if that is not enough then add set_property verilog_define XSIM=1 [current_fileset -simset])

This disables assertions and allows tools to elaborate the code.