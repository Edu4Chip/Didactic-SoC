#include "verilated_fst_c.h"
#include "verilated.h"
#include "VDidactic.h"
#include "Testbench.h"

// Add platform-specific overrides in this file
class TbDidactic : public Testbench<VDidactic> {

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

};