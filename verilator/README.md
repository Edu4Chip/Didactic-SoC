# Didactic Verilator Simulation
This flow uses Verilator to compile the Didactic design into a system-native simulation executable. Software stimulus is passed directly in the form of ELF-files when invoking the simulation.

## Quickstart

After first cloning or cleaning the repo, run `make repository_init` to initialize all dependencies with Bender.

### Linting
Verilator can be used for linting without simulation with the command `make vlint`

### Compilation
The design and C++ testbench are compiled with a single command: `make verilate`.
For large designs, this command can take reasonably long to complete (~5 mins). For this reason the compilation and simulation are completely decoupled, i.e., a single hardware compilation instance can be used to run an arbitrary set of software tests without recompilation.

### Simulation
Simulations are invoked with `make simv TEST=<testname>`. This assumes that an ELF file matching with `<testname>` exists in `../build/sw/<testname>.elf`. The simulation command can be preceded by `make build_test TEST=<testname>` to produce the required executable.

### Under The Hood
This flow utilizes [`vbench`](https://github.com/ANurmi/vbench) to provide the fundamental clocking, reset and JTAG utilities to the testbench. The base class methods of `vbench` can be extended or overwritten in `./verilator/TbDidactic.h`.

### Known Limitations

- `Didactic.v` does not work correctly as a top-level on any tested version, however, running the simulation from one level lower in the hierarchy (`top=SysCtrl_SS_0`) seems to work flawlessly.
- Other interfaces that JTAG are untested. UART should employ [mock](https://github.com/openhwgroup/cva6/blob/master/corev_apu/tb/common/mock_uart.sv) instance for this type of high-level, lightweight simulation.

### Tested Verilator Versions
- 5.008
- 5.024
- 5.038