# TAU-IPXACT

This repository contains ipxact models of interfaces.

| Abreviation |Name | Description |
|-|-|-|
| APB | advanced peripheral bus | |
| AXI | advanced extensible interface||
|| Clock ||
|| Reset ||
|| Clock control? ||
| UART |||
| GPIO |||
| SPI |||
| SDIO |||
| JTAG |||
| IRQ |||
||||

Initial aim is to have minimal setup of definitions to be able to create simple SoC.

## SRC

This repository includes source files as wrappers to integratable modules.

| module name | integrates | description|
|-|-|-|
|axi2apb|converter module||
|axi-icn|axi protocol xbar||
