/*
 * Name: 
 * Contributor(s):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - test program to test some subsystem controls and pmod routing
 *    - 
 * Notes:
 */

//#include "uart.h"
#include "soc_ctrl.h"

int main(){
  int errors=0;

 // uart_init();

  ss_init(0);
  ss_init(1);
  ss_init(2);
  ss_init(3);
  
  ss_reset(4);//unused index = reset all

 // uart_print("initial reset round done");

  for(uint32_t i=0; i<5; i++){
    pmod_target(i);
  }
  
//  uart_print("pmod loop");

  for (uint32_t i=0; i<5; i++){
    ss_init(i);
	  ss_reset(i);
  }

  return 0;

}