/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * integration tieoff
*/

module imt_ss(
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
    output logic        irq_1,

    // Interface: Reset
    input  logic        reset_int,

    // Interface: SS_Ctrl
    input  logic        irq_en_1,
    input  logic [7:0]  ss_ctrl_1,
    
    //Interface: GPIO pmod 
    input  logic [15:0]  pmod_gpi,
    output logic [15:0]  pmod_gpo,
    output logic [15:0]  pmod_gpio_oe

);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!

// TODO: Replace this with your module implementation
  assign PSLVERR = 'd0;
  assign PREADY  = 'd0;
  assign PRDATA  = 'd0;
  assign irq_1   = 'd0;

  assign pmod_gpo     = 'h0;
  assign pmod_gpio_oe = 'h0;

endmodule
