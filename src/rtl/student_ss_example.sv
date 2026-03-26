//-----------------------------------------------------------------------------
// File          : student_ss_example.v
// Creation date : 15.02.2024
// Creation time : 15:31:23
// Description   :
// Created by    :
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
    * SyoSil
  Description:
    * example student area rtl code with off chip gpio interface
    * original interface created with kactus2. Do not rewrite from kactus.
    * Modified version of student_ss_1.sv
*/

module student_ss_example #(
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

    // Interface: IRQ
    output logic              irq_4,

    // Interface: Reset
    input  logic              reset_int,

    // Interface: ss_ctrl
    input logic               irq_en_4,
    input logic [7:0]         ss_ctrl_4,

    //Interface: GPIO pmod 0
    input  logic [3:0]        pmod_0_gpi,
    output logic [3:0]        pmod_0_gpo,
    output logic [3:0]        pmod_0_gpio_oe,

    //Interface: GPIO pmod 1
    input  logic [3:0]        pmod_1_gpi,
    output logic [3:0]        pmod_1_gpo,
    output logic [3:0]        pmod_1_gpio_oe
);

    // Registers
    logic PSLVERR_reg;
    logic [31:0] PRDATA_reg;
    logic PREADY_reg;

    logic [31:0] RW_REG;
    logic [31:0] GPIO_R_REG;
    logic [31:0] GPIO_W_REG;
    logic [31:0] SS_CTRL_REG;

    logic IRQ_REG;
    logic [15:0] COUNT_REG;

    always_ff @(posedge clk_in or negedge reset_int)
    begin: output_w_r
        if (~reset_int) begin
            PSLVERR_reg <=1'b0;
            PRDATA_reg  <='d0;
            PREADY_reg  <=1'b0;

            RW_REG <= 32'd0;
            GPIO_R_REG <= 32'd0;
            GPIO_W_REG <= 32'd0;
            IRQ_REG <= 32'd0;
            SS_CTRL_REG <= 32'd0;
            COUNT_REG <= 32'd0;

            pmod_0_gpio_oe <= 4'h0;
            pmod_1_gpio_oe <= 4'h0;
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
                else if(PWRITE) begin   // write
                    if(PADDR == 0) begin
                        RW_REG <= PWDATA;
                        PSLVERR_reg <= 1'b0;
                        PREADY_reg  <= 1'b1;
                    end
                    else if (PADDR == 8) begin
                        GPIO_W_REG <= PWDATA;
                        PSLVERR_reg <= 1'b0;
                        PREADY_reg  <= 1'b1;
                        pmod_0_gpio_oe <= 4'hf;
                        pmod_1_gpio_oe <= 4'hf;
                    end
                    else if (PADDR == 12) begin
                        SS_CTRL_REG <= PWDATA;
                        PSLVERR_reg <= 1'b0;
                        PREADY_reg  <= 1'b1;
                    end
                    else begin          // psel
                        PSLVERR_reg <= 1'b1;
                        PREADY_reg  <= 1'b1;
                    end
                end
                else begin              // read
                    if(PADDR == 0) begin
                        PRDATA_reg <= RW_REG;
                        PSLVERR_reg <= 1'b0;
                        PREADY_reg  <= 1'b1;
                    end
                    else if(PADDR == 4) begin
                        PRDATA_reg <= GPIO_R_REG;
                        PSLVERR_reg <= 1'b0;
                        PREADY_reg  <= 1'b1;
                        pmod_0_gpio_oe <= 4'h0;
                        pmod_1_gpio_oe <= 4'h0;
                    end
                    else if(PADDR == 12) begin
                        PRDATA_reg <= SS_CTRL_REG;
                        PSLVERR_reg <= 1'b0;
                        PREADY_reg  <= 1'b1;
                    end
                    else begin
                        PSLVERR_reg <= 1'b1;
                        PREADY_reg  <= 1'b1;
                    end
                end
            end
            else begin // psel
                PSLVERR_reg <= 1'b0;
                PREADY_reg  <= 1'b0;
            end

            // Update GPIO Registers according to PMOD output enable
            if (pmod_0_gpio_oe == 4'h0) begin
                GPIO_R_REG[3:0] <= pmod_0_gpi;
            end
            if (pmod_0_gpio_oe == 4'h0) begin
                GPIO_R_REG[7:4] <= pmod_1_gpi;
            end

            SS_CTRL_REG[7:0] <= ss_ctrl_4;

            // enable interrupt using IRQ_REG or update COUNT_REG
            if (irq_4 == 1'b0 && COUNT_REG >= 16'hA00) begin
                IRQ_REG <= 1'b1;
                COUNT_REG <= 32'h0;
            end else if (irq_4 == 1) begin
                IRQ_REG <= 32'h0;
            end else begin
                COUNT_REG <= pmod_0_gpi + COUNT_REG;
            end
        end

    end

    always_comb
    begin: output_assignment

        PSLVERR = PSLVERR_reg;
        PRDATA  = PRDATA_reg;
        PREADY  = PREADY_reg;

        // set irq pin high only if irq_en
        irq_4 = (IRQ_REG & irq_en_4);

        // Update GPO pins according to PMOD output enable
        if (pmod_0_gpio_oe == 4'hf) begin
            pmod_0_gpo = GPIO_W_REG [3:0];
        end

        if (pmod_0_gpio_oe == 4'hf) begin
            pmod_1_gpo = GPIO_W_REG [7:4];
        end

    end


/////// SVA /////////
`ifndef SYNTHESIS
// insert here unsynthesizeable verification assertions.
`endif


endmodule
