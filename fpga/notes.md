## xilinx vivado

### file type change

For vivado compiles, kactus files need to be defined as systemverilog, despite their file extension of .v (verilog). This is due to IPXACT definition for port type, which is tehnically not according to verilog standard (most tools do support it)

easiest way to do this 

set_property file_type SystemVerilog [get_files *.v]

alternative is to define each file separately, but as all verilog is valid SystemVerilog, it is safe to do this.

### includes

Open-source files require few directories set as include paths. These are defined in src/includes.list as well as start of reuse filelists (in comments). in Vivado these are specified in project settings in verilog options.

### memory defines

Later memories will be inferred as BRAMs. Currently this does set the correcr memory type for all FPGAs.