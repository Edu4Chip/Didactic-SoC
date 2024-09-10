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
  uint32_t led_on = 0xFFFFFFFF;
  uint32_t led_off = 0x00000000;

  *(unsigned int*)(ADDR+0x0C) = led_off;
  int i = 0;
  while(i<10) {
	  *(unsigned int*)(ADDR+0x0C) = led_on;
	  *(unsigned int*)(ADDR+0x0C) = led_off;
    i++;
  }
  
  return 0;
}