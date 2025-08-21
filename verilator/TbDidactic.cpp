#include <iostream>
#include <memory>
#include <stdio.h>

#include "TbDidactic.h"

int main(int argc, char** argv) {

  Verilated::commandArgs(argc, argv);

  TbDidactic* tb = new TbDidactic();
  tb->print_logo();

  if (argc == 1) {
    printf("No ELF supplied, exiting..\n\n");
  } else {
    const char* Elf = argv[1];
    printf("ELF: build/sw/%s.elf\n\n", Elf);

    tb->open_trace("../build/verilator_build/waveform.fst");
    for (int it=0;it<100;it++) tb->tick();

  }

  //const std::string TestName = xstr(TEST);
  //const std::string ElfPath  = "./tmp_elf";

  //tb->open_trace("./waveform.fst");
  //for (int it=0;it<100;it++) tb->tick();

  /*if (TestName == "") {
    printf("TEST not set, exiting\n");
  } else {
    tb->reset();
    tb->jtag_reset_master();
    tb->jtag_init();
    if (TestName == "jtag_access") {
      tb->jtag_memory_test();
    } else { // software test
      tb->jtag_elf_run(ElfPath, JTAG_LOAD);
      tb->jtag_wait_eoc();
    }
  }
*/
  delete tb;


  return 0;
}