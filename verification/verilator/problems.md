# List of problems with Verilator

## Problem 1

File `ips/axi/src/axi_lite_mux.sv` contains a line with `typedef logic [$clog2(NoSlvPorts)-1:0] select_t;`.
If this line is enabled, then a following error is generated

```txt
%Error: Internal Error: ips/axi/src/axi_lite_mux.sv:126:38: ../V3Ast.cpp:1101: Comparison of a node with dtypep() with a node without dtypep()
                                                          : ... note: In instance 'Didactic.SystemControl_SS.SysCtrl_SS.Ctrl_xbar.i_axi_lite_xbar.i_xbar.gen_mst_port_mux[0].i_axi_lite_mux'
-node2=SUB 0x5a92dd500320 {da17ci} @dt=0@
```

If this line is replaced with e.g. `typedef logic [31:0] select_t;`, the error disappears.
