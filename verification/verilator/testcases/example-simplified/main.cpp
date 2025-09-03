#include "../common.hpp"

int main(int argc, char** argv) {
    auto simulator = Simulator(argc, argv);
    for (auto i = 0; i < 10; i++) {
        if (i == 1) {
            simulator.model->reset = 1;
        }
        simulator.model->clk_in = 0;
        simulator.finish_half_cycle();
        simulator.model->clk_in = 1;
        simulator.finish_half_cycle();
    }
    simulator.finish_simulation();
    return 0;
}
