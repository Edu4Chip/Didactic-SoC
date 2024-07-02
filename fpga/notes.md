## xilinx vivado

### file type change

For vivado compiles, kactus2 generated files need to be defined as systemverilog, despite their file extension of .v (verilog). This is due to IPXACT definition for port type, which is tehnically not according to verilog standard (most tools do support it).

Easiest way to do this in Vivado:

set_property file_type SystemVerilog [get_files *.v]

Alternative is to define each file separately, but as all verilog is valid SystemVerilog, it is safe to do this.

### includes

Open-source files require few directories set as include paths. These are defined in src/includes.list as well as start of reuse filelists (in comments). in Vivado these are specified in project settings in verilog options.

you can run following to set all:

set_property include_dirs {\<path to repository\>/Didactic-SoC/ips/axi/include \<path to repository\>/ips/common_cells/include \<path to repository\>/Didactic-SoC/ips/ibex/vendor/lowrisc_ip/ip/prim/rtl} [current_fileset]

set_property is_global_include true [get_files  \<path to repository\>/Didactic-SoC/ips/ibex/vendor/lowrisc_ip/ip/prim/rtl/prim_assert_dummy_macros.svh]

### memory defines

As improvement on FPGA, memories will be inferred as BRAMs. Currently this does set the correct memory type for all FPGAs.


### top level

set_property top tb_didactic [get_filesets sim_1]


### defines

when running on vivado sim or verilator, use 

set_property verilog_define VERILATOR=1 [current_fileset -simset]

(and if that is not enough then add set_property verilog_define XSIM=1 [current_fileset -simset])


This disables assertions and allows tools to elaborate the code.