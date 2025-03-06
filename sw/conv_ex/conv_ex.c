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

#define InMatDim  4
#define WgtMatDim 2
#define MultDim   2
#define OutMatDim 3

int main() {

  uart_init();
  fprint("Running 4 convolutions with 4x4 data, 2x2 weight\n");

  uint32_t conv_res[4][OutMatDim][OutMatDim];

  csr_write(CSR_MCYCLE,    0);
  csr_write(CSR_MCYCLEH,   0);
  csr_write(CSR_MINSTRET,  0);
  csr_write(CSR_MINSTRETH, 0);

  asm("fence"); // signal test critical section start

  ////////////////////////////////////////////////
  /// DO NOT EDIT ANYTHING ABOVE THIS LINE !!! ///

  for (int conv_count = 0; conv_count < 4; conv_count++){

    uint8_t  data[InMatDim][InMatDim];
    uint8_t  wgt[WgtMatDim][WgtMatDim]; 
    
    // populate matrices from preloaded memory
    init_matrix(InMatDim, data, 0x01010000 + 0x10 * conv_count);
    init_matrix(WgtMatDim, wgt, 0x01010040 + 0x4  * conv_count);

    // compute convolution
    for (int j = 0; j < 3; j++){
      for (int i = 0; i < 3; i++){
        uint8_t  window[MultDim][MultDim] = {{0}}; 
        uint16_t result[MultDim][MultDim] = {{0}};
        get_submatrix(MultDim, InMatDim, j, i, data, window);
        matmul(MultDim, window, wgt, result);
        conv_res[conv_count][i][j] = accumulate(MultDim, result);
      }
    }
  }

  /// DO NOT EDIT ANYTHING BELOW THIS LINE !!! ///
  ////////////////////////////////////////////////

  asm("fence"); // signal test critical section end

  uint32_t mcycle    = csr_read(CSR_MCYCLE);
  uint32_t mcycleh   = csr_read(CSR_MCYCLEH);
  uint32_t minstret  = csr_read(CSR_MINSTRET);
  uint32_t minstreth = csr_read(CSR_MINSTRETH);

  // print out cycle count and retired instruction count
  fprint("mcycleh:   %x, mcycle:   %x\n", mcycleh, mcycle);
  fprint("minstreth: %x, minstret: %x\n", minstreth, minstret);

  fprint("PRINTING FLATTENED RESULT\n#########################\n");
  for (int conv_count = 0; conv_count < 4; conv_count++){
    print_matrix_flat(3, conv_res[conv_count]);
  }

  return 0;
}