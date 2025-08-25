#include "verilated_fst_c.h"
#include "verilated.h"
#include "VSysCtrl_SS_0.h"
#include "Testbench.h"

// Add platform-specific overrides in this file
class TbDidactic : public Testbench<VSysCtrl_SS_0> {

    public:

        void print_logo(void) {
            printf("    ___ _     _            _   _        _____          _   _                     _     \n");  
            printf("   /   (_) __| | __ _  ___| |_(_) ___  /__   \\___  ___| |_| |__   ___ _ __   ___| |__  \n");
            printf("  / /\\ / |/ _` |/ _` |/ __| __| |/ __|   / /\\/ _ \\/ __| __| '_ \\ / _ \\ '_ \\ / __| '_ \\ \n");
            printf(" / /_//| | (_| | (_| | (__| |_| | (__   / / |  __/\\__ \\ |_| |_) |  __/ | | | (__| | | |\n");
            printf("/___,' |_|\\__,_|\\__,_|\\___|\\__|_|\\___|  \\/   \\___||___/\\__|_.__/ \\___|_| |_|\\___|_| |_|\n");
            printf("///////////////////////////////////////////////////////////////////////////////////////\n");
            printf("\n");
        }

        void jtag_init (void) {
            printf("[JTAG] Perform init \t-\t time %ld\n", m_tickcount);
            const uint32_t IdCodeInstr = 0b11111;
            const uint32_t IdCode      = 0x1c0ffee1;
            const uint8_t  SbcsAddr    = 0x38;
            const uint32_t SbcsData    = 0x58000;
            
            for (int i=0;i<10;i++) jtag_tick();
            uint32_t idcode = get_idcode(IdCodeInstr);
            if (idcode != IdCode) {
                printf("[JTAG] idcode ERROR: read %x, expected %x\n", idcode, IdCode);
                return;
            }
            else { printf("[JTAG] idcode %x OK\n", idcode);}

            // Activate, wait for debug module
            const uint8_t  DMControlAddr = 0x10;
            uint32_t       DMControlData = 0;
            DMControlData               |= 0x1; // set dmactive [bit 0]
            jtag_write(DMControlAddr, DMControlData);

            uint32_t dmcontrol = 0; 
            bool  dmcontrol_active = 0;
            do{
                dmcontrol = jtag_read_dmi_exp_backoff(DMControlAddr);
                dmcontrol_active = dmcontrol & 0x1;
            }while(!dmcontrol_active);
        
            jtag_write(SbcsAddr, SbcsData, 0, 1);
            printf("[JTAG] init OK      \t-\t time %ld\n", m_tickcount);
        }

        bool readback_test (uint32_t addr, uint32_t data){
            bool is_ok = true;
            uint32_t ref_data  = data;
            jtag_mm_write(addr, ref_data, 20, false);
            uint32_t read_data = jtag_mm_read(addr);
            if (ref_data != read_data){
                printf("Readback ERROR! Wrote: %x, read: %x \n", ref_data, read_data);
                is_ok = false;
            }
            return is_ok;
        }

        void didactic_memtest () {

            printf("[TB] Running JTAG memory access test\n");
            printf("[JTAG] Test IMEM base address (0x0100_0000) access: ");
            if(readback_test(0x1000000, 0xDEADBEEF)){
                printf("OK\n");
            }

            printf("[JTAG] Test DMEM base address (0x0101_0000) access: ");
            if(readback_test(0x01010000, 0xBADC0FFE)){
                printf("OK\n");
            }
            
            printf("[JTAG] Test Debug base address (0x0102_0000) access: ");
            if(readback_test(0x01012000, 0xFEEDC0DE)){
                printf("OK\n");
            }
            printf("[JTAG] Test Staff Peripherals base address (0x0103_0000) access: ");
            if(readback_test(0x01013000, 0xBABEBABE)){
                printf("OK\n");
            }
            printf("[JTAG] Test Control Registers base address (0x0104_0000) access: ");
            if(readback_test(0x01013000, 0xFEEDBEEF)){
                printf("OK\n");
            }

            printf("[TB] JTAG test done\n");

        }

};