//-----------------------------------------------------------------------------
// File          : Student_area_0.v
// Creation date : 15.02.2024
// Creation time : 14:58:02
// Description   : 
// Created by    : 
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:Student_area_0:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/tuni.fi/ip/Student_area_0/1.0/Student_area_0.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * example student area rtl code without io cells
    * original interface created with kactus2. Do not rewrite from kactus.
*/

module Student_area_0 #(
    parameter APB_AW = 12,
    parameter APB_DW = 32
  )(
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

    // Interface: IRQ
    output logic              irq,

    // Interface: SS_Ctrl
    input  logic [7:0]        clk_ctrl,
    input  logic              irq_en,

    // Interface: clk
    input  logic              clk_in,

    // Interface: high_speed_clock
    input  logic              high_speed_clk,

    // Interface: reset
    input  logic              rst,

    //Interface: GPIO pmod 0
    input  logic [3:0]        pmod_0_gpi,
    output logic [3:0]        pmod_0_gpo,
    output logic [3:0]        pmod_0_gpio_oe,

    //Interface: GPIO pmod 1
    input  logic [3:0]        pmod_1_gpi,
    output logic [3:0]        pmod_1_gpo,
    output logic [3:0]        pmod_1_gpio_oe
);

  logic PSLVERR_reg      ;
  logic [31:0] PRDATA_reg;
  logic PREADY_reg       ;
  logic [31:0] field_0   ;

  always_ff @(posedge clk_in or negedge rst)
  output_w_r: begin
    if (~rst) begin
      PSLVERR_reg <=  1'b0;
      PRDATA_reg  <=   'd0;
      PREADY_reg  <=  1'b0;
      field_0     <= 32'd0;

    end
    else begin

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
  end

  assign irq            = 1'b0;
  assign pmod_1_gpo     = 3'h0;
  assign pmod_1_gpio_oe = 3'h0;
  assign pmod_0_gpo     = 3'h0;
  assign pmod_0_gpio_oe = 3'h0;

/////// SVA /////////

`ifndef SYNTHESIS
// insert here unsynthesizeable verification assertions.
`endif


endmodule
