# SoC Architecture

Based on design principles (simplicity, modularity) architecture was created to section the student areas from the staff parts.

SoC had originally single clock domain, and each subsystem will be separately controllable and isolatable. Additional fast clock is provided to use in each student subsystem. It is up to each student system to handle synchornization and clock selection. Initial SoC will not provide clock generation, but this can be added later.

Each subsystem is by default in isolated state as safety mechanism to avoid faut propagation. Firstly, subsystem clocks are not enabled and secondly, they are in reset state, by default.

## Clock Tree

Clock tree RTL implementation can be viewed in figure below. Clock is fed through IO cell and it is available globally. As first part of SS isolation, all SS wrappers contain controllable clock gate which is controlled by registers in the control register array. This structure is replicated for optional fast clock that is either generated internally or brought in via another IO cell in IO cell frame. This structure is also in figure below containing example of internal source (such as PLL).

![Didactic SoC Clock Tree](figures/didactic_clk_tree.drawio.svg "SoC Clock Tree")

## Reset Strategy

SoC has 2 distinct external resets. Debug module domain is resettable through jtag reset pin. Functional SoC has global asynchronous low reset. Reset for each subsystem is provided from a register. This includes top level interconnect. This completes the 2 phase isolation for all subsystems.

![Didactic SoC Reset Tree](figures/didactic_reset_tree.drawio.svg "SoC Reset Tree")

If subsystem section requires modification to reset signal, such as polarity change, it must be done internally to the subsystem and verified independently.

## Staff Section

This section of the SoC will contain the control, connetivity and core logic. Template SoC will contain:

* core (riscv ibex in first iteration)

* memory (separate instruction and data memories)

* peripheral devices (uart, spi, gpio)

* Debug module to control and program the SoC

* control registers for subsystem (if we have ipxact memory map available, TAU can generate this with Kamel meta model combined with Kactus2)

* connectivity (soc xbar(s), protocol converters and connection logic)

* tech cells (such as IOs, secondary clock sources etc)


## Student Section

Initial version of Didactic SoC has 4 digital subsystems and one analog section. Each subsequent SoC can have a varying number of sections for students that are fully customizeable. If number of student systems are changed, top interconnect and register array sizes need to be adapted. It is up to each tapeout to specify the specific requirements and design for each of the student modules. Exact area and more details of the system will be specified on each iteration based on functional and non-functional requirements.

Initial student subsystem Interface will be APB bus, control signals and interrupt line. It is up to each subsystem to decide how much of the wiring is in use. Unused wiring must be tied to legal values. Back up designs should exist for substitution should any one of the systems fail to qualify for manufacturing rules, such as electrical requirements and design rule checks.
