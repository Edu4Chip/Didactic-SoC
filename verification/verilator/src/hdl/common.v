/*
# How to add this to Verilog module?

Assuming that "clk" is the clock signal of the module.

```
`ifdef VERILATOR
`include "verification/verilator/src/hdl/common.v"
`INCREMENT_CYCLE_COUNT(clk)
`endif
```
*/

/* deprecated in favor of code generation via python */

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
`include "verification/verilator/src/hdl/common.v"
import "DPI-C" function void check_signal_propagation(input string path, input real itime, input string name1, input int value1, input string name2, input int value2);
`CHECK_SIGNAL_PROPAGATION(from, to)
`endif
```

The `#0` delay is added to make sure that signal propagation is checked only at inactive region.
Thus, all continuous assignments should be done at the previous active region.
Problem: `--timing` option causes segmentation fault at first `model.eval()`.

*/

`define CHECK_SIGNAL_PROPAGATION(FROM, TO) \
    `ifdef VERILATOR \
    always @ (FROM) begin \
        #0 check_signal_propagation(`__FILE__, $realtime, `"FROM`", FROM, `"TO`", TO); \
    end \
    `endif
