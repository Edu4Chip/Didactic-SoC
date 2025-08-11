
/*
 * Name: kth test 
 * Description:
 *    - test program for kth
 * Notes:
 */
#include "soc_ctrl.h"
#include "uart.h"
#include "spi.h"

#define kth_base_address     0x01053000
#define instruction_offset   0x00000000 // 64 words
#define data_in_offset       0x00000100 // 24 words
#define data_out_offset      0x00000200 // 16 words
#define control_offset       0x00000300 // 1 word
#define call_offset          0x00000304 // 1 word
#define return_offset        0x00000308 // 1 word

#define  instruction_register (*(volatile uint32_t*) (kth_base_address + instruction_offset))
#define  data_in_register     (*(volatile uint32_t*) (kth_base_address + data_in_offset))
#define  data_out_register    (*(volatile uint32_t*) (kth_base_address + data_out_offset))
#define  control_register     (*(volatile uint32_t*) (kth_base_address + control_offset)) 
#define  call_register        (*(volatile uint32_t*) (kth_base_address + call_offset))
#define  return_register      (*(volatile uint32_t*) (kth_base_address + return_offset))



int main(){

static uint32_t insts_cell_00[30] = {
    0xE1000040, 0x81802040, 0xE1000000, 0x81002040,
    0xB50E0000, 0xC01C9C00, 0xC014D400, 0xC0191800,
    0xC0216000, 0xC009C800, 0xC00E0C00, 0xC4404000, 
    0xC3404040, 0xC2404040, 0xC3004040, 0x20005001,
    0x20001005, 0xC2004040, 0x20001000, 0x20022003,
    0x20002002, 0x20011002, 0x1000001B, 0xE1000020,
    0x81401040, 0xE1000060, 0x81C01040, 0x2000A001,
    0x10000000, 0x00000000
};

static uint32_t fft_data[24] = {
    0x00000000, 0x001E0000, 0x00110000, 0x000C0000, 0x000F0000, 0xFFF10000, 0xFFDC0000, 0xFFF20000,
    0x00000000, 0x00000000, 0x00180000, 0x00230000, 0x00010000, 0xFFF00000, 0xFFF50000, 0xFFE80000,
    0x01000000, 0x00ECFF9F, 0x00B5FF4B, 0x0061FF14, 0x0000FF00, 0xFF9FFF14, 0xFF4BFF4B, 0xFF14FF9F
};

static uint32_t expected_output[16] = {
    0x00120000, 0x0016000D, 0xFFDFFF41, 0x0010FFF8, 
    0x0016000A, 0xFFD6FFAE, 0x0001FFF1, 0x0004FFFB,
    0x00020000, 0x00040005, 0x0001000F, 0xFFD60052,
    0x0016FFF6, 0x00100008, 0xFFDF00BF, 0x0016FFF3
};

  uint32_t output_data[16];

  int match = 1;
  //kth_init();
  ss_init(3);
  control_register = 0x0;

  //load instructions directly into the kth instruction memory

   // load instructions
 
  for (int i = 0; i < 30; i++) {
    *(volatile uint32_t*)(0x01053000 + i * 4) = insts_cell_00[i];
  }

  

  //ld data in
  //ld_data_in(24, fft_data);
  for (int i = 0; i < 24; i++) {
    *(volatile uint32_t*)(0x01053100 + i * 4) = fft_data[i];
  }

  // call the kth
  call_register = 0x00000001;// Trigger the call to the kth


  while ((return_register & 0x00000001) != 0x00000001) {
        // wait
  }

  for (int i = 0; i < 16; i++) {
    output_data[i] = *(volatile uint32_t*)(0x01053200 + i * 4);
  }

  uart_init();
 
  for (int i = 0; i < 16; i++) {
    if (output_data[i] == expected_output[i]) {
      match = 1;
    } else {
      match = 0;
      break;
  }
  }

  if (match) {
    uart_print("output_data(Correct)\n");
  } else {
    uart_print("output_data(Wrong)\n");
  }

  return 0;

}