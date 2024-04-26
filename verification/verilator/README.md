# Verification with Verilator

## Why this exists?

1. This project uses Verilator to compile hardware description language into executable software. This executable software can be tested using a software testbench. This supports the verification effort of the hardware.

## Who uses this?

1. This script can be executed by user locally.
2. This script can be executed by remote repository CI pipeline.

## How to use?

1. [Install Verilator](https://verilator.org/guide/latest/install.html).
2. Configure file permission.
    - `ls -l verification/verilator/run.sh` should return `**x` for user. If that is not the case then `chmod u+x verification/verilator/run.sh`.
3. Execute Verilator `verification/verilator/run.sh`.
    - Return value is `OK` if no errors were detected.
    - Return value is `FAIL` is errors were detected.
