/*
 * Name: alphabet
 * Description:
 *    Send A-Z over UART, one character per line, then repeat forever.
 *    Baud rate: ~57600 (25 MHz FPGA clock, divisor=27)
 */
#include "uart.h"

static void nop_delay(void) {
    /* 57600 baud @ 25 MHz = ~4325 cycles/char; use 6000 to be safe */
    volatile unsigned int i = 0;
    while (i < 6000) {
        asm("nop");
        i++;
    }
}

int main(void) {
    uart_init();

    while (1) {
        for (char c = 'A'; c <= 'Z'; c++) {
            RBR_THR_DLL = c;    nop_delay();
            RBR_THR_DLL = '\r'; nop_delay();
            RBR_THR_DLL = '\n'; nop_delay();
        }
    }

    return 0;
}
