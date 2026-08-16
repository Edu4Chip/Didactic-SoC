# Didactic SoC — Debug GUI Architecture

## Source Tree

```
fpga/debug/
├── main.py                      entry point — creates QApplication + MainWindow
├── requirements.txt             Python dependencies
├── register_map.json            auto-generated peripheral register database
├── gen_register_map.py          parses sw/common/*.h to produce register_map.json
├── assets/                      static assets (logos, icons)
│   └── E4C_Logo_LARGE_WHITE_BKG_JPG.jpg
├── gdb_snippets/                user GDB scripts (*.gdb), editable in the GUI
│   └── reset_uart.gdb
├── doc/                         this documentation
│   ├── user-guide.md
│   └── architecture.md
├── debugger/                    hardware communication layer (no Qt)
│   ├── gdb.py                   GdbClient — wraps pygdbmi / GDB MI protocol
│   └── uart.py                  UartMonitor — wraps pyserial
└── gui/
    ├── main_window.py           QMainWindow — layout, signal wiring, settings
    ├── workers/
    │   ├── gdb_worker.py        QThread — executes GDB commands off the GUI thread
    │   └── uart_worker.py       QThread — reads UART bytes off the GUI thread
    └── panels/
        ├── connection.py        ConnectionPanel
        ├── elf_loader.py        ElfLoaderPanel
        ├── execution.py         ExecutionPanel
        ├── memory.py            MemoryPanel
        ├── uart_terminal.py     UartTerminalPanel
        ├── gdb_console.py       GdbConsolePanel
        ├── register_map_panel.py RegisterMapPanel
        └── gdb_snippets_panel.py GdbSnippetsPanel
```

---

## Thread Model

```
┌─────────────────────────────────────────────────────┐
│  GUI thread  (Qt main thread)                        │
│  All widgets live here; no blocking I/O allowed      │
└───────────────┬──────────────────┬──────────────────┘
                │ Qt signals/slots  │ Qt signals/slots
        ┌───────▼───────┐  ┌───────▼───────┐
        │  GdbWorker    │  │  UartWorker   │
        │  (QThread)    │  │  (QThread)    │
        │               │  │               │
        │  pygdbmi      │  │  pyserial     │
        │  ↕ subprocess │  │  ↕ /dev/ttyUSB│
        │  GDB process  │  └───────────────┘
        │  ↕ GDB RSP    │
        │  OpenOCD :3333│
        └───────────────┘
```

All cross-thread communication goes through Qt signals and slots. Workers never
touch Qt widgets directly; panels never touch hardware directly.

---

## Debugger Layer (`debugger/`)

### `gdb.py` — GdbClient

A thin wrapper around `pygdbmi.GdbController`. Spawns
`riscv32-unknown-elf-gdb --interpreter=mi3` as a subprocess and speaks the GDB
Machine Interface (MI3) protocol.

**Key design decisions:**

- **`monitor halt` / `monitor resume` / `monitor step`** are used instead of
  GDB's native `-exec-continue` / `-exec-interrupt` / `-exec-step-instruction`.
  GDB's execution commands wait for the target to stop before returning; because
  the SoC typically runs an infinite loop, GDB would block indefinitely and all
  subsequent MI commands would time out. OpenOCD's `monitor` commands execute via
  the TCL interpreter and return immediately.

- **Memory access uses GDB MI** (`-data-read-memory-bytes`,
  `-data-write-memory-bytes`), which goes through the system bus. Writing
  peripheral registers via `set *((int*)addr)` or GDB's memory write packet
  causes "Ignoring packet error" on this debug module.

- **`is_openocd_running()`** checks whether port 3333 is in LISTEN state using
  `ss -tln` rather than opening a TCP connection. Opening a connection causes
  OpenOCD to log "attempted gdb connection rejected" every second.

- **`send_console(cmd)`** wraps a plain GDB or OpenOCD command in
  `-interpreter-exec console "..."` so it can be sent through the MI interface
  without switching GDB modes.

```python
# Public interface
GdbClient.connect()                 # start GDB subprocess, connect to :3333
GdbClient.disconnect()
GdbClient.load_elf(path)            # halt, load symbols, download binary
GdbClient.run()                     # monitor resume
GdbClient.halt()                    # monitor halt
GdbClient.step() -> int | None      # software single-step; returns new PC
GdbClient.get_pc() -> int | None
GdbClient.read_word(addr) -> int    # raises RuntimeError on failure
GdbClient.write_word(addr, value)
GdbClient.send_mi(cmd)              # raw MI command
GdbClient.send_console(cmd)         # GDB console / monitor command
GdbClient.poll_notifications()      # non-blocking poll for async GDB messages
```

### `uart.py` — UartMonitor

Wraps `pyserial`. Provides:
- `list_ports()` — all `/dev/ttyUSB*` devices with descriptions.
- `ftdi_ports()` — filtered to FTDI-based devices (VID 0x0403); used to
  exclude non-FTDI adapters from the port dropdown.
- `connect(port, baudrate)` / `disconnect()` / `read_line()` for use by `UartWorker`.
- `write(text)` — sends a UTF-8 string.
- `write_raw(data: bytes)` — sends arbitrary bytes; used by `UartWorker.send_raw()`.

Default baud rate is **57 600** (FPGA 25 MHz clock, divisor 27).

---

## Worker Layer (`gui/workers/`)

### `GdbWorker` (QThread)

Owns a `GdbClient` instance. The GUI thread never touches `GdbClient` directly.

**Command queue:** the GUI posts commands via `request_*()` slots:

```python
request_load_elf(path)
request_run()
request_halt()
request_step()
request_reset()
request_read_mem(addr)
request_write_mem(addr, value)
request_pc()
request_raw_command(cmd)
```

Each slot puts `(command_name, args)` on an internal `queue.Queue`. The worker
thread's main loop dequeues and dispatches one command per iteration, then polls
GDB for async notifications.

**Initial state detection:** immediately after emitting `connected`, the worker
calls `_query_target_state()`, which sends `monitor targets` and parses the
response to determine whether the CPU is halted or running. This allows the GUI
to reflect the correct execution state even if GDB connects to a target that is
already running.

**Signals emitted to the GUI:**

```python
connected           # GDB subprocess started and connected to OpenOCD
disconnected        # GDB subprocess exited
error(str)          # any exception from the GDB layer
elf_loaded          # download complete
target_halted(int)  # CPU stopped; int = PC
target_running      # CPU started
pc_updated(int)     # PC read (from request_pc or after halt)
memory_read(int, int)   # addr, value
memory_written(int)     # addr
console_output(str) # GDB console/log text (for GDB Console panel)
```

**Async notification handling:** `poll_notifications()` returns any GDB async
records (e.g. `*stopped`, `*running`, `=thread-group-started`) that arrived
since the last poll. `_handle_async()` translates these into the appropriate
signals.

### `UartWorker` (QThread)

Opens the serial port and loops on `read_line()`. Each received line is emitted
via `line_received(str)`. Errors are emitted via `error(str)`.

**`send_raw(data: bytes)`** sends arbitrary binary data with baud-rate pacing to
avoid overrunning the FPGA FIFO. Data is split into 16-byte chunks; after each
chunk the worker sleeps for `chunk_size × 10 / baudrate` seconds (the time
needed to drain one chunk at 8N1). At 57 600 baud a 16-byte chunk takes ~2.8 ms;
a 1 KB payload takes ~180 ms.

---

## GUI Layer (`gui/`)

### `MainWindow`

Creates all panels and workers, then wires signals to slots. No application
logic lives here — it is purely plumbing. The signal map is in
`_connect_signals()`.

**Settings persistence** uses `QSettings("DidacticSoC", "SoCDebugger")`, which
writes to `~/.config/DidacticSoC/SoCDebugger.conf` on Linux. The following are
saved on close and restored on startup:

| Key | Value |
|---|---|
| `window/geometry` | size and screen position |
| `window/h_splitter` | horizontal splitter position (left panel vs tabs) |
| `uart/port` | selected device path (e.g. `/dev/ttyUSB0`) |
| `uart/baud_index` | index into the baud preset combo |
| `uart/custom_baud` | text field content when Custom is selected |
| `elf/last_dir` | last directory used in the ELF file browser |

If the saved UART port is not present in the current port list (device
disconnected), it is added as a placeholder entry so it is pre-selected for
the next Connect attempt.

**UART export / import** is exposed through the File menu:

- `File → Export → UART Data as text…` — saves the UART terminal content to a
  UTF-8 text file.
- `File → Export → UART Data as binary…` — saves terminal content as raw bytes
  (latin-1 encoded).
- `File → Import → UART Data as text… (send to FPGA)` — reads a text file and
  sends it as bytes via UART using `UartWorker.send_raw()`. Disabled unless UART
  is connected.
- `File → Import → UART Data as binary… (send to FPGA)` — same but reads binary.

Notable wiring:
- `GdbWorker.memory_read` is connected to **both** `MemoryPanel.on_memory_read`
  and `RegisterMapPanel.on_memory_read`, so a single read satisfies both.
- `GdbWorker.console_output` feeds the GDB Console panel.
- `GdbSnippetsPanel.command_requested` and `GdbConsolePanel.command_requested`
  both route to `GdbWorker.request_raw_command`, so both panels share the same
  GDB channel.
- `RegisterMapPanel.halt_requested` routes to `GdbWorker.request_halt` so the
  register map can auto-halt the CPU before a write.
- `GdbWorker.target_halted` / `target_running` are forwarded to
  `RegisterMapPanel` so it tracks CPU state.

### Panels

Each panel is a self-contained `QGroupBox` or `QWidget`. Panels:
- Emit signals for user actions (e.g. `load_requested`, `run_requested`).
- Accept slots for state updates (e.g. `on_target_halted`, `on_memory_read`).
- Never import from `debugger/` or `workers/` — they know nothing about
  hardware.

#### `RegisterMapPanel`

A tree view of all SoC peripheral registers loaded from `register_map.json`.

Layout: a narrow line-number gutter (`_num_tree`, 44 px fixed width) sits flush
to the left of the main register tree. Both are wrapped in a single `QFrame`
(StyledPanel/Sunken) so they appear as one widget. The gutter uses a fully flat
item structure (all items top-level) to avoid Qt's unreliable parent-child
expansion in a secondary widget. Collapse/expand sync is done by calling
`setHidden(True/False)` on gutter items that correspond to children of the
collapsed/expanded main-tree item. Scroll sync uses a one-directional
`verticalScrollBar().valueChanged` connection; gutter wheel events are forwarded
to the main tree via a viewport event filter.

CPU halt tracking:
- `on_target_halted()` / `on_target_running()` maintain `_is_halted: bool`.
- A write to a R/W register auto-halts the CPU via `halt_requested` signal if
  `_is_halted` is False.
- Selecting a register row auto-triggers a read via `read_requested`.

#### `GdbSnippetsPanel`

Includes `_GdbHighlighter` (a `QSyntaxHighlighter` subclass) that colours lines
beginning with `#` in dark green (`#1a6e1a`), matching the visual convention for
GDB script comment lines.

#### `ConnectionPanel`

Exposes settings helpers for `MainWindow` to use with `QSettings`:

```python
uart_port() -> str
uart_baud_index() -> int
uart_custom_baud() -> str
set_uart_port(port: str)        # inserts port as placeholder if not in list
set_uart_baud_index(index: int)
set_uart_custom_baud(text: str)
```

---

## Register Map Generation (`gen_register_map.py`)

Parses `sw/common/*.h` to extract `*(volatile uint32_t*)(addr)` style register
definitions. Groups registers by peripheral base address and writes
`register_map.json`.

The JSON structure:

```json
{
  "peripherals": [
    {
      "name": "UART",
      "base": "0x01030100",
      "description": "...",
      "registers": [
        {
          "name": "RBR_THR_DLL",
          "offset": "0x00",
          "access": "R/W",
          "description": "RX Buffer / TX Holding / Divisor Low"
        }
      ]
    }
  ]
}
```

Access overrides: registers whose names contain `LSR`, `MSR`, `IIR`, `PAD_IN`,
or `RXFIFO` are forced to **R**; `TXFIFO` is forced to **W**. Everything else
defaults to **R/W**.

---

## Hardware Notes

### Why `monitor` commands for run and halt

`monitor resume` and `monitor halt` are OpenOCD Tcl commands executed via the
`qRcmd` RSP packet. They bypass GDB's execution state machine entirely and
return to the caller immediately. This avoids GDB blocking indefinitely when
the target runs an infinite loop — a `-exec-continue` on an infinite-loop
target would sit waiting for a `T05` stop reply that never comes.

### Single-step implementation

The `SystemControl_SS` black box (RISC-V CPU + debug module) has several
constraints that rule out standard single-step approaches:

| Mechanism | Outcome |
|---|---|
| `dcsr.step` via `monitor step` or `-exec-step-instruction` | OpenOCD hangs — the CPU steps but halt completion is never signalled back |
| Hardware breakpoints via RSP `Z1` (`-break-insert -h`) | "Ignoring packet error" — OpenOCD's RISC-V backend rejects `Z1` |
| Hardware breakpoints via `monitor bp … hw` | OpenOCD hangs — the trigger module CSR (`tselect`) access never completes |
| Software breakpoints via RSP `Z0` (`-break-insert -t`) | Silent failure — the CPU runs past the intended stop point with no error |

**What works** was determined by reading `dcsr` directly:

```
dcsr = 0x4000b0c3
  xdebugver = 4  →  debug spec 0.13 compliant
  ebreakm   = 1  →  EBREAK in M-mode enters debug mode
  prv       = 3  →  CPU is in M-mode
```

And confirming that instruction memory is writable via the debug module:

```
monitor mww 0x01000130 0x00100073   # write EBREAK
monitor mdw 0x01000130              # reads back 0x00100073  ✓
```

**Implemented approach — C.EBREAK patch + `-exec-continue`:**

1. Decode the instruction at the current PC using a built-in RV32IMC decoder
   (`GdbClient._next_pcs`) to find all reachable next-PCs (1 for sequential
   instructions, 2 for conditional branches, 1 for unconditional jumps).

2. For each next-PC, read the 4-byte aligned word containing it, patch in
   `C.EBREAK` (`0x9002`) at the correct 16-bit half-word offset, and write the
   patched word back via `monitor mww`.

   `C.EBREAK` is used instead of full `EBREAK` (`0x00100073`) because
   `bits[1:0] = 0b10` causes the CPU to treat the 16 bits as a compressed
   instruction regardless of what was originally there. This handles both
   compressed and unaligned 32-bit next-PCs without needing to know the
   instruction size at the destination.

3. Resume with `-exec-continue` (RSP `vCont;c`). GDB is now in Running state
   and correctly expects a `T05` stop reply — using `monitor resume` instead
   would cause GDB to receive `T05` unsolicited when the EBREAK fires, which
   confuses GDB and makes subsequent monitor commands time out.

4. Poll passively for `*stopped` — first scanning the `-exec-continue` response
   burst (the step is so fast that `T05` often arrives before pygdbmi reads the
   `(gdb)` prompt), then calling `poll_notifications()` in a loop with 50 ms
   intervals up to a 5-second timeout.

5. Restore all patched words via `monitor mww` and return the new PC.

**RV32IMC instruction decoder** (`GdbClient._next_pcs`):

The decoder reads one 32-bit word at the current PC and returns the list of
reachable next addresses:

- `bits[1:0] != 0b11` → 16-bit compressed instruction (RVC):
  - `C.J`, `C.JAL` → single target (PC + sign-extended 12-bit imm)
  - `C.BEQZ`, `C.BNEZ` → two targets (PC+2 and PC + sign-extended 9-bit imm)
  - `C.JR`, `C.JALR` → single target (register value, read via GDB)
  - All others → PC+2
- `bits[1:0] == 0b11` → 32-bit instruction:
  - `JAL` (opcode `0x6F`) → single target (PC + sign-extended 21-bit imm)
  - `JALR` (opcode `0x67`) → single target ((rs1 + sign-extended 12-bit imm) & ~1)
  - Conditional branches (opcode `0x63`) → two targets (PC+4 and PC + sign-extended 13-bit imm)
  - All others → PC+4

**Limitation:** `dcsr.stepie = 0` means interrupts are disabled for the single
instruction that executes during each step. Interrupt-driven UART TX does not
make progress while stepping instruction-by-instruction. Use run + breakpoint
for code that depends on interrupts.

### ELF entry point

`link.ld` specifies `ENTRY(reset_handler)` and `crt0.S` declares
`.globl reset_handler`. Together these set the ELF `e_entry` field to the
address of `reset_handler`. GDB's `load` / `-target-download` reads `e_entry`
and sets PC there, so execution starts at `reset_handler` without any manual PC
manipulation.

Without `ENTRY(reset_handler)`, the linker defaults `e_entry` to the start of
the first output section (`0x01000000` = start of `.vectors`), which contains
IRQ vector jump instructions, not the program entry point.

### UART overrun avoidance

The UART Terminal's **\\n** checkbox defaults to off. Always appending `\n`
sends 2 bytes per transmission; if the second byte arrives before the UART TX
FIFO has drained the first, the Line Status Register's Overrun Error bit (LSR
bit 1) is set and the second byte is lost.

When sending files via File → Import, data is chunked into 16-byte blocks with
inter-chunk delays sized to the configured baud rate so the FPGA FIFO never
overflows.
