# Simulation flow

Currently main testbench is set up for simulatiom flow with Questa simulator. Files to compile are selected by bender commands.

Compile process can be done out-of-tree or in tree, depending on publicity of the target system. `BUILD_DIR` parameter can be used to target the library to build folder of Didactic.

Simulation tools used currently:

* questasim 2024.2

* verilator