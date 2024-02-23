# SoC Architecture

based on design principles architecture was created to section the student areas from the staff parts.

SoC will have single clock domain, and each subsystem will be controllable.

## Student section

Each SoC will have a number of sections for students that is fully customizeable. This will affect top ICN. Interface will be APB bus, control signals and (optional) interrupt line.

It is up to each tapeout to specify the requirements and design for each of the student modules. Back up designs should exist for substitution should any one of these fail to meet quality requirements.

exact area and more details of the system will be specified on various things such as technology node and frequencies, power requirements etc.

## Staff section

This section of the SoC will be more complex, it will contain the control and core logic. Template SoC will contain:

* core (riscv ibex in this example)

* memory (i and d memories, bootrom)

* peripheral devices

* control registers for subsystem (if we have ipxact memory map available, TAU can generate this with Kamel meta model combined with Kactus2)

* connectivity (soc xbar(s) and connection logic)

* tech cells (such as IOs etc)

Lot of the exact details will be refined further as the project continues.

