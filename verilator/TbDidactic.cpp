#include <iostream>
#include <memory>
#include <stdio.h>
#include <filesystem>

#define CLKI      clk_i
#define RSTNI     rst_ni

#define JTAGTCK   jtag_tck_i
#define JTAGTDI   jtag_td_i
#define JTAGTDO   jtag_td_o
#define JTAGTMS   jtag_tms_i
#define JTAGTRSTN jtag_trst_ni

#define IDCODE    0x1c0ffee1

#include "TbDidactic.h"

int main(int argc, char** argv) {

  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);

  TbDidactic* tb = new TbDidactic();
  tb->print_logo();

  if (argc == 1) {
    printf("[TB] No TEST specified, exiting..\n\n");
    std::exit(EXIT_SUCCESS);
  } 
  
  // this tb assumes only one passed argument: the ELF
  const std::string elfname(argv[1]);
  std::filesystem::path elfpath = tb->resolve_elf(elfname);

  tb->open_trace("../build/verilator_build/waveform.fst");

  tb->reset();
  tb->jtag_reset_master();
  tb->jtag_init();

    
  delete tb;

  return 0;
}
