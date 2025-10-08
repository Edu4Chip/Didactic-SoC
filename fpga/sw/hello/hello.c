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

  // 8 MHz clock, 9600 baud
  uart_init(8000000,9600);

  while (1) {
    uart_print("hello from didactic!\r\n");
  }
  return 0;
}
