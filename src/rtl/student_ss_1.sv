//-----------------------------------------------------------------------------
// File          : student_ss_1.v
// Creation date : 15.02.2024
// Creation time : 15:31:23
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:subsystem:student_ss_1:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/tuni.fi/subsystem/student_ss_1/1.0/student_ss_1.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example student area rtl code with off chip gpio interface 
    * original interface created with kactus2. Do not rewrite from kactus.
*/

`ifdef VERILATOR
  `include "verification/verilator/src/hdl/nms/student_ss_1.sv"
`endif

module student_ss_1 #(
    parameter                 APB_AW  = 10,
    parameter                 APB_DW  = 32
) (
    // Interface: APB
    input  logic [APB_AW-1:0] PADDR,
    input  logic              PENABLE,
    input  logic              PSEL,
    input  logic [APB_DW-1:0] PWDATA,
    input  logic              PWRITE,
    output logic [APB_DW-1:0] PRDATA,
    output logic              PREADY,
    output logic              PSLVERR,

    // Interface: Clock
    input  logic              clk_in,

    // Interface: IRQ
    output logic              irq_1,

    // Interface: Reset
    input  logic              reset_int,

    // Interface: ss_ctrl
    input logic              irq_en_1,
    input logic [7:0]        ss_ctrl_1,
    
    //Interface: GPIO pmod 0
    input  logic [3:0] pmod_0_gpi,
    output logic [3:0] pmod_0_gpo,
    output logic [3:0] pmod_0_gpio_oe,

    //Interface: GPIO pmod 1
    input  logic [3:0] pmod_1_gpi,
    output logic [3:0] pmod_1_gpo,
    output logic [3:0] pmod_1_gpio_oe
);
  `ifdef VERILATOR
    `include "verification/verilator/src/hdl/ms/student_ss_1.sv"
  `endif

  logic [31:0] field_0;
  logic [31:0] field_1;
  logic PSLVERR_reg;
  logic [31:0] PRDATA_reg;
  logic PREADY_reg;

  always_ff @(posedge clk_in or negedge reset_int)
  output_w_r: begin
    if (~reset_int) begin
      PSLVERR_reg <=1'b0;
      PRDATA_reg  <='d0;
      PREADY_reg  <=1'b0;
      field_0 <= 32'd0;
      field_1 <= 32'd0;

    end
    else begin
      field_1[7:4] <= pmod_1_gpi;


      if(PSEL) begin
        //if access already happened, cut the response signals
        if (PREADY_reg == 1 && PSLVERR_reg == 1 ) begin
          PSLVERR_reg <= 1'b0;
          // error signal does not require it's own process as it
          // can't be without ready
          PREADY_reg <= 1'b0;
        end
        else if (PREADY_reg == 1) begin
          PREADY_reg <= 1'b0;
        end
        else if(PWRITE) begin // write 
            if(PADDR == 0) begin
              field_0 <= PWDATA;
              PSLVERR_reg <= 1'b0;
              PREADY_reg  <= 1'b1;
            end
            else begin // psel
                PSLVERR_reg <= 1'b0;
                PREADY_reg  <= 1'b0;
            end
        end
        else begin // read
            if(PADDR == 0) begin
              PRDATA_reg <= field_0;
              PSLVERR_reg <= 1'b0;
              PREADY_reg  <= 1'b1;
            end
            if(PADDR == 4) begin
              PRDATA_reg <= field_1;
              PSLVERR_reg <= 1'b0;
              PREADY_reg  <= 1'b1;
            end
        end
      end
      else begin // psel
        PSLVERR_reg <= 1'b0;
        PREADY_reg  <= 1'b0;
      end
    end
  end

  always_comb
    output_assignment : begin

    PSLVERR <= PSLVERR_reg;
    PRDATA  <= PRDATA_reg;
    PREADY  <= PREADY_reg;

    pmod_0_gpo <= field_0 [3:0];
  end

assign irq = 1'b0;
// set as always outs
assign pmod_0_gpio_oe = 4'h0;
// set as always ins
assign pmod_1_gpio_oe = 4'hF;


/////// SVA /////////

`ifndef SYNTHESIS
// insert here unsynthesizeable verification assertions.
`endif


endmodule
