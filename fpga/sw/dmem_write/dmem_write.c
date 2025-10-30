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

#define DMEMTESTBASE 0x01010000
const char* e4c[] = {44,44,44,44,44,44,44,44,44,44,44,44,44};

int main() {

  int lines = sizeof(e4c) / sizeof(e4c[0]);

  uart_init(25000000,38400);

  int size = 1000;
  int wvalue = 0x0000AAAA;

  for (int i = 0; i < lines; i++) {
    uart_print(e4c[i]);
    uart_print("\r\n");
  }

  while (1);

uart_print("Writing \r\n");
for (int i = 0; i < size; i++) {
  *( volatile uint32_t* )(DMEMTESTBASE + 4*i) = 4*i;
  uart_print(4*i);
  uart_print("\r\n");
  *( volatile uint32_t* )(DMEMTESTBASE + 4*i) = wvalue;
  *( volatile uint32_t* )(DMEMTESTBASE + 4*i) = wvalue;
}


  return 0;
}
