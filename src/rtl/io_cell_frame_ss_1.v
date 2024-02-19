//-----------------------------------------------------------------------------
// File          : io_cell_frame_ss_1.v
// Creation date : 19.02.2024
// Creation time : 10:17:58
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem.io:io_cell_frame_ss_1:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/tuni.fi/subsystem.io/io_cell_frame_ss_1/1.0/io_cell_frame_ss_1.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example student area io cell file
*/
module io_cell_frame_ss_1 #(
    parameter                              IOCELL_CFG_W     = 5,
    parameter                              IOCELL_COUNT     = 2
) (
    // Interface: GPIO_external
    inout                [1:0]          gpio,

    // Interface: GPIO_internal
    input                [1:0]          gpio_oe,
    input                [1:0]          gpo_in,
    output               [1:0]          gpi_out,

    // These ports are not in any interface
    input                [IOCELL_CFG_W*IOCELL_COUNT-1:0] io_cell_cfg
);

// if desirable, combine oe from Student system here

// gpio
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_gpio0(.FROM_CORE(gpo_in[0]), .TO_CORE(gpi_out[0]), .PAD(gpio[0]), .io_cell_cfg(cell_cfg[1*IOCELL_CFG_W-1:0*IOCELL_CFG_W]));
io_cell_wrapper#(.CELL_TYPE(0), .IOCELL_CFG_W(IOCELL_CFG_W)) i_io_cell_gpio1(.FROM_CORE(gpo_in[1]), .TO_CORE(gpi_out[1]), .PAD(gpio[1]), .io_cell_cfg(cell_cfg[2*IOCELL_CFG_W-1:1*IOCELL_CFG_W]));

endmodule
