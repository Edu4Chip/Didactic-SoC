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

  // 25 MHz clock, 57600 baud
  uart_init(25000000,57600);

  while (1) {
    uart_print("hello from didactic!\r\n");
  }
  return 0;
}
