/*
 * name: uart.h
 * contributor(S):
 *    - Matti Käyrä	(matti.kayra@tuni.fi)
 * description:
 *    - helper functions to use uart
 *    - 
 * notes:
 *    - addresses are to be moved to common mem map header
 */
#ifndef __URAT_H__
#define __UART_H__

#include <stdint.h>

#define PERIPH_BASE 0x01030100u
#define UART_OFFSET 0x100u

#define RBR_THR_DLL *( volatile uint32_t* )(PERIPH_BASE + 0x00u)
#define IER_DLM     *( volatile uint32_t* )(PERIPH_BASE + 0x04u)
#define IIR_FCR     *( volatile uint32_t* )(PERIPH_BASE + 0x08u)
#define LCR         *( volatile uint32_t* )(PERIPH_BASE + 0x0Cu)
#define MCR         *( volatile uint32_t* )(PERIPH_BASE + 0x10u) 
#define LSR         *( volatile uint32_t* )(PERIPH_BASE + 0x14u) 
#define MSR         *( volatile uint32_t* )(PERIPH_BASE + 0x18u) 
#define SCR         *( volatile uint32_t* )(PERIPH_BASE + 0x1Cu)

void uart_init(){
  IIR_FCR = 1u;
  LCR = (1u<<7 | 3u);
  RBR_THR_DLL = 195u;
  LCR = 3u;
  IER_DLM = 1u;//enable transmitter holding register empty interrupt
  IIR_FCR = 2u;

}

void uart_print(const char str[]){
  for (int i = 0; str[i] != '\0'; i++) {
    RBR_THR_DLL = str[i];
  }
}

int uart_loopback_test(){
  
  RBR_THR_DLL = 'K';
  volatile char tmp_val='O';
  tmp_val = RBR_THR_DLL;
  if (tmp_val == 'K'){
    return 0; // pass
  }else{
	return 1; // failure
  }
}

#endif //__UART_H__
