// Description: 
// This is not actual bootrom, but a placeholder.
// it is direct copy of sp_sram.sv present in this folder.
// once architecture and boot details are designed
// this will be replaced by actual bootrom or removed in
//case we want to only rely on the jtag based boot

`ifdef VERILATOR
  `include "verification/verilator/src/hdl/nms/BootRom.sv"
`endif

module BootRom #(
  parameter              INIT_FILE  = "",
  parameter int unsigned DATA_WIDTH = 64,
  parameter int unsigned NUM_WORDS  = 1024
)(
  input  logic                         clk_i,
  input  logic                         rst_ni,

  input  logic                         req_i,
  input  logic                         we_i,
  input  logic [$clog2(NUM_WORDS)-1:0] addr_i,
  input  logic [       DATA_WIDTH-1:0] wdata_i,
  input  logic [ (DATA_WIDTH+7)/8-1:0] be_i,
  output logic [       DATA_WIDTH-1:0] rdata_o,
  // ports for compatability only
  output logic                         ruser_o,
  input  logic                         wuser_i
);
`ifdef VERILATOR
  `include "verification/verilator/src/hdl/ms/BootRom.sv"
`endif

`ifndef FPGA /************************* ASIC SIM MODEL ****************************/

  localparam ADDR_WIDTH = $clog2(NUM_WORDS);

  logic [DATA_WIDTH-1:0] 		    be_s;
  logic [DATA_WIDTH-1:0] 		    ram [NUM_WORDS-1:0];
  logic [ADDR_WIDTH-1:0] 		    raddr_q;
   
  genvar i;
  generate
    for (i = 0; i < (DATA_WIDTH+7)/8; i++) begin
	    if (i == (DATA_WIDTH+7)/8-1) begin
	      assign be_s[DATA_WIDTH-1:i*8] = {(DATA_WIDTH-i*8){be_i[i]}};
	    end else begin
	       assign be_s[(i+1)*8-1 : i*8] = {8{be_i[i]}};
	    end
    end
  endgenerate

  generate

    initial begin
      for (int ram_index = 0; ram_index < NUM_WORDS; ram_index = ram_index + 1)
        ram[ram_index] = {DATA_WIDTH{1'b0}};

      if (INIT_FILE != "") begin: use_init_file
       $readmemh(INIT_FILE, ram);
      end
    end     
    
  endgenerate

  always @(posedge clk_i or negedge rst_ni) begin
  if (~rst_ni) begin
	    raddr_q <= '0;
  end else begin
    if (req_i) begin
      if (!we_i)
        raddr_q <= addr_i;
      else
        for (int i = 0; i < DATA_WIDTH; i++)
          if (be_s[i]) ram[addr_i][i] <= wdata_i[i];
      end
    end
  end

  assign rdata_o = ram[raddr_q];
  assign r_user_o = 1'b0;

`else /****************************** FPGA MODEL ******************************/

  xilinx_sp_BRAM #(
    .RAM_WIDTH ( DATA_WIDTH ),
    .RAM_DEPTH ( NUM_WORDS  ),
    .INIT_FILE ( INIT_FILE  )
  ) i_xilinx_sp_bram (
    .addra ( addr_i  ),      
    .dina  ( wdata_i ),     
    .clka  ( clk_i   ),     
    .wea   ( we_i    ),    
    .ena   ( 1'b1    ),    
    .douta ( rdata_o )    
  );

`endif /***********************************************************************/

endmodule
