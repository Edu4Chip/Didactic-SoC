#include <iostream>
#include <memory>
#include <stdio.h>

#include "VDidactic.h"
#include "verilated_fst_c.h"
#include "verilated.h"

//class TbDidactic : public Testbench<VDidactic> {};

int main(int argc, char** argv) {

  Verilated::commandArgs(argc, argv);
  printf("Hello!\n");
  //TbDidactic* tb = new TbRtTop();
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
  //delete tb;

  return 0;
}