/*
 * Name: accel.c
 * Contributor(s):
 *    - Group5 (TUM systolic-array AI accelerator)
 * Description:
 *    - Baremetal self-checking smoke test for the systolic-array accelerator
 *      integrated in the TUM student subsystem (SS1).
 *    - Computes C = A * B with A and B filled with all ones, so every element
 *      of C must equal K (the reduction depth = 16 in the default build).
 * Notes:
 *    - Accelerator APB window base = 0x0105_1000 (ICN_SS idx 1 = tum_ss).
 *    - Internal address decode uses PADDR[9:8]:
 *        00 -> matrix_buffer_ab  (A @ 0x00, B @ 0x40, CTRL @ 0x80)
 *        01 -> control_unit      (regmap @ 0x100)
 *        10 -> matrix_buffer_c   (DATA @ 0x200, CTRL @ 0x280)
 *    - Hardware array is fixed 16x16x16 (DATA_W = 16). Each 32-bit APB write
 *      packs two 16-bit elements, LSB-lane first.
 */

#include <stdint.h>
#include "soc_ctrl.h"
#include "uart.h"

// Accelerator dimensions (must match the accelerator_top build parameters).
#define ACC_M 16
#define ACC_N 16
#define ACC_K 16
#define ACC_DATA_W 16
#define ELEMS_PER_WORD (32 / ACC_DATA_W) // 2 elements per 32-bit APB word

// TUM subsystem slot index and accelerator APB base address.
#define ACCEL_SS 1
#define ACCEL_BASE 0x01051000u

// matrix_buffer_ab (PADDR[9:8] == 00)
#define MAT_A_DATA (*(volatile uint32_t *)(ACCEL_BASE + 0x000u))
#define MAT_B_DATA (*(volatile uint32_t *)(ACCEL_BASE + 0x040u))
#define MAT_AB_CTRL (*(volatile uint32_t *)(ACCEL_BASE + 0x080u))

// control_unit (PADDR[9:8] == 01)
#define REG_CTRL (*(volatile uint32_t *)(ACCEL_BASE + 0x100u))
#define REG_STATUS (*(volatile uint32_t *)(ACCEL_BASE + 0x104u))
#define REG_M_DIM (*(volatile uint32_t *)(ACCEL_BASE + 0x108u))
#define REG_N_DIM (*(volatile uint32_t *)(ACCEL_BASE + 0x10Cu))
#define REG_INT_EN (*(volatile uint32_t *)(ACCEL_BASE + 0x110u))
#define REG_INT_STAT (*(volatile uint32_t *)(ACCEL_BASE + 0x114u))
#define REG_K_DIM (*(volatile uint32_t *)(ACCEL_BASE + 0x118u))

// matrix_buffer_c (PADDR[9:8] == 10)
#define MAT_C_DATA (*(volatile uint32_t *)(ACCEL_BASE + 0x200u))
#define MAT_C_CTRL (*(volatile uint32_t *)(ACCEL_BASE + 0x280u))

// Control / status bit fields.
#define CTRL_START_BIT (1u << 0)
#define CTRL_SOFTRST_BIT (1u << 1)
#define STATUS_BUSY_BIT (1u << 0)
#define STATUS_DONE_BIT (1u << 1)
#define MAT_CTRL_RESET_BIT (1u << 0)

// Result sink that the testbench / debugger can observe:
//   0xACCE5500 -> PASS, 0xBADD0000 | mismatch_count -> FAIL.
volatile uint32_t accel_result = 0u;

int main(void) {
  uart_init();
  uart_print("accel: start\n");

  // Bring the TUM subsystem out of reset and enable its clock.
  ss_init(ACCEL_SS);

  // 1. Reset the A/B write pointers (transient, self-clearing).
  MAT_AB_CTRL = MAT_CTRL_RESET_BIT;

  // 2. Stream Matrix A = all ones. Two 16-bit lanes per word -> 0x0001_0001.
  const uint32_t ones_word = 0x00010001u;
  const uint32_t a_words = (ACC_M * ACC_K) / ELEMS_PER_WORD; // 128
  for (uint32_t i = 0; i < a_words; i++) {
    MAT_A_DATA = ones_word;
  }

  // 3. Stream Matrix B = all ones.
  const uint32_t b_words = (ACC_K * ACC_N) / ELEMS_PER_WORD; // 128
  for (uint32_t i = 0; i < b_words; i++) {
    MAT_B_DATA = ones_word;
  }

  // 4. Reset the C capture state / read pointer.
  MAT_C_CTRL = MAT_CTRL_RESET_BIT;

  // 5. (Optional) program the exposed dimension registers for documentation.
  REG_M_DIM = ACC_M;
  REG_N_DIM = ACC_N;
  REG_K_DIM = ACC_K;

  // 6. Issue a start pulse to the compute FSM.
  REG_CTRL = CTRL_START_BIT;

  // 7. Wait for completion (STATUS.done). Guard with a timeout so a broken
  //    integration cannot hang the test forever.
  uint32_t timeout = 1000000u;
  while (((REG_STATUS & STATUS_DONE_BIT) == 0u) && (timeout != 0u)) {
    timeout--;
  }

  if (timeout == 0u) {
    uart_print("accel: TIMEOUT waiting for done\n");
    accel_result = 0xBADD0001u;
    while (1) {
      asm volatile("nop");
    }
  }

  // 8. Read back all C elements and check against the golden value K.
  const uint32_t expected = ACC_K; // sum of K ones
  const uint32_t c_count = ACC_M * ACC_N; // 256
  uint32_t mismatches = 0u;
  for (uint32_t i = 0; i < c_count; i++) {
    uint32_t c = MAT_C_DATA;
    if (c != expected) {
      mismatches++;
    }
  }

  // 9. Clear the done status (W1C) for a clean end state.
  REG_STATUS = STATUS_DONE_BIT;

  if (mismatches == 0u) {
    uart_print("accel: PASS\n");
    accel_result = 0xACCE5500u;
  } else {
    uart_print("accel: FAIL\n");
    accel_result = 0xBADD0000u | (mismatches & 0xFFFFu);
  }

  while (1) {
    asm volatile("nop");
  }

  return 0;
}
