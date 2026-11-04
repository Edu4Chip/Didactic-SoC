/*
 * Name: blinky.c
 * Contributor(s):
 *    - Arto Oinonen (arto.oinonen@tuni.fi)
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - "Led blinker" for FPGA
 *    - raw pointers
 * Notes:
 */

#include <stdint.h>
#include "soc_ctrl.h"
#include "gpio.h"

//#define ADDR 0x01030000

int main() {

  pmod_target(5);

  // PMOD A & B: all output
  for(volatile uint32_t i=0; i < 15; i++){
    gpio_init_out(i);
  }

  PAD_OUT = 0x00000000;

  while(1) {

    PAD_OUT ^= 0xFFFFFFFF;

    // Wait 100k cycles
    for (int i=0;i<100000;i++) {
      asm("nop");
    }
  }
  return 0;
}
