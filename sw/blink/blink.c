/*
 * name: blink.c
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi) 
 * description:
 *    - "Led blinker" for sim
 *    - raw pointers
 * notes:
 */

#include <stdint.h>

#define ADDR 0x01030000

int main() {
  // 
  volatile uint32_t led_on = 0xFFFFFFFF;
  volatile uint32_t led_off = 0x00000000;

  *(volatile unsigned int*)(ADDR+0x0C) = led_off;
  int i = 0;
  while(i<10) {
	  *(volatile unsigned int*)(ADDR+0x0C) = led_on;
	  *(volatile unsigned int*)(ADDR+0x0C) = led_off;
    i++;
  }
  
  return 0;
}