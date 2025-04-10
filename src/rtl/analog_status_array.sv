/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * status registers for analog system
*/

module analog_status_array(
    // Interface: APB
    input  logic         [15:0]         PADDR,
    input  logic                        PENABLE,
    input  logic                        PSEL,
    input  logic         [3:0]          PSTRB,
    input  logic         [31:0]         PWDATA,
    input  logic                        PWRITE,
    output logic         [31:0]         PRDATA,
    output logic                        PREADY,
    output logic                        PSLVERR,

    // Interface: clk
    input  logic                        clk_in,

    // Interface: reset
    input  logic                        reset_n,

    // Interface: status_0
    input                [31:0]         status_0,

    // Interface: status_1
    input                [31:0]         status_1,

    // Interface: status_2
    input                [31:0]         status_2,

    // Interface: status_3
    input                [31:0]         status_3
);

  // APB out regs
  logic PSLVERR_reg;
  logic [31:0] PRDATA_reg;
  logic PREADY_reg;

  logic [31:0 ]status_0_reg;
  logic [31:0] status_1_reg;
  logic [31:0] status_2_reg;
  logic [31:0] status_3_reg;

  always_ff @(posedge clk_in or negedge reset_n)
  apb_proc: begin
    if (~reset_n) begin
      status_0_reg = 'h0;
      status_1_reg = 'h0;
    end
    else begin
        if(PSEL) begin
            if (PREADY_reg == 1 && PSLVERR_reg == 1 ) begin
              PSLVERR_reg <= 1'b0;
              PREADY_reg <= 1'b0;
            end
            else if (PREADY_reg == 1) begin
              PREADY_reg <= 1'b0;
            end
            else if (PWRITE) begin
                PREADY_reg  <= 1'b1;
                PSLVERR_reg <= 1'b1;
            end
            else if (~PWRITE) begin    
                if (PADDR == 0) begin
                    PRDATA_reg <= status_0_reg;
                    PSLVERR_reg <= 1'b0;
                    PREADY_reg  <= 1'b1;
                end
                else if (PADDR == 4) begin
                    PRDATA_reg <= status_1_reg;
                    PSLVERR_reg <= 1'b0;
                    PREADY_reg  <= 1'b1;
                end
                else if (PADDR == 8) begin
                    PRDATA_reg <= status_2_reg;
                    PSLVERR_reg <= 1'b0;
                    PREADY_reg  <= 1'b1;
                end
                else if (PADDR == 12) begin
                    PRDATA_reg <= status_3_reg;
                    PSLVERR_reg <= 1'b0;
                    PREADY_reg  <= 1'b1;
                end
                else begin
                    PSLVERR_reg <= 1'b1;
                    PREADY_reg  <= 1'b1;
                end
            end
        end
        else begin
          PSLVERR_reg <= 1'b0;
          PREADY_reg  <= 1'b0;
        end
    end
  end
  assign PSLVERR = PSLVERR_reg;
  assign PRDATA  = PRDATA_reg;
  assign PREADY  = PREADY_reg;

endmodule
