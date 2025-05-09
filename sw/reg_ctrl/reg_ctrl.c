/*
 * Name: reg ctrl
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

 // uart_init();

  ss_init(0);
  ss_init(1);
  ss_init(2);
  ss_init(3);
  ss_init(4);
  
  ss_reset(5);//unused index = reset all

 // uart_print("initial reset round done");

  for(uint32_t i=0; i<5; i++){
    pmod_target(i);// only 4 pmod targets exist currently
  }
  
//  uart_print("pmod loop");

  for (uint32_t i=0; i<6; i++){
    ss_init(i);
    ss_reset(i);
    ss_init_high_speed(i);
    ss_reset(i);
  }

//  uart_print("1. phase done");

  volatile uint32_t errors=0;
  volatile uint32_t read_val=0;
  volatile uint32_t ones= 0xFFFFFFFF;

  for(uint32_t i=0; i < 35; i++ ){
    *(volatile uint32_t*)(CTRL_BASE+i*4)=ones;
    read_val = 0;
    read_val=*(volatile uint32_t*)(CTRL_BASE+i*4);
    if (read_val!=ones){
      errors++;
    }
  }

  return errors;

}