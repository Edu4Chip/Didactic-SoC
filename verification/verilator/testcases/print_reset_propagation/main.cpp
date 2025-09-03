#include <cassert>
#include <fstream>
#include <functional>
#include <iostream>
#include <iterator>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "../common.hpp"

#include <verilated_syms.h>

#define TOP_MODULE_NAME "TOP"

const size_t CYCLES_LOW = 5;
const size_t CYCLES_HIGH = 5;

const std::map<std::string, std::string> RESET_NAME_PER_MODULE = {
  {TOP_MODULE_NAME ".Didactic", "reset"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS", "reset"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS", "reset_internal"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS.ctrl_reg_array", "reset_n"},
  // TODO
  //{TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS.i_ibex_wrapper.Ibex_Core.u_ibex_top.u_ibex_core.if_stage_i", "reset"},
  //{TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS.i_ibex_wrapper.Ibex_Core.u_ibex_tracer", "reset"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS.jtag_dbg_wrapper", "rstn_i"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS.peripherals_obi_to_apb", "reset_n"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS.SysCtrl_SS.sysctrl_obi_xbar", "reset_n"},
  {TOP_MODULE_NAME ".Didactic.SystemControl_SS.i_io_cell_frame", "reset"},
  // TODO
  //{TOP_MODULE_NAME ".Didactic.SystemControl_SS.i_io_cell_frame.unnamedblk1", "reset"},
  // Has no reset
  //{TOP_MODULE_NAME ".Didactic.SystemControl_SS.i_pmod_mux", "reset"},
  // TODO
  //{TOP_MODULE_NAME ".Didactic.SystemControl_SS.unnamedblk1", "reset"},
  {TOP_MODULE_NAME ".Didactic.analog_wrapper_0", "reset_int"},
  // Has no reset
  //{TOP_MODULE_NAME ".Didactic.analog_wrapper_0.analog_ss", "reset"},
  {TOP_MODULE_NAME ".Didactic.analog_wrapper_0.analog_status_array", "reset_n"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu", "reset"},
  // Has no reset
  //{TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.apbMux", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.arb", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.dmem", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.dmem.m", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.dmemMux", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.gpio", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.instrMem", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.instrMem.m", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.leros", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.leros.alu", "reset"},
  // Has no reset
  //{TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.leros.dec", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.ponte", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.ponte.ponteDecoder", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.ponte.ponteDecoder.dec", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.ponte.uartRx", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.ponte.uartTx", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.regBlock", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.rom", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.sysCtrl", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart.rx", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart.rx.buf_0", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart.rx.rx", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart.tx", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart.tx.buf_0", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_dtu_ss_wrapper.i_dtu_ss.dtu.uart.tx.tx", "reset"},
  {TOP_MODULE_NAME ".Didactic.i_imt_ss_wrapper", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_imt_ss_wrapper.Student_SS_3", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_kth_ss_wrapper", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_kth_ss_wrapper.Student_SS_3", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_obi_icn_ss", "reset_n"},
  {TOP_MODULE_NAME ".Didactic.i_tum_ss_warpper", "reset_int"},
  {TOP_MODULE_NAME ".Didactic.i_tum_ss_warpper.Student_SS_3", "reset_int"},
  // TODO
  //{TOP_MODULE_NAME ".Didactic.unnamedblk1", "reset"},
};

svBit read_reset_value_from_scope(const std::string& scope_name, const ModelPointer& model) {
  const svScope scope = svGetScopeFromName(scope_name.c_str());
  assert(scope);
  svSetScope(scope);
  svBit value;
  auto reset_name = RESET_NAME_PER_MODULE.at(scope_name);
  if (reset_name == "reset") {
    model->read_reset(&value);
  } else if (reset_name == "reset_icn") {
    model->read_reset_icn(&value);
  } else if (reset_name == "reset_int") {
    model->read_reset_int(&value);
  } else if (reset_name == "reset_internal") {
    model->read_reset_internal(&value);
  } else if (reset_name == "reset_n") {
    model->read_reset_n(&value);
  } else if (reset_name == "reset_ss") {
    model->read_reset_ss(&value);
  } else if (reset_name == "rstn_i") {
    model->read_rstn_i(&value);
  }  
  return value;
}

// Key:   module name
// Value: reset value
typedef std::map<std::string, svBit> ModuleResetValues;

ModuleResetValues get_reset_values(const ModelPointer& model) {
  ModuleResetValues values;
  for (auto it = RESET_NAME_PER_MODULE.cbegin(); it != RESET_NAME_PER_MODULE.cend(); it++) {
    auto value = read_reset_value_from_scope(it->first, model);
    values[it->first] = value;
  }
  return values;
}

void finish_half_cycle(
  const ContextPointer& context,
  const ModelPointer& model,
  const TracerPointer& tracer
) {
  model->eval();
#if VM_TRACE
  if (tracer) {
    tracer->dump(context->time());
  }
#endif
  context->timeInc(1);
}

class ModuleResetValuesRecord {
  std::map<std::string, std::vector<std::string>> module_reset_values;
  std::vector<std::string> module_names; // TODO: is even needed?
  std::vector<std::string> clock_values;
  std::vector<std::string> reset_values;
public:
  ModuleResetValuesRecord(const std::vector<std::string>& names) {
    for (const auto& name : names) {
      this->module_reset_values[name] = std::vector<std::string>();
      this->module_names.push_back(name);
    }
  }
  void add_to_record(const std::string& name, const std::string& value) {
    // TODO: is value copied or just the reference???
    this->module_reset_values[name].push_back(value);
  }
  void record_reset_value(const std::string& name, const svBit& value) {
    this->add_to_record(name, std::to_string(value));
  }
  void record_reset_values(const ModuleResetValues& values) {
    for (auto it = values.cbegin(); it != values.cend(); it++) {
      this->record_reset_value(it->first, it->second);
    }
  }
  void record_cycle_end(const std::string& name) {
    this->add_to_record(name, ".");
  }
  void record_cycle_ends() {
    for (const auto& name : this->module_names) {
      this->record_cycle_end(name);
    }
  }
  void record_clock_value(const CData& value) {
    this->clock_values.push_back(std::to_string(value));
  }
  void record_clock_cycle_end() {
    this->clock_values.push_back(".");
  }
  void record_top_reset_value(const CData& value) {
    this->reset_values.push_back(std::to_string(value));
  }
  void record_top_cycle_end() {
    this->reset_values.push_back(".");
  }
  void print() {
    // Print top input clock values over time
    for (const auto& value : this->clock_values) {
      std::cout << value;
    }
    std::cout << " " << "clock" << std::endl;

    // Print top input reset values over time
    for (const auto& value : this->reset_values) {
      std::cout << value;
    }
    std::cout << " " << "reset" << std::endl;
    
    // Print reset values over time per module
    // Print initial state first, then state each half cycle, separated by cycles
    for (const auto& pair : this->module_reset_values) {
      for (const auto& value : pair.second) {
        std::cout << value;
      }
      std::cout << " " << pair.first << std::endl;
    }
  }
};

int main(int argc, char** argv) {
  // Setup Verilator
  const auto context = std::make_unique<Context>();
  context->commandArgs(argc, argv);
  context->debug(0);
  context->randReset(2);
  context->randSeed(12345);
  const auto model = std::make_unique<Model>(context.get(), TOP_MODULE_NAME);
  TracerPointer tracer = nullptr;
#if VM_TRACE
  auto flag = Verilated::commandArgsPlusMatch("trace");
  if (flag && strcmp(flag, "+trace") == 0) {
    Verilated::traceEverOn(true);
    tracer = std::make_unique<Tracer>();
    model->trace(tracer.get(), 99);
    Verilated::mkdir("logs");
    tracer->open("logs/vlt_dump.vcd");
  }
#endif
  // Run simulation

  auto module_names = std::vector<std::string>();
  for (const auto& pair : RESET_NAME_PER_MODULE) {
    module_names.push_back(pair.first);
  }

  auto record = ModuleResetValuesRecord(module_names);

  {
    // Record initial reset values
    auto values = get_reset_values(model);
    record.record_reset_values(values);
  }
  record.record_clock_value(model->clk_in);
  record.record_top_reset_value(model->reset);
  
  record.record_cycle_ends();
  record.record_clock_cycle_end();
  record.record_top_cycle_end();

  // Keep reset low for given cycles
  for (auto i = 0; i < CYCLES_LOW; i++) {
    model->clk_in = 0;
    model->reset = 0;
    finish_half_cycle(context, model, tracer);

    {
      auto values = get_reset_values(model);
      record.record_reset_values(values);
    }
    record.record_clock_value(model->clk_in);
    record.record_top_reset_value(model->reset);

    model->clk_in = 1;
    model->reset = 0;
    finish_half_cycle(context, model, tracer);

    {
      auto values = get_reset_values(model);
      record.record_reset_values(values);
    }
    record.record_clock_value(model->clk_in);
    record.record_top_reset_value(model->reset);
    
    record.record_cycle_ends();
    record.record_clock_cycle_end();
    record.record_top_cycle_end();
  }

  // Keep reset high for given cycles
  for (auto i = 0; i < CYCLES_HIGH; i++) {
    model->clk_in = 0;
    model->reset = 1;
    finish_half_cycle(context, model, tracer);

    {
      auto values = get_reset_values(model);
      record.record_reset_values(values);
    }
    record.record_clock_value(model->clk_in);
    record.record_top_reset_value(model->reset);

    model->clk_in = 1;
    model->reset = 1;
    finish_half_cycle(context, model, tracer);

    {
      auto values = get_reset_values(model);
      record.record_reset_values(values);
    }
    record.record_clock_value(model->clk_in);
    record.record_top_reset_value(model->reset);

    record.record_cycle_ends();
    record.record_clock_cycle_end();
    record.record_top_cycle_end();
  }

  {
    auto values = get_reset_values(model);
    record.record_reset_values(values);
  }
  record.record_clock_value(model->clk_in);
  record.record_top_reset_value(model->reset);

  record.print();

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
