/*
 * name: 
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * description:
 *    - uart tx to rx loopback test
 * notes:
 *    - compile tb without uart receiver to enable loopback
 */
#include "uart.h"

int main() {

  uart_init();
  volatile uint32_t temp = 3;
  temp = uart_loopback_test();

  if(temp == 0){
    return 0; // success
  }else if(temp == 1){
	  return 1; // failure
  }else{
	  return 499;//just random number 
  }
  
  
}