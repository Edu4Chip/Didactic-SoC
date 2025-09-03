/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example analog student area tieoff code
*/
module student_ss_analog #(
  )(

    // interface: analog_IO
    inout wire [1:0] ana_core_in,
    inout wire [2:0] ana_core_out,
    inout wire [1:0] ana_core_io,

    // interface: status_0
    output wire [31:0] status_0,

    // interface: status_1
    output wire [31:0] status_1,

    // interface: status_2
    output wire [31:0] status_2,

    // interface: status_3
    output wire [31:0] status_3
  );

  // minimal analog integration model
  assign ana_core_in  = 'd0;
  assign ana_core_out = 'd0;
  assign ana_core_io  = 'd0;

  assign status_0 = 'h0;
  assign status_1 = 'h1;
  assign status_2 = 'h2;
  assign status_3 = 'h3;

endmodule