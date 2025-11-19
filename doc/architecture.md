# SoC Architecture

Based on design principles (simplicity, modularity) architecture was created to section the student areas from the staff parts.

SoC had originally single clock domain, and each subsystem will be separately controllable and isolatable. Additional fast clock is provided to use in each student subsystem. It is up to each student system to handle synchornization and clock selection. Initial template will not provide clock generation, but this can be added later.

## Clock Tree

Clock tree RTL implementation can be viewed in figure below. Clock is fed through IO cell and it is available globally. As first part of SS isolation, all SS wrappers contain controllable clock gate which is controlled by registers in the control register array. This structure is replicated for optional fast clock that is either generated internally or brought in via io cell in IO cell frame. This structure is depicted in figure below containing example of internal source (such as PLL).

![Didactic SoC Clock Tree](figures/didactic_clk_tree.drawio.svg "SoC Clock Tree")

## Reset Strategy

SoC has 2 distinct resets. Debug module domain is resettable through jtag reset pin. Functional SoC has global asynchronous low reset. Each subsystem on top of this has a register wired as reset source, including top level interconnect. This completes the 2 phase isolation for all subsystems.

![Didactic SoC Reset Tree](figures/didactic_reset_tree.drawio.svg "SoC Reset Tree")

If SS requires modification to reset signal, it must be done internally to the SS.

## Staff Section

This section of the SoC will contain the control, connetivity and core logic. Template SoC will contain:

* core (riscv ibex in this example)

* memory (separate instruction and data memories)

* peripheral devices (uart, spi, gpio)

* Debug module to control the SoC

* control registers for subsystem (if we have ipxact memory map available, TAU can generate this with Kamel meta model combined with Kactus2)

* connectivity (soc xbar(s), protocol converters and connection logic)

* tech cells (such as IOs etc)

Lot of the exact details will be refined further as the project continues.

## Student Section

Each SoC will have a number of sections for students that is fully customizeable. If number of student systems are changed, it will affect top ICN. Interface will be APB bus, control signals and (optional) interrupt line.

It is up to each tapeout to specify the requirements and design for each of the student modules. Back up designs should exist for substitution should any one of these fail to meet quality requirements. (electrical connectivity, manufacturing rules etc)

Exact area and more details of the system will be specified on various things such as technology node and frequencies, power requirements etc.
