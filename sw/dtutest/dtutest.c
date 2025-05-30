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
  RST_CTRL = (mask & (~(2u<<2)));
}

void dtu_reset_disable() {
  volatile uint32_t mask = RST_CTRL;
  RST_CTRL = (mask | 2u<<2);
}

void dtu_clock_enable() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask | 1u);
}

void dtu_clock_disable() {
  volatile uint32_t mask = SS2_CTRL;
  SS2_CTRL = (mask & (~1u));
}

void setSysCtrlBits(uint32_t bit) {
  volatile int * sysCtrl = (int *) (0x01052C00);
  volatile uint32_t mask = *sysCtrl;
  *sysCtrl = (mask | (1 << bit));
}

void clearSysCtrlBits(uint32_t bit) {
  volatile int * sysCtrl = (int *) (0x01052C00);
  volatile uint32_t mask = *sysCtrl;
  *sysCtrl = (mask & (~(1 << bit)));
}

void leros_reset_enable() {
  setSysCtrlBits(0);
}

void leros_reset_disable() {
  clearSysCtrlBits(0);
}

void leros_reset() {
  leros_reset_enable();
  leros_reset_disable();
}

void leros_boot_from_rom() {
  clearSysCtrlBits(1);
}

void leros_boot_from_ram() {
  setSysCtrlBits(1);
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

  volatile int * leros_regs = (int *) (0x01052800);

  volatile uint32_t mask;

  dtu_init();

  *(volatile unsigned int*)(0x01052000) = 0x21000000;
  *(volatile unsigned int*)(0x01052004) = 0x2a002980;
  *(volatile unsigned int*)(0x01052008) = 0x50013001;
  *(volatile unsigned int*)(0x0105200c) = 0x30022100;
  *(volatile unsigned int*)(0x01052010) = 0x09012002;
  *(volatile unsigned int*)(0x01052014) = 0x70003002;
  *(volatile unsigned int*)(0x01052018) = 0x23017041;
  *(volatile unsigned int*)(0x0105201c) = 0x70450930;
  *(volatile unsigned int*)(0x01052020) = 0x8ff8;

  for (int i = 0; i < 4; i++) {
    leros_regs[i] = i;
  }

  for (int i = 0; i < 4; i++) {
    leros_regs[i] = leros_regs[i];
  }

  for (int i = 0; i < 20; i++) {
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