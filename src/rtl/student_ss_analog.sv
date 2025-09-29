/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example analog student area tieoff code
*/
module student_ss_analog #(
  )(
    //Interface: GPIO pmod 
    input  logic [15:0]  pmod_gpi,
    output logic [15:0]  pmod_gpo,
    output logic [15:0]  pmod_gpio_oe  
  );

  assign pmod_gpio_oe = 'b0;
  assign pmod_gpio = 'b0;

  analog_block inst (
    .control(pmod_gpi)
  );

endmodule

module analog_block (
    input  logic [15:0]  control
  );
  // black box module, will be replaced during backend flow 
  // with actual analog block
  // the block's analog IOs will be handled by the block 
  // and are not passed through the digital part
endmodule
