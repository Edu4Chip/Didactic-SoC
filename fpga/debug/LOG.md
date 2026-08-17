# Debug Tool — Known Issues & Findings

## 8. Disassembly panel added

A **Disassembly** tab was added to the right-hand tab widget. It shows the
disassembled program with a PC marker (`▶`), breakpoint gutter (`●`), and a
compact call-stack list.

The disassembly is built once at ELF load time using
`riscv32-unknown-elf-objdump -d --no-show-raw-insn` as a subprocess. The result
is cached and reused on every halt/step/reset with zero GDB I/O. The panel never
updates while the target is running.

Using GDB's `-data-disassemble` instead (the first implementation) caused the
same `abstractcs.cmderr` latch problem described in entry #7 below.

---

## 7. `step()` silently failed to write C.EBREAK — root cause: `abstractcs.cmderr` latch

**Symptom:** After adding the disassembly panel, clicking Step caused the target
to resume and run freely without stopping. `step()` timed out with "C.EBREAK did
not halt the target."

**Root cause:** GDB's `-data-read-memory-bytes` (used inside `step()` to decode
the current instruction and to read the word to be patched) causes OpenOCD to use
the **program buffer** access path: it writes a `lw a0,0(a0); ebreak` snippet
into the debug module's program buffer and executes it on the hart. On this
target, program-buffer execution leaves `abstractcs.cmderr` latched.

OpenOCD checks `cmderr` before executing every abstract command. When `cmderr`
is set, OpenOCD clears it and returns `ERROR_FAIL` without executing the
command. This means the subsequent `monitor mww` call (which writes the
C.EBREAK patch into IMEM) silently fails — the write never happens. GDB resumes
the target with the original instruction in place, hits nothing, and `step()`
times out after 5 seconds.

The same issue occurred when `disassemble()` was called (via GDB's
`-data-disassemble`) at ELF load time before running: the thousands of
target-memory reads it triggered latched `cmderr`, which then broke the first
`monitor mww` in `step()`.

**Diagnosis method:** Manual GDB console sequence:
```
monitor reg pc          → 0x01000116
monitor mdw 0x01000116  → 0x47920001  (16-bit C.LWSP at PC)
monitor mdw 0x01000118  → 0x07854792  (word at next_pc)
monitor mww 0x01000118 0x07859002     (patch C.EBREAK into lower halfword)
monitor mdw 0x01000118  → 0x07859002  (write verified)
monitor resume          → target halted immediately on C.EBREAK ✓
monitor mww 0x01000118 0x07854792     (restore)
monitor resume          → target ran freely ✓
monitor halt            → PC = 0x010000e4 ✓
```
This sequence worked because it uses only `monitor` commands, which use the
direct abstract-command path and do not touch the program buffer or latch
`cmderr`. The Python `step()` used GDB MI commands for the reads, which used
the program buffer and broke the subsequent `mww`.

**Fix:** All reads inside `step()` were changed from GDB MI commands to
OpenOCD `monitor` commands:
- `get_pc()` → `_monitor_reg_pc()` (sends `monitor reg pc`)
- `read_word(pc)` → `_monitor_mdw(pc & ~3)` (sends `monitor mdw`)
- `read_word(word_addr)` → `_monitor_mdw(word_addr)` (sends `monitor mdw`)

A `monitor mdw` readback verification was also added after each `monitor mww`
so a failed write raises a specific error immediately instead of timing out.

ELF-load disassembly was changed from GDB's `-data-disassemble` to
`riscv32-unknown-elf-objdump` (subprocess on the ELF file, no target I/O).

---

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
