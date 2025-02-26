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
  
  print_uart("hello from 2D conv, COMP.CE.250!\n");
  
  return 0;
}