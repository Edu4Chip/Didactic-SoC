
/*
 * name: 
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * description:
 *    - test program for spi
 * notes:
 */

 #include "spi.h"
 #include "soc_ctrl.h"
 #include <stdint.h>

 int main(){

   spi_init();   

   spi_read(32u << 8);
    // spce out read and write operations
    volatile uint32_t wait_loop=0;
    while(wait_loop<200){
      asm("nop");
      wait_loop++;
    }
   spi_write(80u, 32u << 8);

   return 0;

 }