//-----------------------------------------------------------------------------
// File          : APB_SDIO.v
// Creation date : 23.02.2024
// Creation time : 12:29:34
// Description   :
// Created by    :
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:pulp.peripheral:APB_SDIO:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/pulp.peripheral/APB_SDIO/1.0/APB_SDIO.1.0.xml
//-----------------------------------------------------------------------------

module APB_SDIO(
    // Interface: APB
    input                [31:0]         PADDR,
    input                               PENABLE,
    input                               PSEL,
    input                [31:0]         PWDATA,
    input                               PWRITE,
    output               [31:0]         PRDATA,
    output                              PREADY,
    output                              PSLVERR,

    // Interface: Reset_n
    input                               sys_clk_i,

    // Interface: SDIO
    input                [3:0]          sdio_data_i_internal,
    output                              sdio_clk_internal,
    output                              sdio_cmd_internal,
    output               [3:0]          sdio_data_o_internal,

    // There ports are contained in many interfaces
    input                               periph_clk_i,

    // These ports are not in any interface
    input                               rst_n_i,
    input                               sdcmd_i,
    input                [3:0]          sddata_i,
    input                               sdio_init_disable_i,
    output                              eot_o,
    output                              err_o,
    output                              sdclk_o,
    output                              sdcmd_o,
    output                              sdcmd_oen_o,
    output               [3:0]          sddata_o,
    output               [3:0]          sddata_oen_o
  );


  // WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!

  // assign all outputs here as 0 for placeholder desing to compile.


endmodule
