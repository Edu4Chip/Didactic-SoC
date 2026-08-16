# Debug Tool — Known Issues & Findings

## 6. Single-step not supported by hardware — software workaround implemented

**Symptom:** Clicking the Step button had no visible effect, or the target ran
continuously without stopping.

**Investigation results:**

| Attempt | Outcome | Root cause |
|---|---|---|
| `monitor step` | 10-second timeout | CPU steps but debug module never signals halt completion |
| `-exec-step-instruction` | 10-second timeout | Same underlying issue via GDB RSP `vCont;s` |
| `-break-insert -h -t` (RSP Z1) | "Ignoring packet error" | OpenOCD RISC-V backend rejects Z1 hardware breakpoint packet |
| `monitor bp … hw` | 10-second timeout | Trigger module CSR (`tselect`) access hangs the debug module |
| `-break-insert -t` (RSP Z0, software BP) | Target ran forever | GDB's Z0 write fails silently; instruction memory appears read-only via RSP memory write |
| `monitor mww` direct write | **Success** | Instruction memory IS writable through the OpenOCD memory bus |

**Key diagnostic commands and findings:**

```
(gdb) monitor reg dcsr
dcsr (/32): 0x4000b0c3
```

Decoded:
- `xdebugver = 4` — debug spec 0.13 compliant
- `ebreakm = 1` — **EBREAK in M-mode enters debug mode** ← the enabling condition
- `prv = 3` — CPU is running in M-mode
- `stepie = 0` — interrupts disabled during single step

```
(gdb) monitor mww 0x01000130 0x00100073
(gdb) monitor mdw 0x01000130
0x01000130: 00100073     ← write succeeded; instruction memory is writable via mww
```

**Fix:** Software single-step implemented in `GdbClient.step()` — see
`doc/architecture.md § Single-step implementation` for full details.

The short version: patch `C.EBREAK` (`0x9002`) into instruction memory at the
next PC via `monitor mww`, resume with `-exec-continue` so GDB expects `T05`,
poll passively for `*stopped`, restore the original instruction. No hardware
trigger module or RSP breakpoint packets are involved.

---

## 1. GDB memory write fails with "Ignoring packet error" on peripheral registers

**Symptom:** `set *((int*)0x01030100) = 0x41` in GDB produces repeated "Ignoring packet error" and nothing is sent.

**Cause:** GDB's memory write uses the program buffer mechanism (runs a small snippet on the CPU), which is unreliable for memory-mapped peripheral addresses.

**Fix:** Use OpenOCD's native memory commands which go directly over the debug bus:
```
monitor mww 0x01030100 0x41   # write
monitor mdw 0x01030100        # read
```

---

## 2. GDB memory read returns "read failed" with no detail

**Symptom:** The memory panel shows "Read failed" with no explanation.

**Cause:** `read_word()` was silently returning `None` when the GDB/MI response contained an error result.

**Fix:** `read_word()` now raises `RuntimeError` with the GDB error message when the response message is `"error"`, so the actual reason (e.g. target running, bus fault) is surfaced in the status bar.

---

## 3. UART baud rate mismatch — garbled output

**Symptom:** Data received on host serial port is garbled. `uart.h` comment states 100 MHz clock → 230400 baud.

**Cause:** The FPGA PLL (see `fpga/rtl/DidacticZ1.v`) generates 25 MHz, not 100 MHz:
- Input: 125 MHz, DIVCLK_DIVIDE=5, CLKFBOUT_MULT=33, CLKOUT0_DIVIDE=33
- Output: 125 / 5 * 33 / 33 = **25 MHz**

With divisor=27: 25 MHz / (16 × 27) = **57,870 baud ≈ 57600**

**Fix:** Use 57600 baud on the host. The 100 MHz / 230400 values apply to the ASIC version only. Both `uart.h` and `uart.py` have been updated accordingly.

---

## 4. UART peripheral must be initialized before use

**Symptom:** Writing to `0x01030100` (THR) sends nothing or garbage if the SoC has just been powered/reset without running application code.

**Cause:** The UART divisor registers are in an undefined reset state. `uart_init()` in `sw/common/uart.h` must be called first to configure the baud rate, FIFO, and line control registers.

**Fix:** Use `fpga/utils/reset_uart.gdb` to initialize the UART via GDB without needing an ELF:
```
(gdb) source fpga/utils/reset_uart.gdb
```

---

## 5. Identifying the UART serial port among multiple ttyUSB devices

**Symptom:** Multiple `/dev/ttyUSBx` devices present; unclear which is the UART channel.

**Cause:** OpenOCD uses libusb directly (raw `/dev/bus/usb/…`) and detaches the kernel driver only for the JTAG channel. The UART channel remains as a `ttyUSB` device. The JTAG channel shows up as a gap in the ttyUSB numbering.

**Method:** Run `ls /dev/ttyUSB*` — the missing number in the sequence is the JTAG channel held by OpenOCD. The adjacent lower-numbered port is the UART (channel A for FT4232H, channel B for FT2232H).

Confirm with:
```bash
udevadm info -a /dev/ttyUSB0 | grep idVendor   # should show 0403 for FTDI
```
