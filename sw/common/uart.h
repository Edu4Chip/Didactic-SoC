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
#include <stdarg.h>


#define PERIPH_BASE 0x01030100
#define UART_OFFSET 0x100

#define RBR_THR_DLL *( volatile uint8_t* )(0x01030100)
#define IER_DLM     *( volatile uint8_t* )(0x01030104)
#define IIR_FCR     *( volatile uint8_t* )(0x01030108)
#define LCR         *( volatile uint8_t* )(0x0103010C)
#define MCR         *( volatile uint8_t* )(0x01030110) 
#define LSR         *( volatile uint8_t* )(0x01030114) 
#define MSR         *( volatile uint8_t* )(0x01030118) 
#define SCR         *( volatile uint8_t* )(0x0103011C)

void uart_init(){
  // io cells are currently set to one directionals. change of dir would be like this:
/*  // set rx io cells as receive
  volatile uint32_t temp =   *( volatile uint32_t* )(0x010400034);

  *( volatile uint32_t* )(0x010400034) = temp | u1<<11;
*/

  // init uart settings (for typical tx/rx setup)
  IIR_FCR = 1u;
  LCR = (1u<<7 | 3u);
  RBR_THR_DLL = 13u;//divisor to define baudrate: 38400 = frequncy/(16*)
  LCR = 3u;
  IER_DLM = 1u;// enable transmitter holding register empty interrupt
  IIR_FCR = 2u; // receiver fifo reset

}

uint8_t is_transmit_empty()
{
    return LSR & 0x20;
}

void write_serial(uint8_t a)
{
  while (is_transmit_empty() == 0)
    ;
  RBR_THR_DLL = a;
}

void print_uart(const char *str)
{
    const char *cur = &str[0];
    while (*cur != '\0')
    {
        write_serial((uint8_t)*cur);
        ++cur;
    }
    
}

void bin_to_hex(uint8_t inp, uint8_t res[2])
{   
    uint8_t inp_low = (inp & 0xf);
    uint8_t inp_high = ((inp >> 4) & 0xf);

    res[1] = inp_low < 10 ? inp_low + 48 : inp_low + 55;
    res[0] = inp_high < 10 ? inp_high + 48 : inp_high + 55;
}

void print_uart_int(uint32_t addr)
{
    int i;
    for (i = 3; i > -1; i--)
    {
        uint8_t cur = (addr >> (i * 8)) & 0xff;
        uint8_t hex[2];
        bin_to_hex(cur, hex);
        write_serial(hex[0]);
        write_serial(hex[1]);
    }
}

// super bare-bones mock printf
void fprint(const char* str, ...){
  va_list args; 
  va_start(args, str);
  for (int i = 0; str[i] != '\0'; i++){
    if (str[i] == '%') {
      print_uart_int(va_arg(args, int));
      i++;
    }
    else
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
