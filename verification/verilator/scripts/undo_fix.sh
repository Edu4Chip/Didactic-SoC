#!/bin/bash

# Path to the file with issues
# Todo: See do_fix.sh Todo
AXI_FILE=".bender/git/checkouts/axi-aae2d6c181d6f97b/src/axi_lite_mux.sv"

# Restore the original file if backup exists
if [ -f "${AXI_FILE}.orig" ]; then
    cp "${AXI_FILE}.orig" "${AXI_FILE}"
    echo "Restored original ${AXI_FILE}"
else
    echo "No backup found for ${AXI_FILE}"
fi