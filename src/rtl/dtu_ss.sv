//-----------------------------------------------------------------------------
// File          : dtu_ss
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:student_ss_2:1.0
// whose XML file is C:/Users/kayra/Documents/repos/didactic-soc/ipxact/tuni.fi/subsystem/student_ss_2/1.0/student_ss_2.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * 
*/

module dtu_ss(
    // Interface: APB
    input  logic [31:0] PADDR,
    input  logic        PENABLE,
    input  logic        PSEL,
    input  logic [31:0] PWDATA,
    input  logic        PWRITE,
    input  logic  [3:0] PSTRB,
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
    output logic [15:0]  pmod_gpio_oe,

);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!

  tech_not i_tech_not (.a(reset_int),
                       .z(reset_pos));

  reg [1:0] reset_sync;
  always_ff @(posedge clk_in) reset_sync <= {reset_sync[0], reset_pos};



  DtuSubsystem dtu(
    .clock(clk_in),
    .reset(reset_sync[1]),
    .io_apb_psel(PSEL),
    .io_apb_paddr(PADDR),
    .io_apb_penable(PENABLE),
    .io_apb_pwdata(PWDATA),
    .io_apb_pwrite(PWRITE),
    .io_apb_prdata(PRDATA),
    .io_apb_pready(PREADY),
    .io_apb_pslverr(PSLVERR),
    .io_apb_pstrb(PSTRB),
    .io_irq(irq_2),
    .io_irqEn(irq_en_2),
    .io_ssCtrl(ss_ctrl_2),
    .io_pmod_0_gpi(pmod_gpi[3:0]),
    .io_pmod_0_gpo(pmod_gpo[3:0]),
    .io_pmod_0_oe(pmod_gpio_oe[3:0]),
    .io_pmod_1_gpi(pmod_gpi[7:4]),
    .io_pmod_1_gpo(pmod_gpo[7:4]),
    .io_pmod_1_oe(pmod_gpio_oe[7:4])
  );

  assign pmod_gpo[15:8] = 'h0;

endmodule
