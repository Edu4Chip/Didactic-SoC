/*
 * Name: gpio.c
 * Contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - test for gpio helpers of Didactic SoC
 * Notes:
 *    -
 */
#include "gpio.h"
//#include "uart.h"
#include <stdint.h>

int main(){
  const uint32_t all_1 = 0xFFFFFFFF;
  const uint32_t all_0 = 0x0;
  volatile uint32_t read_val = 0;
  volatile uint32_t errors = 0;

  //uart_init();

  // write one over to see if function behaves correctly
  for(volatile uint32_t i=0; i < 7; i++){
    gpio_init_in(i);
  }
  // test too large val to see it does not break
  gpio_init_in(8);

  read_val = gpio_read();

  if(read_val == 0){
    errors++;
    //uart_print("[Error]");
  }

  for(uint32_t i=0; i < 9; i++){
    gpio_init_out(i);
  }
  // test too large val to see it does not break
  gpio_init_out(8);

  gpio_write(all_1);
  gpio_write(all_0);
  gpio_write(all_1);
  gpio_write(all_0);
  
  // test to figure out why exception
  read_val = PAD_CFG_GPIO6;
  read_val = PAD_CFG_GPIO7;
  PAD_CFG_GPIO7 = 0;
  PAD_CFG_GPIO7 = 0x1;
  PAD_CFG_GPIO7 = 0;
  

  gpio_init_in(7);

  return errors;

}