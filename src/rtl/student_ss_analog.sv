/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example analog student area tieoff code
*/
module student_ss_analog #(
    parameter NUM_IO = 2
  )(

    // interface: analog_IO
    inout wire [NUM_IO-1:0] ana_core_out,
    inout wire [NUM_IO-1:0] ana_core_in

  );

  // minimal analog integration model
  assign ana_core_in  = 'd0;
  assign ana_core_out = 'd0;

endmodule