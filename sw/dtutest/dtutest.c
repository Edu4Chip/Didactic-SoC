/*
 * Name: blink.c
 * Contributor(s):
 *    - Matti Käyrä (matti.kayra@tuni.fi) 
 * Description:
 *    - "Led blinker" for sim
 *    - raw pointers
 * Notes:
 */

#include <stdint.h>
#include "soc_ctrl.h"

void dtu_reset_enable() {
  volatile uint32_t mask = RST_CTRL;
  RST_CTRL = (mask | 2u<<2);
}

void dtu_reset_disable() {
  volatile uint32_t mask = RST_CTRL;
  RST_CTRL = (mask & (~(2u<<2)));
}

void dtu_clock_enable() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask | 1u);
}

void dtu_clock_disable() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask & (~1u));
}

void leros_reset_enable() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask | 0x4u);
}

void leros_reset_disable() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask & (~0x4u));
}

void leros_boot_from_rom() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask & (~0x8u));
}

void leros_boot_from_ram() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask | 0x8u);
}

void dtu_init() {
  // takes dtu ss and icn out of reset
  volatile uint32_t mask = RST_CTRL;
  //     old value | target ss bit | icn reset
  RST_CTRL = (mask | 2u<<2 | 1u);

  dtu_clock_enable();

  dtu_reset_disable();
}

int main() {

  volatile int * leros_imem = (int *) (0x01052000);

  volatile int * leros_regs = (int *) (0x01052FF0);

  volatile uint32_t mask;

  dtu_init();

  *(volatile unsigned int*)(0x01052000) = 0x21000000;
  *(volatile unsigned int*)(0x01052004) = 0x2a002980;
  *(volatile unsigned int*)(0x01052008) = 0x50013001;
  *(volatile unsigned int*)(0x0105200c) = 0x29be21ef;
  *(volatile unsigned int*)(0x01052010) = 0x2bde2aad;
  *(volatile unsigned int*)(0x01052014) = 0x70017000;
  *(volatile unsigned int*)(0x01052018) = 0x70037002;
  *(volatile unsigned int*)(0x0105201c) = 0x70092175;
  *(volatile unsigned int*)(0x01052020) = 0x70052101;
  *(volatile unsigned int*)(0x01052024) = 0x09016005;
  *(volatile unsigned int*)(0x01052028) = 0x8ffd7005;

  for (int i = 0; i < 4; i++) {
    leros_regs[i] = i;
  }

  for (int i = 0; i < 4; i++) {
    leros_regs[i] = leros_regs[i];
  }

  for (int i = 0; i < 100; i++) {
    mask = SS2_CTRL;
  }

  leros_reset_enable();
  leros_boot_from_ram();
  leros_reset_disable();

  for (int i = 0; i < 100; i++) {
    mask = SS2_CTRL;
  }
  
  return 0;
}