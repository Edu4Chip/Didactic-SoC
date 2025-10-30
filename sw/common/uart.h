/*
 * Name: uart
 * Contributor(s):
 *    - Matti Käyrä	(matti.kayra@tuni.fi)
 *    - Mohamed Soliman (mohamed.w.soliman.tuni.fi)
 * Description:
 *    - helper functions to use uart
 * Notes:
 *    - addresses are to be moved to common mem map header
 */
#ifndef __UART_H__
#define __UART_H__

#include <stdint.h>

#define PERIPH_BASE 0x01030000
#define UART_OFFSET 0x100

#define RBR_THR_DLL *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x00)
#define IER_DLM     *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x04)
#define IIR_FCR     *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x08)
#define LCR         *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x0C)
#define MCR         *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x10)
#define LSR         *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x14)
#define MSR         *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x18)
#define SCR         *( volatile uint32_t* )(PERIPH_BASE + UART_OFFSET + 0x1C)

void uart_init(uint32_t freq, uint32_t baud){
  // io cells are currently set to one directionals. change of dir would be like this:
/*  // set rx io cells as receive
  volatile uint32_t temp =   *( volatile uint32_t* )(0x010400034);

  *( volatile uint32_t* )(0x010400034) = temp | u1<<11;
*/

  uint32_t divisor = freq / (baud << 4);

  // Precalculated example divisor for 8MHz clock, 9600
  // uint32_t divisor = 52;

  // init uart settings (for typical tx/rx setup)
  IIR_FCR     = 0x00;                   // disable uart interrupt
  LCR         = (0x80);                 // Enable DLAB (set baud rate divisor)
  RBR_THR_DLL =  divisor;               // divisor (lo byte)
  IER_DLM     = (divisor >> 8) & 0xFF;  // divisor (hi byte)
  LCR         = 0x03;                   // 8 bits, no parity, one stop bit
  IIR_FCR     = 0xC7;                   // Enable FIFO, clear them, with 14-byte threshold
  MCR         = 0x20;                   // Autoflow mode
  //  IER_DLM     = 1u;// enable transmitter holding register empty interrupt
  
}

// Poll until the transmit buffer is empty
int is_transmit_empty()
{
    return (LSR) & 0x20;
}

// Poll until the transmit buffer is empty
void write_serial(char a)
{
  while (!is_transmit_empty()) {};
  RBR_THR_DLL = a;
}

void uart_print(const char str[]){
  for (int i = 0; str[i] != '\0'; i++) {
    write_serial(str[i]);
  }
}

int uart_loopback_test(){
  
  RBR_THR_DLL = 'K';
  volatile char tmp_val='O';
  volatile uint32_t wait_loop=0;
  while(wait_loop<500){
    asm("nop");
    wait_loop++;
  }

  tmp_val = RBR_THR_DLL;
  if (tmp_val == 'K'){
    return 0; // pass
  }else{
    return 1; // failure
  }
}

#endif //__UART_H__
