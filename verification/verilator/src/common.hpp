// Common functions and objects used by multiple Verilator executables

#ifndef COMMON_H
#define COMMON_H

#include <cassert>
#include <iomanip>
#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <tuple>
#include <vector>

// Model independent includes
#include <svdpi.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

// Model dependent includes
#include "VDidactic.h"
#include "VDidactic__Dpi.h"

// ===========================================
// Functions and objects used with Verilog DPI
// ===========================================

// Key: path to the module, value: clock cycles recorded by the module
std::map<std::string, unsigned int> CYCLE_COUNTS;

// Add module to the cycle counter
void register_module(const char* path_c) {
  std::string path(path_c);
  CYCLE_COUNTS[path] = 0;
}

// Increment module clock cycle count in the cycle counter
void increment_cycle_count(const char* path_c) {
  std::string path(path_c);
  CYCLE_COUNTS[path] += 1;
}

struct SignalPropagationFailure {
  // File path to the module
  std::string path;
  // At what time step the failure happened
  unsigned int time;
  // Name of the first signal
  std::string name1;
  // Name of the second signal
  std::string name2;
  // Value of the first signal at the time step
  int value1;
  // Value of the second signal at the time step
  int value2;
};

std::vector<SignalPropagationFailure> SIGNAL_PROPAGATION_FAILURES;

// Check if the signal value has propagated from first to second signal
void check_signal_propagation(const char* path, double time, const char* name1, int value1, const char* name2, int value2) {
  if (value1 != value2) {
    SignalPropagationFailure spf;
    spf.path = path;
    spf.time = time;
    spf.name1 = name1;
    spf.name2 = name2;
    spf.value1 = value1;
    spf.value2 = value2;
    SIGNAL_PROPAGATION_FAILURES.push_back(spf);
  }
}

struct StatusImem {
  uint32_t err_i;
  uint32_t gnt_i;
  uint32_t rdata_i;
  uint32_t rdata_intg_i;
  uint32_t rvalid_i;
  uint32_t addr_o;
  uint32_t req_o;
};

struct StatusDmem {
  uint32_t err_i;
  uint32_t gnt_i;
  uint32_t rdata_i;
  uint32_t rdata_intg_i;
  uint32_t rvalid_i;
  uint32_t addr_o;
  uint32_t be_o;
  uint32_t req_o;
  uint32_t wdata_intg_o;
  uint32_t wdata_o;
  uint32_t we_o;
};

extern void print_core_state(double time, const uint32_t* status_imem, const uint32_t* status_dmem) {
  std::cout << "[" << time << "] " << __func__ << std::endl;

  // Apparently struct members come in reverse order...
  struct StatusImem* status_imem2 = (struct StatusImem*)status_imem;
  struct StatusImem status_imem3;
  status_imem3.err_i = status_imem2->req_o;
  status_imem3.gnt_i = status_imem2->addr_o;
  status_imem3.rdata_i = status_imem2->rvalid_i;
  status_imem3.rdata_intg_i = status_imem2->rdata_intg_i;
  status_imem3.rvalid_i = status_imem2->rdata_i;
  status_imem3.addr_o = status_imem2->gnt_i;
  status_imem3.req_o = status_imem2->req_o;
  struct StatusDmem* status_dmem2 = (struct StatusDmem*)status_dmem;
  struct StatusDmem status_dmem3;
  status_dmem3.err_i = status_dmem2->we_o;
  status_dmem3.gnt_i = status_dmem2->wdata_o;
  status_dmem3.rdata_i = status_dmem2->wdata_intg_o;
  status_dmem3.rdata_intg_i = status_dmem2->req_o;
  status_dmem3.rvalid_i = status_dmem2->be_o;
  status_dmem3.addr_o = status_dmem2->addr_o;
  status_dmem3.be_o = status_dmem2->rvalid_i;
  status_dmem3.req_o = status_dmem2->rdata_intg_i;
  status_dmem3.wdata_intg_o = status_dmem2->rdata_i;
  status_dmem3.wdata_o = status_dmem2->gnt_i;
  status_dmem3.we_o = status_dmem2->err_i;

  std::cout << "  " << "imem:" << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "err_i: " << status_imem3.err_i << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "gnt_i: " << status_imem3.gnt_i << std::endl;
  std::cout << "  " << "  " << std::right << std::setw(15) << "rdata_i: " << status_imem3.rdata_i << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "rdata_intg_i: " << status_imem3.rdata_intg_i << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "rvalid_i: " << status_imem3.rvalid_i << std::endl;
  std::cout << "  " << "  " << std::right << std::setw(15) << "addr_o: " << "0x" << std::hex << status_imem3.addr_o << std::dec << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "req_o: " << status_imem3.req_o << std::endl;

  std::cout << "  " << "dmem:" << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "err_i: " << status_dmem3.err_i << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "gnt_i: " << status_dmem3.gnt_i << std::endl;
  std::cout << "  " << "  " << std::right << std::setw(15) << "rdata_i: " << status_dmem3.rdata_i << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "rdata_intg_i: " << status_dmem3.rdata_intg_i << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "rvalid_i: " << status_dmem3.rvalid_i << std::endl;
  std::cout << "  " << "  " << std::right << std::setw(15) << "addr_o: " << "0x" << std::hex << status_dmem3.addr_o << std::dec << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "be_o: " << status_dmem3.be_o << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "req_o: " << status_dmem3.req_o << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "wdata_intg_o: " << status_dmem3.wdata_intg_o << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "wdata_o: " << status_dmem3.wdata_o << std::endl;
  // std::cout << "  " << "  " << std::right << std::setw(15) << "we_o: " << status_dmem3.we_o << std::endl;
}

// =============================================
// Functions and objects used in simulation code
// =============================================

using SimulationTime = vluint64_t;
using Context = VerilatedContext;
using ContextPointer = std::unique_ptr<Context>;
using Model = VDidactic;
using ModelPointer = std::unique_ptr<Model>;
using Tracer = VerilatedVcdC;
using TracerPointer = std::unique_ptr<Tracer>;

void toggle_clock(const ModelPointer& model) {
  switch (model->clk_in) {
    case 0:
      model->clk_in = 1;
      break;
    case 1:
      model->clk_in = 0;
      break;
    default:
      // This branch should never happen
      assert(false);
      break;
  }
}

using Task = std::function<void(const ContextPointer&, const ModelPointer&)>;

struct ScheduledTask {
  // At what time step the task is executed. If multiple tasks are scheduled to
  // the same time step, the execution order is not guaranteed to be the order
  // of scheduling
  SimulationTime time;
  Task task;
};

// Add task to a task list
void schedule_task(std::vector<ScheduledTask>& tasks, const SimulationTime time, const Task task) {
  ScheduledTask stask;
  stask.time = time;
  stask.task = task;
  tasks.push_back(stask);
}

void task_initialize(const ContextPointer& context, const ModelPointer& model) {
  std::cout << "[" << context->time() << "] " << __func__ << std::endl;
  model->ana_core_in = 0;
  model->ana_core_out = 0;
  model->boot_sel = 0;
  model->clk_in = 0;
  model->fetch_en = 0;
  model->gpio = 0;
  model->jtag_tck = 0;
  model->jtag_tdi = 0;
  model->jtag_tdo = 0;
  model->jtag_tms = 0;
  model->jtag_trst = 0;
  model->reset = 1;
  model->spi_csn = 0;
  model->spi_data = 0;
  model->spi_sck = 0;
  model->uart_rx = 0;
  model->uart_tx = 0;
}

void task_assert_reset(const ContextPointer& context, const ModelPointer& model) {
  std::cout << "[" << context->time() << "] " << __func__ << std::endl;
  model->reset = 0;
}

void task_deassert_reset(const ContextPointer& context, const ModelPointer& model) {
  std::cout << "[" << context->time() << "] " << __func__ << std::endl;
  model->reset = 1;
}

void task_assert_fetch_enable(const ContextPointer& context, const ModelPointer& model) {
  std::cout << "[" << context->time() << "] " << __func__ << std::endl;
  model->fetch_en = 1;
}

#endif /* COMMON_H */
