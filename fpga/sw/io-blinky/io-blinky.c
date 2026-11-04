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

int main() {

  // PMOD mux: SysCtrl
  pmod_target(5);

  // PMOD A: output
  for(volatile uint32_t i=0; i < 8; i++){
    gpio_init_out(i);
    sysctrl_gpio_init_out(i);
    sysctrl_gpio_enable(i);
  }
  // PMOD B: input
  for(volatile uint32_t i=8; i < 16; i++){
    gpio_init_in(i);
    sysctrl_gpio_init_in(i);
    sysctrl_gpio_enable(i);
  }

  while(1) {
    gpio_write(gpio_read() >> 8 & 0xFF);
    //PAD_OUT = (PAD_IN >> 8) & 0xFF;
  }
  return 0;
}
