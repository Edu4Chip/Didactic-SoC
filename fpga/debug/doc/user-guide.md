# Didactic SoC — Debug GUI User Guide

## Overview

The debug GUI is a PySide6 desktop application that provides a unified interface
for programming, running, and communicating with the Didactic SoC on an FPGA
board. It replaces the need to manually invoke GDB and picocom from separate
terminal windows.

### Prerequisites

| Requirement | Notes |
|---|---|
| Python ≥ 3.10 | Required by PySide6 |
| `riscv32-unknown-elf-gdb` | RISC-V toolchain GDB |
| OpenOCD (custom build) | Must support the RISC-V debug module; see `fpga/utils/` |
| FTDI FT4232H USB adapter | Provides JTAG (channel 1) and UART (channel 0) |

Install Python dependencies:

```bash
pip install -r fpga/debug/requirements.txt
```

### Starting the GUI

```bash
cd fpga/debug
python main.py
```

Window size, position, UART port, and baud rate are automatically restored from
the previous session (stored in `~/.config/DidacticSoC/SoCDebugger.conf`).

---

## Layout

```
┌──────────────────────────────────────────────────────────────┐
│  Menu bar  (File | Help)                                      │
│  Toolbar   (▶ Run | ⏸ Halt | ⤵ Step | ↺ Reset)              │
├──────────────────────────────────────────────────────────────┤
│  Connection  │                                               │
│  ELF Loader  │  ← tab widget →                              │
│  Execution   │  GDB Console                                 │
│  Memory      │  Register Map                                │
│              │  GDB Snippets                                │
├──────────────────────────────────────────────────────────────┤
│  UART Terminal  (full width, always visible)                  │
└──────────────────────────────────────────────────────────────┘
```

The window is divided by two splitters — one horizontal (left controls vs. right
tabs) and one vertical (top area vs. UART terminal). All dividers are draggable.

---

## Menu Bar

### File

| Menu item | Action |
|---|---|
| **Export → UART Data as text…** | Save the UART terminal content to a UTF-8 text file |
| **Export → UART Data as binary…** | Save the UART terminal content as raw bytes |
| **Import → UART Data as text… (send to FPGA)** | Read a text file and send it byte-by-byte via UART *(enabled only when UART is connected)* |
| **Import → UART Data as binary… (send to FPGA)** | Read a binary file and send it byte-by-byte via UART *(enabled only when UART is connected)* |
| **Exit** | Close the application (`Ctrl+Q`) |

Imported files are sent with baud-rate pacing (16-byte chunks, inter-chunk delay
sized to the configured baud rate) to prevent FPGA FIFO overflow.

### Help

- **About** — shows project info, memory map, clock/baud reference, and the
  Edu4Chip project logo.

---

## Panels

### Connection

Controls the three independent connections needed for debugging.

**OpenOCD**

- The green/red indicator reflects whether OpenOCD is listening on port 3333.
  It is polled every second using `ss -tln` (no TCP connection is opened, so
  OpenOCD logs stay clean).
- **Start OpenOCD** launches `openocd -f <config>` as a child process.  
  The binary path and config file paths are editable; the config defaults to
  `fpga/utils/openocd-didactic.cfg`.
- If OpenOCD is started externally (e.g. in a terminal), the indicator turns
  green automatically.

**GDB**

- **Connect GDB** starts `riscv32-unknown-elf-gdb` as a subprocess and
  connects it to OpenOCD's GDB server on port 3333 (`target extended-remote
  :3333`). GDB runs in MI3 mode so the GUI can parse its output.
- The button is only enabled when OpenOCD is detected as running.
- On connect, the GUI automatically queries the CPU state (`monitor targets`)
  and reflects whether the target is already running or halted.

**UART**

- The port dropdown lists `/dev/ttyUSB*` devices. The **↺** button rescans.
  FTDI-based devices are auto-detected; the JTAG channel (held by OpenOCD) is
  not listed.
- The last-used port and baud rate are restored automatically on startup.
- The baud rate selector has presets for the two main targets:
  - **57600** — FPGA with 25 MHz PLL clock (default)
  - **230400** — ASIC with 100 MHz clock
  - **Custom** — shows a text field for any other value

---

### ELF Loader

Loads a compiled RISC-V ELF binary onto the board and starts execution.

1. Click **Browse…** or type the path to a `.elf` file.
2. Click **Load & Run**.

The sequence executed internally:
1. `monitor halt` — stops the CPU.
2. `-file-exec-and-symbols <path>` — loads symbols into GDB.
3. `-target-download` — writes all ELF segments to IMEM via the system bus and
   sets PC to the ELF entry point (`reset_handler`, defined by `ENTRY()` in
   `link.ld`).
4. `monitor resume` — starts execution.

A short log at the bottom of the panel shows progress and any errors.

> **Note:** `monitor reset halt` is intentionally not used. The OpenOCD config
> has `reset_config none` (no physical reset line on the FPGA), so that command
> always times out. `monitor halt` is used instead.

---

### Execution

Shows CPU state and provides execution controls. The panel is disabled until
GDB is connected.

| Control | Action |
|---|---|
| **▶ Run** | `monitor resume` — resumes execution from current PC |
| **⏸ Halt** | `monitor halt` — stops the CPU |
| **⤵ Step** | `monitor step` — executes one instruction |
| **↺ Reset** | `monitor halt` — halts (hardware reset is not available) |

The same controls are also available in the main toolbar.

The status indicator shows **Running** (green) or **Halted** (amber). The PC
field is updated automatically when the target halts.

> **Why `monitor` instead of GDB native commands?**  
> GDB's `-exec-continue` waits for the target to stop before returning. Because
> the SoC typically runs infinite loops, GDB would block indefinitely and become
> unresponsive. `monitor resume`/`halt`/`step` are OpenOCD TCL commands that
> return immediately and do not block GDB's MI interface.

---

### Memory

Reads or writes a single 32-bit word at any address. Uses GDB's
`-data-read-memory-bytes` and `-data-write-memory-bytes` MI commands, which
access memory via the system bus (not via the CPU's program counter).

- The address field accepts hex (`0x01030114`) or decimal.
- The value field for writes accepts hex or decimal.
- The result field shows the read value in hex and decimal.

**Useful addresses:**

| Address | Description |
|---|---|
| `0x01000000` | IMEM start (instruction memory) |
| `0x01010000` | DMEM start (data memory — safe for R/W tests) |
| `0x01030100` | UART RBR/THR/DLL |
| `0x01030114` | UART LSR (bit 0 = data ready, bit 5 = TX empty) |
| `0x01040000` | SoC Control base |

> **Note:** Writing to peripheral registers via GDB memory write commands
> can cause "Ignoring packet error" on some implementations. Use **GDB Console**
> with `monitor mww <addr> <val>` for peripheral writes instead.

---

### GDB Console *(tab)*

A terminal window that shows all GDB output and lets you type raw GDB or
OpenOCD monitor commands.

- Output from GDB (console, log, and async messages) is streamed here
  automatically.
- Type any GDB or `monitor` command in the input field and press Enter.
- Commands starting with `-` are sent as GDB MI commands; all others are
  wrapped in `-interpreter-exec console "..."`.

**Common commands:**

```
monitor mdw 0x01030114          read UART LSR
monitor mww 0x01030100 0x41     write 'A' to UART TX
monitor reg pc                  read current PC
source fpga/utils/reset_uart.gdb  initialise UART manually
```

---

### Register Map *(tab)*

A browsable tree of all memory-mapped peripheral registers, auto-populated from
`register_map.json` (which is generated from the C header files in
`sw/common/`).

The tree has a narrow line-number gutter on the left that stays synchronised
with the main tree's scroll position and collapse/expand state.

**Reading registers:**

- **Click** any register row to read its current value from the target
  automatically.
- Click **Read** in the toolbar to re-read the selected register.
- Click **Read All** to read every register in the map sequentially.
- Values are shown in hex. Hovering shows a tooltip with hex, decimal, binary,
  and ASCII representations.

**Writing registers:**

- **Double-click** a R/W or W register to open an inline editor in the Value
  column. Enter the new value (hex or decimal) and press Enter to write.
- If the CPU is currently running, it is halted automatically before the write
  and left halted afterwards.

**Refreshing the map:**

- Click **↺ Refresh** to re-run `gen_register_map.py` and regenerate
  `register_map.json` from the latest header files. The tree reloads
  automatically.

**Access types:** registers marked **R** are read-only (double-click triggers a
read), **W** write-only, **R/W** read-write.

**Export:** Click **Export CSV** to save the current register values to a CSV
file with columns: `#`, Peripheral, Name, Address, Access, Value, Description.

---

### GDB Snippets *(tab)*

A library of reusable GDB script files (`.gdb`) stored in `fpga/debug/gdb_snippets/`.
The editor highlights lines beginning with `#` in dark green (GDB comment
syntax).

**Running a snippet:**

1. Select it in the left pane — its content appears in the editor.
2. Click **▶ Run**. The snippet is saved first, then GDB executes it via
   `source <path>`. Output appears in the **GDB Console** tab.

**Editing:**

- The editor is a plain-text field. Changes are unsaved until **Save** is
  clicked (the button enables when there are unsaved edits).

**Managing snippets:**

| Button | Action |
|---|---|
| **+** | Prompts for a name and creates a new empty `.gdb` file |
| **−** | Deletes the selected file (confirmation required) |
| **↺** | Rescans the `gdb_snippets/` directory |

**Included snippets:**

- `reset_uart` — initialises the UART peripheral for 57600 baud (FPGA 25 MHz).
  Run this if the UART was not initialised by a loaded program.

---

### UART Terminal

Always visible at the bottom of the window, spanning the full width. Receives
data from the board's UART TX line and lets you transmit to UART RX.

- Output is shown in a monospace scrolling display.
- Type in the input field and press **Enter** or **Send**.
- The **\\n** checkbox controls whether a newline byte is appended to each
  transmission. Default is **off** — leave it off unless the target's receive
  handler expects line-terminated input (sending an extra byte can cause a UART
  overrun if the TX FIFO is not ready).
- **Clear** empties the display.
- To send a file to the FPGA, use **File → Import → UART Data as text/binary**.
- To save received data, use **File → Export → UART Data as text/binary**.

---

## Typical Workflow

```
1. Connect board via USB.
2. Start OpenOCD  →  Connection panel → Start OpenOCD
                     Wait for green indicator.
3. Connect GDB   →  Connection panel → Connect GDB
                     GUI detects initial CPU state automatically.
4. Connect UART  →  Select ttyUSB0, baud 57600, click Connect
                     (port and baud are pre-selected from last session)
5. Build ELF     →  cd sw && make TESTCASE=<name> build_test
6. Load & Run    →  ELF Loader → Browse → Load & Run
                     UART terminal shows program output.
7. Halt / inspect →  Execution panel → Halt
                      Register Map: click a row to read its value.
                      Double-click a R/W row to write a new value.
8. Resume        →  Execution panel → Run
```

---

## Baud Rate Reference

| Target | Clock | Divisor | Baud |
|---|---|---|---|
| FPGA (PYNQ-Z1/Z2) | 25 MHz | 27 | ~57 600 |
| ASIC | 100 MHz | 27 | ~230 400 |

Formula: `baud = clock / (16 × divisor)`
