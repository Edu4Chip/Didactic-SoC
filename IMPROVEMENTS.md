# Possible Improvements

## OpenOCD commit does not support FT4232HA

**File:** `fpga/utils/openocd-didactic.cfg` and OpenOCD source

The pinned OpenOCD commit (`9ea7f3d`, v0.12) does not include the FT4232HA in
its FTDI device table. The FT4232HA is the automotive-grade variant of the
FT4232H; it is functionally identical for JTAG use but ships with a different
USB PID (`0x6048` vs `0x6011` for the standard H).

**Fix A — config only (per-user workaround):** change `ftdi vid_pid 0x0403
0x6011` to `ftdi vid_pid 0x0403 0x6048` in `openocd-didactic.cfg`.

**Fix B — source patch (permanent, covers all users):** three files need
changing in the OpenOCD tree:

- `src/jtag/drivers/mpsse.h` — add `TYPE_FT4232HA` to the `ftdi_chip_type`
  enum.
- `src/jtag/drivers/mpsse.c` — add a `case 0x3600:` branch (the `bcdDevice`
  value from the FT4232HA EEPROM, confirmed in its mini module datasheet
  Appendix A) that sets `ctx->type = TYPE_FT4232HA`.
- `contrib/60-openocd.rules` — add a udev rule for PID `0x6048` so Linux
  grants non-root access to the device.

## reset_handler not exported as a global symbol

**File:** `sw/common/crt0.S`

`reset_handler` was defined as a local label with no `.globl` directive. The
linker's `ENTRY(reset_handler)` in `link.ld` searches only global symbols, so
it fell back to `0x01000000` with the warning:

```
cannot find entry symbol reset_handler; defaulting to 01000000
```

This silently re-introduced the wrong ELF entry point even after `ENTRY()` was
added to the linker script.

**Fix (applied):** added `.globl reset_handler` above the label in `crt0.S`.
The ELF `e_entry` field now correctly points to `reset_handler`, and GDB's
`load` sets PC there automatically.

## Missing ENTRY in linker script causes wrong ELF entry point

**File:** `sw/common/link.ld`

Without an `ENTRY()` directive the linker defaults the ELF `e_entry` field to
the start of the first output section, which is `0x01000000` — the first word of
`.vectors`. That word is `jal x0, default_handler`, an IRQ vector entry that
immediately jumps to `mret` and loops indefinitely. When GDB's `load` command
downloads the binary it sets PC to `e_entry`, so the CPU was running the wrong
code and never reaching `reset_handler` or `main()`.

Compounding the issue, this core's RISC-V Debug Module has unreliable abstract
commands, so `monitor reg pc <addr>` and `set $pc` both fail intermittently with
"Written PC does not match read back value". This made it impossible to recover
by manually correcting PC after load.

**Fix (applied):** add `ENTRY(reset_handler)` at the top of `link.ld`. GDB's
`load` now sets PC to `reset_handler` automatically, and a plain `continue` is
sufficient to start the program.

**Workaround used during debugging:** patch the first IMEM word in-place with
`monitor mww 0x01000000 0x12A0006F` (encodes `jal x0, reset_handler`) so the
CPU jumps to `reset_handler` regardless of where GDB left PC. Confirmed working
— alphabet A–Z output visible over UART at 57600 baud.

## UART baud rate mismatch between ASIC and FPGA targets

**File:** `sw/common/uart.h`, `fpga/utils/reset_uart.gdb`, `fpga/debug/debugger/uart.py`

`uart.h` had a comment claiming 100 MHz clock and 230400 baud. The FPGA PLL
generates 25 MHz (125 MHz ÷ 5 × 33 ÷ 33). At 25 MHz with divisor 27:
25 000 000 ÷ (16 × 27) ≈ 57 870 → nearest standard baud = **57600**.

**Fix (applied):** updated comment in `uart.h`, default baud in `uart.py` (GUI),
and `reset_uart.gdb`. The GUI baud selector lists both rates with labels so
users switching between FPGA and ASIC targets know which to pick.

## SPI DATA1 pin — Z1/Z2 compatibility

**File:** `fpga/constraints/z1.xdc:56`

`spi_data[1]` is currently assigned to FPGA pin V5 (Bank 13). On the PYNQ-Z2,
V5 is routed internally to the audio codec and is not exposed on any external
connector, making DATA1 inaccessible when using the Z2.

**Fix:** Reassign `spi_data[1]` to any available Bank 13 pin that appears on
the Z2 Raspberry Pi header (and by extension the Z1 RPI header). Staying in
Bank 13 keeps all four QSPI DATA lines in the same IO bank, which is important
for signal integrity and IDELAY grouping. Physically adjacent candidates that
minimise routing skew relative to DATA2 (V6) and DATA3 (U7):

| FPGA Pin | Z2 RPI name | Notes                          |
|----------|-------------|--------------------------------|
| V8       | rpio_10_r   | closest to V6/U7 — recommended |
| W8       | rpio_13_r   | also physically close          |
| W6       | rpio_23_r   |                                |
| Y6       | rpio_15_r   | MRCC pin                       |

A `fpga/constraints/z2.xdc` (based on `~/Downloads/pynq-z2.xdc`) also needs to
be created and added to the build flow once a target pin is chosen.
