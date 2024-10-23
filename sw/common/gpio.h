/*
 * name: gpio.h
 * contributor(S):
 *    - 
 * description:
 *    - helper functions to use generic (pmod) ios
 *    - 
 * notes:
 */
#ifndef __GPIO_H__
#define __GPIO_H__

#define ADDR 0x01030000

#define PAD_IN  *(uint32_t *)(ADDR+0x08)
#define PAD_OUT *(uint32_t *)(ADDR+0x0C)

#define CTRL_BASE 0x01040000
#define PAD_CFG_GPIO0 *(uint32_t*)(CTRL_BASE + 0x28)
#define PAD_CFG_GPIO1 *(uint32_t*)(CTRL_BASE + 0x2C)
#define PAD_CFG_GPIO2 *(uint32_t*)(CTRL_BASE + 0x30)
#define PAD_CFG_GPIO3 *(uint32_t*)(CTRL_BASE + 0x34)
#define PAD_CFG_GPIO4 *(uint32_t*)(CTRL_BASE + 0x38)
#define PAD_CFG_GPIO5 *(uint32_t*)(CTRL_BASE + 0x4C)
#define PAD_CFG_GPIO6 *(uint32_t*)(CTRL_BASE + 0x40)
#define PAD_CFG_GPIO7 *(uint32_t*)(CTRL_BASE + 0x44)

void init_gpio_out(uint32_t index){
  volatile uint32_t mask = 0;
  switch (index)
  {
    case 0:
	  mask = PAD_CFG_GPIO0;
	  PAD_CFG_GPIO0 = (mask & ~(1u));



  }
}

void init_gpio_out(uint32_t index){
  volatile uint32_t mask = 0;
  switch (index)
  {
    case 0:
	  mask = PAD_CFG_GPIO0;
	  PAD_CFG_GPIO0 = (mask | 1u);



  }
}

int read_gpio(){
  return PAD_IN;
}

void write_gpio(uint32_t val){
  PAD_OUT = val;
}

#endif //__GPIO_H__
