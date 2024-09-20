#include <cassert>
#include <fstream>
#include <functional>
#include <iostream>
#include <iterator>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "common.hpp"

enum TestBenchState {
  starting,
  assert_reset,
  deassert_reset,
  finished,
  waiting,
};

void task_example(const ContextPointer& context, [[maybe_unused]] const ModelPointer& model) {
  std::cout << "[" << context->time() << "]" << " " << __func__ << std::endl;
}

int main(int argc, char** argv) {
  // Setup Verilator
  const auto context = std::make_unique<Context>();
  context->commandArgs(argc, argv);
  context->debug(0);
  context->randReset(2);
  context->randSeed(12345);
  const auto model = std::make_unique<Model>(context.get(), "DIDACTIC");
#if VM_TRACE
  TracerPointer tracer = nullptr;
  auto flag = Verilated::commandArgsPlusMatch("trace");
  if (flag && strcmp(flag, "+trace") == 0) {
    Verilated::traceEverOn(true);
    tracer = std::make_unique<Tracer>();
    model->trace(tracer.get(), 99);
    Verilated::mkdir("logs");
    tracer->open("logs/vlt_dump.vcd");
  }
#endif

  // Setup example FSM
  TestBenchState tb_state = TestBenchState::starting;
  TestBenchState tb_state_after_waiting = TestBenchState::waiting;
  unsigned int clock_cycles_to_wait = 0;

  // Schedule tasks
  std::vector<ScheduledTask> scheduled_tasks;
  schedule_task(scheduled_tasks, 10, task_example);

  // Run simulation
  const size_t maximum_iterations = 1000;
  for (size_t i = 0; i < maximum_iterations; i++) {
    for (ScheduledTask task : scheduled_tasks) {
      if (task.time == context->time()) {
        task.task(context, model);
      }
    }
    bool stop_iteration = false;
    switch (tb_state) {
      case TestBenchState::starting:
        task_initialize(context, model);
        tb_state = TestBenchState::assert_reset;
        break;
      case TestBenchState::assert_reset:
        task_assert_reset(context, model);
        tb_state = TestBenchState::deassert_reset;
        break;
      case TestBenchState::deassert_reset:
        task_deassert_reset(context, model);
        tb_state = TestBenchState::waiting;
        tb_state_after_waiting = TestBenchState::finished;
        clock_cycles_to_wait = 10;
        break;
      case TestBenchState::finished:
        std::cout << "[" << context->time() << "] " << "finished" << std::endl;
        stop_iteration = true;
        tb_state = TestBenchState::finished;
        break;
      case TestBenchState::waiting:
        if (model->clk_in == 1) {
          // Clock does high-to-low
        } else if (model->clk_in == 0) {
          // Clock does low-to-high
          clock_cycles_to_wait -= 1;
        } else {
          // This branch should never happen
          assert(false);
        }
        if (clock_cycles_to_wait == 0) {
          // Waited enough cycles
          tb_state = tb_state_after_waiting;
        } else {
          // Still waiting
          tb_state = TestBenchState::waiting;
        }
        break;
    }
    // Compute combinatorial logic
    model->eval();
    // Compute sequential logic
    toggle_clock(model);
    model->eval();
#if VM_TRACE
    if (tracer) {
      tracer->dump(context->time());
    }
#endif
    context->timeInc(1);
    if (stop_iteration) {
      break;
    }
  }
#if VM_TRACE
  if (tracer) {
    tracer->dump(context->time());
  }
#endif
  model->final();
#if VM_TRACE
  if (tracer) {
    tracer->close();
  }
#endif
  return 0;
}
