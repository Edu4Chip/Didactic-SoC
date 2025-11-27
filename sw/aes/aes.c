/*
 * Name: aes
 * Contributor(s):
 *    - Antti Nurmi (antti.nurmi@tuni.fi)
 * Description:
 *    - hello world for Didactic SoC
 * Notes:
 *    - compile tb lib with uart receiver define
 */
#include "uart.h"

int main() {

  uart_init(25000000,38400);
  
  mock_uart_print("AES Test\n");
  mock_uart_print("bottom text\n");
  
  return 0;
}
