/*
 * name: soc_ctrl
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * description:
 *    - helper functions to control didcatic soc
 *    - 
 * notes:
 *    - addresses are to be moved to common mem map header
 */

#ifndef __SOC_CTRL_H__
#define __SOC_CTRL_H__

#include <stdint.h>

#define CTRL_BASE 0x01040000

#define RST_OFFSET      0x4
#define SS0_CTRL_OFFSET 0xC
#define SS1_CTRL_OFFSET 0x10
#define SS2_CTRL_OFFSET 0x14
#define SS3_CTRL_OFFSET 0x18
#define PMOD_OFFSET     0x24

#define RST_CTRL  *( volatile uint32_t* )(CTRL_BASE+RST_OFFSET)
#define SS0_CTRL  *( volatile uint32_t* )(CTRL_BASE+SS0_CTRL_OFFSET)
#define SS1_CTRL  *( volatile uint32_t* )(CTRL_BASE+SS1_CTRL_OFFSET)
#define SS2_CTRL  *( volatile uint32_t* )(CTRL_BASE+SS2_CTRL_OFFSET)
#define SS3_CTRL  *( volatile uint32_t* )(CTRL_BASE+SS3_CTRL_OFFSET)
#define PMOD_CTRL *( volatile uint32_t* )(CTRL_BASE+PMOD_OFFSET)

void ss_init(const uint32_t target_ss){
  // init: reset + clock enable
  volatile uint32_t mask = RST_CTRL;
  //     old value | target ss bit | icn reset
  RST_CTRL = (mask | 2u<<target_ss | 1u);

  // switch case for clock enabling
  switch (target_ss)
  {
    case 0:
      mask = SS0_CTRL;
      SS0_CTRL = (mask | 1u);
      break;
    case 1:
      mask = SS1_CTRL;
      SS1_CTRL = (mask | 1u);
      break;
    case 2:
      mask = SS2_CTRL;
      SS2_CTRL = (mask | 1u);
      break;
    case 3:
      mask = SS3_CTRL;
      SS3_CTRL = (mask | 1u);
      break;
    default:
      // error handling
      asm("nop");
  }

}

void ss_reset(const uint32_t target_ss){
  // reset: reset + clock disabled + irq disabled
  volatile uint32_t mask = 0;


  switch (target_ss)
  {
    case 0:
      mask = RST_CTRL;
      RST_CTRL = mask & ~(2u<<target_ss);
      mask = SS0_CTRL;
      SS0_CTRL = (mask & ~(1u));
      break;
    case 1:
      mask = RST_CTRL;
      RST_CTRL = mask & ~(2u<<target_ss);
      mask = SS1_CTRL;
      SS1_CTRL = (mask & ~(1u));
      break;
    case 2:
      mask = RST_CTRL;
      RST_CTRL = mask & ~(2u<<target_ss);
      mask = SS2_CTRL;
      SS2_CTRL = (mask & ~(1u));
      break;
    case 3:
      mask = RST_CTRL;
      RST_CTRL = mask & ~(2u<<target_ss);
      mask = SS3_CTRL;
      SS3_CTRL = (mask & ~(1u));
      break;
    default:
      // if targeting other number than specific ss, reset all
      RST_CTRL = 0u;
      mask = SS0_CTRL;
      SS0_CTRL = (mask & ~(1u));
      mask = SS1_CTRL;
      SS1_CTRL = (mask & ~(1u));
      mask = SS2_CTRL;
      SS2_CTRL = (mask & ~(1u));
      mask = SS3_CTRL;
      SS3_CTRL = (mask & ~(1u));
      
  }

}

void pmod_target(const uint32_t target_ss){
  // indexing: ss numbers. all other values route gpios from sysctrl
  PMOD_CTRL = target_ss;
}

#endif