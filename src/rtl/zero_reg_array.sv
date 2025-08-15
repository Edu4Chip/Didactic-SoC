//-----------------------------------------------------------------------------
// File          : SS_Ctrl_reg_array.v
// Creation date : 23.02.2024
// Creation time : 12:38:00
// Description   :
// Created by    :
// Tool : Kactus2 3.13.1 64-bit
// Plugin : Verilog generator 2.4
// This file was generated based on IP-XACT component tuni.fi:ip:SS_Ctrl_reg_array:1.0
// whose XML file is C:/Users/kayra/Documents/repos/tau-ipxact/ipxact/tuni.fi/ip/SS_Ctrl_reg_array/1.0/SS_Ctrl_reg_array.1.0.xml
//-----------------------------------------------------------------------------
/*
  Contributors:
    * Matti Käyrä (matti.kayra@tuni.fi)
  Description:
    * copid from ss_ctrl_reg_array
*/


module zero_reg_array #(
    parameter AW = 32,
    parameter DW = 32
  )(

    // Interface: Clock
    input  logic clk,

    // Interface: Reset
    input  logic reset_n,

    // Interface: mem_reg_if
    input  logic [AW-1:0]   addr_i,
    input  logic [DW/8-1:0] be_i,
    input  logic            req_i,
    input  logic [DW-1:0]   wdata_i,
    input  logic            we_i,
    input  logic            rready_i,
    output logic [DW-1:0]   rdata_o,
    output logic            rvalid_o,
    output logic            rvalidpar_o,
    output logic            gnt_o,
    output logic            gntpar_o

);
  
  localparam NUM_REGS = 5;

  logic [NUM_REGS-1:0][31:0] generic_reg; 

  logic rvalid_reg;
  logic gnt_reg;
  logic [DW-1:0] rdata_out_reg;

    // FFs for write or read/write registers
    always_ff @( posedge clk or negedge reset_n )
    begin : control_register_ff
    if (~reset_n) begin

        for(int i=0; i < NUM_REGS; i++) begin
          generic_reg[i] <= 'h0;
        end


        rvalid_reg <= 1'b0;
        gnt_reg <= 1'b1;
        rdata_out_reg <= 'h0;
        
    end
    else begin

      // req - gnt handshake
      if(req_i & gnt_reg) begin
        gnt_reg <= 1'b0;
      end

      if (we_i & req_i & ~rvalid_reg) begin

        // io cell cfg
        for(int i=0; i < NUM_REGS; i++) begin
          if ( addr_i[15:0] == i*4) begin //
            generic_reg[i] <= wdata_i;
          end
        end

        rvalid_reg <= 1'b1;
      end
      else if(~we_i & req_i & ~rvalid_reg) begin 

        for(int i=0; i < NUM_REGS; i++) begin
          if ( addr_i[15:0] == i*4) begin // check 28 - 88
              rdata_out_reg <= generic_reg[i];
          end
        end

        rvalid_reg <= 1'b1;
      end
      else if(~rready_i & ~gnt_reg) begin
        rvalid_reg <= 1'b1;
      end
      else begin
        gnt_reg    <= 1'b1;
        rvalid_reg <= 1'b0;
      end
    end
  end // control_register_ff

  always_comb // 
  begin : comb_logic
    
    rvalid_o    = rvalid_reg;
    rvalidpar_o = ~rvalid_reg;
    gnt_o       = gnt_reg;
    gntpar_o    = ~gnt_reg;
    rdata_o     = rdata_out_reg;

end // comb_logic

endmodule
