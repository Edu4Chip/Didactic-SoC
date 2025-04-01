// Description: SRAM Behavioral Model / Xilinx FPGA memory

module sp_sram #(
  parameter              INIT_FILE  = "",
  parameter int unsigned DATA_WIDTH = 64,
  parameter int unsigned NUM_WORDS  = 1024
)(
  input  logic                         clk_i,
  input  logic                         rst_ni,

  input  logic                         req_i,
  input  logic                         we_i,
  input  logic                         rready_i,
  input  logic [$clog2(NUM_WORDS)-1:0] addr_i,
  input  logic [       DATA_WIDTH-1:0] wdata_i,
  input  logic [     DATA_WIDTH/8-1:0] be_i,
  output logic [       DATA_WIDTH-1:0] rdata_o,
  output logic                         rvalid_o,
  output logic                         rvalidpar_o,
  output logic                         gnt_o,
  output logic                         gntpar_o
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
      gnt_reg = 1'b1;
      rvalid_reg = 1'b0;
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

`else /****************************** FPGA MODEL ******************************/
/*
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
*/
   // BRAM_SINGLE_MACRO: Single Port RAM
   //                    Artix-7
   // Xilinx HDL Language Template, version 2024.2

   /////////////////////////////////////////////////////////////////////
   //  READ_WIDTH | BRAM_SIZE | READ Depth  | ADDR Width |            //
   // WRITE_WIDTH |           | WRITE Depth |            |  WE Width  //
   // ============|===========|=============|============|============//
   //    37-72    |  "36Kb"   |      512    |    9-bit   |    8-bit   //
   //    19-36    |  "36Kb"   |     1024    |   10-bit   |    4-bit   //
   //    19-36    |  "18Kb"   |      512    |    9-bit   |    4-bit   //
   //    10-18    |  "36Kb"   |     2048    |   11-bit   |    2-bit   //
   //    10-18    |  "18Kb"   |     1024    |   10-bit   |    2-bit   //
   //     5-9     |  "36Kb"   |     4096    |   12-bit   |    1-bit   //
   //     5-9     |  "18Kb"   |     2048    |   11-bit   |    1-bit   //
   //     3-4     |  "36Kb"   |     8192    |   13-bit   |    1-bit   //
   //     3-4     |  "18Kb"   |     4096    |   12-bit   |    1-bit   //
   //       2     |  "36Kb"   |    16384    |   14-bit   |    1-bit   //
   //       2     |  "18Kb"   |     8192    |   13-bit   |    1-bit   //
   //       1     |  "36Kb"   |    32768    |   15-bit   |    1-bit   //
   //       1     |  "18Kb"   |    16384    |   14-bit   |    1-bit   //
   /////////////////////////////////////////////////////////////////////

   logic [DATA_WIDTH/8-1:0] we_internal;

   for(genvar i = 0; i < DATA_WIDTH/8; i++) begin
    assign we_internal[i] = we_i & be_i[i];
   end

   BRAM_SINGLE_MACRO #(
      .BRAM_SIZE("18Kb"), // Target BRAM, "18Kb" or "36Kb" 
      .INIT_FILE ("NONE"),
      .WRITE_WIDTH(DATA_WIDTH), // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .READ_WIDTH(DATA_WIDTH)  // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
   ) BRAM_SINGLE_MACRO_inst (
      .DO(rdata_o),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(addr_i),   // Input address, width defined by read/write port depth
      .CLK(clk_i),     // 1-bit input clock
      .DI(wdata_i),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(1'b1),       // 1-bit input RAM enable
      .REGCE(1'b0), // 1-bit input output register enable
      .RST(rst_ni),     // 1-bit input reset
      .WE(we_internal)        // Input write enable, width defined by write port depth
   );

   // End of BRAM_SINGLE_MACRO_inst instantiation
	

`endif /***********************************************************************/

assign ruser_o = 1'b0;

endmodule
