`include "axi/assign.svh"

module didactic_student_domain #(
    parameter int unsigned AxiAddrWidth = 32'd12,
    parameter int unsigned AxiDataWidth = 32'd32
) (
    input  logic         clk_i,
    input  logic         rst_ni,
    output logic         irq_o,
           AXI_BUS.Slave axi_s
);

  localparam int unsigned NumMasters = 3;
  localparam int unsigned NumSlaves = 4;
  localparam int unsigned NumMems = 4;
  localparam int unsigned AxiIdWidthMasters = 5;
  // AXI configuration which is automatically derived.
  localparam int unsigned AxiIdWidthSlaves = AxiIdWidthMasters + $clog2(NumMasters);
  localparam int unsigned AxiStrbWidth = AxiDataWidth / 8;
  localparam int unsigned AxiUserWidth = 5;

  typedef axi_pkg::xbar_rule_32_t rule_t;

  localparam axi_pkg::xbar_cfg_t XbarCfg = '{
      NoSlvPorts: NumMasters,
      NoMstPorts: NumSlaves,
      MaxMstTrans: 10,
      MaxSlvTrans: 6,
      FallThrough: 1'b0,
      LatencyMode: axi_pkg::CUT_ALL_AX,
      AxiIdWidthSlvPorts: AxiIdWidthMasters,
      AxiIdUsedSlvPorts: AxiIdWidthMasters,
      UniqueIds: 1'b0,
      AxiAddrWidth: AxiAddrWidth,
      AxiDataWidth: AxiDataWidth,
      NoAddrRules: NumSlaves
  };

  localparam rule_t [NumSlaves-1:0] AddrMap = {
    rule_t'{idx: 0, start_addr: 32'h01050000, end_addr: 32'h01052000},
    rule_t'{idx: 1, start_addr: 32'h01052000, end_addr: 32'h01054000},
    rule_t'{idx: 2, start_addr: 32'h01054000, end_addr: 32'h01055000},
    rule_t'{idx: 3, start_addr: 32'h01055000, end_addr: 32'h01056000}
  };

  logic [NumMems-1:0]                       req;
  logic [NumMems-1:0]                       we;
  logic [NumMems-1:0][(AxiDataWidth/8)-1:0] be;
  logic [NumMems-1:0][    AxiDataWidth-1:0] wdata;
  logic [NumMems-1:0][    AxiDataWidth-1:0] rdata;
  logic [NumMems-1:0][    AxiAddrWidth-1:0] addr;

  AXI_BUS #(
      .AXI_ADDR_WIDTH(AxiAddrWidth),
      .AXI_DATA_WIDTH(AxiDataWidth),
      .AXI_ID_WIDTH  (AxiIdWidthMasters),
      .AXI_USER_WIDTH(AxiUserWidth)
  ) master[NumMasters-1:0] ();

  AXI_BUS #(
      .AXI_ADDR_WIDTH(AxiAddrWidth),
      .AXI_DATA_WIDTH(AxiDataWidth),
      .AXI_ID_WIDTH  (AxiIdWidthSlaves),
      .AXI_USER_WIDTH(AxiUserWidth)
  ) slave[NumSlaves-1:0] ();

  axi_xbar_intf #(
      .Cfg   (XbarCfg),
      .AXI_USER_WIDTH (AxiUserWidth),
      .rule_t(rule_t)
  ) i_xbar (
      .clk_i,
      .rst_ni,
      .test_i(1'b0),
      .slv_ports(master),
      .mst_ports(slave),
      .addr_map_i(AddrMap)
  );

  `AXI_ASSIGN(master[0], axi_s)

  axi2mem #(
      .AXI_ID_WIDTH  (AxiIdWidthSlaves),
      .AXI_ADDR_WIDTH(AxiAddrWidth),
      .AXI_DATA_WIDTH(AxiDataWidth),
      .AXI_USER_WIDTH(AxiUserWidth)
  ) i_src_mem_if (
      .clk_i,
      .rst_ni,
      .slave (slave[0]),
      .req_o (req[0]),
      .we_o  (we[0]),
      .addr_o(addr[0]),
      .be_o  (be[0]),
      .data_o(wdata[0]),
      .data_i(rdata[0])
  );

  axi2mem #(
      .AXI_ID_WIDTH  (AxiIdWidthSlaves),
      .AXI_ADDR_WIDTH(AxiAddrWidth),
      .AXI_DATA_WIDTH(AxiDataWidth),
      .AXI_USER_WIDTH(AxiUserWidth)
  ) i_dst_mem_if (
      .clk_i,
      .rst_ni,
      .slave (slave[1]),
      .req_o (req[1]),
      .we_o  (we[1]),
      .addr_o(addr[1]),
      .be_o  (be[1]),
      .data_o(wdata[1]),
      .data_i(rdata[1])
  );

  tc_sram #(
      .NumWords (2048),
      .DataWidth(AxiDataWidth),
      .NumPorts (1),
      .Latency  (1),
      .SimInit  ("random")
  ) i_src_sram (
      .clk_i,
      .rst_ni,
      .req_i  (req[0]),
      .we_i   (we[0]),
      .be_i   (be[0]),
      .addr_i (addr[0][12:3]),
      .wdata_i(wdata[0]),
      .rdata_o(rdata[0])
  );
  tc_sram #(
      .NumWords (2048),
      .DataWidth(AxiDataWidth),
      .NumPorts (1),
      .Latency  (1),
      .SimInit  ("zeros")
  ) i_dst_sram (
      .clk_i,
      .rst_ni,
      .req_i  (req[1]),
      .we_i   (we[1]),
      .be_i   (be[1]),
      .addr_i (addr[1][12:3]),
      .wdata_i(wdata[1]),
      .rdata_o(rdata[1])
  );


endmodule : didactic_student_domain

