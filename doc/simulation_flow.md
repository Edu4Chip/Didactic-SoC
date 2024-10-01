# Simulation flow

Currently main testbench is set up for simulatiom flow with Questa simulator. Running the sim picks compiled libraries as separate units and combines the libraries for hierachical SoC.

Student libraries can be inserted to either (src/sv-files.list)[../src/sv-files.list] or they can be compiled as their own separate library. Latter is preferable as it logically separates the IPs from each other.

Compile process can be done out-of-tree or in tree, depending on publicity of the target system. `BUILD_DIR` parameter can be used to target the library to build folder of Didactic.

Tools used currently:

* questasim 2024.2