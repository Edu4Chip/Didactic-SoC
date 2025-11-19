# Baremetal SW

Staff area CPU (Ibex) can run RISC-V programs with ISA of RV32IMC. Example commands to crosscompile programs can be found in [sw/Makefile](../sw/Makefile).

Prequsite programs for the program compilation and conversion for simulation:
 
  * riscv toolchain with 32-bit IMC support

  * elf2hex conversion tool with 32-bit support

## Programming conventions

  * Access to various registers on SoC is done via raw pointer writing in C.

  * Common headers have been developed to hide constant pointer casts.

  * Complete Memory map header will eventually be exported from kactus.

## Use of Student subsystem

Preliminary single RW test case has been created for student system 0 and 1. These show initialization and raw pointer access.

## Preliminary table for mem map

|memory map target | start | end | actual size |
|-|-|-| - |
| instruction memory | 0x0100_0000 | 0x0100_FFFF | 16 KiB|
| data memory|0x0101_0000|0x0101_FFFF|16 KiB|
| debug module|0x0102_0000|0x0102_FFFF| 0x900|
| staff peripherals|0x0103_0000|0x0103_FFFF|0x300|
| control registers|0x0104_0000|0x0104_FFFF|0x184|
| interconnect|0x0105_0000|0x0105_FFFF|denoted by number of ss|
| student 0|0x0105_0000|0x0105_0FFF||
| student 1|0x0105_1000|0x0105_1FFF||
| student 2|0x0105_2000|0x0105_2FFF|template is empty|
| student 3|0x0105_3000|0x0105_3FFF|template is empty|

Note that there is lot of unused adressing. This will not cause area overhead on most tools. (if this would, major restructuring can be done relatively easily.)