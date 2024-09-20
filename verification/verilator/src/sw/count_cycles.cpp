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

#include "common.hpp"

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

  // Schedule tasks
  std::vector<ScheduledTask> scheduled_tasks;
  schedule_task(scheduled_tasks, 2, task_initialize);
  schedule_task(scheduled_tasks, 4, task_assert_reset);
  schedule_task(scheduled_tasks, 6, task_deassert_reset);

  // Run simulation
  const size_t maximum_iterations = 1000;
  for (size_t i = 0; i < maximum_iterations; i++) {
    for (ScheduledTask task : scheduled_tasks) {
      if (task.time == context->time()) {
        task.task(context, model);
      }
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

  // Report results
  std::cout << "cycle counts:" << std::endl;
  size_t longest_path_length = 0;
  size_t longest_cycle_count = 0;
  for (const auto& t : CYCLE_COUNTS) {
    longest_path_length = std::max(t.first.size(), longest_path_length);
    longest_cycle_count = std::max(std::to_string(t.second).size(), longest_cycle_count);
  }
  for (const auto& t : CYCLE_COUNTS) {
    std::cout << "  " << std::setfill(' ') << std::setw(longest_path_length) << t.first << ": " << std::setw(longest_cycle_count) << t.second << std::endl;
  }
  return 0;
}
