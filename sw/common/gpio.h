/*
 * Name: gpio.h
 * Contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - helper functions to use generic (pmod) ios
 *    - 
 * Notes:
 *    - addresses are to be moved to common mem map header
 */
#ifndef __GPIO_H__
#define __GPIO_H__

#include <stdint.h>

#define ADDR 0x01030000

#define PAD_IN  *(uint32_t *)(ADDR+0x08)
#define PAD_OUT *(uint32_t *)(ADDR+0x0C)

#define CTRL_BASE 0x01040000
#define PAD_CFG_GPIO0 *(uint32_t*)(CTRL_BASE + 0x4C)
#define PAD_CFG_GPIO1 *(uint32_t*)(CTRL_BASE + 0x50)
#define PAD_CFG_GPIO2 *(uint32_t*)(CTRL_BASE + 0x54)
#define PAD_CFG_GPIO3 *(uint32_t*)(CTRL_BASE + 0x58)
#define PAD_CFG_GPIO4 *(uint32_t*)(CTRL_BASE + 0x5C)
#define PAD_CFG_GPIO5 *(uint32_t*)(CTRL_BASE + 0x60)
#define PAD_CFG_GPIO6 *(uint32_t*)(CTRL_BASE + 0x64)
#define PAD_CFG_GPIO7 *(uint32_t*)(CTRL_BASE + 0x68)
#define PAD_CFG_GPIO8 *(uint32_t*)(CTRL_BASE + 0x6C)
#define PAD_CFG_GPIO9 *(uint32_t*)(CTRL_BASE + 0x70)
#define PAD_CFG_GPIO10 *(uint32_t*)(CTRL_BASE + 0x74)
#define PAD_CFG_GPIO11 *(uint32_t*)(CTRL_BASE + 0x78)
#define PAD_CFG_GPIO12 *(uint32_t*)(CTRL_BASE + 0x7C)
#define PAD_CFG_GPIO13 *(uint32_t*)(CTRL_BASE + 0x80)
#define PAD_CFG_GPIO14 *(uint32_t*)(CTRL_BASE + 0x84)
#define PAD_CFG_GPIO15 *(uint32_t*)(CTRL_BASE + 0x88)

void gpio_init_out(uint32_t index){
  volatile uint32_t mask = 0;
  switch (index)
  {
    case 0:
      mask = PAD_CFG_GPIO0;
      PAD_CFG_GPIO0 = (mask & ~(1u));
      break;
    case 1:
      mask = PAD_CFG_GPIO1;
      PAD_CFG_GPIO1 = (mask & ~(1u));
      break;
    case 2:
      mask = PAD_CFG_GPIO2;
      PAD_CFG_GPIO2 = (mask & ~(1u));
      break;
    case 3:
      mask = PAD_CFG_GPIO3;
      PAD_CFG_GPIO3 = (mask & ~(1u));
      break;
    case 4:
      mask = PAD_CFG_GPIO4;
      PAD_CFG_GPIO4 = (mask & ~(1u));
      break;
    case 5:
      mask = PAD_CFG_GPIO5;
      PAD_CFG_GPIO5 = (mask & ~(1u));
      break;
    case 6:
      mask = PAD_CFG_GPIO6;
      PAD_CFG_GPIO6 = (mask & ~(1u));
      break;
    case 7:
      mask = PAD_CFG_GPIO7;
      PAD_CFG_GPIO7 = (mask & ~(1u));
      break;
    case 8:
      mask = PAD_CFG_GPIO8;
      PAD_CFG_GPIO8 = (mask & ~(1u));
      break;
    case 9:
      mask = PAD_CFG_GPIO9;
      PAD_CFG_GPIO9 = (mask & ~(1u));
      break;
    case 10:
      mask = PAD_CFG_GPIO10;
      PAD_CFG_GPIO10 = (mask & ~(1u));
      break;
    case 11:
      mask = PAD_CFG_GPIO11;
      PAD_CFG_GPIO11 = (mask & ~(1u));
      break;
    case 12:
      mask = PAD_CFG_GPIO12;
      PAD_CFG_GPIO12 = (mask & ~(1u));
      break;
    case 13:
      mask = PAD_CFG_GPIO13;
      PAD_CFG_GPIO13 = (mask & ~(1u));
      break;
    case 14:
      mask = PAD_CFG_GPIO14;
      PAD_CFG_GPIO14 = (mask & ~(1u));
      break;
    case 15:
      mask = PAD_CFG_GPIO15;
      PAD_CFG_GPIO15 = (mask & ~(1u));
      break;
    default:
      asm("nop");
      break;
  }
}

void gpio_init_in(const uint32_t index){
  volatile uint32_t mask = 0;
  switch (index)
  {
    case 0:
      mask = PAD_CFG_GPIO0;
      PAD_CFG_GPIO0 = (mask | 1u);
      break;
    case 1:
      mask = PAD_CFG_GPIO1;
      PAD_CFG_GPIO1 = (mask | 1u);
      break;
    case 2:
      mask = PAD_CFG_GPIO2;
      PAD_CFG_GPIO2 = (mask | 1u);
      break;
    case 3:
      mask = PAD_CFG_GPIO3;
      PAD_CFG_GPIO3 = (mask | 1u);
      break;
    case 4:
      mask = PAD_CFG_GPIO4;
      PAD_CFG_GPIO4 = (mask | 1u);
      break;
    case 5:
      mask = PAD_CFG_GPIO5;
      PAD_CFG_GPIO5 = (mask | 1u);
      break;
    case 6:
      mask = PAD_CFG_GPIO6;
      PAD_CFG_GPIO6 = (mask | 1u);
      break;
    case 7:
      mask = PAD_CFG_GPIO7;
      PAD_CFG_GPIO7 = (mask | 1u);
      break;
    case 8:
      mask = PAD_CFG_GPIO8;
      PAD_CFG_GPIO8 = (mask | 1u);
      break;
    case 9:
      mask = PAD_CFG_GPIO9;
      PAD_CFG_GPIO9 = (mask | 1u);
      break;
    case 10:
      mask = PAD_CFG_GPIO10;
      PAD_CFG_GPIO10 = (mask | 1u);
      break;
    case 11:
      mask = PAD_CFG_GPIO11;
      PAD_CFG_GPIO11 = (mask | 1u);
      break;
    case 12:
      mask = PAD_CFG_GPIO12;
      PAD_CFG_GPIO12 = (mask | 1u);
      break;
    case 13:
      mask = PAD_CFG_GPIO13;
      PAD_CFG_GPIO13 = (mask | 1u);
      break;
    case 14:
      mask = PAD_CFG_GPIO14;
      PAD_CFG_GPIO14 = (mask | 1u);
      break;
    case 15:
      mask = PAD_CFG_GPIO15;
      PAD_CFG_GPIO15 = (mask | 1u);
      break;
    default:
      asm("nop");
      break;

  }
}

volatile uint32_t gpio_read(){
  return PAD_IN;
}

void gpio_write(const uint32_t val){
  PAD_OUT = val;
}

#endif //__GPIO_H__
