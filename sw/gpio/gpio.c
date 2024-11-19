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
  volatile uint32_t read_val = 0xFFFF;
  volatile uint32_t errors = 0;

  //uart_init();

  // Test too many gpios to check that init
  // function does not break
  for(volatile uint32_t i=0; i < 9; i++){
    gpio_init_in(i);
  }
  
  // check value
  read_val = gpio_read();

  // tri1 does not force gpios internally, 
  // so read should be equal to 0
  if(read_val != 0x0){
    errors++;
    //uart_print("[Error]");
  }

  // Again, check that init function can handle overflow
  for(uint32_t i=0; i < 9; i++){
    gpio_init_out(i);
  }

  // blinker waveform - check manually
  gpio_write(all_1);
  gpio_write(all_0);
  gpio_write(all_1);
  gpio_write(all_0);
 
  return errors;

}