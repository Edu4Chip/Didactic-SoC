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
4. Initialize repository `make verilator-initialize`.
5. Translate HW to SW with Verilator `make verilator-generate-model`
    - Select testcase, e.g. `example` using `make verilator-generate-model testcase=example`.
    - Return value is `OK` if no errors were detected.
    - Return value is `FAIL` is errors were detected.
6. Build Verilator's output with SW testbench `make verilator-build`.
7. Execute SW testbench `make verilator-run`.
    - `make verilator-run` should automatically execute `make verilator-build`.

### Tracing

1. Execute SW testbench with tracing `make verilator-run-traced`.
    - `make verilator-run-traced` should automatically execute `make verilator-build`.
2. Inspect trace with GTKWave `gtkwave logs/vlt_dump.vcd`.

### Troubleshooting

#### Missing clock signal

If you see an error like this:

```python
/src/generated/SomeSubsystem.sv
Traceback (most recent call last):
File "./verification/verilator/scripts/generate_bindings.py", line 74, in <module>
clock_signal_name = clock_signal_names[path.name]
~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 'SomeSubsystem.sv'
make: *** [Makefile:86: verilator-generate-bindings] Error 1
```

This means that the clock signal name is not defined in `verification/verilator/scripts/clock_signal_names.py`. You can add the clock signal name to the dictionary in `verification/verilator/scripts/clock_signal_names.py` and re-run the command.

```python
clock_signal_names = {
    'SomeSubsystem.sv': 'clk',
    'SomeOtherSubsystem.sv': 'clk',
}
```
