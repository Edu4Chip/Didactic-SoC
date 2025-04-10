/*
  Project: Edu4Chip
  Module(s): tech_not
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * simulation model for inverter
*/

module tech_not (
    input  logic a,
    output logic z
  );

  assign z = ~a;

endmodule