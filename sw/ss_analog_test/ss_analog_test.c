
/*
 * Name: ss analog test
 * Contributor(s):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * Description:
 *    - test program for ss analog
 * Notes:
 */
#include "soc_ctrl.h"

int main(){
  

  int errors = 0;
  
  ss_init(4);
  volatile uint32_t temp_0 = 0xFF;
  // this is basic read operation
  temp_0 = *( volatile uint32_t* ) 0x01054000;

  // check against tieoff
  if (temp_0 != 0x0){
    errors++;
  }

  temp_0 = *( volatile uint32_t* ) 0x01054004;
  // 
  if (temp_0 != 0x1){
    errors++;
  }

  temp_0 = *( volatile uint32_t* ) 0x01054008;
  // 
  if (temp_0 != 0x2){
    errors++;
  }

  temp_0 = *( volatile uint32_t* ) 0x0105400C;
  // 
  if(temp_0 != 0x3){
    errors++;
  }


  return errors;

}