/*
 * Name: dtutest.c
 * Contributor(s):
 *    - Tjark Petersen (tjape@dtu.dk)
 * Description:
 *    - launches simple selftest on didactic soc
 * Notes:
 */

#include <stdint.h>
#include "soc_ctrl.h"

#define DTU_BASE 0x01052000
#define IMEM_OFFSET 0x00
#define REGS_OFFSET 0x800
#define SYS_CTRL_OFFSET 0xC00

#define IMEM     (( volatile uint32_t * ) (DTU_BASE + IMEM_OFFSET))
#define REGS     (( volatile uint32_t * ) (DTU_BASE + REGS_OFFSET))
#define SYS_CTRL *( volatile uint32_t * ) (DTU_BASE + SYS_CTRL_OFFSET)

#define CLEAR_BIT(x, bit) volatile uint32_t old = x; x = (old & ~(1u << (bit)))
#define SET_BIT(x, bit) volatile uint32_t old = x; x = (old | (1u << (bit)))


void dtu_reset_enable() {
  CLEAR_BIT(RST_CTRL, 4);
}

void dtu_reset_disable() {
  SET_BIT(RST_CTRL, 4);
}

void dtu_clock_enable() {
  SET_BIT(SS2_CTRL, 0);
}

void dtu_clock_disable() {
  CLEAR_BIT(SS2_CTRL, 0);
}

void leros_reset(uint8_t enable) {
  if (enable) {
    SET_BIT(SYS_CTRL, 0); // enable reset
  } else {
    CLEAR_BIT(SYS_CTRL, 0); // disable reset
  }
}

void leros_boot_from_rom() {
  CLEAR_BIT(SYS_CTRL, 1);
}

void leros_boot_from_ram() {
  SET_BIT(SYS_CTRL, 1);
}

void leros_uart_loopback(uint8_t enable) {
  if (enable) {
    SET_BIT(SYS_CTRL, 2); // enable loopback
  } else {
    CLEAR_BIT(SYS_CTRL, 2); // disable loopback
  }
}

void dtu_init() {
  dtu_clock_enable();
  volatile uint32_t mask = RST_CTRL;
  // old value | target ss bit | icn reset
  RST_CTRL = (mask | 2u<<2 | 1u); 
}

void load_blink() {
  *(volatile unsigned int*)(0x01052000) = 0x21000000;
  *(volatile unsigned int*)(0x01052004) = 0x2a002980;
  *(volatile unsigned int*)(0x01052008) = 0x50013001;
  *(volatile unsigned int*)(0x0105200c) = 0x30022100;
  *(volatile unsigned int*)(0x01052010) = 0x09012002;
  *(volatile unsigned int*)(0x01052014) = 0x70003002;
  *(volatile unsigned int*)(0x01052018) = 0x23017041;
  *(volatile unsigned int*)(0x0105201c) = 0x70450930;
  *(volatile unsigned int*)(0x01052020) = 0x8ff8;
}

void load_selftest() {
*(volatile unsigned int*)(0x01052000) = 0x29802100;
*(volatile unsigned int*)(0x01052004) = 0x30012a00;
*(volatile unsigned int*)(0x01052008) = 0x60005001;
*(volatile unsigned int*)(0x0105200c) = 0x30019fff;
*(volatile unsigned int*)(0x01052010) = 0x30022001;
*(volatile unsigned int*)(0x01052014) = 0x30032002;
*(volatile unsigned int*)(0x01052018) = 0x30042003;
*(volatile unsigned int*)(0x0105201c) = 0x30052004;
*(volatile unsigned int*)(0x01052020) = 0x30062005;
*(volatile unsigned int*)(0x01052024) = 0x30072006;
*(volatile unsigned int*)(0x01052028) = 0x70412007;
*(volatile unsigned int*)(0x0105202c) = 0x30016041;
*(volatile unsigned int*)(0x01052030) = 0x60447045;
*(volatile unsigned int*)(0x01052034) = 0x9ffe2301;
*(volatile unsigned int*)(0x01052038) = 0x70016045;
*(volatile unsigned int*)(0x0105203c) = 0x70002101;
*(volatile unsigned int*)(0x01052040) = 0x8000;
}

int main2() {

  dtu_init();
  SYS_CTRL = 0x7;

  load_selftest();

  SYS_CTRL = 0x6;

  REGS[0] = 0xDEADBEEF;

  while(REGS[0] == 0) {
    // wait for selftest to finish
  }

  if (REGS[1] != 0xEF) {
    return -1; // selftest failed
  }

  return 0; // selftest passed
}

int main() {

  PMOD_CTRL = 2; // route pmod to dtu_ss

  SS2_CTRL = 1; // enable clock for dtu_ss

  RST_CTRL = 9; // deassert dtu_ss and icn reset

  SYS_CTRL = 1; // reset leros

  SYS_CTRL = 0; // deassert leros reset

  return 0;

}