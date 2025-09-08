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

#define ADDR 0x01030000

int main() {

  volatile uint32_t led_on = 0xFFFFFFFF;
  volatile uint32_t led_off = 0x00000000;

  *(volatile unsigned int*)(ADDR+0x0C) = led_off;

  while(1) {
    *(volatile unsigned int*)(ADDR+0x0C) ^= 0xFFFFFFFF;
    // Wait 100k cycles
    for (int i=0;i<100000;i++) {
      asm("nop");
    }
  }
  return 0;
}
