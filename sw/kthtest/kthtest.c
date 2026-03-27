/*
 * Name: kth test 
 * Description:
 *    - test program for kth
 * Notes:
 */
#include "soc_ctrl.h"
#include "uart.h"
#include "spi.h"
#include <stdint.h>                                                                                                              
#include <stddef.h>

                                                                                                                                 
#define KTH_BASE_ADDR        0x01053000

#define KTH_INSTR_OFFSET     0x000
#define KTH_DATA_IN_OFFSET   0x100                                                                                               
#define KTH_DATA_OUT_OFFSET  0x200
#define KTH_CONTROL_OFFSET   0x300                                                                                               
#define KTH_CALL_OFFSET      0x304                                                                                               
#define KTH_RETURN_OFFSET    0x308

#define KTH_MAX_INSTR    64  // 64 words
#define KTH_MAX_DATA_IN  24  // 24 words
#define KTH_MAX_DATA_OUT 16  // 16 words

#define KTH_REG(offset) (*(volatile uint32_t *)(KTH_BASE_ADDR + (offset)))

static inline void kth_set_control(uint32_t val)                                                                                 
{               
    KTH_REG(KTH_CONTROL_OFFSET) = val;                                                                                           
}       

static inline void kth_load_instructions(const uint32_t *insts, size_t count)                                                    
{
    for (size_t i = 0; i < count; i++)                                                                                           
        *(volatile uint32_t *)(KTH_BASE_ADDR + KTH_INSTR_OFFSET + i * 4) = insts[i];                                             
}
                                                                                                                                 
static inline void kth_load_data_in(const uint32_t *data, size_t count)                                                          
{
    for (size_t i = 0; i < count; i++)                                                                                           
        *(volatile uint32_t *)(KTH_BASE_ADDR + KTH_DATA_IN_OFFSET + i * 4) = data[i];
}                                                                                                                                
 
static inline void kth_call(void)                                                                                                
{               
    KTH_REG(KTH_CALL_OFFSET) = 0x1;
}                                                                                                                                
 
static inline void kth_wait_return(void)                                                                                         
{               
    while ((KTH_REG(KTH_RETURN_OFFSET) & 0x1) != 0x1);                                                                                                                        
}
                                                                                                                                 
static inline void kth_read_data_out(uint32_t *buf, size_t count)
{
    for (size_t i = 0; i < count; i++)
        buf[i] = *(volatile uint32_t *)(KTH_BASE_ADDR + KTH_DATA_OUT_OFFSET + i * 4);                                            
}


int main(void)
{
    static const uint32_t insts_cell_00[30] = {
        0xE1000040, 0x81802040, 0xE1000000, 0x81002040,                                                                          
        0xB50E0000, 0xC01C9C00, 0xC014D400, 0xC0191800,
        0xC0216000, 0xC009C800, 0xC00E0C00, 0xC4404000,                                                                          
        0xC3404040, 0xC2404040, 0xC3004040, 0x20005001,
        0x20001005, 0xC2004040, 0x20001000, 0x20022003,                                                                          
        0x20002002, 0x20011002, 0x1000001B, 0xE1000020,
        0x81401040, 0xE1000060, 0x81C01040, 0x2000A001,                                                                          
        0x10000000, 0x00000000
    };                                                                                                                           
                
    static const uint32_t fft_data[24] = {                                                                                       
        0x00000000, 0x001E0000, 0x00110000, 0x000C0000,
        0x000F0000, 0xFFF10000, 0xFFDC0000, 0xFFF20000,                                                                          
        0x00000000, 0x00000000, 0x00180000, 0x00230000,
        0x00010000, 0xFFF00000, 0xFFF50000, 0xFFE80000,                                                                          
        0x01000000, 0x00ECFF9F, 0x00B5FF4B, 0x0061FF14,
        0x0000FF00, 0xFF9FFF14, 0xFF4BFF4B, 0xFF14FF9F                                                                           
    };          
                                                                                                                                 
    static const uint32_t expected_output[16] = {
        0x00120000, 0x0016000D, 0xFFDFFF41, 0x0010FFF8,
        0x0016000A, 0xFFD6FFAE, 0x0001FFF1, 0x0004FFFB,                                                                          
        0x00020000, 0x00040005, 0x0001000F, 0xFFD60052,                                                                          
        0x0016FFF6, 0x00100008, 0xFFDF00BF, 0x0016FFF3                                                                           
    };                                                                                                                           
                
    uint32_t output_data[16];                                                                                                    
                
    ss_init(3);
    kth_set_control(0x0);
    kth_load_instructions(insts_cell_00, 30);                                                                                    
    kth_load_data_in(fft_data, 24);
                                                                                                                                 
    kth_call(); 
    kth_wait_return();
    kth_read_data_out(output_data, 16);                                                                                          
 
    uart_init();                                                                                                                 
                
    int match = 1;
    for (int i = 0; i < 16; i++) {
        if (output_data[i] != expected_output[i]) {
            match = 0;                                                                                                           
            break;
        }                                                                                                                        
    }           
    uart_print(match ? "output_data(Correct)\n" : "output_data(Wrong)\n");

    return 0;
}