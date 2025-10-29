# IP-XACT

This repository contains various IP-XACT models. Models are created with Kactus2 Tool. Models relate to Didactic SoC chip of EDU4Chip project but they are generic and reusable for any purposes.

Initial goal is to have minimal setup of definitions to be able to create simple SoC with Kactus2.

IP-XACT XML files within ipxact folder follow VLNV (vendor-library-name-version) folder hierarchy.

## interfaces

This is listing of IP-XACT interfaces contained with this repository.

| Name | Description | Notes |
|-|-|-|
| APB | advanced peripheral bus | |
| AXI | advanced extensible interface 4 |not used as part of the SoC |
| Clock |||
| Reset |||
| SS control |||
| UART |||
| GPIO |||
| SPI |||
| SDIO |||
| JTAG |||
| IRQ |||
| debug |||
| AXI4LITE |||
| generic.memory |||
| ibex.memory |||
| io_cell_cfg |||
| analog|generic interface for analog designs||

More to be added as work progresses.

## Modules

This repository includes source files and wrappers to integratable modules.

| module  | description|  notes|
|-|-|-|
| axi4lite to APB wrapper||reuses Pulp platform axi components|
| icn ss|axi protocol converter acting as xbar|reuses Pulp platform axi components|
| sysctrl xbar|xbar instanciation with protocol converter for one initiator port| reuses Pulp platform axi components|
|jtag dbg wrapper|wrapper for debug module and converters|resuses riscv debug module|
|ibex bridge|converts ibex mem bus to axi4lite||
|mem bridge|converts generic memory interface to axi4lite||
|sram|sram model with mem preload option||
|io cell frame x2|module to do io cell integration||
|student ss/area x4| example simple subsystems for education purposes|
|io cell|simple io cell models|sim only|
|io cell wrapper|module to enable various types of io cells through same module||
|tech cg|clock gate example module|sim model|
|tech mux|mux example module|sim model

## Generated RTL

IP-XACT and Kactus2 combination can be used to generate structural RTL. These can be inspected to greater detail through Kactus2.
