# Didactic SoC

This is the common chip template for the Edu4chip project. It is created with IPXACT modeling using the Kactus2 tool. Source files are reused from both open source and previous projects. This project is licensed under the terms of the Solderpad Hardware License v2.1.

See Doc Folder for more extensive documentation and guides as well as contribution guidelines (to be written).
## Architecture

Didactic aims to have simple SoC architecture while being easily extendable for various tapeouts.

![Didactic SoC architecture](doc/figures/didactic_architecture.drawio.svg "SoC Architecture Diagram")

In addition to these requirements, system needs to be reliable and have enough peripherals to operate as controller to manage student SS.

## Get started

This repository uses Bender, install instructions [here](https://github.com/pulp-platform/bender).

After cloning this repository, run `make repository_init` to fetch all of the submodules to correct versions. Bender initialization will offer user to resolve dependencies interactively. In these, it is correct to resolve to use ones linked by this repository. Generally these are updated to be latest releases (in either tag or hash form).

## Basic simulation flow

baremetal program run on IBEX CPU has been abstracted to `make test_all TESTCASE=blink` command.

This will build HW libraries (`Questa`), executable binary (`riscv-toolchain`), convert binary to hexfile (`elf2hex`) and finally run the simulator (`Questa`). testcase targets folder in sw folder and expects it to contain .c file with same name. eg. <code>sw/hello/hello.c</code>.

## Folders

.bender: open source IP are added to this project as bender dependencies. These are part of bender.yml and this folder is created by bender tool. Folder itself is not part of the repository. 

build: Not included by git repository. Created as part of make commands to contain all tool outputs.

Doc: Full documentation is gathered within doc folder.

FPGA: tool scripts, documentation and constraint files for FPGA platforms should be added to this folder.

ipxact: XML files of IPXACT definitions are kept within this folder.

sim: Simulation Makefiles and scripts are kept in this folder. Additionally, supporting files for waveform generation can be added here. 

* All tool scripts need to include capability of targeting bender with scripts or make commands. Calling bender with particular commands produce output of files to target the build with. Examples are provided for questa and verilator uses.

scripts: General use scripts that are not directly part of any other major categories can be added here.

src: RTL source files are added to this folder in relevant subfolders. If your RTL is not publicly available, create a tieoff module to allow others to proceed with their work. (Tieoff: interface .sv/.v/.vhd with all outputs being driven with inactive constants, likes 0's.)

sw: baremetal programs and their flow. These include common headers and simple test cases to run on RISC-V core.

syn: Synthesis Makefiles and commands.

.vendor_ips: Not included by repository. Submodules that do not directly support bender are added as vendor dependencies and fetched to this folder.

Verification: Contains experimental verilator verification setup.

## What is currently missing

* simulation flow currently only supports .v / .sv files.

* SW common functions are missing some desirable features (eg. uart overloading for printing int values).

* irq support for baremetal c programs. `crt0.S` implementation is minimal (WIP).

* tool commands for syn / nandgate. These estimations could be useful early.

* Documentation is incomplete. Once complete, it should contain details why certain template architecture was chosen as well as more extensive documentation what is included where. Additionally, template documentation should be added for "student" systems to document themselves.

* pcb related items such as external clock frequency, connetivity. Initial assumption is external 8 MHz oscillator.

* FPGA prototyping flow. Currently there is only short description how to get the files to compile.

## What is excluded from repository

* tool outputs: tools should create build folder for their output. None of this folder content should be part of the git repository. IF need be, provide documentation how to run tools to get the same output.
