#include <iostream>
#include <memory>
#include <stdio.h>
#include <filesystem>

#define CLKI      clk_internal
#define RSTNI     reset_internal

#define JTAGTCK   jtag_tck_internal
#define JTAGTDI   jtag_tdi_internal
#define JTAGTDO   jtag_tdo_internal
#define JTAGTMS   jtag_tms_internal
#define JTAGTRSTN jtag_trst_internal

#define IDCODE    0x1c0ffee1

#include "TbDidactic.h"

int main(int argc, char** argv) {

  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);

  TbDidactic* tb = new TbDidactic();
  tb->print_logo();

  if (argc == 1) {
    printf("[TB] No TEST specified, exiting..\n\n");
  } else {

    const std::string Elf(argv[1]);

    std::cout << "[TB] Looking for ELF: " << Elf << std::endl;

    std::filesystem::path elfpath = std::string("../build/sw/") + Elf + ".elf";
    bool elfPathExists = std::filesystem::exists(elfpath);
    
    if(!elfPathExists) {
      std::cout << "[TB] ERROR! ELF not found in path " << elfpath << std::endl << std::endl;
    } 
    else {
      std::cout << "[TB] ELF path is " << elfpath << std::endl;

      tb->open_trace("../build/verilator_build/waveform.fst");
      for (int it=0;it<100;it++) tb->tick();

      tb->reset();
      tb->jtag_reset_master();
      tb->jtag_init();

      if (Elf == "memtest") {
        tb->didactic_memtest();
      } else {
        tb->jtag_run_elf(elfpath.string());
        tb->jtag_wait_eoc();
      }
    } 
  }
  delete tb;

  return 0;
}