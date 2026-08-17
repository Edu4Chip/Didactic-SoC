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
        ├── gdb_snippets_panel.py GdbSnippetsPanel
        └── disassembly_panel.py DisassemblyPanel
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

- **`monitor halt` / `monitor resume`** are used for run/halt instead of GDB's
  native `-exec-continue` / `-exec-interrupt`. GDB's execution commands wait for
  the target to stop before returning; because the SoC typically runs an infinite
  loop, GDB would block indefinitely. OpenOCD's `monitor` commands execute via
  the TCL interpreter and return immediately.

- **`-exec-continue` is used only inside `step()`**, not for normal run. Step
  puts GDB into Running state so it correctly expects the `T05` stop reply when
  the C.EBREAK fires; using `monitor resume` for step would deliver `T05`
  unsolicited and confuse GDB's MI state machine.

- **All memory and register reads inside `step()` use OpenOCD `monitor`
  commands** (`monitor mdw`, `monitor reg pc`) rather than GDB MI commands
  (`-data-read-memory-bytes`, `-data-evaluate-expression`). GDB's memory-read
  path triggers program-buffer execution (loads `lw a0,0(a0); ebreak` into the
  debug module's program buffer and runs it on the hart), which leaves
  `abstractcs.cmderr` latched on this target. A latched `cmderr` causes the very
  next abstract command — the `monitor mww` that writes C.EBREAK — to silently
  fail: OpenOCD clears `cmderr` and returns `ERROR_FAIL` without executing the
  write. No C.EBREAK is written, `-exec-continue` resumes the target freely, and
  `step()` times out after 5 seconds. Using `monitor mdw` avoids the program
  buffer entirely and does not latch `cmderr`.

- **Memory access for the Memory panel** uses GDB MI (`-data-read-memory-bytes`,
  `-data-write-memory-bytes`). Writing peripheral registers via GDB's memory
  write packet causes "Ignoring packet error" on this debug module; use
  `monitor mww` for peripherals.

- **Disassembly is built from the ELF file** using `riscv32-unknown-elf-objdump`
  as a subprocess at load time — not via GDB's `-data-disassemble`. The latter
  reads target IMEM through the debug module and would latch `cmderr` for the
  same reason as above. The objdump output is cached once and reused on every
  halt/step/reset with zero GDB I/O.

  > **Possible future revert to live FPGA disassembly:** GDB's `-data-disassemble`
  > could be used again if called at a point where `cmderr` latching is harmless —
  > for example, *after* a `step()` has already completed (patches written,
  > target halted at the new PC, originals restored), or *while the target is
  > running* (so there is no pending `monitor mww` for cmderr to silently block).
  > Concretely, calling `-data-disassemble` from the `halt` or `reset` dispatch
  > (rather than `load_elf`) would be safe: by that point `step()` is not in
  > progress, and cmderr set by the disassembly read would be cleared before any
  > subsequent `step()` call begins. The objdump approach is kept for now because
  > it is faster (no JTAG round-trips), works offline, and gives the full binary
  > view even before the first halt.

- **`is_openocd_running()`** checks whether port 3333 is in LISTEN state using
  `ss -tln` rather than opening a TCP connection. Opening a connection causes
  OpenOCD to log "attempted gdb connection rejected" every second.

- **`send_console(cmd)`** wraps a plain GDB or OpenOCD command in
  `-interpreter-exec console "..."` so it can be sent through the MI interface
  without switching GDB modes.

```python
# Public interface
GdbClient.connect()                    # start GDB subprocess, connect to :3333
GdbClient.disconnect()
GdbClient.load_elf(path)               # halt, load symbols, download binary
GdbClient.run()                        # monitor resume
GdbClient.halt()                       # monitor halt
GdbClient.step() -> int | None         # software single-step; returns new PC
GdbClient.get_pc() -> int | None
GdbClient.read_word(addr) -> int       # raises RuntimeError on failure
GdbClient.write_word(addr, value)
GdbClient.disassemble_elf(path) -> list[dict]   # objdump; no target I/O
GdbClient.add_breakpoint(addr)         # patch C.EBREAK into IMEM
GdbClient.remove_breakpoint(addr)      # restore original instruction
GdbClient.has_breakpoint(addr) -> bool
GdbClient.breakpoint_addrs -> set[int]
GdbClient.send_mi(cmd)                 # raw MI command
GdbClient.send_console(cmd)            # GDB console / monitor command
GdbClient.poll_notifications()         # non-blocking poll for async GDB messages
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
request_toggle_breakpoint(addr)
request_disassemble(addr)        # frame navigation only; target must be halted
```

**Disassembly cache:** at ELF load time the worker calls `disassemble_elf(path)`
(subprocess objdump, no target I/O), stores the result in `_disasm_cache`, and
emits `disassembly_ready`. On every subsequent halt/step/reset `_emit_halted()`
reuses the cache — it never calls any GDB or OpenOCD command. This is essential:
any GDB memory read between a halt and the next `step()` call can latch
`abstractcs.cmderr` and silently break the C.EBREAK write (see Hardware Notes).

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
connected                                # GDB subprocess started and connected to OpenOCD
disconnected                             # GDB subprocess exited
error(str)                               # any exception from the GDB layer
elf_loaded                               # download complete
target_halted(int)                       # CPU stopped; int = PC
target_running                           # CPU started
pc_updated(int)                          # PC read (from request_pc or after halt)
memory_read(int, int)                    # addr, value
memory_written(int)                      # addr
console_output(str)                      # GDB console/log text (for GDB Console panel)
disassembly_ready(list, int, list, bool) # insns, pc, bp_addrs, scroll_to_pc
stack_ready(list)                        # stack frames
breakpoint_added(int)                    # addr
breakpoint_removed(int)                  # addr
```

**Async notification handling:** `poll_notifications()` returns any GDB async
records (e.g. `*stopped`, `*running`) that arrived since the last poll.
`_handle_async()` emits only UI-state signals (`target_halted`, `target_running`)
— it performs **no GDB I/O**. Issuing any GDB command from an async handler
while the target may still be running causes the "Ignoring packet error" loop.

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

#### `DisassemblyPanel`

A `QGroupBox` containing a call-stack list (`QListWidget`, max 88 px tall) and a
three-column disassembly table (`QTableWidget`): gutter | address | instruction.

**Update policy — passive display only:**
- Updated via `disassembly_ready` signal on halt, step, and reset.
- Never polls while the target is running; no async GDB I/O.
- The gutter column shows `▶` at the current PC, `●` at breakpoint addresses,
  and `⊙` when both coincide. Clicking the gutter column toggles a breakpoint.

**Incremental breakpoint update:** `on_breakpoint_changed(addr, added)` updates
only the single gutter cell for the changed address — no full table rebuild.

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

### Command compatibility reference

Commands that behave incorrectly on this target and their working alternatives.
All failures were confirmed by direct testing; root causes are documented in
`LOG.md`.

| Category | Broken command | Failure mode | Working alternative |
|---|---|---|---|
| **Run** | `-exec-continue` | Blocks indefinitely on infinite-loop targets; GDB waits for `T05` that never arrives | `monitor resume` |
| **Halt** | `-exec-interrupt` | Not accepted by GDB while target is running via `monitor resume` (GDB is not in Running state) | `monitor halt` |
| **Reset** | `monitor reset halt` | Timeout — no physical reset line on the FPGA board (`reset_config none`) | `monitor halt` |
| **Single-step** | `monitor step` / `-exec-step-instruction` (`vCont;s`) | Timeout — CPU steps but debug module never signals halt completion | C.EBREAK patch via `monitor mww` + `-exec-continue` (see §Single-step) |
| **Hardware breakpoints** | `-break-insert -h` (RSP `Z1`) | "Ignoring packet error" — OpenOCD RISC-V backend rejects `Z1` | C.EBREAK patch via `monitor mww` |
| **Hardware breakpoints** | `monitor bp … hw` | Timeout — trigger-module CSR (`tselect`) access hangs the debug module | C.EBREAK patch via `monitor mww` |
| **Software breakpoints** | `-break-insert -t` (RSP `Z0`) | Silent failure — IMEM appears read-only via the RSP memory-write packet | `monitor mww` to write C.EBREAK (`0x9002`) directly |
| **Memory write (peripherals)** | `-data-write-memory-bytes`, `set *((int*)addr)=val` | "Ignoring packet error" — GDB's write path uses the program buffer, which is unreliable for memory-mapped I/O | `monitor mww addr val` |
| **Memory read (inside `step()`)** | `-data-read-memory-bytes` | Uses program buffer (`lw a0,0(a0); ebreak` on hart), leaving `abstractcs.cmderr` latched; subsequent `monitor mww` silently does nothing and C.EBREAK is never written | `monitor mdw addr` |
| **Register read (inside `step()`)** | `-data-evaluate-expression $pc` | Same cmderr risk as above when used immediately before `monitor mww` | `monitor reg pc` |
| **Disassembly at load time** | `-data-disassemble` (GDB MI) | Reads entire IMEM via program buffer, latching `cmderr` and breaking the first `monitor mww` in the next `step()` call | `riscv32-unknown-elf-objdump -d` on the ELF file (no target I/O) |

**The `abstractcs.cmderr` latch pattern** (rows 8–10) is the most subtle failure
mode. Any GDB command that triggers program-buffer execution sets `cmderr` as a
side effect on this target. OpenOCD checks `cmderr` before every abstract
command; when set it clears `cmderr` and returns `ERROR_FAIL` without executing
— so the *next* command after a program-buffer read silently fails. The fix in
all cases is to use OpenOCD's `monitor` commands instead of GDB MI for reads that
immediately precede a `monitor mww`.

---

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

1. Read the current PC via `monitor reg pc` (OpenOCD direct path — see
   critical note on `abstractcs.cmderr` below).

2. Read the aligned word(s) containing the current instruction via
   `monitor mdw`, decode it with the built-in RV32IMC decoder
   (`GdbClient._next_pcs`) to find all reachable next-PCs (1 for sequential
   instructions, 2 for conditional branches, 1 for unconditional jumps).

3. For each next-PC, read the 4-byte aligned word containing it via
   `monitor mdw`, patch in `C.EBREAK` (`0x9002`) at the correct 16-bit
   half-word offset, write the patched word back via `monitor mww`, and
   verify the write with a `monitor mdw` readback.

   `C.EBREAK` is used instead of full `EBREAK` (`0x00100073`) because
   `bits[1:0] = 0b10` causes the CPU to treat the 16 bits as a compressed
   instruction regardless of what was originally there. This handles both
   compressed and unaligned 32-bit next-PCs without needing to know the
   instruction size at the destination.

4. Resume with `-exec-continue` (RSP `vCont;c`). GDB is now in Running state
   and correctly expects a `T05` stop reply — using `monitor resume` instead
   would cause GDB to receive `T05` unsolicited when the EBREAK fires, which
   confuses GDB and makes subsequent monitor commands time out.

5. Poll passively for `*stopped` — first scanning the `-exec-continue` response
   burst (the step is so fast that `T05` often arrives before pygdbmi reads the
   `(gdb)` prompt), then calling `poll_notifications()` in a loop with 50 ms
   intervals up to a 5-second timeout.

6. Restore all patched words via `monitor mww` and return the new PC.

**Critical: why all reads in `step()` use `monitor` commands, not GDB MI**

GDB's `-data-read-memory-bytes` causes OpenOCD to use the **program buffer**:
it writes a `lw a0,0(a0); ebreak` snippet into the debug module's program
buffer and executes it on the hart. On this target, program-buffer execution
leaves `abstractcs.cmderr` latched. OpenOCD checks `cmderr` before every
abstract command; if set it clears `cmderr` and returns `ERROR_FAIL` without
executing the command. This means the very next `monitor mww` call silently
does nothing — no C.EBREAK ever reaches IMEM — and `-exec-continue` resumes
the target with the original instruction, causing a 5-second timeout.

`monitor mdw` and `monitor reg pc` use a direct abstract-command register/memory
access that does not go through the program buffer and does not latch `cmderr`.
Using these for all reads inside `step()` (matching the access path of a working
manual test) eliminates the silent write failure.

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
