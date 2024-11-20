#!/bin/bash

AXI_PATH=$(bender path axi)

# Remove changes
sed -i '125d;128d;129d;130d;131d;132d' $AXI_PATH/src/axi_lite_mux.sv
