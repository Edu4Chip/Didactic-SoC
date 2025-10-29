//-----------------------------------------------------------------------------
// File          : student_ss_2.v
// Creation date : 22.04.2024
// Creation time : 14:06:50
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// Interface was originally generated based on IP-XACT component tuni.fi:subsystem:student_ss_2:1.0
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example student area tieoff code
*/

module student_ss_2(
    // Interface: APB
    input  logic [31:0] PADDR,
    input  logic        PENABLE,
    input  logic        PSEL,
    input  logic [31:0] PWDATA,
    input  logic        PWRITE,
    output logic [31:0] PRDATA,
    output logic        PREADY,
    output logic        PSLVERR,

    // Interface: Clock
    input  logic        clk_in,

    // Interface: high_speed_clock
    input  logic        high_speed_clk,

    // Interface: IRQ
    output logic        irq_2,

    // Interface: Reset
    input  logic        reset_int,

    // Interface: SS_Ctrl
    input  logic        irq_en_2,
    input  logic [7:0]  ss_ctrl_2,

    //Interface: GPIO pmod 0
    input  logic [15:0]  pmod_gpi,
    output logic [15:0]  pmod_gpo,
    output logic [15:0]  pmod_gpio_oe
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!

// this file contains minimal functionality to avoid breaking anything in other ends of the chip.

  assign PSLVERR = 'd0;
  assign PREADY  = 'd0;
  assign PRDATA  = 'd0;
  assign irq_2   = 'd0;

  assign pmod_gpo     = 'h0;
  assign pmod_gpio_oe = 'h0;

endmodule
