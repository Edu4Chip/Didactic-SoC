/*
 * Name: hello 
 * Contributor(s):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - hello world for Didactic SoC
 * Notes:
 *    - compile tb lib with uart receiver define
 */
#include "uart.h"

int main() {

  uart_init();
  
  //uart_print("hello from didactic!\n");
  mock_uart_print("hello from didactic!\n");
  
  return 0;
}
