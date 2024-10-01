
/*
 * name: 
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * description:
 *    - test program for ss0
 * notes:
 */
#include "soc_ctrl.h"

int main(){
  

  int errors=0;
  //example how to use a ss 0
  ss_init(0);
  volatile uint32_t temp_0=0xFF;
  // this is basic read operation
  temp_0 = *( volatile uint32_t* )0x010500000;
  if (temp_0==0xFF){
    errors++;
  }
  temp_0 = 0x0;
  // this is basic write operation
  *( volatile uint32_t* )0x010500000 = 0xFF;

  temp_0 = *( volatile uint32_t* )0x010500000;

  if(temp_0!=0xFF){
    errors++;
  }

  return errors;

}