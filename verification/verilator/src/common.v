/*
# How to add this to Verilog module?

Assuming that "clk" is the clock signal of the module.

```
`ifdef VERILATOR
`include "verification/verilator/src/common.v"
`INCREMENT_CYCLE_COUNT(clk)
`endif
```
*/

`define INCREMENT_CYCLE_COUNT(clk) \
    `ifdef VERILATOR \
    import "DPI-C" function void register_module(input string path); \
    import "DPI-C" function void increment_cycle_count(input string path); \
    initial begin \
        register_module(`__FILE__); \
    end \
    always @ (posedge clk) begin \
        increment_cycle_count(`__FILE__); \
    end \
    `endif

/*
# How to add this to Verilog module?

Assuming that "from" and "to" are signals.

```
`ifdef VERILATOR
`include "verification/verilator/src/common.v"
import "DPI-C" function void check_signal_propagation(input string path, input real itime, input string name1, input int value1, input string name2, input int value2);
`CHECK_SIGNAL_PROPAGATION(from, to)
`endif
```
*/

`define CHECK_SIGNAL_PROPAGATION(FROM, TO) \
    `ifdef VERILATOR \
    always @ (FROM) begin \
        #0 check_signal_propagation(`__FILE__, $realtime, `"FROM`", FROM, `"TO`", TO); \
    end \
    `endif
