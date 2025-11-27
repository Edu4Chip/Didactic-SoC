#include "verilated_fst_c.h"
#include "verilated.h"
#include "Vdidactic_vtop.h"
#include "Testbench.h"

#define xstr(s) str(s)
#define str(s) #s

// Add platform-specific overrides in this file
class TbDidactic : public Testbench<Vdidactic_vtop> {

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

        std::filesystem::path resolve_elf(std::string elf_name) {
          std::filesystem::path res = elf_name;
          if (elf_name.size() > 3) {
            if (elf_name.substr(elf_name.size() - 4) != ".elf") {
              res += ".elf";
            } 
          } else {
            res += ".elf";
          }

          if (!std::filesystem::exists(res)) {
            // naive path does not exist, look in build dir
            std::string repo_root = xstr(ROOT);
            std::filesystem::path bd = repo_root + "/build/sw/";
            std::filesystem::path full_path = bd.string() + res.string();
            if (std::filesystem::exists( full_path.string())) {
              res = full_path;
            } else {
              std::cerr << "ELF not found! Looked in:" << std::endl
                        << "1: " << res.string() << std::endl
                        << "2: " << bd.string() + res.string() << std::endl;
              std::exit(EXIT_FAILURE);
            }
          }
          return res;
        }
};
