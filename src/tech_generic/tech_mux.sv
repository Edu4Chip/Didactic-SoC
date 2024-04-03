/*
  Project: Edu4Chip
  Module(s): tech_mux
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * simulation model for multiplexer
*/

module tech_mux (
    input  logic a, 
    input  logic b, 
    input  logic s,
    output logic z
  );

  assign z = s ? b : a;

endmodule