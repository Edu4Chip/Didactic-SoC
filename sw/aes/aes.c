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
#include "mmio.h"

int main() {

  uart_init(25000000,38400);
  
  mock_uart_print("[UART] AES Test \n");
  
  write_u32(0x01050000, 0xDEADBEEF);

  mock_uart_print("[UART] Test ended \n");

  return 0;
}
