/*
 * Name: conv_ex 
 * Contributor(s):
 *    - Antti Nurmi <antti.nurmi@tuni.fi>
 * Description:
 *    - (Mock) 2D convolution application for course project
 */
#include "uart.h"

int main() {

  uart_init();
  
  const uint32_t test_code = 0x250;

  fprint("hello from 2D conv, COMP.CE.%x!\n", test_code);

  volatile uint32_t DMEM_FIRST = *(uint32_t*)(0x01010000);
  fprint("DMEM first value: %x\n", DMEM_FIRST);

  
  return 0;
}