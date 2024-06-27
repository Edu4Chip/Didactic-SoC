#include <cassert>
#include <fstream>
#include <iostream>
#include <iterator>
#include <memory>
#include <sstream>
#include <string>
#include <vector>
#include <verilated.h>
#if VM_TRACE
#include <verilated_vcd_c.h>
#endif

#include "VDidactic.h"

// Simulation time
vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

enum TestBenchState {
  starting,
  assert_reset,
  deassert_reset,
  assert_fetch_enable,
  finished,
  waiting,
};

int main(int argc, char **argv) {
  std::cout << "hello from " << __FILE__ << std::endl;
  const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
  contextp->commandArgs(argc, argv);
  const std::unique_ptr<VDidactic> didactic{
      new VDidactic{contextp.get(), "DIDACTIC"}};
#if VM_TRACE
  VerilatedVcdC *tfp = NULL;
  const char *flag = Verilated::commandArgsPlusMatch("trace");
  if (flag && 0 == strcmp(flag, "+trace")) {
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    didactic->trace(tfp, 99);
    Verilated::mkdir("logs");
    tfp->open("logs/vlt_dump.vcd");
  }
#endif
  TestBenchState tb_state = TestBenchState::starting;
  const int maximum_iterations = 1000;
  TestBenchState tb_state_after_waiting = TestBenchState::waiting;
  int clock_cycles_to_wait = 0;
  for (int i = 0; i < maximum_iterations; i++) {
    bool stop_iteration = false;
    switch (tb_state) {
    case TestBenchState::starting:
      printf("[%ld] initialize inputs\n", contextp->time());
      didactic->boot_sel = 0;
      didactic->clk_in = 1;
      didactic->fetch_en = 0;
      didactic->gpio = 0;
      didactic->jtag_tck = 0;
      didactic->jtag_tdi = 0;
      didactic->jtag_tdo = 0;
      didactic->jtag_tms = 0;
      didactic->jtag_trst = 0;
      // Apparently reset is inverted
      didactic->reset = 1;
      didactic->spi_csn = 0;
      didactic->spi_data = 0;
      didactic->spi_sck = 0;
      didactic->uart_rx = 0;
      didactic->uart_tx = 0;
      didactic->ana_core_in = 0;
      didactic->ana_core_out = 0;
      tb_state = TestBenchState::assert_reset;
      break;
    case TestBenchState::assert_reset:
      printf("[%ld] assert reset\n", contextp->time());
      didactic->reset = 0;
      tb_state = TestBenchState::deassert_reset;
      break;
    case TestBenchState::deassert_reset:
      printf("[%ld] deassert reset\n", contextp->time());
      didactic->reset = 1;
      tb_state = TestBenchState::assert_fetch_enable;
      break;
    case TestBenchState::assert_fetch_enable:
      printf("[%ld] assert fetch_enable\n", contextp->time());
      didactic->fetch_en = 1;
      tb_state = TestBenchState::waiting;
      tb_state_after_waiting = TestBenchState::finished;
      clock_cycles_to_wait = 10;
      break;
    case TestBenchState::finished:
      printf("[%ld] finished\n", contextp->time());
      stop_iteration = true;
      tb_state = TestBenchState::finished;
      break;
    case TestBenchState::waiting:
      if (didactic->clk_in == 1) {
        // Clock does high-to-low
      } else if (didactic->clk_in == 0) {
        // Clock does low-to-high
        clock_cycles_to_wait -= 1;
      } else {
        // This branch should never happen
        assert(false);
      }
      if (clock_cycles_to_wait == 0) {
        // Waited enough cycles
        tb_state = tb_state_after_waiting;
        printf("[%ld] waiting done\n", contextp->time());
      } else if (0 < clock_cycles_to_wait) {
        // Still waiting
        tb_state = TestBenchState::waiting;
        // printf("[%ld] waiting %i more cycles\n", contextp->time(),
        // clock_cycles_to_wait);
      } else {
        // This branch should never happen
        assert(false);
      }
      break;
    }
    main_time++;
    switch (didactic->clk_in) {
    case 0:
      didactic->clk_in = 1;
      break;
    case 1:
      didactic->clk_in = 0;
      break;
    default:
      // This branch should never happen
      assert(false);
      break;
    }
    didactic->eval();
#if VM_TRACE
    if (tfp) {
      tfp->dump(main_time);
    }
#endif
    if (stop_iteration) {
      break;
    }
  }
#if VM_TRACE
  if (tfp) {
    tfp->dump(main_time);
  }
#endif
  didactic->final();
#if VM_TRACE
  if (tfp) {
    tfp->close();
    tfp = NULL;
  }
#endif
  return 0;
}
