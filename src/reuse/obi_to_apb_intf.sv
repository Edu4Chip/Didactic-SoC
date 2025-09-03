// Copyright 2020 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Nils Wistoff <nwistoff@iis.ee.ethz.ch>
// Antti Nurmi <antti.nurmi@tuni.fi>
// Matti Käyrä <matti.kayra@tuni.fi>
// Adapted from reg_to_apb.sv
// copied here form: https://github.com/soc-hub-fi/Atalanta/blob/main/src/ip/obi_to_apb_intf.sv
// 

module obi_to_apb_intf #(
  )(
    input  logic        clk_i,
    input  logic        rst_ni,
    OBI_BUS.Subordinate obi_i,
    APB.Master          apb_o
  );
  
    // APB phase FSM
    typedef enum logic [1:0] {SETUP, ACCESS, HANDSHAKE} state_e;
    state_e state_d, state_q;

    logic [31:0] data;
    logic err;
  
    // Feed these through.
    assign apb_o.paddr  = obi_i.addr;
    assign apb_o.pwrite = obi_i.we;
    assign apb_o.pwdata = obi_i.wdata;
    assign apb_o.psel   = obi_i.req;
    assign apb_o.pstrb  = obi_i.be;
  
    assign obi_i.err    = err;
    assign obi_i.rdata  = data;
  
    // Tie PPROT to {0: unprivileged, 1: non-secure, 0: data}
    assign apb_o.pprot   = 3'b010;
  
    // APB phase FSM
    always_comb begin : apb_fsm
      apb_o.penable  = 1'b0;
      obi_i.gnt      = 1'b0;
      obi_i.rvalid   = 1'b0;
      state_d           = state_q;
      unique case (state_q)
        // Setup phase (or idle). Deassert PENABLE, gate PREADY.
        SETUP: if (obi_i.req) state_d = ACCESS;
        // Access phase. Assert PENABLE, feed PREADY through.
        ACCESS: begin
          apb_o.penable = 1'b1;
          obi_i.gnt   = apb_o.pready;
          if (apb_o.pready) state_d = HANDSHAKE;
        end
        HANDSHAKE: begin
          obi_i.rvalid = 1'b1;
          state_d = (obi_i.req) ? ACCESS : SETUP;
        end
        // We should never reach this state.
        default: state_d = SETUP;
      endcase
    end
  
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        state_q <= SETUP;
        data <= 32'b0;
        err <= 1'b0;
      end else begin
        state_q <= state_d;
        data <= apb_o.prdata;
        err <= apb_o.pslverr;
      end
    end
  
  endmodule : obi_to_apb_intf