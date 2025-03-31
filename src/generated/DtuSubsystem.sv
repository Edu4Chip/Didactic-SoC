module SystemControl(
  input         clock,
  input         reset,
  input         apbPort_psel,
  input         apbPort_penable,
  input         apbPort_pwrite,
  input  [31:0] apbPort_pwdata,
  output        apbPort_pready,
  output [31:0] apbPort_prdata,
  output        ctrlPort_lerosReset,
  output        ctrlPort_lerosBootFromRam
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  lerosResetReg; // @[SystemControl.scala 15:30]
  reg  lerosBootFromRamReg; // @[SystemControl.scala 16:36]
  wire [1:0] _apbPort_prdata_T = {lerosBootFromRamReg,lerosResetReg}; // @[Cat.scala 33:92]
  assign apbPort_pready = apbPort_psel & apbPort_penable; // @[SystemControl.scala 24:21]
  assign apbPort_prdata = {{30'd0}, _apbPort_prdata_T}; // @[SystemControl.scala 20:18]
  assign ctrlPort_lerosReset = lerosResetReg; // @[SystemControl.scala 17:23]
  assign ctrlPort_lerosBootFromRam = lerosBootFromRamReg; // @[SystemControl.scala 18:29]
  always @(posedge clock) begin
    if (reset) begin // @[SystemControl.scala 15:30]
      lerosResetReg <= 1'h0; // @[SystemControl.scala 15:30]
    end else if (apbPort_psel & apbPort_penable) begin // @[SystemControl.scala 24:41]
      if (apbPort_pwrite) begin // @[SystemControl.scala 28:26]
        lerosResetReg <= apbPort_pwdata[0]; // @[SystemControl.scala 29:21]
      end
    end
    if (reset) begin // @[SystemControl.scala 16:36]
      lerosBootFromRamReg <= 1'h0; // @[SystemControl.scala 16:36]
    end else if (apbPort_psel & apbPort_penable) begin // @[SystemControl.scala 24:41]
      if (apbPort_pwrite) begin // @[SystemControl.scala 28:26]
        lerosBootFromRamReg <= apbPort_pwdata[1]; // @[SystemControl.scala 30:27]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lerosResetReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  lerosBootFromRamReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Rx(
  input        clock,
  input        reset,
  input        io_rxd,
  input        io_channel_ready,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[UARTRx.scala 34:30]
  reg  rxReg; // @[UARTRx.scala 34:22]
  reg  falling_REG; // @[UARTRx.scala 35:35]
  wire  falling = ~rxReg & falling_REG; // @[UARTRx.scala 35:24]
  reg [7:0] shiftReg; // @[UARTRx.scala 37:25]
  reg [19:0] cntReg; // @[UARTRx.scala 38:23]
  reg [3:0] bitsReg; // @[UARTRx.scala 39:24]
  reg  valReg; // @[UARTRx.scala 40:23]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[UARTRx.scala 43:22]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[UARTRx.scala 47:24]
  wire  _GEN_0 = bitsReg == 4'h1 | valReg; // @[UARTRx.scala 49:27 50:14 40:23]
  assign io_channel_valid = valReg; // @[UARTRx.scala 62:20]
  assign io_channel_bits = shiftReg; // @[UARTRx.scala 61:19]
  always @(posedge clock) begin
    if (reset) begin // @[UARTRx.scala 34:30]
      rxReg_REG <= 1'h0; // @[UARTRx.scala 34:30]
    end else begin
      rxReg_REG <= io_rxd; // @[UARTRx.scala 34:30]
    end
    if (reset) begin // @[UARTRx.scala 34:22]
      rxReg <= 1'h0; // @[UARTRx.scala 34:22]
    end else begin
      rxReg <= rxReg_REG; // @[UARTRx.scala 34:22]
    end
    falling_REG <= rxReg; // @[UARTRx.scala 35:35]
    if (reset) begin // @[UARTRx.scala 37:25]
      shiftReg <= 8'h0; // @[UARTRx.scala 37:25]
    end else if (!(cntReg != 20'h0)) begin // @[UARTRx.scala 42:24]
      if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
        shiftReg <= _shiftReg_T_1; // @[UARTRx.scala 46:14]
      end
    end
    if (reset) begin // @[UARTRx.scala 38:23]
      cntReg <= 20'h8; // @[UARTRx.scala 38:23]
    end else if (cntReg != 20'h0) begin // @[UARTRx.scala 42:24]
      cntReg <= _cntReg_T_1; // @[UARTRx.scala 43:12]
    end else if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
      cntReg <= 20'h8; // @[UARTRx.scala 45:12]
    end else if (falling) begin // @[UARTRx.scala 52:23]
      cntReg <= 20'hb; // @[UARTRx.scala 53:12]
    end
    if (reset) begin // @[UARTRx.scala 39:24]
      bitsReg <= 4'h0; // @[UARTRx.scala 39:24]
    end else if (!(cntReg != 20'h0)) begin // @[UARTRx.scala 42:24]
      if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
        bitsReg <= _bitsReg_T_1; // @[UARTRx.scala 47:13]
      end else if (falling) begin // @[UARTRx.scala 52:23]
        bitsReg <= 4'h8; // @[UARTRx.scala 54:13]
      end
    end
    if (reset) begin // @[UARTRx.scala 40:23]
      valReg <= 1'h0; // @[UARTRx.scala 40:23]
    end else if (valReg & io_channel_ready) begin // @[UARTRx.scala 57:36]
      valReg <= 1'h0; // @[UARTRx.scala 58:12]
    end else if (!(cntReg != 20'h0)) begin // @[UARTRx.scala 42:24]
      if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
        valReg <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  falling_REG = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  shiftReg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  cntReg = _RAND_4[19:0];
  _RAND_5 = {1{`RANDOM}};
  bitsReg = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  valReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] shiftReg; // @[UARTTx.scala 29:25]
  reg [3:0] cntReg; // @[UARTTx.scala 30:23]
  reg [3:0] bitsReg; // @[UARTTx.scala 31:24]
  wire  _io_channel_ready_T = cntReg == 4'h0; // @[UARTTx.scala 33:31]
  wire [9:0] shift = shiftReg[10:1]; // @[UARTTx.scala 40:28]
  wire [10:0] _shiftReg_T_1 = {1'h1,shift}; // @[UARTTx.scala 41:23]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[UARTTx.scala 42:26]
  wire [10:0] _shiftReg_T_3 = {2'h3,io_channel_bits,1'h0}; // @[UARTTx.scala 45:49]
  wire [3:0] _cntReg_T_1 = cntReg - 4'h1; // @[UARTTx.scala 50:22]
  assign io_txd = shiftReg[0]; // @[UARTTx.scala 34:21]
  assign io_channel_ready = cntReg == 4'h0 & bitsReg == 4'h0; // @[UARTTx.scala 33:40]
  always @(posedge clock) begin
    if (reset) begin // @[UARTTx.scala 29:25]
      shiftReg <= 11'h7ff; // @[UARTTx.scala 29:25]
    end else if (_io_channel_ready_T) begin // @[UARTTx.scala 36:24]
      if (bitsReg != 4'h0) begin // @[UARTTx.scala 38:27]
        shiftReg <= _shiftReg_T_1; // @[UARTTx.scala 41:16]
      end else if (io_channel_valid) begin // @[UARTTx.scala 43:34]
        shiftReg <= _shiftReg_T_3; // @[UARTTx.scala 45:18]
      end
    end
    if (reset) begin // @[UARTTx.scala 30:23]
      cntReg <= 4'h0; // @[UARTTx.scala 30:23]
    end else if (_io_channel_ready_T) begin // @[UARTTx.scala 36:24]
      if (bitsReg != 4'h0) begin // @[UARTTx.scala 38:27]
        cntReg <= 4'h8; // @[UARTTx.scala 39:14]
      end else if (io_channel_valid) begin // @[UARTTx.scala 43:34]
        cntReg <= 4'h8; // @[UARTTx.scala 44:16]
      end
    end else begin
      cntReg <= _cntReg_T_1; // @[UARTTx.scala 50:12]
    end
    if (reset) begin // @[UARTTx.scala 31:24]
      bitsReg <= 4'h0; // @[UARTTx.scala 31:24]
    end else if (_io_channel_ready_T) begin // @[UARTTx.scala 36:24]
      if (bitsReg != 4'h0) begin // @[UARTTx.scala 38:27]
        bitsReg <= _bitsReg_T_1; // @[UARTTx.scala 42:15]
      end else if (io_channel_valid) begin // @[UARTTx.scala 43:34]
        bitsReg <= 4'hb; // @[UARTTx.scala 46:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shiftReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PonteEscaper(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  output       io_valid,
  output       io_startRead,
  output       io_startWrite,
  output [7:0] io_data,
  input        io_stall
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  escaped; // @[PonteEscaper.scala 23:24]
  wire  isEscape = io_in_bits == 8'h5a; // @[PonteEscaper.scala 24:29]
  wire  _GEN_0 = escaped & io_in_valid ? 1'h0 : escaped; // @[PonteEscaper.scala 28:38 29:13 23:24]
  wire  _GEN_1 = isEscape & io_in_valid | _GEN_0; // @[PonteEscaper.scala 26:33 27:13]
  wire [5:0] _io_data_T = escaped ? 6'h20 : 6'h0; // @[PonteEscaper.scala 35:30]
  wire [7:0] _GEN_2 = {{2'd0}, _io_data_T}; // @[PonteEscaper.scala 35:25]
  assign io_in_ready = ~io_stall; // @[PonteEscaper.scala 37:18]
  assign io_valid = isEscape ? 1'h0 : io_in_valid; // @[PonteEscaper.scala 32:18]
  assign io_startRead = io_in_bits == 8'hab; // @[PonteEscaper.scala 33:30]
  assign io_startWrite = io_in_bits == 8'haa; // @[PonteEscaper.scala 34:31]
  assign io_data = io_in_bits ^ _GEN_2; // @[PonteEscaper.scala 35:25]
  always @(posedge clock) begin
    escaped <= reset | _GEN_1; // @[PonteEscaper.scala 23:{24,24}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  escaped = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PonteDecoder(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input  [7:0]  io_in_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [7:0]  io_out_bits,
  output [15:0] io_apb_paddr,
  output        io_apb_psel,
  output        io_apb_penable,
  output        io_apb_pwrite,
  output [31:0] io_apb_pwdata,
  input         io_apb_pready,
  input  [31:0] io_apb_prdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  dec_clock; // @[PonteDecoder.scala 28:19]
  wire  dec_reset; // @[PonteDecoder.scala 28:19]
  wire  dec_io_in_ready; // @[PonteDecoder.scala 28:19]
  wire  dec_io_in_valid; // @[PonteDecoder.scala 28:19]
  wire [7:0] dec_io_in_bits; // @[PonteDecoder.scala 28:19]
  wire  dec_io_valid; // @[PonteDecoder.scala 28:19]
  wire  dec_io_startRead; // @[PonteDecoder.scala 28:19]
  wire  dec_io_startWrite; // @[PonteDecoder.scala 28:19]
  wire [7:0] dec_io_data; // @[PonteDecoder.scala 28:19]
  wire  dec_io_stall; // @[PonteDecoder.scala 28:19]
  reg [2:0] stateReg; // @[PonteDecoder.scala 35:25]
  reg [1:0] cntReg; // @[PonteDecoder.scala 36:23]
  reg [15:0] addrReg; // @[PonteDecoder.scala 37:24]
  reg  isWriteReg; // @[PonteDecoder.scala 38:27]
  reg [7:0] readLenReg; // @[PonteDecoder.scala 39:27]
  reg [31:0] dataReg; // @[PonteDecoder.scala 40:24]
  wire [2:0] _GEN_0 = dec_io_startWrite ? 3'h2 : stateReg; // @[PonteDecoder.scala 62:39 63:20 35:25]
  wire [2:0] _GEN_1 = dec_io_startRead ? 3'h1 : _GEN_0; // @[PonteDecoder.scala 60:32 61:20]
  wire [2:0] _GEN_2 = dec_io_valid ? _GEN_1 : stateReg; // @[PonteDecoder.scala 35:25 59:26]
  wire [2:0] _GEN_3 = dec_io_valid ? 3'h2 : stateReg; // @[PonteDecoder.scala 70:26 71:18 35:25]
  wire [1:0] _cntReg_T_1 = cntReg - 2'h1; // @[PonteDecoder.scala 76:26]
  wire [15:0] _addrReg_T_1 = {dec_io_data,addrReg[15:8]}; // @[Cat.scala 33:92]
  wire  _T_9 = cntReg == 2'h0; // @[PonteDecoder.scala 78:21]
  wire [2:0] _stateReg_T = isWriteReg ? 3'h3 : 3'h4; // @[PonteDecoder.scala 79:26]
  wire [2:0] _GEN_4 = cntReg == 2'h0 ? _stateReg_T : stateReg; // @[PonteDecoder.scala 78:30 79:20 35:25]
  wire [1:0] _GEN_5 = cntReg == 2'h0 ? 2'h3 : _cntReg_T_1; // @[PonteDecoder.scala 76:16 78:30 80:18]
  wire [1:0] _GEN_6 = dec_io_valid ? _GEN_5 : cntReg; // @[PonteDecoder.scala 36:23 75:26]
  wire [15:0] _GEN_7 = dec_io_valid ? _addrReg_T_1 : addrReg; // @[PonteDecoder.scala 75:26 77:17 37:24]
  wire [2:0] _GEN_8 = dec_io_valid ? _GEN_4 : stateReg; // @[PonteDecoder.scala 35:25 75:26]
  wire [31:0] _dataReg_T_1 = {dec_io_data,dataReg[31:8]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_9 = _T_9 ? 3'h4 : stateReg; // @[PonteDecoder.scala 88:30 89:20 35:25]
  wire [1:0] _GEN_10 = dec_io_valid ? _cntReg_T_1 : cntReg; // @[PonteDecoder.scala 85:26 86:16 36:23]
  wire [31:0] _GEN_11 = dec_io_valid ? _dataReg_T_1 : dataReg; // @[PonteDecoder.scala 85:26 87:17 40:24]
  wire [2:0] _GEN_12 = dec_io_valid ? _GEN_9 : stateReg; // @[PonteDecoder.scala 35:25 85:26]
  wire [15:0] _addrReg_T_3 = addrReg + 16'h4; // @[PonteDecoder.scala 105:28]
  wire [2:0] _stateReg_T_1 = isWriteReg ? 3'h3 : 3'h6; // @[PonteDecoder.scala 106:24]
  wire [31:0] _GEN_13 = io_apb_pready ? io_apb_prdata : dataReg; // @[PonteDecoder.scala 103:27 104:17 40:24]
  wire [15:0] _GEN_14 = io_apb_pready ? _addrReg_T_3 : addrReg; // @[PonteDecoder.scala 103:27 105:17 37:24]
  wire [2:0] _GEN_15 = io_apb_pready ? _stateReg_T_1 : stateReg; // @[PonteDecoder.scala 103:27 106:18 35:25]
  wire [2:0] _GEN_16 = _T_9 ? 3'h7 : stateReg; // @[PonteDecoder.scala 115:30 116:20 35:25]
  wire [31:0] _GEN_17 = io_out_ready ? {{8'd0}, dataReg[31:8]} : dataReg; // @[PonteDecoder.scala 112:26 113:17 40:24]
  wire [1:0] _GEN_18 = io_out_ready ? _cntReg_T_1 : cntReg; // @[PonteDecoder.scala 112:26 114:16 36:23]
  wire [2:0] _GEN_19 = io_out_ready ? _GEN_16 : stateReg; // @[PonteDecoder.scala 112:26 35:25]
  wire [7:0] _readLenReg_T_1 = readLenReg - 8'h1; // @[PonteDecoder.scala 122:32]
  wire [2:0] _stateReg_T_3 = readLenReg == 8'h0 ? 3'h0 : 3'h4; // @[PonteDecoder.scala 123:22]
  wire [7:0] _GEN_21 = 3'h7 == stateReg ? _readLenReg_T_1 : readLenReg; // @[PonteDecoder.scala 122:18 54:20 39:27]
  wire [2:0] _GEN_22 = 3'h7 == stateReg ? _stateReg_T_3 : stateReg; // @[PonteDecoder.scala 123:16 54:20 35:25]
  wire  _GEN_23 = 3'h6 == stateReg | 3'h7 == stateReg; // @[PonteDecoder.scala 110:20 54:20]
  wire [31:0] _GEN_25 = 3'h6 == stateReg ? _GEN_17 : dataReg; // @[PonteDecoder.scala 54:20 40:24]
  wire [1:0] _GEN_26 = 3'h6 == stateReg ? _GEN_18 : cntReg; // @[PonteDecoder.scala 54:20 36:23]
  wire [2:0] _GEN_27 = 3'h6 == stateReg ? _GEN_19 : _GEN_22; // @[PonteDecoder.scala 54:20]
  wire [7:0] _GEN_28 = 3'h6 == stateReg ? readLenReg : _GEN_21; // @[PonteDecoder.scala 54:20 39:27]
  wire  _GEN_29 = 3'h5 == stateReg | _GEN_23; // @[PonteDecoder.scala 54:20 99:20]
  wire [1:0] _GEN_31 = 3'h5 == stateReg ? 2'h3 : _GEN_26; // @[PonteDecoder.scala 102:14 54:20]
  wire [31:0] _GEN_32 = 3'h5 == stateReg ? _GEN_13 : _GEN_25; // @[PonteDecoder.scala 54:20]
  wire [15:0] _GEN_33 = 3'h5 == stateReg ? _GEN_14 : addrReg; // @[PonteDecoder.scala 54:20 37:24]
  wire [2:0] _GEN_34 = 3'h5 == stateReg ? _GEN_15 : _GEN_27; // @[PonteDecoder.scala 54:20]
  wire  _GEN_35 = 3'h5 == stateReg ? 1'h0 : 3'h6 == stateReg; // @[PonteDecoder.scala 49:16 54:20]
  wire [7:0] _GEN_36 = 3'h5 == stateReg ? readLenReg : _GEN_28; // @[PonteDecoder.scala 54:20 39:27]
  wire  _GEN_37 = 3'h4 == stateReg | _GEN_29; // @[PonteDecoder.scala 54:20 94:20]
  wire  _GEN_38 = 3'h4 == stateReg | 3'h5 == stateReg; // @[PonteDecoder.scala 54:20 95:19]
  wire [2:0] _GEN_39 = 3'h4 == stateReg ? 3'h5 : _GEN_34; // @[PonteDecoder.scala 54:20 96:16]
  wire  _GEN_40 = 3'h4 == stateReg ? 1'h0 : 3'h5 == stateReg; // @[PonteDecoder.scala 43:18 54:20]
  wire [1:0] _GEN_41 = 3'h4 == stateReg ? cntReg : _GEN_31; // @[PonteDecoder.scala 54:20 36:23]
  wire [31:0] _GEN_42 = 3'h4 == stateReg ? dataReg : _GEN_32; // @[PonteDecoder.scala 54:20 40:24]
  wire [15:0] _GEN_43 = 3'h4 == stateReg ? addrReg : _GEN_33; // @[PonteDecoder.scala 54:20 37:24]
  wire  _GEN_44 = 3'h4 == stateReg ? 1'h0 : _GEN_35; // @[PonteDecoder.scala 49:16 54:20]
  wire [7:0] _GEN_45 = 3'h4 == stateReg ? readLenReg : _GEN_36; // @[PonteDecoder.scala 54:20 39:27]
  wire [1:0] _GEN_46 = 3'h3 == stateReg ? _GEN_10 : _GEN_41; // @[PonteDecoder.scala 54:20]
  wire [31:0] _GEN_47 = 3'h3 == stateReg ? _GEN_11 : _GEN_42; // @[PonteDecoder.scala 54:20]
  wire [2:0] _GEN_48 = 3'h3 == stateReg ? _GEN_12 : _GEN_39; // @[PonteDecoder.scala 54:20]
  wire  _GEN_49 = 3'h3 == stateReg ? 1'h0 : _GEN_37; // @[PonteDecoder.scala 52:16 54:20]
  wire  _GEN_50 = 3'h3 == stateReg ? 1'h0 : _GEN_38; // @[PonteDecoder.scala 42:15 54:20]
  wire  _GEN_51 = 3'h3 == stateReg ? 1'h0 : _GEN_40; // @[PonteDecoder.scala 43:18 54:20]
  wire [15:0] _GEN_52 = 3'h3 == stateReg ? addrReg : _GEN_43; // @[PonteDecoder.scala 54:20 37:24]
  wire  _GEN_53 = 3'h3 == stateReg ? 1'h0 : _GEN_44; // @[PonteDecoder.scala 49:16 54:20]
  wire [7:0] _GEN_54 = 3'h3 == stateReg ? readLenReg : _GEN_45; // @[PonteDecoder.scala 54:20 39:27]
  wire [1:0] _GEN_55 = 3'h2 == stateReg ? _GEN_6 : _GEN_46; // @[PonteDecoder.scala 54:20]
  wire [2:0] _GEN_57 = 3'h2 == stateReg ? _GEN_8 : _GEN_48; // @[PonteDecoder.scala 54:20]
  wire  _GEN_59 = 3'h2 == stateReg ? 1'h0 : _GEN_49; // @[PonteDecoder.scala 52:16 54:20]
  wire  _GEN_60 = 3'h2 == stateReg ? 1'h0 : _GEN_50; // @[PonteDecoder.scala 42:15 54:20]
  wire  _GEN_61 = 3'h2 == stateReg ? 1'h0 : _GEN_51; // @[PonteDecoder.scala 43:18 54:20]
  wire  _GEN_62 = 3'h2 == stateReg ? 1'h0 : _GEN_53; // @[PonteDecoder.scala 49:16 54:20]
  wire [1:0] _GEN_64 = 3'h1 == stateReg ? 2'h1 : _GEN_55; // @[PonteDecoder.scala 54:20 68:14]
  wire [2:0] _GEN_66 = 3'h1 == stateReg ? _GEN_3 : _GEN_57; // @[PonteDecoder.scala 54:20]
  wire  _GEN_69 = 3'h1 == stateReg ? 1'h0 : _GEN_59; // @[PonteDecoder.scala 52:16 54:20]
  wire  _GEN_70 = 3'h1 == stateReg ? 1'h0 : _GEN_60; // @[PonteDecoder.scala 42:15 54:20]
  wire  _GEN_71 = 3'h1 == stateReg ? 1'h0 : _GEN_61; // @[PonteDecoder.scala 43:18 54:20]
  wire  _GEN_72 = 3'h1 == stateReg ? 1'h0 : _GEN_62; // @[PonteDecoder.scala 49:16 54:20]
  wire [1:0] _GEN_73 = 3'h0 == stateReg ? 2'h1 : _GEN_64; // @[PonteDecoder.scala 54:20 56:14]
  wire  _GEN_74 = 3'h0 == stateReg ? dec_io_startWrite : isWriteReg; // @[PonteDecoder.scala 54:20 57:18 38:27]
  wire [2:0] _GEN_75 = 3'h0 == stateReg ? _GEN_2 : _GEN_66; // @[PonteDecoder.scala 54:20]
  wire  _GEN_83 = dec_io_startWrite | _GEN_74; // @[PonteDecoder.scala 135:35 136:18]
  PonteEscaper dec ( // @[PonteDecoder.scala 28:19]
    .clock(dec_clock),
    .reset(dec_reset),
    .io_in_ready(dec_io_in_ready),
    .io_in_valid(dec_io_in_valid),
    .io_in_bits(dec_io_in_bits),
    .io_valid(dec_io_valid),
    .io_startRead(dec_io_startRead),
    .io_startWrite(dec_io_startWrite),
    .io_data(dec_io_data),
    .io_stall(dec_io_stall)
  );
  assign io_in_ready = dec_io_in_ready; // @[PonteDecoder.scala 29:13]
  assign io_out_valid = 3'h0 == stateReg ? 1'h0 : _GEN_72; // @[PonteDecoder.scala 49:16 54:20]
  assign io_out_bits = dataReg[7:0]; // @[PonteDecoder.scala 50:25]
  assign io_apb_paddr = addrReg; // @[PonteDecoder.scala 45:16]
  assign io_apb_psel = 3'h0 == stateReg ? 1'h0 : _GEN_70; // @[PonteDecoder.scala 42:15 54:20]
  assign io_apb_penable = 3'h0 == stateReg ? 1'h0 : _GEN_71; // @[PonteDecoder.scala 43:18 54:20]
  assign io_apb_pwrite = isWriteReg; // @[PonteDecoder.scala 44:17]
  assign io_apb_pwdata = dataReg; // @[PonteDecoder.scala 46:17]
  assign dec_clock = clock;
  assign dec_reset = reset;
  assign dec_io_in_valid = io_in_valid; // @[PonteDecoder.scala 29:13]
  assign dec_io_in_bits = io_in_bits; // @[PonteDecoder.scala 29:13]
  assign dec_io_stall = 3'h0 == stateReg ? 1'h0 : _GEN_69; // @[PonteDecoder.scala 52:16 54:20]
  always @(posedge clock) begin
    if (reset) begin // @[PonteDecoder.scala 35:25]
      stateReg <= 3'h0; // @[PonteDecoder.scala 35:25]
    end else if (dec_io_valid & ~dec_io_stall) begin // @[PonteDecoder.scala 131:39]
      if (dec_io_startRead) begin // @[PonteDecoder.scala 132:28]
        stateReg <= 3'h1; // @[PonteDecoder.scala 134:16]
      end else if (dec_io_startWrite) begin // @[PonteDecoder.scala 135:35]
        stateReg <= 3'h2; // @[PonteDecoder.scala 137:16]
      end else begin
        stateReg <= _GEN_75;
      end
    end else begin
      stateReg <= _GEN_75;
    end
    if (reset) begin // @[PonteDecoder.scala 36:23]
      cntReg <= 2'h0; // @[PonteDecoder.scala 36:23]
    end else if (dec_io_valid & ~dec_io_stall) begin // @[PonteDecoder.scala 131:39]
      if (dec_io_startRead) begin // @[PonteDecoder.scala 132:28]
        cntReg <= _GEN_73;
      end else if (dec_io_startWrite) begin // @[PonteDecoder.scala 135:35]
        cntReg <= 2'h1; // @[PonteDecoder.scala 138:14]
      end else begin
        cntReg <= _GEN_73;
      end
    end else begin
      cntReg <= _GEN_73;
    end
    if (reset) begin // @[PonteDecoder.scala 37:24]
      addrReg <= 16'h0; // @[PonteDecoder.scala 37:24]
    end else if (!(3'h0 == stateReg)) begin // @[PonteDecoder.scala 54:20]
      if (!(3'h1 == stateReg)) begin // @[PonteDecoder.scala 54:20]
        if (3'h2 == stateReg) begin // @[PonteDecoder.scala 54:20]
          addrReg <= _GEN_7;
        end else begin
          addrReg <= _GEN_52;
        end
      end
    end
    if (reset) begin // @[PonteDecoder.scala 38:27]
      isWriteReg <= 1'h0; // @[PonteDecoder.scala 38:27]
    end else if (dec_io_valid & ~dec_io_stall) begin // @[PonteDecoder.scala 131:39]
      if (dec_io_startRead) begin // @[PonteDecoder.scala 132:28]
        isWriteReg <= 1'h0; // @[PonteDecoder.scala 133:18]
      end else begin
        isWriteReg <= _GEN_83;
      end
    end else if (3'h0 == stateReg) begin // @[PonteDecoder.scala 54:20]
      isWriteReg <= dec_io_startWrite; // @[PonteDecoder.scala 57:18]
    end
    if (reset) begin // @[PonteDecoder.scala 39:27]
      readLenReg <= 8'h0; // @[PonteDecoder.scala 39:27]
    end else if (!(3'h0 == stateReg)) begin // @[PonteDecoder.scala 54:20]
      if (3'h1 == stateReg) begin // @[PonteDecoder.scala 54:20]
        readLenReg <= dec_io_data; // @[PonteDecoder.scala 69:18]
      end else if (!(3'h2 == stateReg)) begin // @[PonteDecoder.scala 54:20]
        readLenReg <= _GEN_54;
      end
    end
    if (reset) begin // @[PonteDecoder.scala 40:24]
      dataReg <= 32'h0; // @[PonteDecoder.scala 40:24]
    end else if (!(3'h0 == stateReg)) begin // @[PonteDecoder.scala 54:20]
      if (!(3'h1 == stateReg)) begin // @[PonteDecoder.scala 54:20]
        if (!(3'h2 == stateReg)) begin // @[PonteDecoder.scala 54:20]
          dataReg <= _GEN_47;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  addrReg = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  isWriteReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  readLenReg = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  dataReg = _RAND_5[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Ponte(
  input         clock,
  input         reset,
  output        io_uart_tx,
  input         io_uart_rx,
  output [15:0] io_apb_paddr,
  output        io_apb_psel,
  output        io_apb_penable,
  output        io_apb_pwrite,
  output [31:0] io_apb_pwdata,
  input         io_apb_pready,
  input  [31:0] io_apb_prdata
);
  wire  uartRx_clock; // @[Ponte.scala 31:22]
  wire  uartRx_reset; // @[Ponte.scala 31:22]
  wire  uartRx_io_rxd; // @[Ponte.scala 31:22]
  wire  uartRx_io_channel_ready; // @[Ponte.scala 31:22]
  wire  uartRx_io_channel_valid; // @[Ponte.scala 31:22]
  wire [7:0] uartRx_io_channel_bits; // @[Ponte.scala 31:22]
  wire  uartTx_clock; // @[Ponte.scala 32:22]
  wire  uartTx_reset; // @[Ponte.scala 32:22]
  wire  uartTx_io_txd; // @[Ponte.scala 32:22]
  wire  uartTx_io_channel_ready; // @[Ponte.scala 32:22]
  wire  uartTx_io_channel_valid; // @[Ponte.scala 32:22]
  wire [7:0] uartTx_io_channel_bits; // @[Ponte.scala 32:22]
  wire  ponteDecoder_clock; // @[Ponte.scala 37:28]
  wire  ponteDecoder_reset; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_in_ready; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_in_valid; // @[Ponte.scala 37:28]
  wire [7:0] ponteDecoder_io_in_bits; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_out_ready; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_out_valid; // @[Ponte.scala 37:28]
  wire [7:0] ponteDecoder_io_out_bits; // @[Ponte.scala 37:28]
  wire [15:0] ponteDecoder_io_apb_paddr; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_apb_psel; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_apb_penable; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_apb_pwrite; // @[Ponte.scala 37:28]
  wire [31:0] ponteDecoder_io_apb_pwdata; // @[Ponte.scala 37:28]
  wire  ponteDecoder_io_apb_pready; // @[Ponte.scala 37:28]
  wire [31:0] ponteDecoder_io_apb_prdata; // @[Ponte.scala 37:28]
  Rx uartRx ( // @[Ponte.scala 31:22]
    .clock(uartRx_clock),
    .reset(uartRx_reset),
    .io_rxd(uartRx_io_rxd),
    .io_channel_ready(uartRx_io_channel_ready),
    .io_channel_valid(uartRx_io_channel_valid),
    .io_channel_bits(uartRx_io_channel_bits)
  );
  Tx uartTx ( // @[Ponte.scala 32:22]
    .clock(uartTx_clock),
    .reset(uartTx_reset),
    .io_txd(uartTx_io_txd),
    .io_channel_ready(uartTx_io_channel_ready),
    .io_channel_valid(uartTx_io_channel_valid),
    .io_channel_bits(uartTx_io_channel_bits)
  );
  PonteDecoder ponteDecoder ( // @[Ponte.scala 37:28]
    .clock(ponteDecoder_clock),
    .reset(ponteDecoder_reset),
    .io_in_ready(ponteDecoder_io_in_ready),
    .io_in_valid(ponteDecoder_io_in_valid),
    .io_in_bits(ponteDecoder_io_in_bits),
    .io_out_ready(ponteDecoder_io_out_ready),
    .io_out_valid(ponteDecoder_io_out_valid),
    .io_out_bits(ponteDecoder_io_out_bits),
    .io_apb_paddr(ponteDecoder_io_apb_paddr),
    .io_apb_psel(ponteDecoder_io_apb_psel),
    .io_apb_penable(ponteDecoder_io_apb_penable),
    .io_apb_pwrite(ponteDecoder_io_apb_pwrite),
    .io_apb_pwdata(ponteDecoder_io_apb_pwdata),
    .io_apb_pready(ponteDecoder_io_apb_pready),
    .io_apb_prdata(ponteDecoder_io_apb_prdata)
  );
  assign io_uart_tx = uartTx_io_txd; // @[Ponte.scala 34:14]
  assign io_apb_paddr = ponteDecoder_io_apb_paddr; // @[Ponte.scala 39:23]
  assign io_apb_psel = ponteDecoder_io_apb_psel; // @[Ponte.scala 39:23]
  assign io_apb_penable = ponteDecoder_io_apb_penable; // @[Ponte.scala 39:23]
  assign io_apb_pwrite = ponteDecoder_io_apb_pwrite; // @[Ponte.scala 39:23]
  assign io_apb_pwdata = ponteDecoder_io_apb_pwdata; // @[Ponte.scala 39:23]
  assign uartRx_clock = clock;
  assign uartRx_reset = reset;
  assign uartRx_io_rxd = io_uart_rx; // @[Ponte.scala 35:17]
  assign uartRx_io_channel_ready = ponteDecoder_io_in_ready; // @[Ponte.scala 38:22]
  assign uartTx_clock = clock;
  assign uartTx_reset = reset;
  assign uartTx_io_channel_valid = ponteDecoder_io_out_valid; // @[Ponte.scala 40:23]
  assign uartTx_io_channel_bits = ponteDecoder_io_out_bits; // @[Ponte.scala 40:23]
  assign ponteDecoder_clock = clock;
  assign ponteDecoder_reset = reset;
  assign ponteDecoder_io_in_valid = uartRx_io_channel_valid; // @[Ponte.scala 38:22]
  assign ponteDecoder_io_in_bits = uartRx_io_channel_bits; // @[Ponte.scala 38:22]
  assign ponteDecoder_io_out_ready = uartTx_io_channel_ready; // @[Ponte.scala 40:23]
  assign ponteDecoder_io_apb_pready = io_apb_pready; // @[Ponte.scala 39:23]
  assign ponteDecoder_io_apb_prdata = io_apb_prdata; // @[Ponte.scala 39:23]
endmodule
module AluAccu(
  input         clock,
  input         reset,
  input  [2:0]  io_op,
  input  [31:0] io_din,
  input  [3:0]  io_enaMask,
  input         io_enaByte,
  input         io_enaHalf,
  input  [1:0]  io_off,
  output [31:0] io_accu
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] a; // @[AluAccu.scala 24:24]
  wire [31:0] _res_T_1 = a + io_din; // @[AluAccu.scala 36:16]
  wire [31:0] _res_T_3 = a - io_din; // @[AluAccu.scala 39:16]
  wire [31:0] _res_T_4 = a & io_din; // @[AluAccu.scala 42:16]
  wire [31:0] _res_T_5 = a | io_din; // @[AluAccu.scala 45:16]
  wire [31:0] _res_T_6 = a ^ io_din; // @[AluAccu.scala 48:16]
  wire [31:0] _res_T_9 = {a[31],a[31:1]}; // @[AluAccu.scala 51:20]
  wire [31:0] _GEN_0 = 3'h6 == io_op ? io_din : a; // @[AluAccu.scala 31:14 54:11 29:24]
  wire [31:0] _GEN_1 = 3'h7 == io_op ? _res_T_9 : _GEN_0; // @[AluAccu.scala 31:14 51:11]
  wire [31:0] _GEN_2 = 3'h5 == io_op ? _res_T_6 : _GEN_1; // @[AluAccu.scala 31:14 48:11]
  wire [31:0] _GEN_3 = 3'h4 == io_op ? _res_T_5 : _GEN_2; // @[AluAccu.scala 31:14 45:11]
  wire [31:0] _GEN_4 = 3'h3 == io_op ? _res_T_4 : _GEN_3; // @[AluAccu.scala 31:14 42:11]
  wire [31:0] _GEN_5 = 3'h2 == io_op ? _res_T_3 : _GEN_4; // @[AluAccu.scala 31:14 39:11]
  wire [31:0] _GEN_6 = 3'h1 == io_op ? _res_T_1 : _GEN_5; // @[AluAccu.scala 31:14 36:11]
  wire [31:0] res = 3'h0 == io_op ? a : _GEN_6; // @[AluAccu.scala 31:14 33:11]
  wire [7:0] _GEN_8 = io_off == 2'h3 ? res[31:24] : res[7:0]; // @[AluAccu.scala 65:30 66:10 58:25]
  wire [7:0] _GEN_9 = io_off == 2'h2 ? res[23:16] : _GEN_8; // @[AluAccu.scala 62:30 63:10]
  wire [15:0] _GEN_10 = io_off == 2'h2 ? res[31:16] : res[15:0]; // @[AluAccu.scala 62:30 64:10 59:25]
  wire [7:0] _signExt_T = io_off == 2'h1 ? res[15:8] : _GEN_9; // @[AluAccu.scala 70:21]
  wire [15:0] _signExt_T_1 = io_off == 2'h1 ? res[15:0] : _GEN_10; // @[AluAccu.scala 72:21]
  wire [15:0] _GEN_13 = io_enaByte ? $signed({{8{_signExt_T[7]}},_signExt_T}) : $signed(_signExt_T_1); // @[AluAccu.scala 69:21 70:13 72:13]
  wire [7:0] split_0 = io_enaMask[0] ? res[7:0] : a[7:0]; // @[AluAccu.scala 78:20]
  wire [7:0] split_1 = io_enaMask[1] ? res[15:8] : a[15:8]; // @[AluAccu.scala 78:20]
  wire [7:0] split_2 = io_enaMask[2] ? res[23:16] : a[23:16]; // @[AluAccu.scala 78:20]
  wire [7:0] split_3 = io_enaMask[3] ? res[31:24] : a[31:24]; // @[AluAccu.scala 78:20]
  wire [31:0] _accuReg_T = {{16{_GEN_13[15]}},_GEN_13}; // @[AluAccu.scala 84:24]
  wire [31:0] _accuReg_T_1 = {split_3,split_2,split_1,split_0}; // @[AluAccu.scala 87:22]
  assign io_accu = a; // @[AluAccu.scala 90:11]
  always @(posedge clock) begin
    if (reset) begin // @[AluAccu.scala 24:24]
      a <= 32'h0; // @[AluAccu.scala 24:24]
    end else if ((io_enaByte | io_enaHalf) & &io_enaMask) begin // @[AluAccu.scala 81:54]
      a <= _accuReg_T; // @[AluAccu.scala 84:13]
    end else begin
      a <= _accuReg_T_1; // @[AluAccu.scala 87:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  a = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Decode(
  input  [15:0] io_din,
  output [31:0] io_dout_operand,
  output [3:0]  io_dout_enaMask,
  output [2:0]  io_dout_op,
  output [9:0]  io_dout_off,
  output [11:0] io_dout_brOff,
  output        io_dout_useDecOpd,
  output [3:0]  io_dout_nextState,
  output        io_dout_enaByte,
  output        io_dout_enaHalf,
  output        io_dout_isDataAccess,
  output [3:0]  io_dout_brType
);
  wire [3:0] field = io_din[15:12]; // @[Decode.scala 69:21]
  wire  _T_5 = field == 4'hb; // @[Decode.scala 71:11]
  wire  _T_6 = field == 4'h8 | field == 4'h9 | field == 4'ha | _T_5; // @[Decode.scala 70:75]
  wire [3:0] _GEN_0 = _T_6 | field == 4'hc ? 4'h8 : 4'h0; // @[Decode.scala 38:17 71:49 72:17]
  wire [7:0] _sigExt_T_1 = io_din[7:0]; // @[Decode.scala 81:25]
  wire [31:0] sigExt = {{24{_sigExt_T_1[7]}},_sigExt_T_1}; // @[Decode.scala 80:20 81:10]
  wire [31:0] _d_operand_T = {{24{_sigExt_T_1[7]}},_sigExt_T_1}; // @[Decode.scala 82:23]
  wire  _GEN_87 = 8'h26 == io_din[15:8] ? 1'h0 : 8'h27 == io_din[15:8]; // @[Decode.scala 91:24 79:27]
  wire  _GEN_97 = 8'h25 == io_din[15:8] | _GEN_87; // @[Decode.scala 145:14 91:24]
  wire  _GEN_109 = 8'h24 == io_din[15:8] ? 1'h0 : _GEN_97; // @[Decode.scala 91:24 79:27]
  wire  _GEN_119 = 8'h23 == io_din[15:8] | _GEN_109; // @[Decode.scala 134:14 91:24]
  wire  _GEN_131 = 8'h22 == io_din[15:8] ? 1'h0 : _GEN_119; // @[Decode.scala 91:24 79:27]
  wire  _GEN_143 = 8'h21 == io_din[15:8] ? 1'h0 : _GEN_131; // @[Decode.scala 91:24 79:27]
  wire  _GEN_154 = 8'h20 == io_din[15:8] ? 1'h0 : _GEN_143; // @[Decode.scala 91:24 79:27]
  wire  _GEN_165 = 8'h10 == io_din[15:8] ? 1'h0 : _GEN_154; // @[Decode.scala 91:24 79:27]
  wire  _GEN_176 = 8'hd == io_din[15:8] ? 1'h0 : _GEN_165; // @[Decode.scala 91:24 79:27]
  wire  _GEN_187 = 8'hc == io_din[15:8] ? 1'h0 : _GEN_176; // @[Decode.scala 91:24 79:27]
  wire  _GEN_198 = 8'h9 == io_din[15:8] ? 1'h0 : _GEN_187; // @[Decode.scala 91:24 79:27]
  wire  noSext = 8'h8 == io_din[15:8] ? 1'h0 : _GEN_198; // @[Decode.scala 91:24 79:27]
  wire [31:0] _GEN_1 = noSext ? {{24'd0}, io_din[7:0]} : _d_operand_T; // @[Decode.scala 82:13 83:{17,29}]
  wire [33:0] _off_T = {$signed(sigExt), 2'h0}; // @[Decode.scala 89:23]
  wire [31:0] _d_operand_T_3 = {sigExt[23:0],8'h0}; // @[Decode.scala 162:41]
  wire [31:0] _d_operand_T_5 = {sigExt[15:0],16'h0}; // @[Decode.scala 168:41]
  wire [31:0] _d_operand_T_7 = {io_din[7:0],24'h0}; // @[Decode.scala 174:32]
  wire [32:0] _off_T_1 = {$signed(sigExt), 1'h0}; // @[Decode.scala 203:27]
  wire [3:0] _GEN_2 = 8'hff == io_din[15:8] ? 4'ha : _GEN_0; // @[Decode.scala 223:19 91:24]
  wire [3:0] _GEN_3 = 8'h40 == io_din[15:8] ? 4'h9 : _GEN_2; // @[Decode.scala 220:19 91:24]
  wire [3:0] _GEN_4 = 8'h72 == io_din[15:8] ? 4'h7 : _GEN_3; // @[Decode.scala 215:19 91:24]
  wire [33:0] _GEN_6 = 8'h72 == io_din[15:8] ? $signed({{1{_off_T_1[32]}},_off_T_1}) : $signed(_off_T); // @[Decode.scala 217:11 91:24 89:7]
  wire [3:0] _GEN_7 = 8'h71 == io_din[15:8] ? 4'h6 : _GEN_4; // @[Decode.scala 210:19 91:24]
  wire  _GEN_8 = 8'h71 == io_din[15:8] | 8'h72 == io_din[15:8]; // @[Decode.scala 211:22 91:24]
  wire [33:0] _GEN_9 = 8'h71 == io_din[15:8] ? $signed({{2{sigExt[31]}},sigExt}) : $signed(_GEN_6); // @[Decode.scala 212:11 91:24]
  wire [3:0] _GEN_10 = 8'h70 == io_din[15:8] ? 4'h5 : _GEN_7; // @[Decode.scala 206:19 91:24]
  wire  _GEN_11 = 8'h70 == io_din[15:8] | _GEN_8; // @[Decode.scala 207:22 91:24]
  wire [33:0] _GEN_12 = 8'h70 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_9); // @[Decode.scala 91:24 89:7]
  wire [3:0] _GEN_13 = 8'h62 == io_din[15:8] ? 4'h3 : _GEN_10; // @[Decode.scala 198:19 91:24]
  wire  _GEN_15 = 8'h62 == io_din[15:8] | _GEN_11; // @[Decode.scala 200:22 91:24]
  wire [2:0] _GEN_16 = 8'h62 == io_din[15:8] ? 3'h6 : 3'h0; // @[Decode.scala 201:12 33:10 91:24]
  wire [3:0] _GEN_17 = 8'h62 == io_din[15:8] ? 4'hf : 4'h0; // @[Decode.scala 202:17 32:15 91:24]
  wire [33:0] _GEN_18 = 8'h62 == io_din[15:8] ? $signed({{1{_off_T_1[32]}},_off_T_1}) : $signed(_GEN_12); // @[Decode.scala 203:11 91:24]
  wire [3:0] _GEN_19 = 8'h61 == io_din[15:8] ? 4'h3 : _GEN_13; // @[Decode.scala 190:19 91:24]
  wire  _GEN_21 = 8'h61 == io_din[15:8] | _GEN_15; // @[Decode.scala 192:22 91:24]
  wire [2:0] _GEN_22 = 8'h61 == io_din[15:8] ? 3'h6 : _GEN_16; // @[Decode.scala 193:12 91:24]
  wire [3:0] _GEN_23 = 8'h61 == io_din[15:8] ? 4'hf : _GEN_17; // @[Decode.scala 194:17 91:24]
  wire [33:0] _GEN_24 = 8'h61 == io_din[15:8] ? $signed({{2{sigExt[31]}},sigExt}) : $signed(_GEN_18); // @[Decode.scala 195:11 91:24]
  wire  _GEN_25 = 8'h61 == io_din[15:8] ? 1'h0 : 8'h62 == io_din[15:8]; // @[Decode.scala 40:15 91:24]
  wire [3:0] _GEN_26 = 8'h60 == io_din[15:8] ? 4'h3 : _GEN_19; // @[Decode.scala 184:19 91:24]
  wire  _GEN_27 = 8'h60 == io_din[15:8] | _GEN_21; // @[Decode.scala 185:22 91:24]
  wire [2:0] _GEN_28 = 8'h60 == io_din[15:8] ? 3'h6 : _GEN_22; // @[Decode.scala 186:12 91:24]
  wire [3:0] _GEN_29 = 8'h60 == io_din[15:8] ? 4'hf : _GEN_23; // @[Decode.scala 187:17 91:24]
  wire  _GEN_30 = 8'h60 == io_din[15:8] ? 1'h0 : 8'h61 == io_din[15:8]; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_31 = 8'h60 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_24); // @[Decode.scala 91:24 89:7]
  wire  _GEN_32 = 8'h60 == io_din[15:8] ? 1'h0 : _GEN_25; // @[Decode.scala 40:15 91:24]
  wire [3:0] _GEN_33 = 8'h50 == io_din[15:8] ? 4'h2 : _GEN_26; // @[Decode.scala 181:19 91:24]
  wire  _GEN_34 = 8'h50 == io_din[15:8] ? 1'h0 : _GEN_27; // @[Decode.scala 41:20 91:24]
  wire [2:0] _GEN_35 = 8'h50 == io_din[15:8] ? 3'h0 : _GEN_28; // @[Decode.scala 33:10 91:24]
  wire [3:0] _GEN_36 = 8'h50 == io_din[15:8] ? 4'h0 : _GEN_29; // @[Decode.scala 32:15 91:24]
  wire  _GEN_37 = 8'h50 == io_din[15:8] ? 1'h0 : _GEN_30; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_38 = 8'h50 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_31); // @[Decode.scala 91:24 89:7]
  wire  _GEN_39 = 8'h50 == io_din[15:8] ? 1'h0 : _GEN_32; // @[Decode.scala 40:15 91:24]
  wire [3:0] _GEN_40 = 8'h30 == io_din[15:8] ? 4'h4 : _GEN_33; // @[Decode.scala 178:19 91:24]
  wire  _GEN_41 = 8'h30 == io_din[15:8] ? 1'h0 : _GEN_34; // @[Decode.scala 41:20 91:24]
  wire [2:0] _GEN_42 = 8'h30 == io_din[15:8] ? 3'h0 : _GEN_35; // @[Decode.scala 33:10 91:24]
  wire [3:0] _GEN_43 = 8'h30 == io_din[15:8] ? 4'h0 : _GEN_36; // @[Decode.scala 32:15 91:24]
  wire  _GEN_44 = 8'h30 == io_din[15:8] ? 1'h0 : _GEN_37; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_45 = 8'h30 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_38); // @[Decode.scala 91:24 89:7]
  wire  _GEN_46 = 8'h30 == io_din[15:8] ? 1'h0 : _GEN_39; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_47 = 8'h2b == io_din[15:8] ? 3'h6 : _GEN_42; // @[Decode.scala 172:12 91:24]
  wire [3:0] _GEN_48 = 8'h2b == io_din[15:8] ? 4'h8 : _GEN_43; // @[Decode.scala 173:17 91:24]
  wire [31:0] _GEN_49 = 8'h2b == io_din[15:8] ? _d_operand_T_7 : _GEN_1; // @[Decode.scala 174:17 91:24]
  wire [3:0] _GEN_51 = 8'h2b == io_din[15:8] ? _GEN_0 : _GEN_40; // @[Decode.scala 91:24]
  wire  _GEN_52 = 8'h2b == io_din[15:8] ? 1'h0 : _GEN_41; // @[Decode.scala 41:20 91:24]
  wire  _GEN_53 = 8'h2b == io_din[15:8] ? 1'h0 : _GEN_44; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_54 = 8'h2b == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_45); // @[Decode.scala 91:24 89:7]
  wire  _GEN_55 = 8'h2b == io_din[15:8] ? 1'h0 : _GEN_46; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_56 = 8'h2a == io_din[15:8] ? 3'h6 : _GEN_47; // @[Decode.scala 166:12 91:24]
  wire [3:0] _GEN_57 = 8'h2a == io_din[15:8] ? 4'hc : _GEN_48; // @[Decode.scala 167:17 91:24]
  wire [31:0] _GEN_58 = 8'h2a == io_din[15:8] ? _d_operand_T_5 : _GEN_49; // @[Decode.scala 168:17 91:24]
  wire  _GEN_59 = 8'h2a == io_din[15:8] | 8'h2b == io_din[15:8]; // @[Decode.scala 169:19 91:24]
  wire [3:0] _GEN_60 = 8'h2a == io_din[15:8] ? _GEN_0 : _GEN_51; // @[Decode.scala 91:24]
  wire  _GEN_61 = 8'h2a == io_din[15:8] ? 1'h0 : _GEN_52; // @[Decode.scala 41:20 91:24]
  wire  _GEN_62 = 8'h2a == io_din[15:8] ? 1'h0 : _GEN_53; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_63 = 8'h2a == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_54); // @[Decode.scala 91:24 89:7]
  wire  _GEN_64 = 8'h2a == io_din[15:8] ? 1'h0 : _GEN_55; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_65 = 8'h29 == io_din[15:8] ? 3'h6 : _GEN_56; // @[Decode.scala 160:12 91:24]
  wire [3:0] _GEN_66 = 8'h29 == io_din[15:8] ? 4'he : _GEN_57; // @[Decode.scala 161:17 91:24]
  wire [31:0] _GEN_67 = 8'h29 == io_din[15:8] ? _d_operand_T_3 : _GEN_58; // @[Decode.scala 162:17 91:24]
  wire  _GEN_68 = 8'h29 == io_din[15:8] | _GEN_59; // @[Decode.scala 163:19 91:24]
  wire [3:0] _GEN_69 = 8'h29 == io_din[15:8] ? _GEN_0 : _GEN_60; // @[Decode.scala 91:24]
  wire  _GEN_70 = 8'h29 == io_din[15:8] ? 1'h0 : _GEN_61; // @[Decode.scala 41:20 91:24]
  wire  _GEN_71 = 8'h29 == io_din[15:8] ? 1'h0 : _GEN_62; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_72 = 8'h29 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_63); // @[Decode.scala 91:24 89:7]
  wire  _GEN_73 = 8'h29 == io_din[15:8] ? 1'h0 : _GEN_64; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_74 = 8'h27 == io_din[15:8] ? 3'h5 : _GEN_65; // @[Decode.scala 154:12 91:24]
  wire [3:0] _GEN_75 = 8'h27 == io_din[15:8] ? 4'hf : _GEN_66; // @[Decode.scala 155:17 91:24]
  wire  _GEN_77 = 8'h27 == io_din[15:8] | _GEN_68; // @[Decode.scala 157:19 91:24]
  wire [31:0] _GEN_78 = 8'h27 == io_din[15:8] ? _GEN_1 : _GEN_67; // @[Decode.scala 91:24]
  wire [3:0] _GEN_79 = 8'h27 == io_din[15:8] ? _GEN_0 : _GEN_69; // @[Decode.scala 91:24]
  wire  _GEN_80 = 8'h27 == io_din[15:8] ? 1'h0 : _GEN_70; // @[Decode.scala 41:20 91:24]
  wire  _GEN_81 = 8'h27 == io_din[15:8] ? 1'h0 : _GEN_71; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_82 = 8'h27 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_72); // @[Decode.scala 91:24 89:7]
  wire  _GEN_83 = 8'h27 == io_din[15:8] ? 1'h0 : _GEN_73; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_84 = 8'h26 == io_din[15:8] ? 3'h5 : _GEN_74; // @[Decode.scala 149:12 91:24]
  wire [3:0] _GEN_85 = 8'h26 == io_din[15:8] ? 4'hf : _GEN_75; // @[Decode.scala 150:17 91:24]
  wire  _GEN_88 = 8'h26 == io_din[15:8] ? 1'h0 : _GEN_77; // @[Decode.scala 37:17 91:24]
  wire [31:0] _GEN_89 = 8'h26 == io_din[15:8] ? _GEN_1 : _GEN_78; // @[Decode.scala 91:24]
  wire [3:0] _GEN_90 = 8'h26 == io_din[15:8] ? _GEN_0 : _GEN_79; // @[Decode.scala 91:24]
  wire  _GEN_91 = 8'h26 == io_din[15:8] ? 1'h0 : _GEN_80; // @[Decode.scala 41:20 91:24]
  wire  _GEN_92 = 8'h26 == io_din[15:8] ? 1'h0 : _GEN_81; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_93 = 8'h26 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_82); // @[Decode.scala 91:24 89:7]
  wire  _GEN_94 = 8'h26 == io_din[15:8] ? 1'h0 : _GEN_83; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_95 = 8'h25 == io_din[15:8] ? 3'h4 : _GEN_84; // @[Decode.scala 143:12 91:24]
  wire [3:0] _GEN_96 = 8'h25 == io_din[15:8] ? 4'hf : _GEN_85; // @[Decode.scala 144:17 91:24]
  wire  _GEN_98 = 8'h25 == io_din[15:8] | _GEN_88; // @[Decode.scala 146:19 91:24]
  wire [31:0] _GEN_100 = 8'h25 == io_din[15:8] ? _GEN_1 : _GEN_89; // @[Decode.scala 91:24]
  wire [3:0] _GEN_101 = 8'h25 == io_din[15:8] ? _GEN_0 : _GEN_90; // @[Decode.scala 91:24]
  wire  _GEN_102 = 8'h25 == io_din[15:8] ? 1'h0 : _GEN_91; // @[Decode.scala 41:20 91:24]
  wire  _GEN_103 = 8'h25 == io_din[15:8] ? 1'h0 : _GEN_92; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_104 = 8'h25 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_93); // @[Decode.scala 91:24 89:7]
  wire  _GEN_105 = 8'h25 == io_din[15:8] ? 1'h0 : _GEN_94; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_106 = 8'h24 == io_din[15:8] ? 3'h4 : _GEN_95; // @[Decode.scala 138:12 91:24]
  wire [3:0] _GEN_107 = 8'h24 == io_din[15:8] ? 4'hf : _GEN_96; // @[Decode.scala 139:17 91:24]
  wire  _GEN_110 = 8'h24 == io_din[15:8] ? 1'h0 : _GEN_98; // @[Decode.scala 37:17 91:24]
  wire [31:0] _GEN_111 = 8'h24 == io_din[15:8] ? _GEN_1 : _GEN_100; // @[Decode.scala 91:24]
  wire [3:0] _GEN_112 = 8'h24 == io_din[15:8] ? _GEN_0 : _GEN_101; // @[Decode.scala 91:24]
  wire  _GEN_113 = 8'h24 == io_din[15:8] ? 1'h0 : _GEN_102; // @[Decode.scala 41:20 91:24]
  wire  _GEN_114 = 8'h24 == io_din[15:8] ? 1'h0 : _GEN_103; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_115 = 8'h24 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_104); // @[Decode.scala 91:24 89:7]
  wire  _GEN_116 = 8'h24 == io_din[15:8] ? 1'h0 : _GEN_105; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_117 = 8'h23 == io_din[15:8] ? 3'h3 : _GEN_106; // @[Decode.scala 132:12 91:24]
  wire [3:0] _GEN_118 = 8'h23 == io_din[15:8] ? 4'hf : _GEN_107; // @[Decode.scala 133:17 91:24]
  wire  _GEN_120 = 8'h23 == io_din[15:8] | _GEN_110; // @[Decode.scala 135:19 91:24]
  wire [31:0] _GEN_122 = 8'h23 == io_din[15:8] ? _GEN_1 : _GEN_111; // @[Decode.scala 91:24]
  wire [3:0] _GEN_123 = 8'h23 == io_din[15:8] ? _GEN_0 : _GEN_112; // @[Decode.scala 91:24]
  wire  _GEN_124 = 8'h23 == io_din[15:8] ? 1'h0 : _GEN_113; // @[Decode.scala 41:20 91:24]
  wire  _GEN_125 = 8'h23 == io_din[15:8] ? 1'h0 : _GEN_114; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_126 = 8'h23 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_115); // @[Decode.scala 91:24 89:7]
  wire  _GEN_127 = 8'h23 == io_din[15:8] ? 1'h0 : _GEN_116; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_128 = 8'h22 == io_din[15:8] ? 3'h3 : _GEN_117; // @[Decode.scala 127:12 91:24]
  wire [3:0] _GEN_129 = 8'h22 == io_din[15:8] ? 4'hf : _GEN_118; // @[Decode.scala 128:17 91:24]
  wire  _GEN_132 = 8'h22 == io_din[15:8] ? 1'h0 : _GEN_120; // @[Decode.scala 37:17 91:24]
  wire [31:0] _GEN_133 = 8'h22 == io_din[15:8] ? _GEN_1 : _GEN_122; // @[Decode.scala 91:24]
  wire [3:0] _GEN_134 = 8'h22 == io_din[15:8] ? _GEN_0 : _GEN_123; // @[Decode.scala 91:24]
  wire  _GEN_135 = 8'h22 == io_din[15:8] ? 1'h0 : _GEN_124; // @[Decode.scala 41:20 91:24]
  wire  _GEN_136 = 8'h22 == io_din[15:8] ? 1'h0 : _GEN_125; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_137 = 8'h22 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_126); // @[Decode.scala 91:24 89:7]
  wire  _GEN_138 = 8'h22 == io_din[15:8] ? 1'h0 : _GEN_127; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_139 = 8'h21 == io_din[15:8] ? 3'h6 : _GEN_128; // @[Decode.scala 122:12 91:24]
  wire [3:0] _GEN_140 = 8'h21 == io_din[15:8] ? 4'hf : _GEN_129; // @[Decode.scala 123:17 91:24]
  wire  _GEN_141 = 8'h21 == io_din[15:8] | _GEN_132; // @[Decode.scala 124:19 91:24]
  wire [31:0] _GEN_144 = 8'h21 == io_din[15:8] ? _GEN_1 : _GEN_133; // @[Decode.scala 91:24]
  wire [3:0] _GEN_145 = 8'h21 == io_din[15:8] ? _GEN_0 : _GEN_134; // @[Decode.scala 91:24]
  wire  _GEN_146 = 8'h21 == io_din[15:8] ? 1'h0 : _GEN_135; // @[Decode.scala 41:20 91:24]
  wire  _GEN_147 = 8'h21 == io_din[15:8] ? 1'h0 : _GEN_136; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_148 = 8'h21 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_137); // @[Decode.scala 91:24 89:7]
  wire  _GEN_149 = 8'h21 == io_din[15:8] ? 1'h0 : _GEN_138; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_150 = 8'h20 == io_din[15:8] ? 3'h6 : _GEN_139; // @[Decode.scala 117:12 91:24]
  wire [3:0] _GEN_151 = 8'h20 == io_din[15:8] ? 4'hf : _GEN_140; // @[Decode.scala 118:17 91:24]
  wire  _GEN_153 = 8'h20 == io_din[15:8] ? 1'h0 : _GEN_141; // @[Decode.scala 37:17 91:24]
  wire [31:0] _GEN_155 = 8'h20 == io_din[15:8] ? _GEN_1 : _GEN_144; // @[Decode.scala 91:24]
  wire [3:0] _GEN_156 = 8'h20 == io_din[15:8] ? _GEN_0 : _GEN_145; // @[Decode.scala 91:24]
  wire  _GEN_157 = 8'h20 == io_din[15:8] ? 1'h0 : _GEN_146; // @[Decode.scala 41:20 91:24]
  wire  _GEN_158 = 8'h20 == io_din[15:8] ? 1'h0 : _GEN_147; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_159 = 8'h20 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_148); // @[Decode.scala 91:24 89:7]
  wire  _GEN_160 = 8'h20 == io_din[15:8] ? 1'h0 : _GEN_149; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_161 = 8'h10 == io_din[15:8] ? 3'h7 : _GEN_150; // @[Decode.scala 113:12 91:24]
  wire [3:0] _GEN_162 = 8'h10 == io_din[15:8] ? 4'hf : _GEN_151; // @[Decode.scala 114:17 91:24]
  wire  _GEN_164 = 8'h10 == io_din[15:8] ? 1'h0 : _GEN_153; // @[Decode.scala 37:17 91:24]
  wire [31:0] _GEN_166 = 8'h10 == io_din[15:8] ? _GEN_1 : _GEN_155; // @[Decode.scala 91:24]
  wire [3:0] _GEN_167 = 8'h10 == io_din[15:8] ? _GEN_0 : _GEN_156; // @[Decode.scala 91:24]
  wire  _GEN_168 = 8'h10 == io_din[15:8] ? 1'h0 : _GEN_157; // @[Decode.scala 41:20 91:24]
  wire  _GEN_169 = 8'h10 == io_din[15:8] ? 1'h0 : _GEN_158; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_170 = 8'h10 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_159); // @[Decode.scala 91:24 89:7]
  wire  _GEN_171 = 8'h10 == io_din[15:8] ? 1'h0 : _GEN_160; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_172 = 8'hd == io_din[15:8] ? 3'h2 : _GEN_161; // @[Decode.scala 108:12 91:24]
  wire [3:0] _GEN_173 = 8'hd == io_din[15:8] ? 4'hf : _GEN_162; // @[Decode.scala 109:17 91:24]
  wire  _GEN_174 = 8'hd == io_din[15:8] | _GEN_164; // @[Decode.scala 110:19 91:24]
  wire [31:0] _GEN_177 = 8'hd == io_din[15:8] ? _GEN_1 : _GEN_166; // @[Decode.scala 91:24]
  wire [3:0] _GEN_178 = 8'hd == io_din[15:8] ? _GEN_0 : _GEN_167; // @[Decode.scala 91:24]
  wire  _GEN_179 = 8'hd == io_din[15:8] ? 1'h0 : _GEN_168; // @[Decode.scala 41:20 91:24]
  wire  _GEN_180 = 8'hd == io_din[15:8] ? 1'h0 : _GEN_169; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_181 = 8'hd == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_170); // @[Decode.scala 91:24 89:7]
  wire  _GEN_182 = 8'hd == io_din[15:8] ? 1'h0 : _GEN_171; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_183 = 8'hc == io_din[15:8] ? 3'h2 : _GEN_172; // @[Decode.scala 103:12 91:24]
  wire [3:0] _GEN_184 = 8'hc == io_din[15:8] ? 4'hf : _GEN_173; // @[Decode.scala 104:17 91:24]
  wire  _GEN_186 = 8'hc == io_din[15:8] ? 1'h0 : _GEN_174; // @[Decode.scala 37:17 91:24]
  wire [31:0] _GEN_188 = 8'hc == io_din[15:8] ? _GEN_1 : _GEN_177; // @[Decode.scala 91:24]
  wire [3:0] _GEN_189 = 8'hc == io_din[15:8] ? _GEN_0 : _GEN_178; // @[Decode.scala 91:24]
  wire  _GEN_190 = 8'hc == io_din[15:8] ? 1'h0 : _GEN_179; // @[Decode.scala 41:20 91:24]
  wire  _GEN_191 = 8'hc == io_din[15:8] ? 1'h0 : _GEN_180; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_192 = 8'hc == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_181); // @[Decode.scala 91:24 89:7]
  wire  _GEN_193 = 8'hc == io_din[15:8] ? 1'h0 : _GEN_182; // @[Decode.scala 40:15 91:24]
  wire [2:0] _GEN_194 = 8'h9 == io_din[15:8] ? 3'h1 : _GEN_183; // @[Decode.scala 91:24 98:12]
  wire [3:0] _GEN_195 = 8'h9 == io_din[15:8] ? 4'hf : _GEN_184; // @[Decode.scala 91:24 99:17]
  wire  _GEN_196 = 8'h9 == io_din[15:8] | _GEN_186; // @[Decode.scala 100:19 91:24]
  wire [31:0] _GEN_199 = 8'h9 == io_din[15:8] ? _GEN_1 : _GEN_188; // @[Decode.scala 91:24]
  wire [3:0] _GEN_200 = 8'h9 == io_din[15:8] ? _GEN_0 : _GEN_189; // @[Decode.scala 91:24]
  wire  _GEN_201 = 8'h9 == io_din[15:8] ? 1'h0 : _GEN_190; // @[Decode.scala 41:20 91:24]
  wire  _GEN_202 = 8'h9 == io_din[15:8] ? 1'h0 : _GEN_191; // @[Decode.scala 39:15 91:24]
  wire [33:0] _GEN_203 = 8'h9 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_192); // @[Decode.scala 91:24 89:7]
  wire  _GEN_204 = 8'h9 == io_din[15:8] ? 1'h0 : _GEN_193; // @[Decode.scala 40:15 91:24]
  wire [33:0] _GEN_214 = 8'h8 == io_din[15:8] ? $signed(_off_T) : $signed(_GEN_203); // @[Decode.scala 91:24 89:7]
  assign io_dout_operand = 8'h8 == io_din[15:8] ? _GEN_1 : _GEN_199; // @[Decode.scala 91:24]
  assign io_dout_enaMask = 8'h8 == io_din[15:8] ? 4'hf : _GEN_195; // @[Decode.scala 91:24 94:17]
  assign io_dout_op = 8'h8 == io_din[15:8] ? 3'h1 : _GEN_194; // @[Decode.scala 91:24 93:12]
  assign io_dout_off = _GEN_214[9:0]; // @[Decode.scala 88:17]
  assign io_dout_brOff = io_din[11:0]; // @[Decode.scala 77:27]
  assign io_dout_useDecOpd = 8'h8 == io_din[15:8] ? 1'h0 : _GEN_196; // @[Decode.scala 37:17 91:24]
  assign io_dout_nextState = 8'h8 == io_din[15:8] ? _GEN_0 : _GEN_200; // @[Decode.scala 91:24]
  assign io_dout_enaByte = 8'h8 == io_din[15:8] ? 1'h0 : _GEN_202; // @[Decode.scala 39:15 91:24]
  assign io_dout_enaHalf = 8'h8 == io_din[15:8] ? 1'h0 : _GEN_204; // @[Decode.scala 40:15 91:24]
  assign io_dout_isDataAccess = 8'h8 == io_din[15:8] ? 1'h0 : _GEN_201; // @[Decode.scala 41:20 91:24]
  assign io_dout_brType = io_din[15:12]; // @[Decode.scala 69:21]
endmodule
module Leros(
  input         clock,
  input         reset,
  output [10:0] imemIO_addr,
  input  [15:0] imemIO_instr,
  output [15:0] dmemIO_rdAddr,
  input  [31:0] dmemIO_rdData,
  output [15:0] dmemIO_wrAddr,
  output [31:0] dmemIO_wrData,
  output        dmemIO_wr,
  output [3:0]  dmemIO_wrMask
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  wire  alu_clock; // @[Leros.scala 18:19]
  wire  alu_reset; // @[Leros.scala 18:19]
  wire [2:0] alu_io_op; // @[Leros.scala 18:19]
  wire [31:0] alu_io_din; // @[Leros.scala 18:19]
  wire [3:0] alu_io_enaMask; // @[Leros.scala 18:19]
  wire  alu_io_enaByte; // @[Leros.scala 18:19]
  wire  alu_io_enaHalf; // @[Leros.scala 18:19]
  wire [1:0] alu_io_off; // @[Leros.scala 18:19]
  wire [31:0] alu_io_accu; // @[Leros.scala 18:19]
  wire [15:0] dec_io_din; // @[Leros.scala 33:19]
  wire [31:0] dec_io_dout_operand; // @[Leros.scala 33:19]
  wire [3:0] dec_io_dout_enaMask; // @[Leros.scala 33:19]
  wire [2:0] dec_io_dout_op; // @[Leros.scala 33:19]
  wire [9:0] dec_io_dout_off; // @[Leros.scala 33:19]
  wire [11:0] dec_io_dout_brOff; // @[Leros.scala 33:19]
  wire  dec_io_dout_useDecOpd; // @[Leros.scala 33:19]
  wire [3:0] dec_io_dout_nextState; // @[Leros.scala 33:19]
  wire  dec_io_dout_enaByte; // @[Leros.scala 33:19]
  wire  dec_io_dout_enaHalf; // @[Leros.scala 33:19]
  wire  dec_io_dout_isDataAccess; // @[Leros.scala 33:19]
  wire [3:0] dec_io_dout_brType; // @[Leros.scala 33:19]
  reg [10:0] pcReg; // @[Leros.scala 23:22]
  reg [15:0] addrReg; // @[Leros.scala 24:24]
  wire [10:0] _pcNext_T_1 = pcReg + 11'h1; // @[Leros.scala 26:34]
  reg [31:0] decReg_operand; // @[Leros.scala 36:23]
  reg [3:0] decReg_enaMask; // @[Leros.scala 36:23]
  reg [2:0] decReg_op; // @[Leros.scala 36:23]
  reg [11:0] decReg_brOff; // @[Leros.scala 36:23]
  reg  decReg_useDecOpd; // @[Leros.scala 36:23]
  reg  decReg_enaByte; // @[Leros.scala 36:23]
  reg  decReg_enaHalf; // @[Leros.scala 36:23]
  reg [3:0] decReg_brType; // @[Leros.scala 36:23]
  wire [15:0] _GEN_108 = {{6{dec_io_dout_off[9]}},dec_io_dout_off}; // @[Leros.scala 40:33]
  wire [15:0] effAddr = $signed(addrReg) + $signed(_GEN_108); // @[Leros.scala 40:47]
  wire [13:0] effAddrWord = effAddr[15:2]; // @[Leros.scala 41:30]
  wire [15:0] _effAddrOff_T = effAddr & 16'h3; // @[Leros.scala 43:25]
  wire [13:0] memAddr = dec_io_dout_isDataAccess ? effAddrWord : {{6'd0}, imemIO_instr[7:0]}; // @[Leros.scala 53:20]
  reg [13:0] memAddrReg; // @[Leros.scala 54:27]
  reg [1:0] effAddrOffReg; // @[Leros.scala 55:30]
  reg [3:0] stateReg; // @[Leros.scala 76:25]
  wire  _GEN_15 = 4'hc == decReg_brType & alu_io_accu[31]; // @[Leros.scala 126:29 125:33 131:38]
  wire  _GEN_16 = 4'hb == decReg_brType ? ~alu_io_accu[31] : _GEN_15; // @[Leros.scala 126:29 130:38]
  wire  _GEN_17 = 4'ha == decReg_brType ? alu_io_accu != 32'h0 : _GEN_16; // @[Leros.scala 126:29 129:39]
  wire  _GEN_18 = 4'h9 == decReg_brType ? alu_io_accu == 32'h0 : _GEN_17; // @[Leros.scala 126:29 128:38]
  wire  doBranch = 4'h8 == decReg_brType | _GEN_18; // @[Leros.scala 126:29 127:37]
  wire [10:0] _pcNext_T_2 = pcReg; // @[Leros.scala 134:26]
  wire [11:0] _GEN_109 = {{1{_pcNext_T_2[10]}},_pcNext_T_2}; // @[Leros.scala 134:33]
  wire [11:0] _pcNext_T_6 = $signed(_GEN_109) + $signed(decReg_brOff); // @[Leros.scala 134:49]
  wire [11:0] _GEN_20 = doBranch ? _pcNext_T_6 : {{1'd0}, _pcNext_T_1}; // @[Leros.scala 133:23 134:16 26:27]
  wire [31:0] _GEN_22 = 4'h9 == stateReg ? alu_io_accu : {{21'd0}, _pcNext_T_1}; // @[Leros.scala 139:14 84:20 26:27]
  wire [31:0] _GEN_26 = 4'h8 == stateReg ? {{20'd0}, _GEN_20} : _GEN_22; // @[Leros.scala 84:20]
  wire [31:0] _GEN_37 = 4'h7 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_26; // @[Leros.scala 84:20 26:27]
  wire [31:0] _GEN_46 = 4'h6 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_37; // @[Leros.scala 84:20 26:27]
  wire [31:0] _GEN_55 = 4'h5 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_46; // @[Leros.scala 84:20 26:27]
  wire [31:0] _GEN_64 = 4'h4 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_55; // @[Leros.scala 84:20 26:27]
  wire [31:0] _GEN_73 = 4'h3 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_64; // @[Leros.scala 84:20 26:27]
  wire [31:0] _GEN_83 = 4'h2 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_73; // @[Leros.scala 84:20 26:27]
  wire [31:0] pcNext = 4'h1 == stateReg ? {{21'd0}, _pcNext_T_1} : _GEN_83; // @[Leros.scala 84:20 26:27]
  wire [31:0] _GEN_1 = stateReg != 4'h1 ? pcNext : {{21'd0}, pcReg}; // @[Leros.scala 78:29 80:11 23:22]
  wire [3:0] _dmemIO_wrMask_T = 4'h1 << effAddrOffReg; // @[Leros.scala 111:34]
  wire [7:0] _GEN_3 = 2'h0 == effAddrOffReg ? alu_io_accu[7:0] : alu_io_accu[7:0]; // @[Leros.scala 112:{30,30} 46:16]
  wire [7:0] _GEN_4 = 2'h1 == effAddrOffReg ? alu_io_accu[7:0] : alu_io_accu[15:8]; // @[Leros.scala 112:{30,30} 46:16]
  wire [7:0] _GEN_5 = 2'h2 == effAddrOffReg ? alu_io_accu[7:0] : alu_io_accu[23:16]; // @[Leros.scala 112:{30,30} 46:16]
  wire [7:0] _GEN_6 = 2'h3 == effAddrOffReg ? alu_io_accu[7:0] : alu_io_accu[31:24]; // @[Leros.scala 112:{30,30} 46:16]
  wire [1:0] _T_26 = effAddrOffReg | 2'h1; // @[Leros.scala 120:29]
  wire [7:0] _GEN_14 = 2'h3 == _T_26 ? alu_io_accu[15:8] : _GEN_6; // @[Leros.scala 120:{36,36}]
  wire [7:0] _GEN_35 = 4'h7 == stateReg ? _GEN_14 : alu_io_accu[31:24]; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_44 = 4'h6 == stateReg ? _GEN_6 : _GEN_35; // @[Leros.scala 84:20]
  wire [7:0] _GEN_53 = 4'h5 == stateReg ? alu_io_accu[31:24] : _GEN_44; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_62 = 4'h4 == stateReg ? alu_io_accu[31:24] : _GEN_53; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_71 = 4'h3 == stateReg ? alu_io_accu[31:24] : _GEN_62; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_81 = 4'h2 == stateReg ? alu_io_accu[31:24] : _GEN_71; // @[Leros.scala 46:16 84:20]
  wire [7:0] vecAccu_3 = 4'h1 == stateReg ? alu_io_accu[31:24] : _GEN_81; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_13 = 2'h2 == _T_26 ? alu_io_accu[15:8] : _GEN_5; // @[Leros.scala 120:{36,36}]
  wire [7:0] _GEN_34 = 4'h7 == stateReg ? _GEN_13 : alu_io_accu[23:16]; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_43 = 4'h6 == stateReg ? _GEN_5 : _GEN_34; // @[Leros.scala 84:20]
  wire [7:0] _GEN_52 = 4'h5 == stateReg ? alu_io_accu[23:16] : _GEN_43; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_61 = 4'h4 == stateReg ? alu_io_accu[23:16] : _GEN_52; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_70 = 4'h3 == stateReg ? alu_io_accu[23:16] : _GEN_61; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_80 = 4'h2 == stateReg ? alu_io_accu[23:16] : _GEN_70; // @[Leros.scala 46:16 84:20]
  wire [7:0] vecAccu_2 = 4'h1 == stateReg ? alu_io_accu[23:16] : _GEN_80; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_12 = 2'h1 == _T_26 ? alu_io_accu[15:8] : _GEN_4; // @[Leros.scala 120:{36,36}]
  wire [7:0] _GEN_33 = 4'h7 == stateReg ? _GEN_12 : alu_io_accu[15:8]; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_42 = 4'h6 == stateReg ? _GEN_4 : _GEN_33; // @[Leros.scala 84:20]
  wire [7:0] _GEN_51 = 4'h5 == stateReg ? alu_io_accu[15:8] : _GEN_42; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_60 = 4'h4 == stateReg ? alu_io_accu[15:8] : _GEN_51; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_69 = 4'h3 == stateReg ? alu_io_accu[15:8] : _GEN_60; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_79 = 4'h2 == stateReg ? alu_io_accu[15:8] : _GEN_69; // @[Leros.scala 46:16 84:20]
  wire [7:0] vecAccu_1 = 4'h1 == stateReg ? alu_io_accu[15:8] : _GEN_79; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_11 = 2'h0 == _T_26 ? alu_io_accu[15:8] : _GEN_3; // @[Leros.scala 120:{36,36}]
  wire [7:0] _GEN_32 = 4'h7 == stateReg ? _GEN_11 : alu_io_accu[7:0]; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_41 = 4'h6 == stateReg ? _GEN_3 : _GEN_32; // @[Leros.scala 84:20]
  wire [7:0] _GEN_50 = 4'h5 == stateReg ? alu_io_accu[7:0] : _GEN_41; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_59 = 4'h4 == stateReg ? alu_io_accu[7:0] : _GEN_50; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_68 = 4'h3 == stateReg ? alu_io_accu[7:0] : _GEN_59; // @[Leros.scala 46:16 84:20]
  wire [7:0] _GEN_78 = 4'h2 == stateReg ? alu_io_accu[7:0] : _GEN_68; // @[Leros.scala 46:16 84:20]
  wire [7:0] vecAccu_0 = 4'h1 == stateReg ? alu_io_accu[7:0] : _GEN_78; // @[Leros.scala 46:16 84:20]
  wire [31:0] _dmemIO_wrData_T_2 = {vecAccu_3,vecAccu_2,vecAccu_1,vecAccu_0}; // @[Leros.scala 113:63]
  wire [4:0] _dmemIO_wrMask_T_1 = 5'h3 << effAddrOffReg; // @[Leros.scala 118:34]
  wire [31:0] _GEN_24 = 4'h9 == stateReg ? {{21'd0}, _pcNext_T_1} : alu_io_accu; // @[Leros.scala 84:20 141:21 59:17]
  wire  _GEN_27 = 4'h8 == stateReg ? 1'h0 : 4'h9 == stateReg; // @[Leros.scala 60:13 84:20]
  wire [31:0] _GEN_28 = 4'h8 == stateReg ? alu_io_accu : _GEN_24; // @[Leros.scala 59:17 84:20]
  wire  _GEN_30 = 4'h7 == stateReg | _GEN_27; // @[Leros.scala 117:17 84:20]
  wire [4:0] _GEN_31 = 4'h7 == stateReg ? _dmemIO_wrMask_T_1 : 5'hf; // @[Leros.scala 84:20 118:21 61:17]
  wire [31:0] _GEN_36 = 4'h7 == stateReg ? _dmemIO_wrData_T_2 : _GEN_28; // @[Leros.scala 84:20 121:21]
  wire  _GEN_39 = 4'h6 == stateReg | _GEN_30; // @[Leros.scala 110:17 84:20]
  wire [4:0] _GEN_40 = 4'h6 == stateReg ? {{1'd0}, _dmemIO_wrMask_T} : _GEN_31; // @[Leros.scala 84:20 111:21]
  wire [31:0] _GEN_45 = 4'h6 == stateReg ? _dmemIO_wrData_T_2 : _GEN_36; // @[Leros.scala 84:20 113:21]
  wire  _GEN_48 = 4'h5 == stateReg | _GEN_39; // @[Leros.scala 105:17 84:20]
  wire [4:0] _GEN_49 = 4'h5 == stateReg ? 5'hf : _GEN_40; // @[Leros.scala 61:17 84:20]
  wire [31:0] _GEN_54 = 4'h5 == stateReg ? alu_io_accu : _GEN_45; // @[Leros.scala 59:17 84:20]
  wire  _GEN_57 = 4'h4 == stateReg | _GEN_48; // @[Leros.scala 101:17 84:20]
  wire [4:0] _GEN_58 = 4'h4 == stateReg ? 5'hf : _GEN_49; // @[Leros.scala 61:17 84:20]
  wire [31:0] _GEN_63 = 4'h4 == stateReg ? alu_io_accu : _GEN_54; // @[Leros.scala 59:17 84:20]
  wire  _GEN_66 = 4'h3 == stateReg ? 1'h0 : _GEN_57; // @[Leros.scala 60:13 84:20]
  wire [4:0] _GEN_67 = 4'h3 == stateReg ? 5'hf : _GEN_58; // @[Leros.scala 61:17 84:20]
  wire [31:0] _GEN_72 = 4'h3 == stateReg ? alu_io_accu : _GEN_63; // @[Leros.scala 59:17 84:20]
  wire [31:0] _GEN_75 = 4'h2 == stateReg ? dmemIO_rdData : {{16'd0}, addrReg}; // @[Leros.scala 84:20 93:15 24:24]
  wire  _GEN_76 = 4'h2 == stateReg ? 1'h0 : _GEN_66; // @[Leros.scala 60:13 84:20]
  wire [4:0] _GEN_77 = 4'h2 == stateReg ? 5'hf : _GEN_67; // @[Leros.scala 61:17 84:20]
  wire [31:0] _GEN_82 = 4'h2 == stateReg ? alu_io_accu : _GEN_72; // @[Leros.scala 59:17 84:20]
  wire [31:0] _GEN_98 = 4'h1 == stateReg ? {{16'd0}, addrReg} : _GEN_75; // @[Leros.scala 84:20 24:24]
  wire [4:0] _GEN_100 = 4'h1 == stateReg ? 5'hf : _GEN_77; // @[Leros.scala 61:17 84:20]
  wire [31:0] _GEN_110 = reset ? 32'h0 : _GEN_1; // @[Leros.scala 23:{22,22}]
  wire [31:0] _GEN_111 = reset ? 32'h0 : _GEN_98; // @[Leros.scala 24:{24,24}]
  AluAccu alu ( // @[Leros.scala 18:19]
    .clock(alu_clock),
    .reset(alu_reset),
    .io_op(alu_io_op),
    .io_din(alu_io_din),
    .io_enaMask(alu_io_enaMask),
    .io_enaByte(alu_io_enaByte),
    .io_enaHalf(alu_io_enaHalf),
    .io_off(alu_io_off),
    .io_accu(alu_io_accu)
  );
  Decode dec ( // @[Leros.scala 33:19]
    .io_din(dec_io_din),
    .io_dout_operand(dec_io_dout_operand),
    .io_dout_enaMask(dec_io_dout_enaMask),
    .io_dout_op(dec_io_dout_op),
    .io_dout_off(dec_io_dout_off),
    .io_dout_brOff(dec_io_dout_brOff),
    .io_dout_useDecOpd(dec_io_dout_useDecOpd),
    .io_dout_nextState(dec_io_dout_nextState),
    .io_dout_enaByte(dec_io_dout_enaByte),
    .io_dout_enaHalf(dec_io_dout_enaHalf),
    .io_dout_isDataAccess(dec_io_dout_isDataAccess),
    .io_dout_brType(dec_io_dout_brType)
  );
  assign imemIO_addr = pcNext[10:0]; // @[Leros.scala 29:15]
  assign dmemIO_rdAddr = {{2'd0}, memAddr}; // @[Leros.scala 56:17]
  assign dmemIO_wrAddr = {{2'd0}, memAddrReg}; // @[Leros.scala 58:17]
  assign dmemIO_wrData = 4'h1 == stateReg ? alu_io_accu : _GEN_82; // @[Leros.scala 59:17 84:20]
  assign dmemIO_wr = 4'h1 == stateReg ? 1'h0 : _GEN_76; // @[Leros.scala 60:13 84:20]
  assign dmemIO_wrMask = _GEN_100[3:0];
  assign alu_clock = clock;
  assign alu_reset = reset;
  assign alu_io_op = decReg_op; // @[Leros.scala 64:13]
  assign alu_io_din = decReg_useDecOpd ? decReg_operand : dmemIO_rdData; // @[Leros.scala 71:20]
  assign alu_io_enaMask = stateReg != 4'h1 ? decReg_enaMask : 4'h0; // @[Leros.scala 65:18 78:29 81:20]
  assign alu_io_enaByte = decReg_enaByte; // @[Leros.scala 68:18]
  assign alu_io_enaHalf = decReg_enaHalf; // @[Leros.scala 69:18]
  assign alu_io_off = effAddrOffReg; // @[Leros.scala 70:14]
  assign dec_io_din = imemIO_instr; // @[Leros.scala 34:14]
  always @(posedge clock) begin
    pcReg <= _GEN_110[10:0]; // @[Leros.scala 23:{22,22}]
    addrReg <= _GEN_111[15:0]; // @[Leros.scala 24:{24,24}]
    if (reset) begin // @[Leros.scala 36:23]
      decReg_operand <= 32'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_operand <= dec_io_dout_operand; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_enaMask <= 4'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_enaMask <= dec_io_dout_enaMask; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_op <= 3'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_op <= dec_io_dout_op; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_brOff <= 12'sh0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_brOff <= dec_io_dout_brOff; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_useDecOpd <= 1'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_useDecOpd <= dec_io_dout_useDecOpd; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_enaByte <= 1'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_enaByte <= dec_io_dout_enaByte; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_enaHalf <= 1'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_enaHalf <= dec_io_dout_enaHalf; // @[Leros.scala 87:14]
    end
    if (reset) begin // @[Leros.scala 36:23]
      decReg_brType <= 4'h0; // @[Leros.scala 36:23]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      decReg_brType <= dec_io_dout_brType; // @[Leros.scala 87:14]
    end
    if (dec_io_dout_isDataAccess) begin // @[Leros.scala 53:20]
      memAddrReg <= effAddrWord;
    end else begin
      memAddrReg <= {{6'd0}, imemIO_instr[7:0]};
    end
    effAddrOffReg <= _effAddrOff_T[1:0]; // @[Leros.scala 42:24 43:14]
    if (reset) begin // @[Leros.scala 76:25]
      stateReg <= 4'h1; // @[Leros.scala 76:25]
    end else if (4'h1 == stateReg) begin // @[Leros.scala 84:20]
      stateReg <= dec_io_dout_nextState; // @[Leros.scala 86:16]
    end else if (stateReg != 4'h1) begin // @[Leros.scala 78:29]
      stateReg <= 4'h1; // @[Leros.scala 79:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  addrReg = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  decReg_operand = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  decReg_enaMask = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  decReg_op = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  decReg_brOff = _RAND_5[11:0];
  _RAND_6 = {1{`RANDOM}};
  decReg_useDecOpd = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  decReg_enaByte = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  decReg_enaHalf = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  decReg_brType = _RAND_9[3:0];
  _RAND_10 = {1{`RANDOM}};
  memAddrReg = _RAND_10[13:0];
  _RAND_11 = {1{`RANDOM}};
  effAddrOffReg = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  stateReg = _RAND_12[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ChiselSyncMemory(
  input         clock,
  input  [8:0]  io_wordAddr,
  input         io_write,
  input  [31:0] io_wrData,
  output [31:0] io_rdData,
  input  [3:0]  io_mask
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:511]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_0_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_0_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_0_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_0_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_0_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_0_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_0_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_0_io_rdData_MPORT_en_pipe_0;
  reg [8:0] mem_0_io_rdData_MPORT_addr_pipe_0;
  reg [7:0] mem_1 [0:511]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_1_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_1_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_1_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_1_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_1_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_1_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_1_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_1_io_rdData_MPORT_en_pipe_0;
  reg [8:0] mem_1_io_rdData_MPORT_addr_pipe_0;
  reg [7:0] mem_2 [0:511]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_2_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_2_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_2_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_2_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_2_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_2_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_2_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_2_io_rdData_MPORT_en_pipe_0;
  reg [8:0] mem_2_io_rdData_MPORT_addr_pipe_0;
  reg [7:0] mem_3 [0:511]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_3_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_3_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_3_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_3_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [8:0] mem_3_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_3_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_3_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_3_io_rdData_MPORT_en_pipe_0;
  reg [8:0] mem_3_io_rdData_MPORT_addr_pipe_0;
  wire [32:0] _io_rdData_T_5 = {1'h0,mem_3_io_rdData_MPORT_data,mem_2_io_rdData_MPORT_data,mem_1_io_rdData_MPORT_data,
    mem_0_io_rdData_MPORT_data}; // @[Helper.scala 25:49]
  assign mem_0_io_rdData_MPORT_en = mem_0_io_rdData_MPORT_en_pipe_0;
  assign mem_0_io_rdData_MPORT_addr = mem_0_io_rdData_MPORT_addr_pipe_0;
  assign mem_0_io_rdData_MPORT_data = mem_0[mem_0_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_0_MPORT_data = io_wrData[7:0];
  assign mem_0_MPORT_addr = io_wordAddr;
  assign mem_0_MPORT_mask = io_mask[0];
  assign mem_0_MPORT_en = io_write;
  assign mem_1_io_rdData_MPORT_en = mem_1_io_rdData_MPORT_en_pipe_0;
  assign mem_1_io_rdData_MPORT_addr = mem_1_io_rdData_MPORT_addr_pipe_0;
  assign mem_1_io_rdData_MPORT_data = mem_1[mem_1_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_1_MPORT_data = io_wrData[15:8];
  assign mem_1_MPORT_addr = io_wordAddr;
  assign mem_1_MPORT_mask = io_mask[1];
  assign mem_1_MPORT_en = io_write;
  assign mem_2_io_rdData_MPORT_en = mem_2_io_rdData_MPORT_en_pipe_0;
  assign mem_2_io_rdData_MPORT_addr = mem_2_io_rdData_MPORT_addr_pipe_0;
  assign mem_2_io_rdData_MPORT_data = mem_2[mem_2_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_2_MPORT_data = io_wrData[23:16];
  assign mem_2_MPORT_addr = io_wordAddr;
  assign mem_2_MPORT_mask = io_mask[2];
  assign mem_2_MPORT_en = io_write;
  assign mem_3_io_rdData_MPORT_en = mem_3_io_rdData_MPORT_en_pipe_0;
  assign mem_3_io_rdData_MPORT_addr = mem_3_io_rdData_MPORT_addr_pipe_0;
  assign mem_3_io_rdData_MPORT_data = mem_3[mem_3_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_3_MPORT_data = io_wrData[31:24];
  assign mem_3_MPORT_addr = io_wordAddr;
  assign mem_3_MPORT_mask = io_mask[3];
  assign mem_3_MPORT_en = io_write;
  assign io_rdData = _io_rdData_T_5[31:0];
  always @(posedge clock) begin
    if (mem_0_MPORT_en & mem_0_MPORT_mask) begin
      mem_0[mem_0_MPORT_addr] <= mem_0_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_0_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_0_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_0_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
    if (mem_1_MPORT_en & mem_1_MPORT_mask) begin
      mem_1[mem_1_MPORT_addr] <= mem_1_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_1_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_1_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_1_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
    if (mem_2_MPORT_en & mem_2_MPORT_mask) begin
      mem_2[mem_2_MPORT_addr] <= mem_2_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_2_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_2_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_2_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
    if (mem_3_MPORT_en & mem_3_MPORT_mask) begin
      mem_3[mem_3_MPORT_addr] <= mem_3_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_3_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_3_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_3_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    mem_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    mem_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    mem_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_io_rdData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_io_rdData_MPORT_addr_pipe_0 = _RAND_2[8:0];
  _RAND_4 = {1{`RANDOM}};
  mem_1_io_rdData_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_1_io_rdData_MPORT_addr_pipe_0 = _RAND_5[8:0];
  _RAND_7 = {1{`RANDOM}};
  mem_2_io_rdData_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_2_io_rdData_MPORT_addr_pipe_0 = _RAND_8[8:0];
  _RAND_10 = {1{`RANDOM}};
  mem_3_io_rdData_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_3_io_rdData_MPORT_addr_pipe_0 = _RAND_11[8:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionMemory(
  input         clock,
  input  [10:0] instrPort_addr,
  output [15:0] instrPort_instr,
  input  [10:0] apbPort_paddr,
  input         apbPort_psel,
  input         apbPort_penable,
  input         apbPort_pwrite,
  input  [3:0]  apbPort_pstrb,
  input  [31:0] apbPort_pwdata,
  output        apbPort_pready,
  output [31:0] apbPort_prdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  mem_clock; // @[ChiselSyncMemory.scala 11:19]
  wire [8:0] mem_io_wordAddr; // @[ChiselSyncMemory.scala 11:19]
  wire  mem_io_write; // @[ChiselSyncMemory.scala 11:19]
  wire [31:0] mem_io_wrData; // @[ChiselSyncMemory.scala 11:19]
  wire [31:0] mem_io_rdData; // @[ChiselSyncMemory.scala 11:19]
  wire [3:0] mem_io_mask; // @[ChiselSyncMemory.scala 11:19]
  wire  _T_1 = apbPort_penable & apbPort_pwrite; // @[InstructionMemory.scala 56:32]
  wire [8:0] _GEN_4 = ~apbPort_pwrite ? apbPort_paddr[10:2] : apbPort_paddr[10:2]; // @[ChiselSyncMemory.scala 43:17 InstructionMemory.scala 54:27]
  wire  _GEN_8 = ~apbPort_pwrite ? 1'h0 : _T_1; // @[ChiselSyncMemory.scala 13:16 InstructionMemory.scala 54:27]
  wire [15:0] upr = mem_io_rdData[31:16]; // @[InstructionMemory.scala 67:19]
  wire [15:0] lwr = mem_io_rdData[15:0]; // @[InstructionMemory.scala 68:19]
  reg  instrPort_instr_REG; // @[InstructionMemory.scala 69:35]
  ChiselSyncMemory mem ( // @[ChiselSyncMemory.scala 11:19]
    .clock(mem_clock),
    .io_wordAddr(mem_io_wordAddr),
    .io_write(mem_io_write),
    .io_wrData(mem_io_wrData),
    .io_rdData(mem_io_rdData),
    .io_mask(mem_io_mask)
  );
  assign instrPort_instr = instrPort_instr_REG ? upr : lwr; // @[InstructionMemory.scala 69:27]
  assign apbPort_pready = apbPort_psel & apbPort_penable; // @[InstructionMemory.scala 44:18 50:22 52:20]
  assign apbPort_prdata = mem_io_rdData; // @[InstructionMemory.scala 54:27 55:22]
  assign mem_clock = clock;
  assign mem_io_wordAddr = apbPort_psel ? _GEN_4 : instrPort_addr[9:1]; // @[ChiselSyncMemory.scala 43:17 InstructionMemory.scala 50:22]
  assign mem_io_write = apbPort_psel & _GEN_8; // @[ChiselSyncMemory.scala 13:16 InstructionMemory.scala 50:22]
  assign mem_io_wrData = apbPort_pwdata; // @[ChiselSyncMemory.scala 49:15 InstructionMemory.scala 56:51]
  assign mem_io_mask = apbPort_pstrb; // @[ChiselSyncMemory.scala 50:13 InstructionMemory.scala 56:51]
  always @(posedge clock) begin
    instrPort_instr_REG <= instrPort_addr[0]; // @[InstructionMemory.scala 69:50]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  instrPort_instr_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstrMem(
  input         clock,
  input         reset,
  input  [10:0] io_addr,
  output [15:0] io_instr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] memReg; // @[InstrMem.scala 24:23]
  wire [15:0] _GEN_1 = 5'h1 == memReg[4:0] ? 16'h2100 : 16'h0; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_2 = 5'h2 == memReg[4:0] ? 16'h2980 : _GEN_1; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_3 = 5'h3 == memReg[4:0] ? 16'h2a00 : _GEN_2; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_4 = 5'h4 == memReg[4:0] ? 16'h3001 : _GEN_3; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_5 = 5'h5 == memReg[4:0] ? 16'h5001 : _GEN_4; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_6 = 5'h6 == memReg[4:0] ? 16'h2100 : _GEN_5; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_7 = 5'h7 == memReg[4:0] ? 16'h3002 : _GEN_6; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_8 = 5'h8 == memReg[4:0] ? 16'h2002 : _GEN_7; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_9 = 5'h9 == memReg[4:0] ? 16'h901 : _GEN_8; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_10 = 5'ha == memReg[4:0] ? 16'h3002 : _GEN_9; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_11 = 5'hb == memReg[4:0] ? 16'h7000 : _GEN_10; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_12 = 5'hc == memReg[4:0] ? 16'h7041 : _GEN_11; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_13 = 5'hd == memReg[4:0] ? 16'h2301 : _GEN_12; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_14 = 5'he == memReg[4:0] ? 16'h930 : _GEN_13; // @[InstrMem.scala 27:{12,12}]
  wire [15:0] _GEN_15 = 5'hf == memReg[4:0] ? 16'h7045 : _GEN_14; // @[InstrMem.scala 27:{12,12}]
  assign io_instr = 5'h10 == memReg[4:0] ? 16'h8ff8 : _GEN_15; // @[InstrMem.scala 27:{12,12}]
  always @(posedge clock) begin
    if (reset) begin // @[InstrMem.scala 24:23]
      memReg <= 11'h0; // @[InstrMem.scala 24:23]
    end else begin
      memReg <= io_addr; // @[InstrMem.scala 25:10]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  memReg = _RAND_0[10:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegBlock(
  input         clock,
  input         reset,
  input  [4:0]  apbPort_paddr,
  input         apbPort_psel,
  input         apbPort_penable,
  input         apbPort_pwrite,
  input  [31:0] apbPort_pwdata,
  output        apbPort_pready,
  output [31:0] apbPort_prdata,
  input  [2:0]  dmemPort_rdAddr,
  output [31:0] dmemPort_rdData,
  input  [2:0]  dmemPort_wrAddr,
  input  [31:0] dmemPort_wrData,
  input         dmemPort_wr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ibexToLerosRegs_0; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_1; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_2; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_3; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_4; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_5; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_6; // @[RegBlock.scala 34:32]
  reg [31:0] ibexToLerosRegs_7; // @[RegBlock.scala 34:32]
  reg [31:0] lerosToIbexRegs_0; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_1; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_2; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_3; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_4; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_5; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_6; // @[RegBlock.scala 35:32]
  reg [31:0] lerosToIbexRegs_7; // @[RegBlock.scala 35:32]
  wire [2:0] apbIndex = apbPort_paddr[4:2]; // @[RegBlock.scala 40:31]
  reg [2:0] apbPort_prdata_REG; // @[RegBlock.scala 41:44]
  wire [31:0] _GEN_1 = 3'h1 == apbPort_prdata_REG ? lerosToIbexRegs_1 : lerosToIbexRegs_0; // @[RegBlock.scala 41:{18,18}]
  wire [31:0] _GEN_2 = 3'h2 == apbPort_prdata_REG ? lerosToIbexRegs_2 : _GEN_1; // @[RegBlock.scala 41:{18,18}]
  wire [31:0] _GEN_3 = 3'h3 == apbPort_prdata_REG ? lerosToIbexRegs_3 : _GEN_2; // @[RegBlock.scala 41:{18,18}]
  wire [31:0] _GEN_4 = 3'h4 == apbPort_prdata_REG ? lerosToIbexRegs_4 : _GEN_3; // @[RegBlock.scala 41:{18,18}]
  wire [31:0] _GEN_5 = 3'h5 == apbPort_prdata_REG ? lerosToIbexRegs_5 : _GEN_4; // @[RegBlock.scala 41:{18,18}]
  wire [31:0] _GEN_6 = 3'h6 == apbPort_prdata_REG ? lerosToIbexRegs_6 : _GEN_5; // @[RegBlock.scala 41:{18,18}]
  reg [2:0] dmemPort_rdData_REG; // @[RegBlock.scala 52:45]
  wire [31:0] _GEN_34 = 3'h1 == dmemPort_rdData_REG ? ibexToLerosRegs_1 : ibexToLerosRegs_0; // @[RegBlock.scala 52:{19,19}]
  wire [31:0] _GEN_35 = 3'h2 == dmemPort_rdData_REG ? ibexToLerosRegs_2 : _GEN_34; // @[RegBlock.scala 52:{19,19}]
  wire [31:0] _GEN_36 = 3'h3 == dmemPort_rdData_REG ? ibexToLerosRegs_3 : _GEN_35; // @[RegBlock.scala 52:{19,19}]
  wire [31:0] _GEN_37 = 3'h4 == dmemPort_rdData_REG ? ibexToLerosRegs_4 : _GEN_36; // @[RegBlock.scala 52:{19,19}]
  wire [31:0] _GEN_38 = 3'h5 == dmemPort_rdData_REG ? ibexToLerosRegs_5 : _GEN_37; // @[RegBlock.scala 52:{19,19}]
  wire [31:0] _GEN_39 = 3'h6 == dmemPort_rdData_REG ? ibexToLerosRegs_6 : _GEN_38; // @[RegBlock.scala 52:{19,19}]
  assign apbPort_pready = apbPort_psel & apbPort_penable; // @[RegBlock.scala 43:21]
  assign apbPort_prdata = 3'h7 == apbPort_prdata_REG ? lerosToIbexRegs_7 : _GEN_6; // @[RegBlock.scala 41:{18,18}]
  assign dmemPort_rdData = 3'h7 == dmemPort_rdData_REG ? ibexToLerosRegs_7 : _GEN_39; // @[RegBlock.scala 52:{19,19}]
  always @(posedge clock) begin
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_0 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h0 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_0 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_1 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h1 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_1 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_2 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h2 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_2 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_3 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h3 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_3 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_4 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h4 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_4 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_5 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h5 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_5 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_6 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h6 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_6 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 34:32]
      ibexToLerosRegs_7 <= 32'h0; // @[RegBlock.scala 34:32]
    end else if (apbPort_psel & apbPort_penable) begin // @[RegBlock.scala 43:41]
      if (apbPort_pwrite) begin // @[RegBlock.scala 46:26]
        if (3'h7 == apbIndex) begin // @[RegBlock.scala 47:33]
          ibexToLerosRegs_7 <= apbPort_pwdata; // @[RegBlock.scala 47:33]
        end
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_0 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h0 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_0 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_1 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h1 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_1 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_2 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h2 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_2 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_3 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h3 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_3 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_4 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h4 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_4 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_5 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h5 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_5 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_6 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h6 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_6 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    if (reset) begin // @[RegBlock.scala 35:32]
      lerosToIbexRegs_7 <= 32'h0; // @[RegBlock.scala 35:32]
    end else if (dmemPort_wr) begin // @[RegBlock.scala 53:21]
      if (3'h7 == dmemPort_wrAddr) begin // @[RegBlock.scala 54:38]
        lerosToIbexRegs_7 <= dmemPort_wrData; // @[RegBlock.scala 54:38]
      end
    end
    apbPort_prdata_REG <= apbPort_paddr[4:2]; // @[RegBlock.scala 40:31]
    dmemPort_rdData_REG <= dmemPort_rdAddr; // @[RegBlock.scala 52:45]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ibexToLerosRegs_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  ibexToLerosRegs_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ibexToLerosRegs_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ibexToLerosRegs_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ibexToLerosRegs_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  ibexToLerosRegs_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  ibexToLerosRegs_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  ibexToLerosRegs_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  lerosToIbexRegs_0 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  lerosToIbexRegs_1 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  lerosToIbexRegs_2 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  lerosToIbexRegs_3 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  lerosToIbexRegs_4 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  lerosToIbexRegs_5 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  lerosToIbexRegs_6 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  lerosToIbexRegs_7 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  apbPort_prdata_REG = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  dmemPort_rdData_REG = _RAND_17[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Gpio(
  input         clock,
  input         reset,
  input  [1:0]  dmemPort_rdAddr,
  output [31:0] dmemPort_rdData,
  input  [1:0]  dmemPort_wrAddr,
  input  [31:0] dmemPort_wrData,
  input         dmemPort_wr,
  input  [3:0]  pmodPort_gpi,
  output [3:0]  pmodPort_gpo,
  output [3:0]  pmodPort_oe
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] oes; // @[Gpio.scala 21:20]
  reg [3:0] gpos; // @[Gpio.scala 22:21]
  reg [1:0] dmemPort_rdData_REG; // @[Gpio.scala 26:12]
  wire [3:0] _dmemPort_rdData_T_1 = 2'h0 == dmemPort_rdData_REG ? oes : 4'h0; // @[Mux.scala 81:58]
  wire [3:0] _dmemPort_rdData_T_3 = 2'h1 == dmemPort_rdData_REG ? gpos : _dmemPort_rdData_T_1; // @[Mux.scala 81:58]
  wire [3:0] _dmemPort_rdData_T_5 = 2'h2 == dmemPort_rdData_REG ? pmodPort_gpi : _dmemPort_rdData_T_3; // @[Mux.scala 81:58]
  wire [31:0] _GEN_0 = 2'h1 == dmemPort_wrAddr ? dmemPort_wrData : {{28'd0}, gpos}; // @[Gpio.scala 36:29 41:14 22:21]
  wire [31:0] _GEN_1 = 2'h0 == dmemPort_wrAddr ? dmemPort_wrData : {{28'd0}, oes}; // @[Gpio.scala 36:29 38:13 21:20]
  wire [31:0] _GEN_2 = 2'h0 == dmemPort_wrAddr ? {{28'd0}, gpos} : _GEN_0; // @[Gpio.scala 22:21 36:29]
  wire [31:0] _GEN_3 = dmemPort_wr ? _GEN_1 : {{28'd0}, oes}; // @[Gpio.scala 21:20 35:21]
  wire [31:0] _GEN_4 = dmemPort_wr ? _GEN_2 : {{28'd0}, gpos}; // @[Gpio.scala 22:21 35:21]
  wire [31:0] _GEN_5 = reset ? 32'h0 : _GEN_3; // @[Gpio.scala 21:{20,20}]
  wire [31:0] _GEN_6 = reset ? 32'h0 : _GEN_4; // @[Gpio.scala 22:{21,21}]
  assign dmemPort_rdData = {{28'd0}, _dmemPort_rdData_T_5}; // @[Gpio.scala 25:19]
  assign pmodPort_gpo = gpos; // @[Gpio.scala 46:16]
  assign pmodPort_oe = oes; // @[Gpio.scala 47:15]
  always @(posedge clock) begin
    oes <= _GEN_5[3:0]; // @[Gpio.scala 21:{20,20}]
    gpos <= _GEN_6[3:0]; // @[Gpio.scala 22:{21,21}]
    dmemPort_rdData_REG <= dmemPort_rdAddr; // @[Gpio.scala 26:12]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  oes = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  gpos = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  dmemPort_rdData_REG = _RAND_2[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ChiselSyncMemory_1(
  input         clock,
  input  [5:0]  io_wordAddr,
  input         io_write,
  input  [31:0] io_wrData,
  output [31:0] io_rdData,
  input  [3:0]  io_mask
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:63]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_0_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_0_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_0_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_0_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_0_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_0_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_0_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_0_io_rdData_MPORT_en_pipe_0;
  reg [5:0] mem_0_io_rdData_MPORT_addr_pipe_0;
  reg [7:0] mem_1 [0:63]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_1_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_1_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_1_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_1_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_1_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_1_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_1_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_1_io_rdData_MPORT_en_pipe_0;
  reg [5:0] mem_1_io_rdData_MPORT_addr_pipe_0;
  reg [7:0] mem_2 [0:63]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_2_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_2_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_2_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_2_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_2_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_2_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_2_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_2_io_rdData_MPORT_en_pipe_0;
  reg [5:0] mem_2_io_rdData_MPORT_addr_pipe_0;
  reg [7:0] mem_3 [0:63]; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_3_io_rdData_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_3_io_rdData_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_3_io_rdData_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [7:0] mem_3_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
  wire [5:0] mem_3_MPORT_addr; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_3_MPORT_mask; // @[ChiselSyncMemory.scala 30:24]
  wire  mem_3_MPORT_en; // @[ChiselSyncMemory.scala 30:24]
  reg  mem_3_io_rdData_MPORT_en_pipe_0;
  reg [5:0] mem_3_io_rdData_MPORT_addr_pipe_0;
  wire [32:0] _io_rdData_T_5 = {1'h0,mem_3_io_rdData_MPORT_data,mem_2_io_rdData_MPORT_data,mem_1_io_rdData_MPORT_data,
    mem_0_io_rdData_MPORT_data}; // @[Helper.scala 25:49]
  assign mem_0_io_rdData_MPORT_en = mem_0_io_rdData_MPORT_en_pipe_0;
  assign mem_0_io_rdData_MPORT_addr = mem_0_io_rdData_MPORT_addr_pipe_0;
  assign mem_0_io_rdData_MPORT_data = mem_0[mem_0_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_0_MPORT_data = io_wrData[7:0];
  assign mem_0_MPORT_addr = io_wordAddr;
  assign mem_0_MPORT_mask = io_mask[0];
  assign mem_0_MPORT_en = io_write;
  assign mem_1_io_rdData_MPORT_en = mem_1_io_rdData_MPORT_en_pipe_0;
  assign mem_1_io_rdData_MPORT_addr = mem_1_io_rdData_MPORT_addr_pipe_0;
  assign mem_1_io_rdData_MPORT_data = mem_1[mem_1_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_1_MPORT_data = io_wrData[15:8];
  assign mem_1_MPORT_addr = io_wordAddr;
  assign mem_1_MPORT_mask = io_mask[1];
  assign mem_1_MPORT_en = io_write;
  assign mem_2_io_rdData_MPORT_en = mem_2_io_rdData_MPORT_en_pipe_0;
  assign mem_2_io_rdData_MPORT_addr = mem_2_io_rdData_MPORT_addr_pipe_0;
  assign mem_2_io_rdData_MPORT_data = mem_2[mem_2_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_2_MPORT_data = io_wrData[23:16];
  assign mem_2_MPORT_addr = io_wordAddr;
  assign mem_2_MPORT_mask = io_mask[2];
  assign mem_2_MPORT_en = io_write;
  assign mem_3_io_rdData_MPORT_en = mem_3_io_rdData_MPORT_en_pipe_0;
  assign mem_3_io_rdData_MPORT_addr = mem_3_io_rdData_MPORT_addr_pipe_0;
  assign mem_3_io_rdData_MPORT_data = mem_3[mem_3_io_rdData_MPORT_addr]; // @[ChiselSyncMemory.scala 30:24]
  assign mem_3_MPORT_data = io_wrData[31:24];
  assign mem_3_MPORT_addr = io_wordAddr;
  assign mem_3_MPORT_mask = io_mask[3];
  assign mem_3_MPORT_en = io_write;
  assign io_rdData = _io_rdData_T_5[31:0];
  always @(posedge clock) begin
    if (mem_0_MPORT_en & mem_0_MPORT_mask) begin
      mem_0[mem_0_MPORT_addr] <= mem_0_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_0_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_0_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_0_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
    if (mem_1_MPORT_en & mem_1_MPORT_mask) begin
      mem_1[mem_1_MPORT_addr] <= mem_1_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_1_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_1_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_1_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
    if (mem_2_MPORT_en & mem_2_MPORT_mask) begin
      mem_2[mem_2_MPORT_addr] <= mem_2_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_2_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_2_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_2_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
    if (mem_3_MPORT_en & mem_3_MPORT_mask) begin
      mem_3[mem_3_MPORT_addr] <= mem_3_MPORT_data; // @[ChiselSyncMemory.scala 30:24]
    end
    if (io_write) begin
      mem_3_io_rdData_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_3_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_write ? 1'h0 : 1'h1) begin
      mem_3_io_rdData_MPORT_addr_pipe_0 <= io_wordAddr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    mem_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    mem_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    mem_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_io_rdData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_io_rdData_MPORT_addr_pipe_0 = _RAND_2[5:0];
  _RAND_4 = {1{`RANDOM}};
  mem_1_io_rdData_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_1_io_rdData_MPORT_addr_pipe_0 = _RAND_5[5:0];
  _RAND_7 = {1{`RANDOM}};
  mem_2_io_rdData_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_2_io_rdData_MPORT_addr_pipe_0 = _RAND_8[5:0];
  _RAND_10 = {1{`RANDOM}};
  mem_3_io_rdData_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_3_io_rdData_MPORT_addr_pipe_0 = _RAND_11[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataMemory(
  input         clock,
  input  [5:0]  dmemPort_rdAddr,
  output [31:0] dmemPort_rdData,
  input  [5:0]  dmemPort_wrAddr,
  input  [31:0] dmemPort_wrData,
  input         dmemPort_wr,
  input  [3:0]  dmemPort_wrMask
);
  wire  mem_clock; // @[ChiselSyncMemory.scala 11:19]
  wire [5:0] mem_io_wordAddr; // @[ChiselSyncMemory.scala 11:19]
  wire  mem_io_write; // @[ChiselSyncMemory.scala 11:19]
  wire [31:0] mem_io_wrData; // @[ChiselSyncMemory.scala 11:19]
  wire [31:0] mem_io_rdData; // @[ChiselSyncMemory.scala 11:19]
  wire [3:0] mem_io_mask; // @[ChiselSyncMemory.scala 11:19]
  ChiselSyncMemory_1 mem ( // @[ChiselSyncMemory.scala 11:19]
    .clock(mem_clock),
    .io_wordAddr(mem_io_wordAddr),
    .io_write(mem_io_write),
    .io_wrData(mem_io_wrData),
    .io_rdData(mem_io_rdData),
    .io_mask(mem_io_mask)
  );
  assign dmemPort_rdData = mem_io_rdData; // @[DataMemory.scala 17:19]
  assign mem_clock = clock;
  assign mem_io_wordAddr = dmemPort_wr ? dmemPort_wrAddr : dmemPort_rdAddr; // @[DataMemory.scala 19:21 ChiselSyncMemory.scala 43:17 48:17]
  assign mem_io_write = dmemPort_wr; // @[DataMemory.scala 19:21 ChiselSyncMemory.scala 51:14 13:16]
  assign mem_io_wrData = dmemPort_wrData; // @[DataMemory.scala 19:21 ChiselSyncMemory.scala 49:15]
  assign mem_io_mask = dmemPort_wrMask; // @[DataMemory.scala 19:21 ChiselSyncMemory.scala 50:13]
endmodule
module Tx_1(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] shiftReg; // @[UARTTx.scala 29:25]
  reg  cntReg; // @[UARTTx.scala 30:23]
  reg [3:0] bitsReg; // @[UARTTx.scala 31:24]
  wire  _io_channel_ready_T = ~cntReg; // @[UARTTx.scala 33:31]
  wire [9:0] shift = shiftReg[10:1]; // @[UARTTx.scala 40:28]
  wire [10:0] _shiftReg_T_1 = {1'h1,shift}; // @[UARTTx.scala 41:23]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[UARTTx.scala 42:26]
  wire [10:0] _shiftReg_T_3 = {2'h3,io_channel_bits,1'h0}; // @[UARTTx.scala 45:49]
  wire  _GEN_0 = io_channel_valid | cntReg; // @[UARTTx.scala 43:34 44:16 30:23]
  wire  _GEN_3 = bitsReg != 4'h0 | _GEN_0; // @[UARTTx.scala 38:27 39:14]
  assign io_txd = shiftReg[0]; // @[UARTTx.scala 34:21]
  assign io_channel_ready = ~cntReg & bitsReg == 4'h0; // @[UARTTx.scala 33:40]
  always @(posedge clock) begin
    if (reset) begin // @[UARTTx.scala 29:25]
      shiftReg <= 11'h7ff; // @[UARTTx.scala 29:25]
    end else if (_io_channel_ready_T) begin // @[UARTTx.scala 36:24]
      if (bitsReg != 4'h0) begin // @[UARTTx.scala 38:27]
        shiftReg <= _shiftReg_T_1; // @[UARTTx.scala 41:16]
      end else if (io_channel_valid) begin // @[UARTTx.scala 43:34]
        shiftReg <= _shiftReg_T_3; // @[UARTTx.scala 45:18]
      end
    end
    if (reset) begin // @[UARTTx.scala 30:23]
      cntReg <= 1'h0; // @[UARTTx.scala 30:23]
    end else if (_io_channel_ready_T) begin // @[UARTTx.scala 36:24]
      cntReg <= _GEN_3;
    end else begin
      cntReg <= cntReg - 1'h1; // @[UARTTx.scala 50:12]
    end
    if (reset) begin // @[UARTTx.scala 31:24]
      bitsReg <= 4'h0; // @[UARTTx.scala 31:24]
    end else if (_io_channel_ready_T) begin // @[UARTTx.scala 36:24]
      if (bitsReg != 4'h0) begin // @[UARTTx.scala 38:27]
        bitsReg <= _bitsReg_T_1; // @[UARTTx.scala 42:15]
      end else if (io_channel_valid) begin // @[UARTTx.scala 43:34]
        bitsReg <= 4'hb; // @[UARTTx.scala 46:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shiftReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Buffer(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[UARTRx.scala 80:25]
  reg [7:0] dataReg; // @[UARTRx.scala 81:24]
  wire  _io_in_ready_T = ~stateReg; // @[UARTRx.scala 83:27]
  wire  _GEN_1 = io_in_valid | stateReg; // @[UARTRx.scala 87:23 89:16 80:25]
  assign io_in_ready = ~stateReg; // @[UARTRx.scala 83:27]
  assign io_out_valid = stateReg; // @[UARTRx.scala 84:28]
  assign io_out_bits = dataReg; // @[UARTRx.scala 96:15]
  always @(posedge clock) begin
    if (reset) begin // @[UARTRx.scala 80:25]
      stateReg <= 1'h0; // @[UARTRx.scala 80:25]
    end else if (_io_in_ready_T) begin // @[UARTRx.scala 86:28]
      stateReg <= _GEN_1;
    end else if (io_out_ready) begin // @[UARTRx.scala 92:24]
      stateReg <= 1'h0; // @[UARTRx.scala 93:16]
    end
    if (reset) begin // @[UARTRx.scala 81:24]
      dataReg <= 8'h0; // @[UARTRx.scala 81:24]
    end else if (_io_in_ready_T) begin // @[UARTRx.scala 86:28]
      if (io_in_valid) begin // @[UARTRx.scala 87:23]
        dataReg <= io_in_bits; // @[UARTRx.scala 88:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BufferedTx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
  wire  tx_clock; // @[UARTTx.scala 63:18]
  wire  tx_reset; // @[UARTTx.scala 63:18]
  wire  tx_io_txd; // @[UARTTx.scala 63:18]
  wire  tx_io_channel_ready; // @[UARTTx.scala 63:18]
  wire  tx_io_channel_valid; // @[UARTTx.scala 63:18]
  wire [7:0] tx_io_channel_bits; // @[UARTTx.scala 63:18]
  wire  buf__clock; // @[UARTTx.scala 64:19]
  wire  buf__reset; // @[UARTTx.scala 64:19]
  wire  buf__io_in_ready; // @[UARTTx.scala 64:19]
  wire  buf__io_in_valid; // @[UARTTx.scala 64:19]
  wire [7:0] buf__io_in_bits; // @[UARTTx.scala 64:19]
  wire  buf__io_out_ready; // @[UARTTx.scala 64:19]
  wire  buf__io_out_valid; // @[UARTTx.scala 64:19]
  wire [7:0] buf__io_out_bits; // @[UARTTx.scala 64:19]
  Tx_1 tx ( // @[UARTTx.scala 63:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  Buffer buf_ ( // @[UARTTx.scala 64:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_txd = tx_io_txd; // @[UARTTx.scala 68:10]
  assign io_channel_ready = buf__io_in_ready; // @[UARTTx.scala 66:13]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = buf__io_out_valid; // @[UARTTx.scala 67:17]
  assign tx_io_channel_bits = buf__io_out_bits; // @[UARTTx.scala 67:17]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = io_channel_valid; // @[UARTTx.scala 66:13]
  assign buf__io_in_bits = io_channel_bits; // @[UARTTx.scala 66:13]
  assign buf__io_out_ready = tx_io_channel_ready; // @[UARTTx.scala 67:17]
endmodule
module Rx_1(
  input        clock,
  input        reset,
  input        io_rxd,
  input        io_channel_ready,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[UARTRx.scala 34:30]
  reg  rxReg; // @[UARTRx.scala 34:22]
  reg  falling_REG; // @[UARTRx.scala 35:35]
  wire  falling = ~rxReg & falling_REG; // @[UARTRx.scala 35:24]
  reg [7:0] shiftReg; // @[UARTRx.scala 37:25]
  reg [19:0] cntReg; // @[UARTRx.scala 38:23]
  reg [3:0] bitsReg; // @[UARTRx.scala 39:24]
  reg  valReg; // @[UARTRx.scala 40:23]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[UARTRx.scala 43:22]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[UARTRx.scala 47:24]
  wire  _GEN_0 = bitsReg == 4'h1 | valReg; // @[UARTRx.scala 49:27 50:14 40:23]
  assign io_channel_valid = valReg; // @[UARTRx.scala 62:20]
  assign io_channel_bits = shiftReg; // @[UARTRx.scala 61:19]
  always @(posedge clock) begin
    if (reset) begin // @[UARTRx.scala 34:30]
      rxReg_REG <= 1'h0; // @[UARTRx.scala 34:30]
    end else begin
      rxReg_REG <= io_rxd; // @[UARTRx.scala 34:30]
    end
    if (reset) begin // @[UARTRx.scala 34:22]
      rxReg <= 1'h0; // @[UARTRx.scala 34:22]
    end else begin
      rxReg <= rxReg_REG; // @[UARTRx.scala 34:22]
    end
    falling_REG <= rxReg; // @[UARTRx.scala 35:35]
    if (reset) begin // @[UARTRx.scala 37:25]
      shiftReg <= 8'h0; // @[UARTRx.scala 37:25]
    end else if (!(cntReg != 20'h0)) begin // @[UARTRx.scala 42:24]
      if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
        shiftReg <= _shiftReg_T_1; // @[UARTRx.scala 46:14]
      end
    end
    if (reset) begin // @[UARTRx.scala 38:23]
      cntReg <= 20'h1; // @[UARTRx.scala 38:23]
    end else if (cntReg != 20'h0) begin // @[UARTRx.scala 42:24]
      cntReg <= _cntReg_T_1; // @[UARTRx.scala 43:12]
    end else if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
      cntReg <= 20'h1; // @[UARTRx.scala 45:12]
    end else if (falling) begin // @[UARTRx.scala 52:23]
      cntReg <= 20'h1; // @[UARTRx.scala 53:12]
    end
    if (reset) begin // @[UARTRx.scala 39:24]
      bitsReg <= 4'h0; // @[UARTRx.scala 39:24]
    end else if (!(cntReg != 20'h0)) begin // @[UARTRx.scala 42:24]
      if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
        bitsReg <= _bitsReg_T_1; // @[UARTRx.scala 47:13]
      end else if (falling) begin // @[UARTRx.scala 52:23]
        bitsReg <= 4'h8; // @[UARTRx.scala 54:13]
      end
    end
    if (reset) begin // @[UARTRx.scala 40:23]
      valReg <= 1'h0; // @[UARTRx.scala 40:23]
    end else if (valReg & io_channel_ready) begin // @[UARTRx.scala 57:36]
      valReg <= 1'h0; // @[UARTRx.scala 58:12]
    end else if (!(cntReg != 20'h0)) begin // @[UARTRx.scala 42:24]
      if (bitsReg != 4'h0) begin // @[UARTRx.scala 44:31]
        valReg <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  falling_REG = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  shiftReg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  cntReg = _RAND_4[19:0];
  _RAND_5 = {1{`RANDOM}};
  bitsReg = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  valReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UARTRx(
  input        clock,
  input        reset,
  input        io_rxd,
  output       io_out_valid,
  output [7:0] io_out_bits
);
  wire  rx_clock; // @[UARTRx.scala 107:18]
  wire  rx_reset; // @[UARTRx.scala 107:18]
  wire  rx_io_rxd; // @[UARTRx.scala 107:18]
  wire  rx_io_channel_ready; // @[UARTRx.scala 107:18]
  wire  rx_io_channel_valid; // @[UARTRx.scala 107:18]
  wire [7:0] rx_io_channel_bits; // @[UARTRx.scala 107:18]
  wire  buf__clock; // @[UARTRx.scala 108:19]
  wire  buf__reset; // @[UARTRx.scala 108:19]
  wire  buf__io_in_ready; // @[UARTRx.scala 108:19]
  wire  buf__io_in_valid; // @[UARTRx.scala 108:19]
  wire [7:0] buf__io_in_bits; // @[UARTRx.scala 108:19]
  wire  buf__io_out_ready; // @[UARTRx.scala 108:19]
  wire  buf__io_out_valid; // @[UARTRx.scala 108:19]
  wire [7:0] buf__io_out_bits; // @[UARTRx.scala 108:19]
  Rx_1 rx ( // @[UARTRx.scala 107:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rxd(rx_io_rxd),
    .io_channel_ready(rx_io_channel_ready),
    .io_channel_valid(rx_io_channel_valid),
    .io_channel_bits(rx_io_channel_bits)
  );
  Buffer buf_ ( // @[UARTRx.scala 108:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_out_valid = buf__io_out_valid; // @[UARTRx.scala 115:10]
  assign io_out_bits = buf__io_out_bits; // @[UARTRx.scala 115:10]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rxd = io_rxd; // @[UARTRx.scala 112:13]
  assign rx_io_channel_ready = buf__io_in_ready; // @[UARTRx.scala 113:17]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = rx_io_channel_valid; // @[UARTRx.scala 113:17]
  assign buf__io_in_bits = rx_io_channel_bits; // @[UARTRx.scala 113:17]
  assign buf__io_out_ready = 1'h0; // @[UARTRx.scala 115:10]
endmodule
module Uart(
  input         clock,
  input         reset,
  output        uartPins_tx,
  input         uartPins_rx,
  input         dmemPort_rdAddr,
  output [31:0] dmemPort_rdData,
  input         dmemPort_wrAddr,
  input  [31:0] dmemPort_wrData,
  input         dmemPort_wr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  tx_clock; // @[Uart.scala 29:18]
  wire  tx_reset; // @[Uart.scala 29:18]
  wire  tx_io_txd; // @[Uart.scala 29:18]
  wire  tx_io_channel_ready; // @[Uart.scala 29:18]
  wire  tx_io_channel_valid; // @[Uart.scala 29:18]
  wire [7:0] tx_io_channel_bits; // @[Uart.scala 29:18]
  wire  rx_clock; // @[Uart.scala 30:18]
  wire  rx_reset; // @[Uart.scala 30:18]
  wire  rx_io_rxd; // @[Uart.scala 30:18]
  wire  rx_io_out_valid; // @[Uart.scala 30:18]
  wire [7:0] rx_io_out_bits; // @[Uart.scala 30:18]
  reg  REG; // @[Uart.scala 39:15]
  wire [1:0] _dmemPort_rdData_T = {tx_io_channel_ready,rx_io_out_valid}; // @[Uart.scala 40:44]
  wire [7:0] _GEN_0 = REG ? {{6'd0}, _dmemPort_rdData_T} : rx_io_out_bits; // @[Uart.scala 39:42 40:21 42:21]
  wire  _GEN_2 = ~dmemPort_wrAddr ? 1'h0 : dmemPort_wrAddr; // @[Uart.scala 32:23 46:29]
  BufferedTx tx ( // @[Uart.scala 29:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  UARTRx rx ( // @[Uart.scala 30:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rxd(rx_io_rxd),
    .io_out_valid(rx_io_out_valid),
    .io_out_bits(rx_io_out_bits)
  );
  assign uartPins_tx = tx_io_txd; // @[Uart.scala 34:15]
  assign dmemPort_rdData = {{24'd0}, _GEN_0};
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = dmemPort_wr & _GEN_2; // @[Uart.scala 45:21 32:23]
  assign tx_io_channel_bits = dmemPort_wrData[7:0]; // @[Uart.scala 33:22]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rxd = uartPins_rx; // @[Uart.scala 37:13]
  always @(posedge clock) begin
    REG <= ~dmemPort_rdAddr; // @[Uart.scala 39:32]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ApbArbiter(
  input         clock,
  input         reset,
  input  [15:0] io_masters_0_paddr,
  input         io_masters_0_psel,
  input         io_masters_0_penable,
  input         io_masters_0_pwrite,
  input  [31:0] io_masters_0_pwdata,
  output        io_masters_0_pready,
  output [31:0] io_masters_0_prdata,
  input  [15:0] io_masters_1_paddr,
  input         io_masters_1_psel,
  input         io_masters_1_penable,
  input         io_masters_1_pwrite,
  input  [3:0]  io_masters_1_pstrb,
  input  [31:0] io_masters_1_pwdata,
  output        io_masters_1_pready,
  output [31:0] io_masters_1_prdata,
  output [15:0] io_merged_paddr,
  output        io_merged_psel,
  output        io_merged_penable,
  output        io_merged_pwrite,
  output [3:0]  io_merged_pstrb,
  output [31:0] io_merged_pwdata,
  input         io_merged_pready,
  input  [31:0] io_merged_prdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] stateReg; // @[ApbArbiter.scala 36:25]
  wire [2:0] _GEN_2 = io_merged_pready ? 3'h0 : stateReg; // @[ApbArbiter.scala 60:30 61:18 36:25]
  wire  _GEN_4 = 3'h4 == stateReg & io_masters_1_psel; // @[ApbArbiter.scala 45:20 70:17 41:18]
  wire  _GEN_5 = 3'h4 == stateReg & io_masters_1_penable; // @[ApbArbiter.scala 45:20 70:17 42:21]
  wire  _GEN_9 = 3'h4 == stateReg & io_merged_pready; // @[ApbArbiter.scala 45:20 70:17 39:31]
  wire [2:0] _GEN_12 = 3'h4 == stateReg ? _GEN_2 : stateReg; // @[ApbArbiter.scala 45:20 36:25]
  wire  _GEN_14 = 3'h3 == stateReg ? io_masters_1_psel : _GEN_4; // @[ApbArbiter.scala 45:20 65:17]
  wire  _GEN_15 = 3'h3 == stateReg ? 1'h0 : _GEN_5; // @[ApbArbiter.scala 45:20 66:25]
  wire  _GEN_19 = 3'h3 == stateReg ? io_merged_pready : _GEN_9; // @[ApbArbiter.scala 45:20 65:17]
  wire [2:0] _GEN_22 = 3'h3 == stateReg ? 3'h4 : _GEN_12; // @[ApbArbiter.scala 45:20 67:16]
  wire [15:0] _GEN_23 = 3'h2 == stateReg ? io_masters_0_paddr : io_masters_1_paddr; // @[ApbArbiter.scala 45:20 59:17]
  wire  _GEN_24 = 3'h2 == stateReg ? io_masters_0_psel : _GEN_14; // @[ApbArbiter.scala 45:20 59:17]
  wire  _GEN_25 = 3'h2 == stateReg ? io_masters_0_penable : _GEN_15; // @[ApbArbiter.scala 45:20 59:17]
  wire  _GEN_26 = 3'h2 == stateReg ? io_masters_0_pwrite : io_masters_1_pwrite; // @[ApbArbiter.scala 45:20 59:17]
  wire [3:0] _GEN_27 = 3'h2 == stateReg ? 4'hf : io_masters_1_pstrb; // @[ApbArbiter.scala 45:20 59:17]
  wire [31:0] _GEN_28 = 3'h2 == stateReg ? io_masters_0_pwdata : io_masters_1_pwdata; // @[ApbArbiter.scala 45:20 59:17]
  wire  _GEN_29 = 3'h2 == stateReg & io_merged_pready; // @[ApbArbiter.scala 45:20 59:17 39:31]
  wire  _GEN_33 = 3'h2 == stateReg ? 1'h0 : _GEN_19; // @[ApbArbiter.scala 45:20 39:31]
  wire [15:0] _GEN_36 = 3'h1 == stateReg ? io_masters_0_paddr : _GEN_23; // @[ApbArbiter.scala 45:20 54:17]
  wire  _GEN_37 = 3'h1 == stateReg ? io_masters_0_psel : _GEN_24; // @[ApbArbiter.scala 45:20 54:17]
  wire  _GEN_38 = 3'h1 == stateReg ? 1'h0 : _GEN_25; // @[ApbArbiter.scala 45:20 55:25]
  wire  _GEN_39 = 3'h1 == stateReg ? io_masters_0_pwrite : _GEN_26; // @[ApbArbiter.scala 45:20 54:17]
  wire [3:0] _GEN_40 = 3'h1 == stateReg ? 4'hf : _GEN_27; // @[ApbArbiter.scala 45:20 54:17]
  wire [31:0] _GEN_41 = 3'h1 == stateReg ? io_masters_0_pwdata : _GEN_28; // @[ApbArbiter.scala 45:20 54:17]
  wire  _GEN_42 = 3'h1 == stateReg ? io_merged_pready : _GEN_29; // @[ApbArbiter.scala 45:20 54:17]
  wire  _GEN_46 = 3'h1 == stateReg ? 1'h0 : _GEN_33; // @[ApbArbiter.scala 45:20 39:31]
  assign io_masters_0_pready = 3'h0 == stateReg ? 1'h0 : _GEN_42; // @[ApbArbiter.scala 45:20 39:31]
  assign io_masters_0_prdata = io_merged_prdata; // @[ApbArbiter.scala 45:20 38:24]
  assign io_masters_1_pready = 3'h0 == stateReg ? 1'h0 : _GEN_46; // @[ApbArbiter.scala 45:20 39:31]
  assign io_masters_1_prdata = io_merged_prdata; // @[ApbArbiter.scala 45:20 38:24]
  assign io_merged_paddr = 3'h0 == stateReg ? io_masters_1_paddr : _GEN_36; // @[ApbArbiter.scala 45:20 38:24]
  assign io_merged_psel = 3'h0 == stateReg ? 1'h0 : _GEN_37; // @[ApbArbiter.scala 41:18 45:20]
  assign io_merged_penable = 3'h0 == stateReg ? 1'h0 : _GEN_38; // @[ApbArbiter.scala 45:20 42:21]
  assign io_merged_pwrite = 3'h0 == stateReg ? io_masters_1_pwrite : _GEN_39; // @[ApbArbiter.scala 45:20 38:24]
  assign io_merged_pstrb = 3'h0 == stateReg ? io_masters_1_pstrb : _GEN_40; // @[ApbArbiter.scala 45:20 38:24]
  assign io_merged_pwdata = 3'h0 == stateReg ? io_masters_1_pwdata : _GEN_41; // @[ApbArbiter.scala 45:20 38:24]
  always @(posedge clock) begin
    if (reset) begin // @[ApbArbiter.scala 36:25]
      stateReg <= 3'h0; // @[ApbArbiter.scala 36:25]
    end else if (3'h0 == stateReg) begin // @[ApbArbiter.scala 45:20]
      if (io_masters_0_psel) begin // @[ApbArbiter.scala 47:32]
        stateReg <= 3'h1; // @[ApbArbiter.scala 48:18]
      end else if (io_masters_1_psel) begin // @[ApbArbiter.scala 49:38]
        stateReg <= 3'h3; // @[ApbArbiter.scala 50:18]
      end
    end else if (3'h1 == stateReg) begin // @[ApbArbiter.scala 45:20]
      stateReg <= 3'h2; // @[ApbArbiter.scala 56:16]
    end else if (3'h2 == stateReg) begin // @[ApbArbiter.scala 45:20]
      stateReg <= _GEN_2;
    end else begin
      stateReg <= _GEN_22;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ApbMux(
  input  [15:0] io_master_paddr,
  input         io_master_psel,
  input         io_master_penable,
  input         io_master_pwrite,
  input  [3:0]  io_master_pstrb,
  input  [31:0] io_master_pwdata,
  output        io_master_pready,
  output [31:0] io_master_prdata,
  output [15:0] io_targets_0_paddr,
  output        io_targets_0_psel,
  output        io_targets_0_penable,
  output        io_targets_0_pwrite,
  output [3:0]  io_targets_0_pstrb,
  output [31:0] io_targets_0_pwdata,
  input         io_targets_0_pready,
  input  [31:0] io_targets_0_prdata,
  output [15:0] io_targets_1_paddr,
  output        io_targets_1_psel,
  output        io_targets_1_penable,
  output        io_targets_1_pwrite,
  output [31:0] io_targets_1_pwdata,
  input         io_targets_1_pready,
  input  [31:0] io_targets_1_prdata,
  output        io_targets_2_psel,
  output        io_targets_2_penable,
  output        io_targets_2_pwrite,
  output [31:0] io_targets_2_pwdata,
  input         io_targets_2_pready,
  input  [31:0] io_targets_2_prdata
);
  wire  selected = io_master_psel & io_master_paddr[15:11] == 5'h0; // @[ApbMux.scala 51:37]
  wire  _GEN_1 = selected ? io_targets_0_pready : io_targets_2_pready; // @[ApbMux.scala 53:22 55:26 28:7]
  wire [31:0] _GEN_2 = selected ? io_targets_0_prdata : io_targets_2_prdata; // @[ApbMux.scala 53:22 56:26 28:7]
  wire  selected_1 = io_master_psel & io_master_paddr[15:5] == 11'h40; // @[ApbMux.scala 51:37]
  wire  _GEN_5 = selected_1 ? io_targets_1_pready : _GEN_1; // @[ApbMux.scala 53:22 55:26]
  wire [31:0] _GEN_6 = selected_1 ? io_targets_1_prdata : _GEN_2; // @[ApbMux.scala 53:22 56:26]
  wire  selected_2 = io_master_psel & io_master_paddr[15:2] == 14'h300; // @[ApbMux.scala 51:37]
  assign io_master_pready = selected_2 ? io_targets_2_pready : _GEN_5; // @[ApbMux.scala 53:22 55:26]
  assign io_master_prdata = selected_2 ? io_targets_2_prdata : _GEN_6; // @[ApbMux.scala 53:22 56:26]
  assign io_targets_0_paddr = io_master_paddr; // @[ApbMux.scala 28:7]
  assign io_targets_0_psel = io_master_psel & io_master_paddr[15:11] == 5'h0; // @[ApbMux.scala 51:37]
  assign io_targets_0_penable = io_master_penable; // @[ApbMux.scala 28:7]
  assign io_targets_0_pwrite = io_master_pwrite; // @[ApbMux.scala 28:7]
  assign io_targets_0_pstrb = io_master_pstrb; // @[ApbMux.scala 28:7]
  assign io_targets_0_pwdata = io_master_pwdata; // @[ApbMux.scala 28:7]
  assign io_targets_1_paddr = io_master_paddr; // @[ApbMux.scala 28:7]
  assign io_targets_1_psel = io_master_psel & io_master_paddr[15:5] == 11'h40; // @[ApbMux.scala 51:37]
  assign io_targets_1_penable = io_master_penable; // @[ApbMux.scala 28:7]
  assign io_targets_1_pwrite = io_master_pwrite; // @[ApbMux.scala 28:7]
  assign io_targets_1_pwdata = io_master_pwdata; // @[ApbMux.scala 28:7]
  assign io_targets_2_psel = io_master_psel & io_master_paddr[15:2] == 14'h300; // @[ApbMux.scala 51:37]
  assign io_targets_2_penable = io_master_penable; // @[ApbMux.scala 28:7]
  assign io_targets_2_pwrite = io_master_pwrite; // @[ApbMux.scala 28:7]
  assign io_targets_2_pwdata = io_master_pwdata; // @[ApbMux.scala 28:7]
endmodule
module DataMemMux(
  input         clock,
  input         reset,
  input  [15:0] io_master_rdAddr,
  output [31:0] io_master_rdData,
  input  [15:0] io_master_wrAddr,
  input  [31:0] io_master_wrData,
  input         io_master_wr,
  input  [3:0]  io_master_wrMask,
  output [15:0] io_targets_0_rdAddr,
  input  [31:0] io_targets_0_rdData,
  output [15:0] io_targets_0_wrAddr,
  output [31:0] io_targets_0_wrData,
  output        io_targets_0_wr,
  output [3:0]  io_targets_0_wrMask,
  output [15:0] io_targets_1_rdAddr,
  input  [31:0] io_targets_1_rdData,
  output [15:0] io_targets_1_wrAddr,
  output [31:0] io_targets_1_wrData,
  output        io_targets_1_wr,
  output [15:0] io_targets_2_rdAddr,
  input  [31:0] io_targets_2_rdData,
  output [15:0] io_targets_2_wrAddr,
  output [31:0] io_targets_2_wrData,
  output        io_targets_2_wr,
  output [15:0] io_targets_3_rdAddr,
  input  [31:0] io_targets_3_rdData,
  output [15:0] io_targets_3_wrAddr,
  output [31:0] io_targets_3_wrData,
  output        io_targets_3_wr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  rdSelected = io_master_rdAddr[15:6] == 10'h0; // @[DataMemMux.scala 55:80]
  reg  REG; // @[DataMemMux.scala 57:17]
  wire [31:0] _GEN_0 = REG ? io_targets_0_rdData : io_targets_3_rdData; // @[DataMemMux.scala 57:36 58:24 50:7]
  wire  wrSelected = io_master_wrAddr[15:6] == 10'h0; // @[DataMemMux.scala 61:80]
  wire  rdSelected_1 = io_master_rdAddr[15:3] == 13'h400; // @[DataMemMux.scala 55:80]
  reg  REG_1; // @[DataMemMux.scala 57:17]
  wire [31:0] _GEN_1 = REG_1 ? io_targets_1_rdData : _GEN_0; // @[DataMemMux.scala 57:36 58:24]
  wire  wrSelected_1 = io_master_wrAddr[15:3] == 13'h400; // @[DataMemMux.scala 61:80]
  wire  rdSelected_2 = io_master_rdAddr[15:2] == 14'h810; // @[DataMemMux.scala 55:80]
  reg  REG_2; // @[DataMemMux.scala 57:17]
  wire [31:0] _GEN_2 = REG_2 ? io_targets_2_rdData : _GEN_1; // @[DataMemMux.scala 57:36 58:24]
  wire  wrSelected_2 = io_master_wrAddr[15:2] == 14'h810; // @[DataMemMux.scala 61:80]
  wire  rdSelected_3 = io_master_rdAddr[15:1] == 15'h1022; // @[DataMemMux.scala 55:80]
  reg  REG_3; // @[DataMemMux.scala 57:17]
  wire  wrSelected_3 = io_master_wrAddr[15:1] == 15'h1022; // @[DataMemMux.scala 61:80]
  assign io_master_rdData = REG_3 ? io_targets_3_rdData : _GEN_2; // @[DataMemMux.scala 57:36 58:24]
  assign io_targets_0_rdAddr = io_master_rdAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_0_wrAddr = io_master_wrAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_0_wrData = io_master_wrData; // @[DataMemMux.scala 50:7]
  assign io_targets_0_wr = io_master_wr & wrSelected; // @[DataMemMux.scala 62:29]
  assign io_targets_0_wrMask = io_master_wrMask; // @[DataMemMux.scala 50:7]
  assign io_targets_1_rdAddr = io_master_rdAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_1_wrAddr = io_master_wrAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_1_wrData = io_master_wrData; // @[DataMemMux.scala 50:7]
  assign io_targets_1_wr = io_master_wr & wrSelected_1; // @[DataMemMux.scala 62:29]
  assign io_targets_2_rdAddr = io_master_rdAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_2_wrAddr = io_master_wrAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_2_wrData = io_master_wrData; // @[DataMemMux.scala 50:7]
  assign io_targets_2_wr = io_master_wr & wrSelected_2; // @[DataMemMux.scala 62:29]
  assign io_targets_3_rdAddr = io_master_rdAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_3_wrAddr = io_master_wrAddr; // @[DataMemMux.scala 50:7]
  assign io_targets_3_wrData = io_master_wrData; // @[DataMemMux.scala 50:7]
  assign io_targets_3_wr = io_master_wr & wrSelected_3; // @[DataMemMux.scala 62:29]
  always @(posedge clock) begin
    if (reset) begin // @[DataMemMux.scala 57:17]
      REG <= 1'h0; // @[DataMemMux.scala 57:17]
    end else begin
      REG <= rdSelected; // @[DataMemMux.scala 57:17]
    end
    if (reset) begin // @[DataMemMux.scala 57:17]
      REG_1 <= 1'h0; // @[DataMemMux.scala 57:17]
    end else begin
      REG_1 <= rdSelected_1; // @[DataMemMux.scala 57:17]
    end
    if (reset) begin // @[DataMemMux.scala 57:17]
      REG_2 <= 1'h0; // @[DataMemMux.scala 57:17]
    end else begin
      REG_2 <= rdSelected_2; // @[DataMemMux.scala 57:17]
    end
    if (reset) begin // @[DataMemMux.scala 57:17]
      REG_3 <= 1'h0; // @[DataMemMux.scala 57:17]
    end else begin
      REG_3 <= rdSelected_3; // @[DataMemMux.scala 57:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  REG_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  REG_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  REG_3 = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DtuSubsystem(
  input         clock,
  input         reset,
  input  [11:0] io_apb_paddr,
  input         io_apb_psel,
  input         io_apb_penable,
  input         io_apb_pwrite,
  input  [3:0]  io_apb_pstrb,
  input  [31:0] io_apb_pwdata,
  output        io_apb_pready,
  output [31:0] io_apb_prdata,
  output        io_apb_pslverr,
  output        io_irq,
  input         io_irqEn,
  input  [5:0]  io_ssCtrl,
  input  [3:0]  io_pmod_0_gpi,
  output [3:0]  io_pmod_0_gpo,
  output [3:0]  io_pmod_0_oe,
  input  [3:0]  io_pmod_1_gpi,
  output [3:0]  io_pmod_1_gpo,
  output [3:0]  io_pmod_1_oe
);
  wire  sysCtrl_clock; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_reset; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_apbPort_psel; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_apbPort_penable; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_apbPort_pwrite; // @[DtuSubsystem.scala 57:24]
  wire [31:0] sysCtrl_apbPort_pwdata; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_apbPort_pready; // @[DtuSubsystem.scala 57:24]
  wire [31:0] sysCtrl_apbPort_prdata; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_ctrlPort_lerosReset; // @[DtuSubsystem.scala 57:24]
  wire  sysCtrl_ctrlPort_lerosBootFromRam; // @[DtuSubsystem.scala 57:24]
  wire  ponte_clock; // @[DtuSubsystem.scala 58:21]
  wire  ponte_reset; // @[DtuSubsystem.scala 58:21]
  wire  ponte_io_uart_tx; // @[DtuSubsystem.scala 58:21]
  wire  ponte_io_uart_rx; // @[DtuSubsystem.scala 58:21]
  wire [15:0] ponte_io_apb_paddr; // @[DtuSubsystem.scala 58:21]
  wire  ponte_io_apb_psel; // @[DtuSubsystem.scala 58:21]
  wire  ponte_io_apb_penable; // @[DtuSubsystem.scala 58:21]
  wire  ponte_io_apb_pwrite; // @[DtuSubsystem.scala 58:21]
  wire [31:0] ponte_io_apb_pwdata; // @[DtuSubsystem.scala 58:21]
  wire  ponte_io_apb_pready; // @[DtuSubsystem.scala 58:21]
  wire [31:0] ponte_io_apb_prdata; // @[DtuSubsystem.scala 58:21]
  wire  leros_clock; // @[DtuSubsystem.scala 61:21]
  wire  leros_reset; // @[DtuSubsystem.scala 61:21]
  wire [10:0] leros_imemIO_addr; // @[DtuSubsystem.scala 61:21]
  wire [15:0] leros_imemIO_instr; // @[DtuSubsystem.scala 61:21]
  wire [15:0] leros_dmemIO_rdAddr; // @[DtuSubsystem.scala 61:21]
  wire [31:0] leros_dmemIO_rdData; // @[DtuSubsystem.scala 61:21]
  wire [15:0] leros_dmemIO_wrAddr; // @[DtuSubsystem.scala 61:21]
  wire [31:0] leros_dmemIO_wrData; // @[DtuSubsystem.scala 61:21]
  wire  leros_dmemIO_wr; // @[DtuSubsystem.scala 61:21]
  wire [3:0] leros_dmemIO_wrMask; // @[DtuSubsystem.scala 61:21]
  wire  instrMem_clock; // @[DtuSubsystem.scala 64:24]
  wire [10:0] instrMem_instrPort_addr; // @[DtuSubsystem.scala 64:24]
  wire [15:0] instrMem_instrPort_instr; // @[DtuSubsystem.scala 64:24]
  wire [10:0] instrMem_apbPort_paddr; // @[DtuSubsystem.scala 64:24]
  wire  instrMem_apbPort_psel; // @[DtuSubsystem.scala 64:24]
  wire  instrMem_apbPort_penable; // @[DtuSubsystem.scala 64:24]
  wire  instrMem_apbPort_pwrite; // @[DtuSubsystem.scala 64:24]
  wire [3:0] instrMem_apbPort_pstrb; // @[DtuSubsystem.scala 64:24]
  wire [31:0] instrMem_apbPort_pwdata; // @[DtuSubsystem.scala 64:24]
  wire  instrMem_apbPort_pready; // @[DtuSubsystem.scala 64:24]
  wire [31:0] instrMem_apbPort_prdata; // @[DtuSubsystem.scala 64:24]
  wire  rom_clock; // @[DtuSubsystem.scala 65:24]
  wire  rom_reset; // @[DtuSubsystem.scala 65:24]
  wire [10:0] rom_io_addr; // @[DtuSubsystem.scala 65:24]
  wire [15:0] rom_io_instr; // @[DtuSubsystem.scala 65:24]
  wire  regBlock_clock; // @[DtuSubsystem.scala 66:24]
  wire  regBlock_reset; // @[DtuSubsystem.scala 66:24]
  wire [4:0] regBlock_apbPort_paddr; // @[DtuSubsystem.scala 66:24]
  wire  regBlock_apbPort_psel; // @[DtuSubsystem.scala 66:24]
  wire  regBlock_apbPort_penable; // @[DtuSubsystem.scala 66:24]
  wire  regBlock_apbPort_pwrite; // @[DtuSubsystem.scala 66:24]
  wire [31:0] regBlock_apbPort_pwdata; // @[DtuSubsystem.scala 66:24]
  wire  regBlock_apbPort_pready; // @[DtuSubsystem.scala 66:24]
  wire [31:0] regBlock_apbPort_prdata; // @[DtuSubsystem.scala 66:24]
  wire [2:0] regBlock_dmemPort_rdAddr; // @[DtuSubsystem.scala 66:24]
  wire [31:0] regBlock_dmemPort_rdData; // @[DtuSubsystem.scala 66:24]
  wire [2:0] regBlock_dmemPort_wrAddr; // @[DtuSubsystem.scala 66:24]
  wire [31:0] regBlock_dmemPort_wrData; // @[DtuSubsystem.scala 66:24]
  wire  regBlock_dmemPort_wr; // @[DtuSubsystem.scala 66:24]
  wire  gpio_clock; // @[DtuSubsystem.scala 67:24]
  wire  gpio_reset; // @[DtuSubsystem.scala 67:24]
  wire [1:0] gpio_dmemPort_rdAddr; // @[DtuSubsystem.scala 67:24]
  wire [31:0] gpio_dmemPort_rdData; // @[DtuSubsystem.scala 67:24]
  wire [1:0] gpio_dmemPort_wrAddr; // @[DtuSubsystem.scala 67:24]
  wire [31:0] gpio_dmemPort_wrData; // @[DtuSubsystem.scala 67:24]
  wire  gpio_dmemPort_wr; // @[DtuSubsystem.scala 67:24]
  wire [3:0] gpio_pmodPort_gpi; // @[DtuSubsystem.scala 67:24]
  wire [3:0] gpio_pmodPort_gpo; // @[DtuSubsystem.scala 67:24]
  wire [3:0] gpio_pmodPort_oe; // @[DtuSubsystem.scala 67:24]
  wire  dmem_clock; // @[DtuSubsystem.scala 68:24]
  wire [5:0] dmem_dmemPort_rdAddr; // @[DtuSubsystem.scala 68:24]
  wire [31:0] dmem_dmemPort_rdData; // @[DtuSubsystem.scala 68:24]
  wire [5:0] dmem_dmemPort_wrAddr; // @[DtuSubsystem.scala 68:24]
  wire [31:0] dmem_dmemPort_wrData; // @[DtuSubsystem.scala 68:24]
  wire  dmem_dmemPort_wr; // @[DtuSubsystem.scala 68:24]
  wire [3:0] dmem_dmemPort_wrMask; // @[DtuSubsystem.scala 68:24]
  wire  uart_clock; // @[DtuSubsystem.scala 69:24]
  wire  uart_reset; // @[DtuSubsystem.scala 69:24]
  wire  uart_uartPins_tx; // @[DtuSubsystem.scala 69:24]
  wire  uart_uartPins_rx; // @[DtuSubsystem.scala 69:24]
  wire  uart_dmemPort_rdAddr; // @[DtuSubsystem.scala 69:24]
  wire [31:0] uart_dmemPort_rdData; // @[DtuSubsystem.scala 69:24]
  wire  uart_dmemPort_wrAddr; // @[DtuSubsystem.scala 69:24]
  wire [31:0] uart_dmemPort_wrData; // @[DtuSubsystem.scala 69:24]
  wire  uart_dmemPort_wr; // @[DtuSubsystem.scala 69:24]
  wire  arb_clock; // @[ApbArbiter.scala 11:21]
  wire  arb_reset; // @[ApbArbiter.scala 11:21]
  wire [15:0] arb_io_masters_0_paddr; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_0_psel; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_0_penable; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_0_pwrite; // @[ApbArbiter.scala 11:21]
  wire [31:0] arb_io_masters_0_pwdata; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_0_pready; // @[ApbArbiter.scala 11:21]
  wire [31:0] arb_io_masters_0_prdata; // @[ApbArbiter.scala 11:21]
  wire [15:0] arb_io_masters_1_paddr; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_1_psel; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_1_penable; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_1_pwrite; // @[ApbArbiter.scala 11:21]
  wire [3:0] arb_io_masters_1_pstrb; // @[ApbArbiter.scala 11:21]
  wire [31:0] arb_io_masters_1_pwdata; // @[ApbArbiter.scala 11:21]
  wire  arb_io_masters_1_pready; // @[ApbArbiter.scala 11:21]
  wire [31:0] arb_io_masters_1_prdata; // @[ApbArbiter.scala 11:21]
  wire [15:0] arb_io_merged_paddr; // @[ApbArbiter.scala 11:21]
  wire  arb_io_merged_psel; // @[ApbArbiter.scala 11:21]
  wire  arb_io_merged_penable; // @[ApbArbiter.scala 11:21]
  wire  arb_io_merged_pwrite; // @[ApbArbiter.scala 11:21]
  wire [3:0] arb_io_merged_pstrb; // @[ApbArbiter.scala 11:21]
  wire [31:0] arb_io_merged_pwdata; // @[ApbArbiter.scala 11:21]
  wire  arb_io_merged_pready; // @[ApbArbiter.scala 11:21]
  wire [31:0] arb_io_merged_prdata; // @[ApbArbiter.scala 11:21]
  wire [15:0] apbMux_io_master_paddr; // @[ApbMux.scala 96:24]
  wire  apbMux_io_master_psel; // @[ApbMux.scala 96:24]
  wire  apbMux_io_master_penable; // @[ApbMux.scala 96:24]
  wire  apbMux_io_master_pwrite; // @[ApbMux.scala 96:24]
  wire [3:0] apbMux_io_master_pstrb; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_master_pwdata; // @[ApbMux.scala 96:24]
  wire  apbMux_io_master_pready; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_master_prdata; // @[ApbMux.scala 96:24]
  wire [15:0] apbMux_io_targets_0_paddr; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_0_psel; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_0_penable; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_0_pwrite; // @[ApbMux.scala 96:24]
  wire [3:0] apbMux_io_targets_0_pstrb; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_targets_0_pwdata; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_0_pready; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_targets_0_prdata; // @[ApbMux.scala 96:24]
  wire [15:0] apbMux_io_targets_1_paddr; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_1_psel; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_1_penable; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_1_pwrite; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_targets_1_pwdata; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_1_pready; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_targets_1_prdata; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_2_psel; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_2_penable; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_2_pwrite; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_targets_2_pwdata; // @[ApbMux.scala 96:24]
  wire  apbMux_io_targets_2_pready; // @[ApbMux.scala 96:24]
  wire [31:0] apbMux_io_targets_2_prdata; // @[ApbMux.scala 96:24]
  wire  dmemMux_clock; // @[DataMemMux.scala 94:25]
  wire  dmemMux_reset; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_master_rdAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_master_rdData; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_master_wrAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_master_wrData; // @[DataMemMux.scala 94:25]
  wire  dmemMux_io_master_wr; // @[DataMemMux.scala 94:25]
  wire [3:0] dmemMux_io_master_wrMask; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_0_rdAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_0_rdData; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_0_wrAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_0_wrData; // @[DataMemMux.scala 94:25]
  wire  dmemMux_io_targets_0_wr; // @[DataMemMux.scala 94:25]
  wire [3:0] dmemMux_io_targets_0_wrMask; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_1_rdAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_1_rdData; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_1_wrAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_1_wrData; // @[DataMemMux.scala 94:25]
  wire  dmemMux_io_targets_1_wr; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_2_rdAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_2_rdData; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_2_wrAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_2_wrData; // @[DataMemMux.scala 94:25]
  wire  dmemMux_io_targets_2_wr; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_3_rdAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_3_rdData; // @[DataMemMux.scala 94:25]
  wire [15:0] dmemMux_io_targets_3_wrAddr; // @[DataMemMux.scala 94:25]
  wire [31:0] dmemMux_io_targets_3_wrData; // @[DataMemMux.scala 94:25]
  wire  dmemMux_io_targets_3_wr; // @[DataMemMux.scala 94:25]
  wire [1:0] io_pmod_0_gpo_lo = {1'h0,ponte_io_uart_tx}; // @[Cat.scala 33:92]
  wire [1:0] io_pmod_0_gpo_hi = {1'h0,uart_uartPins_tx}; // @[Cat.scala 33:92]
  SystemControl sysCtrl ( // @[DtuSubsystem.scala 57:24]
    .clock(sysCtrl_clock),
    .reset(sysCtrl_reset),
    .apbPort_psel(sysCtrl_apbPort_psel),
    .apbPort_penable(sysCtrl_apbPort_penable),
    .apbPort_pwrite(sysCtrl_apbPort_pwrite),
    .apbPort_pwdata(sysCtrl_apbPort_pwdata),
    .apbPort_pready(sysCtrl_apbPort_pready),
    .apbPort_prdata(sysCtrl_apbPort_prdata),
    .ctrlPort_lerosReset(sysCtrl_ctrlPort_lerosReset),
    .ctrlPort_lerosBootFromRam(sysCtrl_ctrlPort_lerosBootFromRam)
  );
  Ponte ponte ( // @[DtuSubsystem.scala 58:21]
    .clock(ponte_clock),
    .reset(ponte_reset),
    .io_uart_tx(ponte_io_uart_tx),
    .io_uart_rx(ponte_io_uart_rx),
    .io_apb_paddr(ponte_io_apb_paddr),
    .io_apb_psel(ponte_io_apb_psel),
    .io_apb_penable(ponte_io_apb_penable),
    .io_apb_pwrite(ponte_io_apb_pwrite),
    .io_apb_pwdata(ponte_io_apb_pwdata),
    .io_apb_pready(ponte_io_apb_pready),
    .io_apb_prdata(ponte_io_apb_prdata)
  );
  Leros leros ( // @[DtuSubsystem.scala 61:21]
    .clock(leros_clock),
    .reset(leros_reset),
    .imemIO_addr(leros_imemIO_addr),
    .imemIO_instr(leros_imemIO_instr),
    .dmemIO_rdAddr(leros_dmemIO_rdAddr),
    .dmemIO_rdData(leros_dmemIO_rdData),
    .dmemIO_wrAddr(leros_dmemIO_wrAddr),
    .dmemIO_wrData(leros_dmemIO_wrData),
    .dmemIO_wr(leros_dmemIO_wr),
    .dmemIO_wrMask(leros_dmemIO_wrMask)
  );
  InstructionMemory instrMem ( // @[DtuSubsystem.scala 64:24]
    .clock(instrMem_clock),
    .instrPort_addr(instrMem_instrPort_addr),
    .instrPort_instr(instrMem_instrPort_instr),
    .apbPort_paddr(instrMem_apbPort_paddr),
    .apbPort_psel(instrMem_apbPort_psel),
    .apbPort_penable(instrMem_apbPort_penable),
    .apbPort_pwrite(instrMem_apbPort_pwrite),
    .apbPort_pstrb(instrMem_apbPort_pstrb),
    .apbPort_pwdata(instrMem_apbPort_pwdata),
    .apbPort_pready(instrMem_apbPort_pready),
    .apbPort_prdata(instrMem_apbPort_prdata)
  );
  InstrMem rom ( // @[DtuSubsystem.scala 65:24]
    .clock(rom_clock),
    .reset(rom_reset),
    .io_addr(rom_io_addr),
    .io_instr(rom_io_instr)
  );
  RegBlock regBlock ( // @[DtuSubsystem.scala 66:24]
    .clock(regBlock_clock),
    .reset(regBlock_reset),
    .apbPort_paddr(regBlock_apbPort_paddr),
    .apbPort_psel(regBlock_apbPort_psel),
    .apbPort_penable(regBlock_apbPort_penable),
    .apbPort_pwrite(regBlock_apbPort_pwrite),
    .apbPort_pwdata(regBlock_apbPort_pwdata),
    .apbPort_pready(regBlock_apbPort_pready),
    .apbPort_prdata(regBlock_apbPort_prdata),
    .dmemPort_rdAddr(regBlock_dmemPort_rdAddr),
    .dmemPort_rdData(regBlock_dmemPort_rdData),
    .dmemPort_wrAddr(regBlock_dmemPort_wrAddr),
    .dmemPort_wrData(regBlock_dmemPort_wrData),
    .dmemPort_wr(regBlock_dmemPort_wr)
  );
  Gpio gpio ( // @[DtuSubsystem.scala 67:24]
    .clock(gpio_clock),
    .reset(gpio_reset),
    .dmemPort_rdAddr(gpio_dmemPort_rdAddr),
    .dmemPort_rdData(gpio_dmemPort_rdData),
    .dmemPort_wrAddr(gpio_dmemPort_wrAddr),
    .dmemPort_wrData(gpio_dmemPort_wrData),
    .dmemPort_wr(gpio_dmemPort_wr),
    .pmodPort_gpi(gpio_pmodPort_gpi),
    .pmodPort_gpo(gpio_pmodPort_gpo),
    .pmodPort_oe(gpio_pmodPort_oe)
  );
  DataMemory dmem ( // @[DtuSubsystem.scala 68:24]
    .clock(dmem_clock),
    .dmemPort_rdAddr(dmem_dmemPort_rdAddr),
    .dmemPort_rdData(dmem_dmemPort_rdData),
    .dmemPort_wrAddr(dmem_dmemPort_wrAddr),
    .dmemPort_wrData(dmem_dmemPort_wrData),
    .dmemPort_wr(dmem_dmemPort_wr),
    .dmemPort_wrMask(dmem_dmemPort_wrMask)
  );
  Uart uart ( // @[DtuSubsystem.scala 69:24]
    .clock(uart_clock),
    .reset(uart_reset),
    .uartPins_tx(uart_uartPins_tx),
    .uartPins_rx(uart_uartPins_rx),
    .dmemPort_rdAddr(uart_dmemPort_rdAddr),
    .dmemPort_rdData(uart_dmemPort_rdData),
    .dmemPort_wrAddr(uart_dmemPort_wrAddr),
    .dmemPort_wrData(uart_dmemPort_wrData),
    .dmemPort_wr(uart_dmemPort_wr)
  );
  ApbArbiter arb ( // @[ApbArbiter.scala 11:21]
    .clock(arb_clock),
    .reset(arb_reset),
    .io_masters_0_paddr(arb_io_masters_0_paddr),
    .io_masters_0_psel(arb_io_masters_0_psel),
    .io_masters_0_penable(arb_io_masters_0_penable),
    .io_masters_0_pwrite(arb_io_masters_0_pwrite),
    .io_masters_0_pwdata(arb_io_masters_0_pwdata),
    .io_masters_0_pready(arb_io_masters_0_pready),
    .io_masters_0_prdata(arb_io_masters_0_prdata),
    .io_masters_1_paddr(arb_io_masters_1_paddr),
    .io_masters_1_psel(arb_io_masters_1_psel),
    .io_masters_1_penable(arb_io_masters_1_penable),
    .io_masters_1_pwrite(arb_io_masters_1_pwrite),
    .io_masters_1_pstrb(arb_io_masters_1_pstrb),
    .io_masters_1_pwdata(arb_io_masters_1_pwdata),
    .io_masters_1_pready(arb_io_masters_1_pready),
    .io_masters_1_prdata(arb_io_masters_1_prdata),
    .io_merged_paddr(arb_io_merged_paddr),
    .io_merged_psel(arb_io_merged_psel),
    .io_merged_penable(arb_io_merged_penable),
    .io_merged_pwrite(arb_io_merged_pwrite),
    .io_merged_pstrb(arb_io_merged_pstrb),
    .io_merged_pwdata(arb_io_merged_pwdata),
    .io_merged_pready(arb_io_merged_pready),
    .io_merged_prdata(arb_io_merged_prdata)
  );
  ApbMux apbMux ( // @[ApbMux.scala 96:24]
    .io_master_paddr(apbMux_io_master_paddr),
    .io_master_psel(apbMux_io_master_psel),
    .io_master_penable(apbMux_io_master_penable),
    .io_master_pwrite(apbMux_io_master_pwrite),
    .io_master_pstrb(apbMux_io_master_pstrb),
    .io_master_pwdata(apbMux_io_master_pwdata),
    .io_master_pready(apbMux_io_master_pready),
    .io_master_prdata(apbMux_io_master_prdata),
    .io_targets_0_paddr(apbMux_io_targets_0_paddr),
    .io_targets_0_psel(apbMux_io_targets_0_psel),
    .io_targets_0_penable(apbMux_io_targets_0_penable),
    .io_targets_0_pwrite(apbMux_io_targets_0_pwrite),
    .io_targets_0_pstrb(apbMux_io_targets_0_pstrb),
    .io_targets_0_pwdata(apbMux_io_targets_0_pwdata),
    .io_targets_0_pready(apbMux_io_targets_0_pready),
    .io_targets_0_prdata(apbMux_io_targets_0_prdata),
    .io_targets_1_paddr(apbMux_io_targets_1_paddr),
    .io_targets_1_psel(apbMux_io_targets_1_psel),
    .io_targets_1_penable(apbMux_io_targets_1_penable),
    .io_targets_1_pwrite(apbMux_io_targets_1_pwrite),
    .io_targets_1_pwdata(apbMux_io_targets_1_pwdata),
    .io_targets_1_pready(apbMux_io_targets_1_pready),
    .io_targets_1_prdata(apbMux_io_targets_1_prdata),
    .io_targets_2_psel(apbMux_io_targets_2_psel),
    .io_targets_2_penable(apbMux_io_targets_2_penable),
    .io_targets_2_pwrite(apbMux_io_targets_2_pwrite),
    .io_targets_2_pwdata(apbMux_io_targets_2_pwdata),
    .io_targets_2_pready(apbMux_io_targets_2_pready),
    .io_targets_2_prdata(apbMux_io_targets_2_prdata)
  );
  DataMemMux dmemMux ( // @[DataMemMux.scala 94:25]
    .clock(dmemMux_clock),
    .reset(dmemMux_reset),
    .io_master_rdAddr(dmemMux_io_master_rdAddr),
    .io_master_rdData(dmemMux_io_master_rdData),
    .io_master_wrAddr(dmemMux_io_master_wrAddr),
    .io_master_wrData(dmemMux_io_master_wrData),
    .io_master_wr(dmemMux_io_master_wr),
    .io_master_wrMask(dmemMux_io_master_wrMask),
    .io_targets_0_rdAddr(dmemMux_io_targets_0_rdAddr),
    .io_targets_0_rdData(dmemMux_io_targets_0_rdData),
    .io_targets_0_wrAddr(dmemMux_io_targets_0_wrAddr),
    .io_targets_0_wrData(dmemMux_io_targets_0_wrData),
    .io_targets_0_wr(dmemMux_io_targets_0_wr),
    .io_targets_0_wrMask(dmemMux_io_targets_0_wrMask),
    .io_targets_1_rdAddr(dmemMux_io_targets_1_rdAddr),
    .io_targets_1_rdData(dmemMux_io_targets_1_rdData),
    .io_targets_1_wrAddr(dmemMux_io_targets_1_wrAddr),
    .io_targets_1_wrData(dmemMux_io_targets_1_wrData),
    .io_targets_1_wr(dmemMux_io_targets_1_wr),
    .io_targets_2_rdAddr(dmemMux_io_targets_2_rdAddr),
    .io_targets_2_rdData(dmemMux_io_targets_2_rdData),
    .io_targets_2_wrAddr(dmemMux_io_targets_2_wrAddr),
    .io_targets_2_wrData(dmemMux_io_targets_2_wrData),
    .io_targets_2_wr(dmemMux_io_targets_2_wr),
    .io_targets_3_rdAddr(dmemMux_io_targets_3_rdAddr),
    .io_targets_3_rdData(dmemMux_io_targets_3_rdData),
    .io_targets_3_wrAddr(dmemMux_io_targets_3_wrAddr),
    .io_targets_3_wrData(dmemMux_io_targets_3_wrData),
    .io_targets_3_wr(dmemMux_io_targets_3_wr)
  );
  assign io_apb_pready = arb_io_masters_1_pready; // @[ApbArbiter.scala 13:23]
  assign io_apb_prdata = arb_io_masters_1_prdata; // @[ApbArbiter.scala 13:23]
  assign io_apb_pslverr = 1'h0; // @[ApbArbiter.scala 13:23]
  assign io_irq = 1'h0; // @[DtuSubsystem.scala 52:10]
  assign io_pmod_0_gpo = {io_pmod_0_gpo_hi,io_pmod_0_gpo_lo}; // @[Cat.scala 33:92]
  assign io_pmod_0_oe = 4'ha; // @[Cat.scala 33:92]
  assign io_pmod_1_gpo = gpio_pmodPort_gpo; // @[DtuSubsystem.scala 89:14]
  assign io_pmod_1_oe = gpio_pmodPort_oe; // @[DtuSubsystem.scala 89:14]
  assign sysCtrl_clock = clock;
  assign sysCtrl_reset = reset;
  assign sysCtrl_apbPort_psel = apbMux_io_targets_2_psel; // @[ApbMux.scala 101:14]
  assign sysCtrl_apbPort_penable = apbMux_io_targets_2_penable; // @[ApbMux.scala 101:14]
  assign sysCtrl_apbPort_pwrite = apbMux_io_targets_2_pwrite; // @[ApbMux.scala 101:14]
  assign sysCtrl_apbPort_pwdata = apbMux_io_targets_2_pwdata; // @[ApbMux.scala 101:14]
  assign ponte_clock = clock;
  assign ponte_reset = reset;
  assign ponte_io_uart_rx = io_pmod_0_gpi[1]; // @[DtuSubsystem.scala 55:31]
  assign ponte_io_apb_pready = arb_io_masters_0_pready; // @[ApbArbiter.scala 12:23]
  assign ponte_io_apb_prdata = arb_io_masters_0_prdata; // @[ApbArbiter.scala 12:23]
  assign leros_clock = clock;
  assign leros_reset = reset | sysCtrl_ctrlPort_lerosReset; // @[DtuSubsystem.scala 62:31]
  assign leros_imemIO_instr = sysCtrl_ctrlPort_lerosBootFromRam ? instrMem_instrPort_instr : rom_io_instr; // @[DtuSubsystem.scala 74:28]
  assign leros_dmemIO_rdData = dmemMux_io_master_rdData; // @[DataMemMux.scala 97:23]
  assign instrMem_clock = clock;
  assign instrMem_instrPort_addr = leros_imemIO_addr; // @[DtuSubsystem.scala 72:16]
  assign instrMem_apbPort_paddr = apbMux_io_targets_0_paddr[10:0]; // @[ApbMux.scala 101:14]
  assign instrMem_apbPort_psel = apbMux_io_targets_0_psel; // @[ApbMux.scala 101:14]
  assign instrMem_apbPort_penable = apbMux_io_targets_0_penable; // @[ApbMux.scala 101:14]
  assign instrMem_apbPort_pwrite = apbMux_io_targets_0_pwrite; // @[ApbMux.scala 101:14]
  assign instrMem_apbPort_pstrb = apbMux_io_targets_0_pstrb; // @[ApbMux.scala 101:14]
  assign instrMem_apbPort_pwdata = apbMux_io_targets_0_pwdata; // @[ApbMux.scala 101:14]
  assign rom_clock = clock;
  assign rom_reset = reset;
  assign rom_io_addr = leros_imemIO_addr; // @[DtuSubsystem.scala 73:16]
  assign regBlock_clock = clock;
  assign regBlock_reset = reset;
  assign regBlock_apbPort_paddr = apbMux_io_targets_1_paddr[4:0]; // @[ApbMux.scala 101:14]
  assign regBlock_apbPort_psel = apbMux_io_targets_1_psel; // @[ApbMux.scala 101:14]
  assign regBlock_apbPort_penable = apbMux_io_targets_1_penable; // @[ApbMux.scala 101:14]
  assign regBlock_apbPort_pwrite = apbMux_io_targets_1_pwrite; // @[ApbMux.scala 101:14]
  assign regBlock_apbPort_pwdata = apbMux_io_targets_1_pwdata; // @[ApbMux.scala 101:14]
  assign regBlock_dmemPort_rdAddr = dmemMux_io_targets_1_rdAddr[2:0]; // @[DataMemMux.scala 101:16]
  assign regBlock_dmemPort_wrAddr = dmemMux_io_targets_1_wrAddr[2:0]; // @[DataMemMux.scala 101:16]
  assign regBlock_dmemPort_wrData = dmemMux_io_targets_1_wrData; // @[DataMemMux.scala 101:16]
  assign regBlock_dmemPort_wr = dmemMux_io_targets_1_wr; // @[DataMemMux.scala 101:16]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_dmemPort_rdAddr = dmemMux_io_targets_2_rdAddr[1:0]; // @[DataMemMux.scala 101:16]
  assign gpio_dmemPort_wrAddr = dmemMux_io_targets_2_wrAddr[1:0]; // @[DataMemMux.scala 101:16]
  assign gpio_dmemPort_wrData = dmemMux_io_targets_2_wrData; // @[DataMemMux.scala 101:16]
  assign gpio_dmemPort_wr = dmemMux_io_targets_2_wr; // @[DataMemMux.scala 101:16]
  assign gpio_pmodPort_gpi = io_pmod_1_gpi; // @[DtuSubsystem.scala 89:14]
  assign dmem_clock = clock;
  assign dmem_dmemPort_rdAddr = dmemMux_io_targets_0_rdAddr[5:0]; // @[DataMemMux.scala 101:16]
  assign dmem_dmemPort_wrAddr = dmemMux_io_targets_0_wrAddr[5:0]; // @[DataMemMux.scala 101:16]
  assign dmem_dmemPort_wrData = dmemMux_io_targets_0_wrData; // @[DataMemMux.scala 101:16]
  assign dmem_dmemPort_wr = dmemMux_io_targets_0_wr; // @[DataMemMux.scala 101:16]
  assign dmem_dmemPort_wrMask = dmemMux_io_targets_0_wrMask; // @[DataMemMux.scala 101:16]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_uartPins_rx = io_pmod_0_gpi[3]; // @[DtuSubsystem.scala 54:31]
  assign uart_dmemPort_rdAddr = dmemMux_io_targets_3_rdAddr[0]; // @[DataMemMux.scala 101:16]
  assign uart_dmemPort_wrAddr = dmemMux_io_targets_3_wrAddr[0]; // @[DataMemMux.scala 101:16]
  assign uart_dmemPort_wrData = dmemMux_io_targets_3_wrData; // @[DataMemMux.scala 101:16]
  assign uart_dmemPort_wr = dmemMux_io_targets_3_wr; // @[DataMemMux.scala 101:16]
  assign arb_clock = clock;
  assign arb_reset = reset;
  assign arb_io_masters_0_paddr = ponte_io_apb_paddr; // @[ApbArbiter.scala 12:23]
  assign arb_io_masters_0_psel = ponte_io_apb_psel; // @[ApbArbiter.scala 12:23]
  assign arb_io_masters_0_penable = ponte_io_apb_penable; // @[ApbArbiter.scala 12:23]
  assign arb_io_masters_0_pwrite = ponte_io_apb_pwrite; // @[ApbArbiter.scala 12:23]
  assign arb_io_masters_0_pwdata = ponte_io_apb_pwdata; // @[ApbArbiter.scala 12:23]
  assign arb_io_masters_1_paddr = {{4'd0}, io_apb_paddr}; // @[ApbArbiter.scala 13:23]
  assign arb_io_masters_1_psel = io_apb_psel; // @[ApbArbiter.scala 13:23]
  assign arb_io_masters_1_penable = io_apb_penable; // @[ApbArbiter.scala 13:23]
  assign arb_io_masters_1_pwrite = io_apb_pwrite; // @[ApbArbiter.scala 13:23]
  assign arb_io_masters_1_pstrb = io_apb_pstrb; // @[ApbArbiter.scala 13:23]
  assign arb_io_masters_1_pwdata = io_apb_pwdata; // @[ApbArbiter.scala 13:23]
  assign arb_io_merged_pready = apbMux_io_master_pready; // @[ApbMux.scala 99:22]
  assign arb_io_merged_prdata = apbMux_io_master_prdata; // @[ApbMux.scala 99:22]
  assign apbMux_io_master_paddr = arb_io_merged_paddr; // @[ApbMux.scala 99:22]
  assign apbMux_io_master_psel = arb_io_merged_psel; // @[ApbMux.scala 99:22]
  assign apbMux_io_master_penable = arb_io_merged_penable; // @[ApbMux.scala 99:22]
  assign apbMux_io_master_pwrite = arb_io_merged_pwrite; // @[ApbMux.scala 99:22]
  assign apbMux_io_master_pstrb = arb_io_merged_pstrb; // @[ApbMux.scala 99:22]
  assign apbMux_io_master_pwdata = arb_io_merged_pwdata; // @[ApbMux.scala 99:22]
  assign apbMux_io_targets_0_pready = instrMem_apbPort_pready; // @[ApbMux.scala 101:14]
  assign apbMux_io_targets_0_prdata = instrMem_apbPort_prdata; // @[ApbMux.scala 101:14]
  assign apbMux_io_targets_1_pready = regBlock_apbPort_pready; // @[ApbMux.scala 101:14]
  assign apbMux_io_targets_1_prdata = regBlock_apbPort_prdata; // @[ApbMux.scala 101:14]
  assign apbMux_io_targets_2_pready = sysCtrl_apbPort_pready; // @[ApbMux.scala 101:14]
  assign apbMux_io_targets_2_prdata = sysCtrl_apbPort_prdata; // @[ApbMux.scala 101:14]
  assign dmemMux_clock = clock;
  assign dmemMux_reset = reset;
  assign dmemMux_io_master_rdAddr = leros_dmemIO_rdAddr; // @[DataMemMux.scala 97:23]
  assign dmemMux_io_master_wrAddr = leros_dmemIO_wrAddr; // @[DataMemMux.scala 97:23]
  assign dmemMux_io_master_wrData = leros_dmemIO_wrData; // @[DataMemMux.scala 97:23]
  assign dmemMux_io_master_wr = leros_dmemIO_wr; // @[DataMemMux.scala 97:23]
  assign dmemMux_io_master_wrMask = leros_dmemIO_wrMask; // @[DataMemMux.scala 97:23]
  assign dmemMux_io_targets_0_rdData = dmem_dmemPort_rdData; // @[DataMemMux.scala 101:16]
  assign dmemMux_io_targets_1_rdData = regBlock_dmemPort_rdData; // @[DataMemMux.scala 101:16]
  assign dmemMux_io_targets_2_rdData = gpio_dmemPort_rdData; // @[DataMemMux.scala 101:16]
  assign dmemMux_io_targets_3_rdData = uart_dmemPort_rdData; // @[DataMemMux.scala 101:16]
endmodule
