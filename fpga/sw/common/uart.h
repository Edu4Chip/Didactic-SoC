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

#define PERIPH_BASE 0x01030100
#define UART_OFFSET 0x100

#define RBR_THR_DLL *( volatile uint32_t* )(0x01030100)
#define IER_DLM     *( volatile uint32_t* )(0x01030104)
#define IIR_FCR     *( volatile uint32_t* )(0x01030108)
#define LCR         *( volatile uint32_t* )(0x0103010C)
#define MCR         *( volatile uint32_t* )(0x01030110) 
#define LSR         *( volatile uint32_t* )(0x01030114) 
#define MSR         *( volatile uint32_t* )(0x01030118) 
#define SCR         *( volatile uint32_t* )(0x0103011C)

void uart_init(){
  // io cells are currently set to one directionals. change of dir would be like this:
/*  // set rx io cells as receive
  volatile uint32_t temp =   *( volatile uint32_t* )(0x010400034);

  *( volatile uint32_t* )(0x010400034) = temp | u1<<11;
*/

  // init uart settings (for typical tx/rx setup)
  IIR_FCR = 1u;
  LCR = (1u<<7 | 3u);
  RBR_THR_DLL = 20u;//divisor to define baudrate: ~38400 = (frequency, 12)/(16*RBR_THR_DLL)
  LCR = 3u;
  IER_DLM = 1u;// enable transmitter holding register empty interrupt
  IIR_FCR = 2u; // receiver fifo reset

}

void uart_print(const char str[]){
  for (int i = 0; str[i] != '\0'; i++) {
  
    RBR_THR_DLL = str[i];

    // best: IRQ based
    // TBD

    // better: poll when char has been sent
    //    volatile int temp = LSR;
    //    while(temp != 0){
    //      temp = LSR;
    //      
    //    }
    //  }

    // basic: manually nop until time has passed
    volatile uint32_t wait_loop=0;
    while(wait_loop<500){
      asm("nop");
      wait_loop++;
    }
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
