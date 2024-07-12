/*
  ibex_axi_bridge.sv
  memory to AXI lite master port converter

  authors: Antti Nurmi    <antti.nurmi@tuni.fi>
           Tom Szymkowiak <thomas.szymkowiak@tuni.fi>
*/
module ibex_axi_bridge #(
  /* NOTE: Limitation exists that IBEX DW/AW must be larger or equal to the
     respective AXI AW/DW. i.e. AXI CANNOT be wider than IBEX */
  parameter int AXI_AW  = 16,
  parameter int AXI_DW  = 32,
  parameter int IBEX_AW = 32,
  parameter int IBEX_DW = 32
)(
  input  logic                  clk_i,
  input  logic                  rst_ni,
  // ibex side          
  input  logic                  req_i,
  output logic                  gnt_o,
  output logic                  rvalid_o,
  input  logic                  we_i,
  input  logic [           3:0] be_i,
  input  logic [   IBEX_AW-1:0] addr_i,
  input  logic [   IBEX_DW-1:0] wdata_i,
  output logic [   IBEX_DW-1:0] rdata_o,
  output logic                  err_o,
  // AXI side
  output logic [    AXI_AW-1:0] aw_addr_o,
  output logic                  aw_valid_o,
  input  logic                  aw_ready_i,

  output logic [    AXI_DW-1:0] w_data_o,
  output logic [(AXI_DW/8)-1:0] w_strb_o,
  output logic                  w_valid_o,
  input  logic                  w_ready_i,

  input  logic [           1:0] b_resp_i,
  input  logic                  b_valid_i,
  output logic                  b_ready_o,

  output logic [    AXI_AW-1:0] ar_addr_o,
  output logic                  ar_valid_o,
  input  logic                  ar_ready_i,

  input  logic [    AXI_DW-1:0] r_data_i,
  input  logic [           1:0] r_resp_i,
  input  logic                  r_valid_i,
  output logic                  r_ready_o
);

`ifdef VERILATOR
`include "verification/verilator/src/common.v"
`INCREMENT_CYCLE_COUNT(clk_i)
`endif

enum logic [3:0] {
  IDLE,
  READ_START,
  AR_HANDSHAKE,
  R_HANDSHAKE,
  WRITE_START,
  AW_HANDSHAKE,
  W_HANDSHAKE,
  WRITE_RESPONSE,
  WRITE_END,
  READ_END //,
  //DELAY
} curr_state, next_state;

logic sel_rdata;

//for now direct assignment
assign w_strb_o = be_i;

always_ff @(posedge(clk_i) or negedge(rst_ni)) 
  begin : state_reg
    if(~rst_ni) begin
      curr_state <= IDLE;
    end
    else begin
      curr_state <= next_state;
    end
  end // state_reg

always_ff @(posedge(clk_i) or negedge(rst_ni))
  begin : update_reg
    if(~rst_ni) begin
      rdata_o <= '0;
    end
    else begin
      rdata_o <= (sel_rdata) ? r_data_i : rdata_o;
    end
  end // update_reg

always_comb 
  begin : main_comb

    next_state = IDLE;
    gnt_o      =  0;
    rvalid_o   =  0;
    err_o      =  0;
    aw_addr_o  = '0;
    aw_valid_o =  0;
    w_data_o   = '0;
    w_valid_o  =  0;
    b_ready_o  = '0;
    ar_addr_o  = '0;
    ar_valid_o =  0;
    r_ready_o  =  0;
    sel_rdata  =  0;

    case (curr_state)
      IDLE: begin 
        if (req_i & ~we_i)
          next_state = READ_START;
        else if (req_i & we_i) begin
          next_state = WRITE_START;
        end
        else
	        next_state = IDLE;
        end
      READ_START: begin
        ar_addr_o  = addr_i[AXI_AW-1:0];
        ar_valid_o =  1;
        r_ready_o  =  1;
        if (ar_ready_i)
          next_state = AR_HANDSHAKE;
	      else
	        next_state = READ_START;
        end
      AR_HANDSHAKE: begin
        sel_rdata  =  1;
        ar_addr_o  = addr_i[AXI_AW-1:0];
        r_ready_o  =  1;
        if (r_valid_i)
          next_state = R_HANDSHAKE;
	      else
	        next_state = AR_HANDSHAKE;
        end
      R_HANDSHAKE: begin
        err_o      = r_resp_i[1];
        //rvalid_o   = 1;
        gnt_o      = 1;
        next_state = READ_END;
        end
      READ_END: begin
        rvalid_o   = 1;
        next_state = IDLE;
        end
      WRITE_START: begin
        aw_addr_o  = addr_i[AXI_AW-1:0];
        w_data_o   = wdata_i;
        aw_valid_o = 1;
        w_valid_o  = 1;
        b_ready_o  = 1;
        if (aw_ready_i && w_ready_i)
          next_state = W_HANDSHAKE;
        else if (aw_ready_i)
          next_state = AW_HANDSHAKE;
	      else
	        next_state = WRITE_START;
        end
      AW_HANDSHAKE: begin
        w_data_o   = wdata_i;
        w_valid_o  = 1;
        b_ready_o  = 1;
        aw_addr_o  = addr_i[AXI_AW-1:0];
        if (w_ready_i)
          next_state = W_HANDSHAKE;
	      else
	        next_state = AW_HANDSHAKE;
        end
      W_HANDSHAKE: begin
        b_ready_o  = 1;
        aw_addr_o  = addr_i[AXI_AW-1:0];
        if (b_valid_i) begin
          next_state = WRITE_END; 
          gnt_o      =  1;
        end
	      else
	        next_state = W_HANDSHAKE;
        end
      WRITE_END: begin
        next_state = IDLE; 
        rvalid_o   =    1;
        end
      default: begin
        end

      endcase
    end // main_comb
endmodule : ibex_axi_bridge
