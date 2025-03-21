//-----------------------------------------------------------------------------
// File          : pmod_mux.v
// Creation date : 25.06.2024
// Creation time : 14:29:15
// Description   :
// Created by    :
// Tool : Kactus2 3.13.2 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:pmod_mux:1.0
// whose XML file is C:/Users/kayra/Documents/repos/Didactic-SoC/ipxact/tuni.fi/ip/pmod_mux/1.0/pmod_mux.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    *
*/

module pmod_mux #(
    parameter IOCELL_CFG_W     = 5,    // control bus width for each individual IO cell
    parameter IOCELL_COUNT     = 26,    // update this value manually to match cell numbers
    parameter NUM_GPIO         = 8
    )(
    // Interface: cell_cfg_from_core
    input  logic [IOCELL_COUNT*IOCELL_CFG_W-1:0] cell_cfg_from_core,

    // Interface: cell_cfg_to_io
    output logic [IOCELL_COUNT*IOCELL_CFG_W-1:0] cell_cfg_to_io,

    // Interface: gpio_core
    input  logic [NUM_GPIO-1:0] gpio_from_core,
    output logic [NUM_GPIO-1:0] gpio_to_core,

    // Interface: gpio_io
    input  logic [NUM_GPIO-1:0] gpio_from_io,
    output logic [NUM_GPIO-1:0] gpio_to_io,

    // Interface: pmod_sel
    input  logic [7:0]          pmod_sel,

    // Interface: ss_0_pmod_0
    input  logic [3:0]          ss_0_pmod_0_gpio_oe,
    input  logic [3:0]          ss_0_pmod_0_gpo,
    output logic [3:0]          ss_0_pmod_0_gpi,

    // Interface: ss_0_pmod_1
    input  logic [3:0]          ss_0_pmod_1_gpio_oe,
    input  logic [3:0]          ss_0_pmod_1_gpo,
    output logic [3:0]          ss_0_pmod_1_gpi,

    // Interface: ss_1_pmod_0
    input  logic [3:0]          ss_1_pmod_0_gpio_oe,
    input  logic [3:0]          ss_1_pmod_0_gpo,
    output logic [3:0]          ss_1_pmod_0_gpi,

    // Interface: ss_1_pmod_1
    input  logic [3:0]          ss_1_pmod_1_gpio_oe,
    input  logic [3:0]          ss_1_pmod_1_gpo,
    output logic [3:0]          ss_1_pmod_1_gpi,

    // Interface: ss_2_pmod_0
    input  logic [3:0]          ss_2_pmod_0_gpio_oe,
    input  logic [3:0]          ss_2_pmod_0_gpo,
    output logic [3:0]          ss_2_pmod_0_gpi,

    // Interface: ss_2_pmod_1
    input  logic [3:0]          ss_2_pmod_1_gpio_oe,
    input  logic [3:0]          ss_2_pmod_1_gpo,
    output logic [3:0]          ss_2_pmod_1_gpi,

    // Interface: ss_3_pmod_0
    input  logic [3:0]          ss_3_pmod_0_gpio_oe,
    input  logic [3:0]          ss_3_pmod_0_gpo,
    output logic [3:0]          ss_3_pmod_0_gpi,

    // Interface: ss_3_pmod_1
    input  logic [3:0]          ss_3_pmod_1_gpio_oe,
    input  logic [3:0]          ss_3_pmod_1_gpo,
    output logic [3:0]          ss_3_pmod_1_gpi
);

  // always direct gpi to controller core
  // disable inputs from subsystems not in use.
  assign gpio_to_core = gpio_from_io;

  always_comb mux_process : begin

    // connect all but gpio direction bit
    for(int i = 0; i < IOCELL_COUNT; i++) begin
      cell_cfg_to_io[(IOCELL_CFG_W*i+1)+:(IOCELL_CFG_W-1)] = cell_cfg_from_core[(IOCELL_CFG_W*i+1)+:(IOCELL_CFG_W-1)];
    end
    for(int i = NUM_GPIO; i < IOCELL_COUNT; i++) begin
      cell_cfg_to_io[IOCELL_CFG_W*i] = cell_cfg_from_core[IOCELL_CFG_W*i];
    end

    unique case(pmod_sel)

      0: begin
        gpio_to_io = {ss_0_pmod_1_gpo,ss_0_pmod_0_gpo};
        for(int i = 0; i < 4; i++) begin
          cell_cfg_to_io[i*IOCELL_CFG_W]                = ss_0_pmod_0_gpio_oe[i];
          cell_cfg_to_io[4*IOCELL_CFG_W+i*IOCELL_CFG_W] = ss_0_pmod_1_gpio_oe[i];
        end
        ss_0_pmod_0_gpi = gpio_from_io[3:0];
        ss_0_pmod_1_gpi = gpio_from_io[7:0];
        ss_1_pmod_0_gpi = 'h0;
        ss_1_pmod_1_gpi = 'h0;
        ss_2_pmod_0_gpi = 'h0;
        ss_2_pmod_1_gpi = 'h0;
        ss_3_pmod_0_gpi = 'h0;
        ss_3_pmod_1_gpi = 'h0;
      end

      1: begin
        gpio_to_io = {ss_1_pmod_1_gpo,ss_1_pmod_0_gpo};
        for(int i = 0; i < 4; i++) begin
          cell_cfg_to_io[i*IOCELL_CFG_W]                = ss_1_pmod_0_gpio_oe[i];
          cell_cfg_to_io[4*IOCELL_CFG_W+i*IOCELL_CFG_W] = ss_1_pmod_1_gpio_oe[i];
        end
        ss_0_pmod_0_gpi = 'h0;
        ss_0_pmod_1_gpi = 'h0;
        ss_1_pmod_0_gpi = gpio_from_io[3:0];
        ss_1_pmod_1_gpi = gpio_from_io[7:0];
        ss_2_pmod_0_gpi = 'h0;
        ss_2_pmod_1_gpi = 'h0;
        ss_3_pmod_0_gpi = 'h0;
        ss_3_pmod_1_gpi = 'h0;
      end

      2: begin
        gpio_to_io = {ss_2_pmod_1_gpo,ss_2_pmod_0_gpo};
        for(int i = 0; i < 4; i++) begin
          cell_cfg_to_io[i*IOCELL_CFG_W]                = ss_2_pmod_0_gpio_oe[i];
          cell_cfg_to_io[4*IOCELL_CFG_W+i*IOCELL_CFG_W] = ss_2_pmod_1_gpio_oe[i];
        end
        ss_0_pmod_0_gpi = 'h0;
        ss_0_pmod_1_gpi = 'h0;
        ss_1_pmod_0_gpi = 'h0;
        ss_1_pmod_1_gpi = 'h0;
        ss_2_pmod_0_gpi = gpio_from_io[3:0];
        ss_2_pmod_1_gpi = gpio_from_io[7:0];
        ss_3_pmod_0_gpi = 'h0;
        ss_3_pmod_1_gpi = 'h0;
      end

      3: begin
        gpio_to_io = {ss_3_pmod_1_gpo,ss_3_pmod_0_gpo};
        for(int i = 0; i < 4; i++) begin
          cell_cfg_to_io[i*IOCELL_CFG_W]                = ss_3_pmod_0_gpio_oe[i];
          cell_cfg_to_io[4*IOCELL_CFG_W+i*IOCELL_CFG_W] = ss_3_pmod_1_gpio_oe[i];
        end
        ss_0_pmod_0_gpi = 'h0;
        ss_0_pmod_1_gpi = 'h0;
        ss_1_pmod_0_gpi = 'h0;
        ss_1_pmod_1_gpi = 'h0;
        ss_2_pmod_0_gpi = 'h0;
        ss_2_pmod_1_gpi = 'h0;
        ss_3_pmod_0_gpi = gpio_from_io[3:0];
        ss_3_pmod_1_gpi = gpio_from_io[7:0];
      end

      default: begin
        gpio_to_io = gpio_from_core;
        for(int i = 0; i < 4; i++) begin
          cell_cfg_to_io[i*IOCELL_CFG_W]                = cell_cfg_from_core[i*IOCELL_CFG_W];
          cell_cfg_to_io[4*IOCELL_CFG_W+i*IOCELL_CFG_W] = cell_cfg_from_core[4*IOCELL_CFG_W+i*IOCELL_CFG_W];
        end
        ss_0_pmod_0_gpi = 'h0;
        ss_0_pmod_1_gpi = 'h0;
        ss_1_pmod_0_gpi = 'h0;
        ss_1_pmod_1_gpi = 'h0;
        ss_2_pmod_0_gpi = 'h0;
        ss_2_pmod_1_gpi = 'h0;
        ss_3_pmod_0_gpi = 'h0;
        ss_3_pmod_1_gpi = 'h0;
      end

    endcase

  end

endmodule
