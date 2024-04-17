# Didactic SoC

This is the common chip template for the Edu4chip project. It is created with IPXACT modeling using the Kactus2 tool. Source files are reused from both open source and previous projects. This project is licensed under the terms of the Solderpad Hardware License v2.1.

See Doc Folder for more extensive documentation and guides as well as contribution guidelines (to be written).

## Get started

After cloning this repository, run <code>make repository_init</code> to fetch all of the submodules to correct versions.

## Folders

Doc: Full documentation is gathered within doc folder.

ips: open source IP are added to this folders as git submodules. We prefer to have all of the modules up to latest versions, but this is confirmed case by case when we are ready to run simulations/synthesis.

ipxact: XML files of IPXACT definitions are kept within this folder.

sim: Simulation Makefiles and scripts are kept in this folder. Additionally, supporting files for waveform generation can be added here. 
* All tool scripts need to include capability of targeting filelists with relative path from filelist to file and # symbol for comments. Empty lines must be okay, too. 

src: RTL source files are added to this folder in relevant subfolders. In addition, filelists for SoC compilation are kept here. If your RTL is not publicly available, create a tieoff module to allow others to proceed with their work. (Tieoff: interface verilog with all outputs being driven with inactive constants, genrally 0's.)

syn: Synthesis Makefiles and commands. Same as with sim folder.

## What is currently missing

* SW solutions are not present currently. (toolchain commands, hello world example c code using ibex+uart)

* ROM implementation + generator commands to convert ROM code to hex files, or similar.

* tool commands for syn / sim. Latter including execution of binaries as well as jtag module testing.

* documentation is incomplete. Once complete, it should contain details why certain template architecture was chosen as well as more extensive documentation what is included where. Additionally, template documentation should be added for "student" systems to document themselves.

* pcb related items such as external clock frequency

## What is excluded from repository

* tool outputs: tools should create build folder for their output. None of this folder content should be part of the git repository. IF need be, provide documentation how to run tools to get the same output.