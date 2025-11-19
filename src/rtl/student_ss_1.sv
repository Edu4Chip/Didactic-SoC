//-----------------------------------------------------------------------------
// File          : student_ss_1.v
// Creation date : 15.02.2024
// Creation time : 15:31:23
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// Interface was originally generated based on IP-XACT component tuni.fi:subsystem:student_ss_1:1.0
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example student area rtl code with off chip gpio interface 
    * original interface created with kactus2. Do not rewrite from kactus.
*/

module student_ss_1 #(
    parameter                 APB_AW  = 10,
    parameter                 APB_DW  = 32
) (
    // Interface: APB
    input  logic [APB_AW-1:0]   PADDR,
    input  logic                PENABLE,
    input  logic                PSEL,
    input  logic [APB_DW-1:0]   PWDATA,
    input  logic                PWRITE,
    input  logic [APB_DW/8-1:0] PSTRB,
    output logic [APB_DW-1:0]   PRDATA,
    output logic                PREADY,
    output logic                PSLVERR,

    // Interface: Clock
    input  logic              clk_in,

    // Interface: high_speed_clock
    input  logic              high_speed_clk,

    // Interface: IRQ
    output logic              irq_1,

    // Interface: Reset
    input  logic              reset_int,

    // Interface: ss_ctrl
    input  logic              irq_en_1,
    input  logic [7:0]        ss_ctrl_1,
    
    //Interface: GPIO pmod
    input  logic [15:0]        pmod_gpi,
    output logic [15:0]        pmod_gpo,
    output logic [15:0]        pmod_gpio_oe
);

  logic [31:0] field_0;
  logic [31:0] field_1;
  logic PSLVERR_reg;
  logic [31:0] PRDATA_reg;
  logic PREADY_reg;

  always_ff @(posedge clk_in or negedge reset_int)
   begin: output_w_r
    if (~reset_int) begin
      PSLVERR_reg <=1'b0;
      PRDATA_reg  <='d0;
      PREADY_reg  <=1'b0;
      field_0 <= 32'd0;
      field_1 <= 32'd0;

    end
    else begin
      field_1[15:8] <= pmod_gpi[15:8];


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
    begin : output_assignment

    PSLVERR <= PSLVERR_reg;
    PRDATA  <= PRDATA_reg;
    PREADY  <= PREADY_reg;

    pmod_gpo <= field_0 [7:0];

  end

  assign irq_1 = 1'b0;
  // set as always outs
  assign pmod_gpio_oe[7:0] = 8'h0;
  // set as always ins
  assign pmod_gpio_oe[15:8] = 8'hF;

  //tieoff rest of pmod outputs as it is not in use
  assign pmod_gpo[15:8] = 8'h0;  

/////// SVA /////////

`ifndef SYNTHESIS
// insert here unsynthesizeable verification assertions.
`endif


endmodule
