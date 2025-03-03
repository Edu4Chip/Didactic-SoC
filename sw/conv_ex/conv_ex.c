/*
 * Name: conv_ex 
 * Contributor(s):
 *    - Antti Nurmi <antti.nurmi@tuni.fi>
 * Description:
 *    - (Mock) 2D convolution application for course project
 */
#include "uart.h"
#include "conv.h"

int main() {

  uart_init();
  
  const uint32_t test_code = 0x250;

  fprint("hello from 2D conv, COMP.CE.%x!\n", test_code);

  volatile uint32_t DMEM_FIRST  = *(uint32_t*)(0x01010000);
  volatile uint32_t DMEM_SECOND = *(uint32_t*)(0x0101000C);

  uint32_t mult_res = DMEM_FIRST * DMEM_SECOND;

  uint8_t mat_test[4][4] = {{0}}; 
  init_matrix(4, mat_test, 0x01010000);
  fprint("matrix test:\n");
  print_matrix(4, mat_test);

  fprint("DMEM first value: %x\n", DMEM_FIRST);
  fprint("DMEM second value: %x\n", DMEM_SECOND);
  fprint("mul_res: %x\n", mult_res);


  
  return 0;
}