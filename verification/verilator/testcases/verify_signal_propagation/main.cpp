#include <cassert>
#include <iomanip>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

#include "../common.hpp"

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
  const size_t maximum_iterations = 50;
  for (size_t i = 0; i < maximum_iterations; i++) {
    for (auto& task : scheduled_tasks) {
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
  std::map<std::string, std::vector<SignalPropagationFailure>> failures_per_ss;
  for (const auto& spf : SIGNAL_PROPAGATION_FAILURES) {
    if (failures_per_ss.count(spf.path) == 0) {
      failures_per_ss[spf.path] = std::vector<SignalPropagationFailure>();
    }
    failures_per_ss[spf.path].push_back(spf);
  }
  std::cout << SIGNAL_PROPAGATION_FAILURES.size() << " signal propagation failures in " << failures_per_ss.size() << " subsystems:" << std::endl;
  if (0 < failures_per_ss.size()) {
    for (const auto& ti : failures_per_ss) {
      std::cout << "  " << ti.first << ":" << std::endl;
      size_t longest_time_length = 0;
      for (const auto& spf : ti.second) {
        longest_time_length = std::max(longest_time_length, std::to_string(spf.time).size());
      }
      std::map<std::string, std::vector<SignalPropagationFailure>> failures_per_name1;
      for (const auto& spf : ti.second) {
        if (failures_per_name1.count(spf.name1) == 0) {
          failures_per_name1[spf.name1] = std::vector<SignalPropagationFailure>();
        }
        failures_per_name1[spf.name1].push_back(spf);
      }
      for (const auto& tj : failures_per_name1) {
        std::string name2 = tj.second[0].name2;
        std::cout << "  " << "  " << tj.first << " vs. " << name2 << ":" << std::endl;
        for (const auto& f : tj.second) {
          std::cout << "  " << "  " << "  " << "[" << std::setfill(' ') << std::setw(longest_time_length) << f.time << "] " << f.value1 << " " << f.value2 << std::endl;
        }
      }
    }
    return 1;
  } else {
    return 0;
  }
}
