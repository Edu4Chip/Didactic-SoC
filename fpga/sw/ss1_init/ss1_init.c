/*
 * Name: student_ss_init.c
 * Contributor(s):
 *    - Arto Oinonen (arto.oinonen@tuni.fi)
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - Lift the reset and enable the clock for a single subsystem
 */

#include <stdint.h>
#include "soc_ctrl.h"
#include "mystery.h"

#define SUBSYSTEM 1

int main() {

  ss_init(SUBSYSTEM);
  pmod_target(SUBSYSTEM);

  // Writing any value to the identify register lights up the corresponding GPIO led for 5 seconds.
  SS1_IDENTIFY = 0x01;

  while(1);

  return 0;
}
