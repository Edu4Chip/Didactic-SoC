# IP-XACT

This repository contains various IP-XACT models. Models are created with Kactus2 Tool. Models relate to Didactic SoC chip of EDU4Chip project but they are generic and reusable for any purposes.

Initial goal is to have minimal setup of definitions to be able to create simple SoC with Kactus2. IP-XACT XML files within ipxact folder follow VLNV (vendor-library-name-version) folder hierarchy.

IPs are integrated using Kactus2 and generated to structural descriptions that compose the SoCs.

## interfaces

This is listing of IP-XACT interfaces contained with this repository.

| Name | Description | Notes |
|-|-|-|
| analog|generic interface for analog designs||
| APB | advanced peripheral bus | |
| AXI4 | advanced extensible interface 4 | |
| AXI4LITE |reduced complexity AXI4||
| Clock |clock singal||
| debug |debug request to core signal||
| generic.memory |generic memory interface||
| GPIO |general purpose IO||
| ibex.memory |ibex memory interface||
| io_cell_cfg |configuration bus for IO cells||
| IRQ |interrupt||
| JTAG |standard debug interface (joint test action group)||
| OBI |open bus interface|[pulp/obi](https://github.com/pulp-platform/obi) implementation|
| Reset |reset signal|polarity agnostic|
| SDIO |secure digital input output interface||
| SPI |serial peripheral interface||
| SS control|custom bus to control subsystems||
| UART |universal asynchronous receiver transmitter||

Interfaces will be if required.

## Modules

This repository includes source files and wrappers to integratable modules.

| module  | description|  notes|
|-|-|-|
| axi4lite to APB wrapper||reuses Pulp platform axi components|
| icn ss|axi protocol converter acting as xbar|reuses Pulp platform axi components|
| sysctrl xbar|xbar implementation with protocol converter for one initiator port| reuses Pulp platform axi components|
|jtag dbg wrapper|wrapper for debug module and converters|resuses riscv debug module|
|ibex bridge|converts ibex mem bus to axi4lite||
|ibex wrapper|wraps core tracer ifdefs for simulation elaboration ||
|mem bridge|converts generic memory interface to axi4lite||
|sram|sram simulation model with mem preload option||
|io cell frame|module to do io cell integration||
|student ss/area x4| example simple subsystems for education purposes||
|student ss/area wrapper x4| example simple subsystem wrapper with colock controls||
|io cell|simple io cell models|sim only|
|io cell wrapper|parameterized io cell selection wrapper||
|tieoff modules|subsystem modules for integrating out of tree modules|interface only|
|tech cg|clock gate example module|sim model|
|tech mux|mux example module|sim model|
