# Verification with Verilator

## Why this exists?

1. This project uses Verilator to compile hardware description language into executable software. This executable software can be tested using a software testbench. This supports the verification effort of the hardware.

## Who uses this?

1. This script can be executed by user locally.
2. This script can be executed by remote repository CI pipeline.

## How to use?

1. [Install Verilator](https://verilator.org/guide/latest/install.html).
2. Configure file permission.
    - `ls -l verification/verilator/scripts/do_fix.sh` must return `**x` for user. If that is not the case then `chmod u+x verification/verilator/scripts/do_fix.sh`.
    - `ls -l verification/verilator/scripts/run.sh` must return `**x` for user. If that is not the case then `chmod u+x verification/verilator/scripts/run.sh`.
    - `ls -l verification/verilator/scripts/undo_fix.sh` must return `**x` for user. If that is not the case then `chmod u+x verification/verilator/scripts/undo_fix.sh`.
3. Translate HW to SW with Verilator `make verilator-generate`.
    - Select executable, e.g. `example` using `make verilator-generate executable=example`.
    - Return value is `OK` if no errors were detected.
    - Return value is `FAIL` is errors were detected.
4. Build Verilator's output with SW testbench `make verilator-build`.
5. Execute SW testbench `make verilator-run`.
    - `make verilator-run` should automatically execute `make verilator-build`.

### Tracing

1. Execute SW testbench with tracing `make verilator-run-traced`.
    - `make verilator-run-traced` should automatically execute `make verilator-build`.
2. Inspect trace with GTKWave `gtkwave logs/vlt_dump.vcd`.
