# Didactic SoC

This is the common chip template for the Edu4chip project. It is created with IP-XACT modeling using the Kactus2 tool. Source files are reused from both open source and previous projects. This project is licensed under the terms of the Solderpad Hardware License v2.1.

See Doc Folder for more extensive documentation and guides as well as contribution guidelines (some of which are yet to be written).

## SoC Architecture

Didactic aims to have simple SoC architecture while being easily extendable for various education and prototyping purposes.

![Didactic SoC architecture](doc/figures/didactic_architecture.drawio.svg "SoC Architecture Diagram")

In addition to these requirements, system needs to be reliable and have enough peripherals to operate as controller to manage various student subsystems.

### Interconnect type

SoC architecture is interconnect bus-type agnostic. Currently, we support AXI4LITE and OBI bus. These are 1.0 and 1.1 SoC builds. OBI is more area and performance optimized due to not requiring converters while axi4lite build has better confidence in correctness.

To use different types, regenerate rtl code from Kactus2 Didactic top level and replace filelist command argument <code>didactic_obi</code> or <code>didactic_axi</code>

## Get started

This repository uses Bender, install instructions [here](https://github.com/pulp-platform/bender).

After cloning this repository, run `make repository_init` to fetch all of the dependencies to correct versions. Bender initialization will offer user to resolve dependencies interactively. In these, it is correct to resolve to use ones required by this repository. Generally, these are updated to be latest releases (in either git tag or git commit hash form).

## Basic simulation flow

Running Baremetal program on IBEX core has been abstracted to `make test_all TEST=blink` command.

This will build HW libraries (`Questa`), executable binary (`riscv-toolchain`), convert binary to hexfile (`elf2hex`) and finally run the simulator (`Questa`). Testcase targets folder in sw folder and expects it to contain .c file with same name. Eg. <code>sw/hello/hello.c</code>.

## Folders

.bender: Open source IP are added to this project as bender dependencies. They are described in bender.yml and this folder is created by bender tool. Folder itself is not part of the repository. 

build: Not included by git repository. Created as part of make commands to contain all tool outputs.

doc: All documentation is gathered within this folder.

fpga: Tool scripts, documentation and constraint files for FPGA platforms should be added to this folder.

ipxact: XML files of IPXACT definitions are kept within this folder.

sim: Simulation Makefiles and scripts are kept in this folder. Additionally, supporting files and/or scripts such as for waveform generation can be added here. 

* All tool scripts need to include capability of targeting bender with scripts or make commands. Calling bender with particular commands produce output of files to target the build with. Examples are provided for questa and verilator uses.

scripts: General use scripts that are not directly part of any other major categories can be added here.

src: RTL source files are added to this folder in relevant subfolders. Student subsystems can be added either as submodules, bender dependencies or directly to this fodler. If your RTL is not publicly available, create a tieoff module to allow others to proceed with their work. (Tieoff: interface .sv/.v/.vhd that matches with the original RTL with all outputs being driven with inactive constant 0's.)

sw: Baremetal programs and their flow. These include common headers and simple test cases to run on RISC-V core. These may later include test cases for various student subsystems. 

syn: Synthesis Makefiles and commands. Open source tools only.

.vendor_ips: Not included by repository. Submodules that do not directly support bender are added as vendor dependencies in bender.yml and fetched to this folder.

Verification: Contains experimental verilator setup and verification PyUVM platform for student subsystems.

## What is currently missing

* simulation flow currently only supports .v / .sv files.

* SW common functions are missing some desirable features (eg. uart overloading for printing int values).

* irq support for baremetal c programs. `crt0.S` implementation is minimal and needs to be extended to contain IRQ handling.

* tool commands for syn / nandgate. These estimations could be useful for early exploration.

* Documentation is incomplete. Once complete, it should contain details why certain template architecture was chosen as well as more extensive documentation what is included where. Additionally, template documentation should be added for "student" systems to document themselves.

* pcb related items such as external clock frequency, connetivity. Initial assumption is to have single external clock source (signal generator / oscillator) and internal faster option.

## What is excluded from repository

* tool outputs: tools should create build folder for their output. None of this folder content should be part of the git repository. IF need be, provide documentation how to run tools to get the same output.

