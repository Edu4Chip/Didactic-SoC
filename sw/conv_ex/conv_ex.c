/*
 * Name: conv_ex 
 * Contributor(s):
 *    - Antti Nurmi <antti.nurmi@tuni.fi>
 * Description:
 *    - (Mock) 2D convolution application for course project
 */
#include <stdlib.h>
#include "uart.h"
#include "conv.h"
#include "csr.h"

int main() {

  uart_init();
  fprint("Initializing conv_ex test\n");

  // TODO: clear CSRs
  csr_write(CSR_MCYCLE,    0);
  csr_write(CSR_MCYCLEH,   0);
  csr_write(CSR_MINSTRET,  0);
  csr_write(CSR_MINSTRETH, 0);

  asm("fence"); // signal test critical section start

  for (int conv_count = 0; conv_count < 4; conv_count++){
    
  }

  uint8_t  mat_test[4][4] = {{0}};
  uint8_t  wgt_test[2][2] = {{0}}; 
  uint32_t conv_res[3][3] = {{0}}; 

  init_matrix(4, mat_test, 0x01010000);
  init_matrix(2, wgt_test, 0x01010000 + 0x40);

  for (int j = 0; j < 3; j++){
    for (int i = 0; i < 3; i++){
      uint8_t window[2][2] = {{0}};
      uint32_t result[2][2] = {{0}};
      get_submatrix(2, 4, j, i, mat_test, window);
      matmul(2, window, wgt_test, result);
      conv_res[i][j] = accumulate(2, result);
    }
  }

  uint32_t mcycle    = csr_read(CSR_MCYCLE);
  uint32_t mcycleh   = csr_read(CSR_MCYCLEH);
  uint32_t minstret  = csr_read(CSR_MINSTRET);
  uint32_t minstreth = csr_read(CSR_MINSTRETH);

  asm("fence"); // signal test critical section end

  // print out cycle count and retired instruction count
  fprint("mcycleh:   %x, mcycle:   %x\n", mcycleh, mcycle);
  fprint("minstreth: %x, minstret: %x\n", minstreth, minstret);

  print_matrix_flat(3, conv_res);

  return 0;
}