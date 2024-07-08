#include <cassert>
#include <fstream>
#include <functional>
#include <iomanip>
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
#include "VDidactic__Dpi.h"
#include "svdpi.h"

#include "common.hpp"

// Simulation time
vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

void task_initialize(const std::shared_ptr<VerilatedContext> &contextp,
                     const std::shared_ptr<VDidactic> &didactic) {
  printf("[%ld] %s\n", contextp->time(), __func__);
  didactic->ana_core_in = 0;
  didactic->ana_core_out = 0;
  didactic->boot_sel = 0;
  didactic->clk_in = 1;
  didactic->fetch_en = 0;
  didactic->gpio = 0;
  didactic->jtag_tck = 0;
  didactic->jtag_tdi = 0;
  didactic->jtag_tdo = 0;
  didactic->jtag_tms = 0;
  didactic->jtag_trst = 0;
  didactic->reset = 1;
  didactic->spi_csn = 0;
  didactic->spi_data = 0;
  didactic->spi_sck = 0;
  didactic->uart_rx = 0;
  didactic->uart_tx = 0;
}

void task_assert_reset(const std::shared_ptr<VerilatedContext> &contextp,
                       const std::shared_ptr<VDidactic> &didactic) {
  printf("[%ld] %s\n", contextp->time(), __func__);
  didactic->reset = 0;
}

void task_deassert_reset(const std::shared_ptr<VerilatedContext> &contextp,
                         const std::shared_ptr<VDidactic> &didactic) {
  printf("[%ld] %s\n", contextp->time(), __func__);
  didactic->reset = 1;
}

void task_assert_fetch_enable(const std::shared_ptr<VerilatedContext> &contextp,
                              const std::shared_ptr<VDidactic> &didactic) {
  printf("[%ld] %s\n", contextp->time(), __func__);
  didactic->fetch_en = 1;
}

using Task = std::function<void(const std::shared_ptr<VerilatedContext> &,
                                const std::shared_ptr<VDidactic> &)>;
struct ScheduledTask {
  uint64_t time;
  Task task;
};

void schedule_task(std::vector<ScheduledTask> &tasks, uint64_t time,
                   Task task) {
  ScheduledTask stask;
  stask.time = time;
  stask.task = task;
  tasks.push_back(stask);
}

int main(int argc, char **argv) {
  std::cout << "hello from " << __FILE__ << std::endl;
  const std::shared_ptr<VerilatedContext> contextp{new VerilatedContext};
  contextp->commandArgs(argc, argv);
  const std::shared_ptr<VDidactic> didactic{
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
  const int maximum_iterations = 1000;
  std::vector<ScheduledTask> scheduled_tasks;
  schedule_task(scheduled_tasks, 2, task_initialize);
  schedule_task(scheduled_tasks, 4, task_assert_reset);
  schedule_task(scheduled_tasks, 6, task_deassert_reset);
  schedule_task(scheduled_tasks, 8, task_assert_fetch_enable);
  for (int i = 0; i < maximum_iterations; i++) {
    for (ScheduledTask task : scheduled_tasks) {
      if (task.time == contextp->time()) {
        task.task(contextp, didactic);
      }
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
  std::cout << "cycle counts:" << std::endl;
  size_t longest_path_length = 0;
  size_t longest_cycle_count = 0;
  for (const auto &t : CYCLE_COUNTS) {
    longest_path_length = std::max(t.first.size(), longest_path_length);
    longest_cycle_count =
        std::max(std::to_string(t.second).size(), longest_cycle_count);
  }
  for (const auto &t : CYCLE_COUNTS) {
    std::cout << "  " << std::setfill(' ') << std::setw(longest_path_length)
              << t.first << ": " << std::setw(longest_cycle_count) << t.second
              << std::endl;
  }
  return 0;
}
