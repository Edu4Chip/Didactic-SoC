# Initialize UART to ~57600 baud (divisor=27, 25MHz/16/27) for FPGA
# Mirrors uart_init() from sw/common/uart.h
# Usage: source fpga/utils/reset_uart.gdb

# FCR (0x01030108) = 0x1 — enable the TX/RX FIFOs (bit 0)
monitor mww 0x01030108 0x1

# LCR (0x0103010C) = 0x83 — set DLAB (bit 7) to allow access to divisor registers,
#   and configure 8 data bits, no parity, 1 stop bit (bits 1:0 = 0b11)
monitor mww 0x0103010c 0x83

# DLL (0x01030100, accessible when DLAB=1) = 27 (0x1b) — baud rate divisor low byte
#   baud = clock / (16 * divisor) = 25MHz / (16 * 27) ≈ 57600
monitor mww 0x01030100 0x1b

# DLM (0x01030104, accessible when DLAB=1) = 0 — baud rate divisor high byte (divisor < 256)
monitor mww 0x01030104 0x0

# LCR (0x0103010C) = 0x3 — clear DLAB (bit 7 = 0) to switch back to normal TX/RX registers,
#   keep 8N1 framing (bits 1:0 = 0b11)
monitor mww 0x0103010c 0x3

# IER (0x01030104, now DLAB=0) = 0x1 — enable the transmitter-holding-register-empty interrupt
#   (bit 0), so the UART signals when it is ready to accept the next byte
monitor mww 0x01030104 0x1

# FCR (0x01030108) = 0x2 — reset (flush) the RX FIFO (bit 1, self-clearing)
#   clears any stale bytes that arrived before initialisation
monitor mww 0x01030108 0x2

echo UART initialized at ~57600 baud (25MHz FPGA clock)\n
