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

  TbDidactic* tb = new TbDidactic();
  tb->print_logo();

  if (argc == 1) {
    printf("[TB] No TEST specified, exiting..\n\n");
    std::exit(EXIT_SUCCESS);
  } 
  
  const std::string TracePath = std::string(xstr(ROOT)) + "/build/verilator_build/waveform.fst";
  std::cout << "[TB] Waveform path: " << TracePath << std::endl;
  tb->open_trace(TracePath.c_str());
  // this tb assumes only one passed argument: the ELF
  const std::string elfname(argv[1]);
  std::filesystem::path elfpath = tb->resolve_elf(elfname);

  tb->reset();
  tb->jtag_reset_master();
  tb->jtag_init();

  tb->jtag_halt_hart();
  std::cout << "[TB] Running preloaded program from entry point in "
            << elfpath.string()
            << std::endl;
  tb->jtag_resume_hart_from(tb->get_entry(elfpath.string()));
  tb->jtag_wait_eoc();

  delete tb;

  return 0;
}
