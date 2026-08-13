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
