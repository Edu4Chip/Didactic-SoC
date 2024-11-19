/*
 * Name: 
 * Contributor(s):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - hello world for didactic soc
 * Notes:
 *    - compile tb lib with uart receiver define
 */
#include "uart.h"

int main() {

  uart_init();
  
  uart_print("hello from didactic!\n");
  
  return 0;
}