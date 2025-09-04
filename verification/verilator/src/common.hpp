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

using SimulationTime = vluint64_t;
using Context = VerilatedContext;
using ContextPointer = std::unique_ptr<Context>;
using Model = VDidactic;
using ModelPointer = std::unique_ptr<Model>;
using Tracer = VerilatedVcdC;
using TracerPointer = std::unique_ptr<Tracer>;

class Simulation {
public:
  ContextPointer context;
  ModelPointer model;
  TracerPointer tracer;
  Simulation(int argc, char** argv) {
    this->context = std::make_unique<Context>();
    this->context->commandArgs(argc, argv);
    this->context->debug(0);
    this->context->randReset(2);
    this->context->randSeed(12345);
    this->model = std::make_unique<Model>(this->context.get(), "TOP");
    this->tracer = nullptr;
#ifdef VM_TRACE
    auto flag = Verilated::commandArgsPlusMatch("trace");
    if (flag && strcmp(flag, "+trace") == 0) {
      Verilated::traceEverOn(true);
      this->tracer = std::make_unique<Tracer>();
      this->model->trace(this->tracer.get(), 99);
      Verilated::mkdir("logs");
      this->tracer->open("logs/vlt_dump.vcd");
    }
#endif
  }
  void record_signals() {
#ifdef VM_TRACE
    if (this->tracer) {
      this->tracer->dump(this->context->time());
    }
#endif
  }
  void finish_half_cycle() {
    this->model->eval();
    this->record_signals();
    this->context->timeInc(1);
  }
  void finish_simulation() {
    this->record_signals();
    this->model->final();
#ifdef VM_TRACE
    if (this->tracer) {
      this->tracer->close();
    }
#endif
  }
  void do_nothing(uint32_t cycles) {
    for (auto i = 0; i < cycles; i++) {
      this->model->clk_in = 0;
      this->finish_half_cycle();
      this->model->clk_in = 1;
      this->finish_half_cycle();
    }
  }
  void do_reset(uint32_t cycles) {
    this->model->reset = 0;
    this->do_nothing(cycles);
    this->model->reset = 1;
  }
};

#endif /* COMMON_H */
