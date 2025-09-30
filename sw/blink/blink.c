/*
 * Name: blink.c
 * Contributor(s):
 *    - Matti Käyrä (matti.kayra@tuni.fi) 
 * Description:
 *    - "Led blinker" for sim
 *    - raw pointers
 * Notes:
 */

#include <stdint.h>
#include "soc_ctrl.h"
#include "gpio.h"

#define ADDR 0x01030000

int main() {
  // 
  pmod_target(5);

  gpio_init_out(0);
  gpio_init_out(1);
  gpio_init_out(2);
  gpio_init_out(3);
  gpio_init_out(4);
  gpio_init_out(5);
  gpio_init_out(6);
  gpio_init_out(7);
  gpio_init_out(8);
  gpio_init_out(9);
  gpio_init_out(10);
  gpio_init_out(11);
  gpio_init_out(12);
  gpio_init_out(13);
  gpio_init_out(14);
  gpio_init_out(15);

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