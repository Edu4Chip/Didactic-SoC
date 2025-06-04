#define PRINT_REGISTERED_MODULES
#include "common.hpp"

int main(int argc, char** argv) {
    const auto context = std::make_unique<Context>();
    context->commandArgs(argc, argv);
    const auto model = std::make_unique<Model>(context.get(), "TOP");
    model->eval();
    model->final();
    return 0;
}
