/*
 * Name: logo
 * Contributor(s):
 *    - Arto Oinonen (arto.oinonen@tuni.fi)
 * Description:
 *    - hello world for Didactic SoC
 * Notes:
 *    - 
 */
#include "gpio.h"
#include "soc_ctrl.h"
#include "uart.h"
#include <stdio.h>

//#define ENC_A      PAD_IN & 0x00000100
//#define ENC_B      PAD_IN & 0x00000200
//#define ENC_BTN    PAD_IN & 0x00000400
//#define ENC_SWT    PAD_IN & 0x00000800
#define ENC_A      PAD_IN & 1
#define ENC_B      PAD_IN & 2
#define ENC_BTN    PAD_IN & 4
#define ENC_SWT    PAD_IN & 8

int wait(int cycles) {
    for (int i=0;i<cycles;i++) {
  		asm("nop");
    }
  return 0;
}

int main() {

  char encoderval = 0;

  // Sysctrl to GPIO
  pmod_target(5);

  // PMOD A: output
  for(volatile uint32_t i=0; i < 8; i++){
    gpio_init_out(i);
  }
  // PMOD B: input
  for(volatile uint32_t i=8; i < 16; i++){
    gpio_init_in(i);
  }

  uart_init(25000000,38400);
  uart_print("Hello from Didactic SoC!\r\n");

  while (1) {
    while (ENC_BTN);
    // Read bits 8-11
//    PAD_OUT = modulocounter(PAD_OUT, 16) >> 8;
//    PAD_OUT = encoderval;
    uart_print("jee\n\r");
    wait(5000000);
  }

  return 0;
}
