//-----------------------------------------------------------------------------
// File          : Student_SS_3.v
// Creation date : 23.04.2024
// Creation time : 12:45:24
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:Student_SS_3:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/subsystem/Student_SS_3/1.0/Student_SS_3.1.0.xml
//-----------------------------------------------------------------------------

`ifdef VERILATOR
    `include "verification/verilator/src/hdl/nms/Student_SS_3.sv"
`endif

module Student_SS_3(
    // Interface: APB
    input  logic         [31:0]         PADDR,
    input  logic                        PENABLE,
    input  logic                        PSEL,
    input  logic         [31:0]         PWDATA,
    input  logic                        PWRITE,
    output logic         [31:0]         PRDATA,
    output logic                        PREADY,
    output logic                        PSLVERR,

    // Interface: Clock
    input  logic                        clk_in,

    // Interface: IRQ
    output logic                        irq_3,

    // Interface: Reset
    input  logic                        reset_int,

    // Interface: SS_Ctrl
    input  logic                        irq_en_3,
    input  logic         [7:0]          ss_ctrl_3,
    
    //Interface: GPIO pmod 0
    input  logic [3:0] pmod_0_gpi,
    output logic [3:0] pmod_0_gpo,
    output logic [3:0] pmod_0_gpio_oe,

    //Interface: GPIO pmod 1
    input  logic [3:0] pmod_1_gpi,
    output logic [3:0] pmod_1_gpo,
    output logic [3:0] pmod_1_gpio_oe
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
`ifdef VERILATOR
    `include "verification/verilator/src/hdl/ms/Student_SS_3.sv"
`endif

// TODO: Replace this with your module implementation
assign PSLVERR = 'd0;
assign PREADY = 'd0;
assign PRDATA  = 'd0;
assign irq_3     = 'd0;


assign pmod_1_gpo =  3'h0;
assign pmod_1_gpio_oe = 3'h0;
assign pmod_0_gpo  = 3'h0;
assign pmod_0_gpio_oe = 3'h0;


endmodule
