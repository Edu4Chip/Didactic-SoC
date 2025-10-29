# Verification

Basic testbench and program loading is completed. Testbench alters software file target based on variables on elaboration command. 

## Baremetal programs

Simple C-programs can be used to verify things that are accessible from RISC-V core. Helper functions have been created to abstract some of the commonly used features.

## Keelhaul

Later in the project once SoC is fully wired up, if we have memory models defined in IP-XACT, we can use Keelhaul system to automatically create binary to run memory read+write test to each of the fields present in the peripheral memory map.

