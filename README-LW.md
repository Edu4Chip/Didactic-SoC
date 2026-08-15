# Automated Installation

A Python-based installer in `fpga/install/` handles all software prerequisites:
OpenOCD (with optional FT4232HA source patch), the RISC-V cross-compiler,
the debug GUI Python venv, Vivado board files, udev device rules, and PATH
configuration — everything under a single root directory.

## Quick start

```bash
source fpga/install/install.sh --board <board> --ftdi-chip <chip>
```

Using `source` (or `.`) is required so the PATH changes take effect in the
current terminal without opening a new one.

**Example — PYNQ-Z1 with FT4232H adapter:**
```bash
source fpga/install/install.sh --board z1 --ftdi-chip ft4232h
```

**Example — PYNQ-Z2 with automotive FT4232HA (source patch applied automatically):**
```bash
source fpga/install/install.sh --board z2 --ftdi-chip ft4232ha
```

## Supported boards and FTDI adapters

| `--board`  | Description       |
|------------|-------------------|
| `z1`       | PYNQ-Z1           |
| `z2`       | PYNQ-Z2           |
| `basys3`   | Digilent Basys3   |

| `--ftdi-chip` | USB PID  | bcdDevice | OpenOCD support      | JTAG channel |
|---------------|----------|-----------|----------------------|--------------|
| `ft2232c`     | `0x6010` | `0x0500`  | Natively supported   | A (ADBUS)    |
| `ft2232h`     | `0x6010` | `0x0700`  | Natively supported   | A (ADBUS)    |
| `ft4232h`     | `0x6011` | `0x0800`  | Natively supported   | B (BDBUS)    |
| `ft4232ha`    | `0x6048` | `0x3600`  | Source patch applied | B (BDBUS)    |

> **FT2232C and FT2232H share the same USB PID.** OpenOCD distinguishes them
> at runtime via the `bcdDevice` field read from the USB descriptor.

## Install layout

Everything lands under a single root directory (`~/DidacticSoCInstall/` by
default). To uninstall completely, delete that directory.

```
~/DidacticSoCInstall/
    bin/
        didactic-debug          ← debug GUI launcher
        openocd                 ← symlink to installed OpenOCD
        riscv32-unknown-elf-*   ← symlinks to toolchain binaries
    board_files/                ← PYNQ board files (when XHub store absent)
    openocd/                    ← OpenOCD installation
    toolchain/                  ← RISC-V toolchain
    venv/                       ← Python venv for the debug GUI
```

Override the root with `--install-dir <path>`.

## Useful flags

| Flag                    | Description                                               |
|-------------------------|-----------------------------------------------------------|
| `--install-dir`         | Root for the entire installation (default: `~/DidacticSoCInstall`) |
| `--dry-run`             | Print what would be done without making any changes       |
| `-v` / `--verbose`      | Show full subprocess output (git, make, configure, …)     |
| `--force-toolchain`     | Re-download and re-install the toolchain even if present  |
| `--vivado-dir`          | Override Vivado auto-detection (e.g. `~/AMD/2025.2/Vivado`) |
| `--skip-prerequisites`  | Skip build-tool availability checks                       |
| `--skip-openocd`        | Skip OpenOCD clone / build / install                      |
| `--skip-toolchain`      | Skip RISC-V toolchain download                            |
| `--skip-debugger`       | Skip Python venv creation and debug GUI launcher          |
| `--skip-vivado-boards`  | Skip Vivado board files installation                      |
| `--skip-path`           | Skip symlink directory creation and PATH extension        |
| `--skip-udev`           | Skip udev rules installation                              |

## What each step does

1. **Prerequisites** — checks that `git`, `gcc`, `make`, `autoconf`,
   `libtoolize`, `pkg-config`, and `pip3` are available.
2. **OpenOCD** — clones `riscv-collab/riscv-openocd` at commit `9ea7f3d`,
   applies the FT4232HA source patch if `--ftdi-chip ft4232ha` is selected,
   then builds and installs to `<install-dir>/openocd/`.
3. **OpenOCD Config** — patches `fpga/utils/openocd-didactic.cfg` with the
   correct `ftdi channel` and `ftdi vid_pid` for the selected chip.
4. **RISC-V Toolchain** — downloads the pre-built `riscv32-elf` release
   tarball for your OS and extracts it to `<install-dir>/toolchain/`.
5. **Debug GUI** — creates a Python venv in `<install-dir>/venv/`, installs
   PySide6, pygdbmi, and pyserial, and writes the `didactic-debug` launcher
   to `<install-dir>/bin/`.
6. **Vivado Board Files** — downloads PYNQ-Z1 and PYNQ-Z2 board files and
   installs them into Vivado's XHub store (Vivado 2019.2+, auto-detected) or
   into a `board_files/` directory registered via `set_param board.repoPaths`.
   Boards already present are silently skipped.
7. **PATH Extension** — creates `<install-dir>/bin/` with symlinks to all
   installed tools and appends an export line to the shell RC file
   (`.bashrc`, `.zshrc`, `config.fish`, …).
8. **Udev Rules** — installs `60-openocd.rules` so the FTDI adapter is
   accessible without root.
9. **Board Summary** — prints the JTAG/UART wiring table for the selected board.

## Download links

All external URLs (OpenOCD repo, toolchain releases, board file archives) are
defined in `fpga/install/links.json` and loaded at startup by
`fpga/install/steps/links.py`. To update a URL or version pin, edit that file —
no step source code needs to change.

## Modular design

Each step is an independent Python class in `fpga/install/steps/`. The same
objects can be imported by a GUI wizard without modification — see
`fpga/install/steps/base.py` for the `Step` interface and
`fpga/install/install.py`:`build_steps()` as the single assembly point.

---

# Debug GUI

A PySide6 desktop application in `fpga/debug/` provides a unified interface for
programming, running, and communicating with the Didactic SoC on the FPGA board.

## Launch

After running the installer:
```bash
didactic-debug
```

Or directly from the repository (requires packages from `requirements.txt`):
```bash
cd fpga/debug
python main.py
```

## Features

- **OpenOCD / GDB / UART** connections managed from one panel
- **ELF Loader** — loads and runs a compiled RISC-V ELF via GDB
- **Register Map** — browsable tree of all memory-mapped peripheral registers,
  click to read, double-click to write; auto-halts the CPU on write
- **GDB Snippets** — editable library of `.gdb` scripts with syntax highlighting
- **UART Terminal** — live terminal with file import / export
- **Settings persistence** — window geometry, UART port, and baud rate are
  restored automatically between sessions
  (`~/.config/DidacticSoC/SoCDebugger.conf`)

See `fpga/debug/doc/user-guide.md` for full usage instructions.

---

# OPENOCD

We need OpenOCD to communicate with the RISC-V core via its dedicated JTAG
interface. The installer automates all steps below; this section documents the
process for reference.

## Clone & Compile

```bash
git clone https://github.com/riscv-collab/riscv-openocd
cd riscv-openocd
git checkout 9ea7f3d647c8ecf6b0f1424002dfc3f4504a162c
./bootstrap
./configure
make -j4
sudo make install
```

## Supported FTDI Adapters

The OpenOCD config (`fpga/utils/openocd-didactic.cfg`) is written for the
**FT4232H** mini module. The FT4232H and the automotive-grade **FT4232HA**
are functionally identical for JTAG purposes but have different USB Product IDs
programmed into their on-board EEPROM:

| Module        | USB VID  | USB PID  | Supported by pinned commit |
|---------------|----------|----------|---------------------------|
| FT4232H       | `0x0403` | `0x6011` | Yes                       |
| FT4232HA      | `0x0403` | `0x6048` | No (source patch needed)  |

The pinned commit (`9ea7f3d`) does not include the FT4232HA PID in its device
table. If you have an FT4232HA mini module, you have two options:

**Option 1 — Update the OpenOCD config** (quickest workaround):

Change the `ftdi vid_pid` line in `fpga/utils/openocd-didactic.cfg`:

```
# FT4232H (default):
ftdi vid_pid 0x0403 0x6011

# FT4232HA — replace the line above with:
ftdi vid_pid 0x0403 0x6048
```

**Option 2 — Patch OpenOCD source** (permanent; applied automatically by the
installer when `--ftdi-chip ft4232ha` is used):

1. **`src/jtag/drivers/mpsse.h`** — add `TYPE_FT4232HA` to the chip-type enum:
```c
 enum ftdi_chip_type {
     TYPE_FT2232H,
     TYPE_FT4232H,
     TYPE_FT232H,
+    TYPE_FT4232HA,
 };
```

2. **`src/jtag/drivers/mpsse.c`** — map the FT4232HA `bcdDevice` value (`0x3600`)
to the new enum value:
```c
+    case 0x3600:
+        ctx->type = TYPE_FT4232HA;
+        break;
     default:
         LOG_ERROR("unsupported FTDI chip type: 0x%04x", desc.bcdDevice);
```

3. **`contrib/60-openocd.rules`** — add a udev rule so Linux grants non-root
access to the FT4232HA (PID `0x6048`):
```
+# Original FT4232HA VID:PID
+ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6048", MODE="660", GROUP="plugdev", TAG+="uaccess"
```

Copy the updated rules file to `/etc/udev/rules.d/` and run
`sudo udevadm control --reload-rules` after building.

---

# RISC-V Toolchain

The installer downloads a pre-built release automatically. For manual
installation, go to:

```
https://github.com/riscv-collab/riscv-gnu-toolchain/releases
```

Example — Ubuntu 22.04:
```bash
wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2026.07.15/riscv32-elf-ubuntu-22.04-gcc.tar.xz
tar -xJf riscv32-elf-ubuntu-22.04-gcc.tar.xz
```

Select the release matching your OS and for 32-bit RISC-V (`riscv32-elf-*`).

---

# Vivado Board Files

The installer detects Vivado automatically and installs board files for PYNQ-Z1
and PYNQ-Z2. On Vivado 2025.x the PYNQ-Z2 files are already bundled with the
AMD installer; only PYNQ-Z1 is downloaded.

| Board   | Source                                                                 |
|---------|------------------------------------------------------------------------|
| PYNQ-Z1 | https://github.com/cathalmccabe/pynq-z1_board_files                   |
| PYNQ-Z2 | https://dpoauwgwqsy2x.cloudfront.net/Download/pynq-z2.zip              |

For Vivado 2019.2+ (AMD unified installer) the files are placed directly in the
XHub store (`data/xhub/boards/XilinxBoardStore/boards/Xilinx/`). For older
Vivado a `set_param board.repoPaths` entry is added to `~/.Xilinx/Vivado/<ver>/Vivado_init.tcl`.

---

# Wiring

The PYNQ-Z1 and PYNQ-Z2 share the same Zynq-7000 FPGA die and therefore the
same physical pin assignments. They differ only in how those pins are labelled
on the board's external connectors:

- **Z1** uses **CK_IO** names on its Arduino-compatible header.
- **Z2** uses **ARI** (Arduino header) and **RPI** (Raspberry Pi header) names.

JTAG and UART signals come out on the top-half Arduino headers on both boards.
An FT4232H/HA minimodule (or similar USB-to-JTAG+UART adapter) is used to
connect a host PC to these pins.

![PYNQ-Z1 board pinout](images/z1-pinout.png)
*Figure 1 — PYNQ-Z1 connector pinout*

![PYNQ-Z2 board pinout](images/z2-pinout.png)
*Figure 2 — PYNQ-Z2 connector pinout*

## JTAG

JTAG signals connect to the FT4232H/HA on its channel B (BD pins).

| Signal | FPGA Pin | Z1 (CK_IO) | Z2 (ARI / RPI) |
|--------|----------|------------|----------------|
| TDI    | T14      | CK_IO_0    | ARI_00         |
| TDO    | U12      | CK_IO_1    | ARI_01         |
| TMS    | V13      | CK_IO_3    | ARI_03         |
| TCK    | Y7       | CK_IO_37   | RPI_024        |

![JTAG wiring diagram](images/jtag-wiring.png)
*Figure 3 — JTAG wiring between FT4232H and PYNQ board*

## UART

UART signals connect to the FT4232H/HA on its channel A (AD pins).

| Signal | FPGA Pin | Z1 (CK_IO) | Z2 (ARI / RPI) |
|--------|----------|------------|----------------|
| RX     | V15      | CK_IO_4    | ARI_04         |
| TX     | T15      | CK_IO_5    | ARI_05         |

![UART wiring diagram](images/uart-wiring.png)
*Figure 4 — UART wiring between FT4232H and PYNQ board*

## GPIO (PMOD)

GPIO signals from the SoC are routed to the PMOD headers. The PMOD connector
names (JA, JB) and FPGA pin assignments are identical on Z1 and Z2.

| GPIO Bit | FPGA Pin | PMOD Connector |
|----------|----------|----------------|
| 0        | Y18      | JA[0]          |
| 1        | Y19      | JA[1]          |
| 2        | Y16      | JA[2]          |
| 3        | Y17      | JA[3]          |
| 4        | U18      | JA[4]          |
| 5        | U19      | JA[5]          |
| 6        | W18      | JA[6]          |
| 7        | W19      | JA[7]          |
| 8        | W14      | JB[0]          |
| 9        | Y14      | JB[1]          |
| 10       | T11      | JB[2]          |
| 11       | T10      | JB[3]          |
| 12       | V16      | JB[4]          |
| 13       | W16      | JB[5]          |
| 14       | V12      | JB[6]          |
| 15       | W13      | JB[7]          |

## SPI

SPI CSN and SCK signals use the Arduino SPI header pins on both boards. SPI DATA
lines are on FPGA Bank 13 and connect to the dedicated underside SPI adapter
connector on the Z1. On the Z2, those same FPGA pins are shared with the audio
codec (DATA0) and the Raspberry Pi header (DATA2, DATA3); DATA1 (V5) is not
routed to any accessible connector on the Z2.

| Signal | FPGA Pin | Z1               | Z2           | Standard SPI | QSPI  |
|--------|----------|------------------|--------------|--------------|-------|
| DATA0  | U5       | SPI adapter      | au_mclk_r    | MOSI         | DATA0 |
| DATA1  | V5       | SPI adapter      | N/A          | MISO         | DATA1 |
| DATA2  | V6       | SPI adapter      | RPI_014      | —            | DATA2 |
| DATA3  | U7       | SPI adapter      | RPI_017      | —            | DATA3 |
| CSN0   | T12      | CK_MOSI          | CK_MOSI      | CS           | CS    |
| CSN1   | W15      | CK_MISO          | CK_MISO      | —            | —     |
| SCK    | H15      | CK_SCK           | CK_SCK       | SCLK         | SCLK  |

![Full wiring overview](images/wiring-overview.png)
*Figure 5 — Full wiring overview: FT4232H, PYNQ board, and PMOD connections*
