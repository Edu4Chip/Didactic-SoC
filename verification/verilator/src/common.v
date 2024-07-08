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
