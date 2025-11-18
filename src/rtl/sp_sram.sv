// Description: SRAM Behavioral Model / Xilinx FPGA memory

module sp_sram #(
  parameter              INIT_FILE  = "",
  parameter int unsigned DATA_WIDTH = 64,
  parameter int unsigned NUM_WORDS  = 1024,
  localparam             ADDR_WIDTH = $clog2(NUM_WORDS)
)(
  input  logic                    clk_i,
  input  logic                    rst_ni,

  input  logic                    req_i,
  input  logic                    we_i,
  input  logic                    rready_i,
  input  logic [  ADDR_WIDTH-1:0] addr_i,
  input  logic [  DATA_WIDTH-1:0] wdata_i,
  input  logic [DATA_WIDTH/8-1:0] be_i,
  output logic [  DATA_WIDTH-1:0] rdata_o,
  output logic                    rvalid_o,
  output logic                    rvalidpar_o,
  output logic                    gnt_o,
  output logic                    gntpar_o
);


  /******** PARITY *****************/
  logic rvalid_reg;
  logic gnt_reg;
  assign rvalid_o = rvalid_reg;
  assign rvalidpar_o = ~rvalid_reg;
  assign gnt_o = gnt_reg;
  assign gntpar_o = ~gnt_reg;

  /******* handshaking ********/

  always_ff @( posedge clk_i or negedge rst_ni )
  begin : control_register_ff
    if (~rst_ni) begin
      gnt_reg <= 1'b1;
      rvalid_reg <= 1'b0;
    end
    else begin
      if(req_i & gnt_reg) begin
        gnt_reg <= 1'b0;
        rvalid_reg <= 1'b1;
      end
      else if(~rready_i & ~gnt_reg) begin
        rvalid_reg <= 1'b1;
      end
      else begin
        gnt_reg <= 1'b1;
        rvalid_reg <= 1'b0;
      end
    end
  end //ff

`ifndef ASIC /************* SIM MODEL / FPGA INFERENCE *******************/

  logic [DATA_WIDTH-1:0] ram [NUM_WORDS-1:0];
  logic [ADDR_WIDTH-1:0] raddr_q;

  generate
    // if defined, preload simulation memory with external file
    initial begin
      if (INIT_FILE != "") begin: use_init_file
        $readmemh(INIT_FILE, ram);
      end
      else begin
        for (int ram_index = 0; ram_index < NUM_WORDS; ram_index++) begin
          ram[ram_index] = {DATA_WIDTH{1'b0}};
        end
      end
    end
  endgenerate

  always @(posedge clk_i or negedge rst_ni) begin
    if (~rst_ni) begin
        raddr_q <= 'h0;
    end 
    else begin
      if(req_i && !we_i)
        raddr_q <= addr_i;
    end
  end


  generate
    for (genvar i=0; i < DATA_WIDTH/8; i++) begin
      always @(posedge clk_i) begin
        if (req_i && we_i) begin
          if(be_i[i]) begin
            ram[addr_i][(i+1)*8-1:i*8]<= wdata_i[(i+1)*8-1:i*8];
          end
        end
      end
    end
  endgenerate

  assign rdata_o = ram[raddr_q];

`endif

endmodule
