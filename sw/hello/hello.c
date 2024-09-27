/*
 * name: 
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * description:
 *    - hello world for didactic soc
 * notes:
 *    - compile tb lib with uart receiver define
 */
#include "uart.h"

int main() {

  uart_init();
  
  uart_print("hello from didactic!\n");
  
  return 0;
}