# Verification

Basic testbench and program loading is completed. Testbench alters software file target based on variables on elaboration command. Initially this is designed for ModelSim/Questa simulator.

## Baremetal programs

Simple C-programs can be used to verify things that are accessible from RISC-V core. Helper functions have been created to abstract some of the commonly used features.

## Keelhaul

Later in the project once SoC is fully wired up, if we have memory models defined in IP-XACT, we can use [Keelhaul](https://github.com/soc-hub-fi/keelhaul) system to automatically create binary to run memory read+write test to each of the fields present in the peripheral memory map.

## PyUVM

Test setup running on PyUVM is developed for subsystem testing. Setup and it's documentation can be found in <code>verification/student_ss</code>.

## Verilator

More emphasis is being given to have Verilator as equivalent verification tool to commercial options on this platform. More features are currently being developed to <code>verification/verilator</code>.