/*
 * name: 
 * contributor(S):
 *    - 
 * description:
 *    - 
 *    - 
 * notes:
 */
#include "uart.h"

int main() {

  uart_init();
  volatile uint32_t temp = 3;
  temp = uart_loopback_test();

  if(temp == 0){
    return 0;
  }else if(temp == 1){
	  return 1;
  }else{
	  return 499;//just random number 
  }
  
  
}