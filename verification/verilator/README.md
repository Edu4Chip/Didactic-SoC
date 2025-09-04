# Verification with Verilator

## Why this exists?

1. This project uses Verilator to compile hardware description language into executable software. This executable software can be tested using a software testbench. This supports the verification effort of the hardware.

## Who uses this?

1. This script can be executed by user locally.
2. This script can be executed by remote repository CI pipeline.

## How to use?

1. [Install Verilator](https://verilator.org/guide/latest/install.html).
2. Optional. [Create virtual environment for Python](https://docs.python.org/3/library/venv.html).
3. Install Python dependencies `pip install --requirement ./verification/verilator/requirements.txt`.
4. Execute all testcases `make verilate`.

### Tracing

1. Tracing is automatically executed by `make verilate`.
2. Inspect trace with e.g. GTKWave `gtkwave logs/vlt_dump.vcd`.

### Configuration of development environment

1. Consider using at least following compiler flags:
    - `-I<path to obj_dir>`
    - `-I<path to verilator/include>`
    - `-I<path to verilator/include/vltstd>`
    - `-DVM_TRACE` while tracing
