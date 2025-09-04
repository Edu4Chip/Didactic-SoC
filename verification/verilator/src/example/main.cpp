#include "../common.hpp"

int main(int argc, char** argv) {
    auto simulation = Simulation(argc, argv);
    simulation.do_reset(1);
    simulation.do_nothing(100);
    simulation.finish_simulation();
    return 0;
}
