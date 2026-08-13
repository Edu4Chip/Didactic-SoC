

# OPENOCD

We need OpenOCD to communicate with the RISC-V core via its dedicated JTAG interface.

## Clone & Compile
1. Clone the repo:
```git clone https://github.com/riscv-collab/riscv-openocd```
2. Checkout commit 9ea7f3d647c8ecf6b0f1424002dfc3f4504a162c (version 0.12)
 ```cd riscv-openocd/
    git checkout 9ea7f3d647c8ecf6b0f1424002dfc3f4504a162c```
3. Add your board if necessary

4. Compile
   ``` ./bootstrap ```
   ``` ./configure ```
   ``` make; sudo make install ```


## Supported FTDI Adapters

The OpenOCD config (`fpga/utils/openocd-didactic.cfg`) is written for the
**FT4232H** mini module. The FT4232H and the automotive-grade **FT4232HA**
are functionally identical for JTAG purposes but have different USB Product IDs
programmed into their on-board EEPROM:

| Module        | USB VID  | USB PID  | Supported by pinned commit |
|---------------|----------|----------|---------------------------|
| FT4232H       | `0x0403` | `0x6011` | Yes                       |
| FT4232HA      | `0x0403` | `0x6048` | No                        |

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

**Option 2 — Patch OpenOCD source** (permanent, covers all users):

Three files need to be changed in the OpenOCD tree before building:

1. **`src/jtag/drivers/mpsse.h`** — add `TYPE_FT4232HA` to the chip-type enum:
```c
 enum ftdi_chip_type {
     TYPE_FT2232H,
     TYPE_FT4232H,
     TYPE_FT232H,
+    TYPE_FT4232HA,
 };
```

2. **`src/jtag/drivers/mpsse.c`** — map the FT4232HA `bcdDevice` value (`0x3600`,
from the module EEPROM) to the new enum value:
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

## Add your board if not present


# RISCV TOOLCHAIN

Go to: https://github.com/riscv-collab/riscv-gnu-toolchain/releases 

Example:  RISCV Toolchain for Ubuntu 22.04
```wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2026.07.15/riscv32-elf-ubuntu-22.04-gcc.tar.xz```


Select release version  for your OS and for 32-bit RISCV

Download and install release.

If you want you can try building from source.

# Wiring

The PYNQ-Z1 and PYNQ-Z2 share the same Zynq-7000 FPGA die and therefore the
same physical pin assignments. They differ only in how those pins are labelled
on the board's external connectors:

- **Z1** uses **CK_IO** names on its Arduino-compatible header.
- **Z2** uses **ARI** (Arduino header) and **RPI** (Raspberry Pi header) names.

JTAG and UART signals come out on the top-half Arduino headers on both boards.
An FT2232HL minimodule (or similar USB-to-JTAG+UART adapter) is used to connect
a host PC to these pins.

![PYNQ-Z1 board pinout](images/z1-pinout.png)
*Figure 1 — PYNQ-Z1 connector pinout*

![PYNQ-Z2 board pinout](images/z2-pinout.png)
*Figure 2 — PYNQ-Z2 connector pinout*

## JTAG

JTAG signals connect to the FT2232HL on its channel B (BD pins).

| Signal | FPGA Pin | Z1 (CK_IO) | Z2 (ARI / RPI) |
|--------|----------|------------|----------------|
| TDI    | T14      | CK_IO_0    | ARI_00         |
| TDO    | U12      | CK_IO_1    | ARI_01         |
| TMS    | V13      | CK_IO_3    | ARI_03         |
| TCK    | Y7       | CK_IO_37   | RPI_024        |

![JTAG wiring diagram](images/jtag-wiring.png)
*Figure 3 — JTAG wiring between FT2232HL and PYNQ board*

## UART

UART signals connect to the FT2232HL on its channel A (AD pins).

| Signal | FPGA Pin | Z1 (CK_IO) | Z2 (ARI / RPI) |
|--------|----------|------------|----------------|
| RX     | V15      | CK_IO_4    | ARI_04         |
| TX     | T15      | CK_IO_5    | ARI_05         |

![UART wiring diagram](images/uart-wiring.png)
*Figure 4 — UART wiring between FT2232HL and PYNQ board*

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
*Figure 5 — Full wiring overview: FT2232HL, PYNQ board, and PMOD connections*

