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
    * Antti Nurmi (antti.nurmi@tuni.fi)
  Description:
    * example student area rtl code without io cells
    * original interface created with kactus2. Do not rewrite from kactus.
*/

`ifdef VERILATOR
  `include "verification/verilator/src/hdl/nms/Student_area_0.sv"
`endif

module Student_area_0 #(
    parameter APB_AW = 12,
    parameter APB_DW = 32
  )(
    // Interface: APB
    input  logic [APB_AW-1:0] PADDR,
    input  logic              PENABLE,
    input  logic              PSEL,
    input  logic [APB_DW-1:0] PWDATA,
    input  logic              PWRITE,
    output logic [APB_DW-1:0] PRDATA,
    output logic              PREADY,
    output logic              PSLVERR,

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

// T2.1: How many parallel matmul units are required
//       to parallelize one convolution in our application?
localparam int unsigned NrMatMul = 0;

// T2.2: Declare signals for two input and one output buffers
//       to feed and consume from the matmul units. Hardware
//       buffer size should be optimized; what is the minimal
//       ammount of stored data required for *one* convolution?
//
//       IMPORTANT! APB bus accesses are simplest to implement
//       if the base element width (Y) is alligned with APB_DW
//       where convenient.

// logic [X-1:0][Y-1:0] *_buffer_d, *_buffer_q;


// T2.3: Register buffer signals.
always_ff @( posedge clk_in or negedge rst )
  begin
    if (~rst) begin
    end else begin
    end
  end

always_comb
  begin : apb_access
    // T2.4: Implement combinational APB access to the previously
    //       declared buffers.
    //
    //       Mandatory: Write access to input buffers, read access from output.
    //       Optional: Read access to input buffers.
    //
    //       Some tips:
    //         - Assign all signals driven by this process a sensible default
    //           value right at the start of the block, override in conditional
    //           statements. For an overview of the APB protocol, see:
    //           https://documentation-service.arm.com/static/60d5b505677cf7536a55c245?token=
    //         - Address decoding is best implemented with `case`-statements. To match ranges
    //           rather than single values, try
    //           ```
    //              unique case (<switch>) inside
    //                 [RangeStart:RangeEnd]: begin
    //                     ...
    //                 end
    //           ```
  end


generate

  logic [NrMatMul-1:0][31:0] window;

  for (genvar i=0; i<NrMatMul; i++)
    begin : g_conv
      // T2.5: The 2x2 * 2x2 matmul unit expects operand bytes to be supplied
      //       as follows:
      //           operand_*_i = {B3, B2, B1, B0}; <-> | B3, B2 |
      //                                               | B1, B0 |
      //
      //       Following the reference algorithm, implement the windowing
      //       of the input matrix here by assigning the appropriate slices
      //       to `window[i]`, used as one of the matmul inputs.

      // assign window[i] = ...

      // T2.5: Assign operand_b_i, result_o to appropriate buffers.
      matmul #(
      ) i_matmul (
        .clk_i       (clk_in),
        .rst_ni      (rst),
        .operand_a_i (window[i]),
        .operand_b_i (),
        .result_o    ()
      );
    end

endgenerate

// Temporary tieoffs
assign PREADY  = PENABLE & PSEL;
assign PSLVERR = 'h0;

assign irq = 0;

assign pmod_0_gpo = 0;
assign pmod_1_gpo = 0;

assign pmod_0_gpio_oe = 0;
assign pmod_1_gpio_oe = 0;

endmodule
