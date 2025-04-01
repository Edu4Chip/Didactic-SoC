#!/bin/bash

# Path to the file with issues
# Todo: This is horrible - it should be flexible enough to work with any version of the AXI, but then again, this is a temporary fix until either AXI is fixed in the main repo (unlikely) or have some poor individual or collective maintain the issues here.
# I could restore the old AXI_PATH="$(bender path axi)" instead, but again, it could cause the issue like last time where AXI package was updated and the old "fix" broke it even further.
AXI_FILE=".bender/git/checkouts/axi-aae2d6c181d6f97b/src/axi_lite_mux.sv"

# Throw an error if the file doesn't exist and tell the user to go double check if anything has not been massively over hauled in the ".bender/git/checkouts/axi-[sha256]]/src/axi_lite_mux.sv" file
if [ ! -f "${AXI_FILE}" ]; then
    echo -e "\033[31mError: ${AXI_FILE} does not exist. Please check the path and try again.\033[0m"
    echo -e "\033[35mNote: Please make sure that the AXI package is not massively overhauled, as this script is designed to work with a specific version of the AXI with hash aae2d6c181d6f97b - if it is the same rename the verification/verilator/scripts/do_fix.sh and undo_fix.sh.\033[0m"
    exit 1
fi

# Back up the original file if it doesn't exist already
if [ ! -f "${AXI_FILE}.orig" ]; then
    cp "${AXI_FILE}" "${AXI_FILE}.orig"
    echo "Backed up original ${AXI_FILE} to ${AXI_FILE}.orig"
fi

# Restore from original before applying fixes
if [ -f "${AXI_FILE}.orig" ]; then
    cp "${AXI_FILE}.orig" "${AXI_FILE}"
    echo "Restored original ${AXI_FILE} from backup"
fi

# Add Verilator lint_off directives at the top of the file
sed -i.bak '12i\
/* verilator lint_off SELRANGE */\
/* verilator lint_off WIDTH */\
' "${AXI_FILE}"

echo "Applied lint_off directives to ${AXI_FILE}"

# Find the line where select_t is defined and replace it with a fixed width version
sed -i.bak 's/typedef logic \[$clog2(NoSlvPorts)-1:0\] select_t;/typedef logic [31:0] select_t;/' "${AXI_FILE}"

# Fix B channel section (around line 193-195) - "Mida vittu" but this is the only way to fix the "Illegal bit or array select; type does not have a bit range, or bad dimension: data type is 'logic'"
sed -i.bak 's/(b_select == select_t'\''(i))/(b_select == 32'\''(i))/g' "${AXI_FILE}"

# Fix W channel section
sed -i.bak 's/(w_select == select_t'\''(i))/(w_select == 32'\''(i))/g' "${AXI_FILE}"

# Fix R channel section
sed -i.bak 's/(r_select == select_t'\''(i))/(r_select == 32'\''(i))/g' "${AXI_FILE}"

# Remove backup files created by sed
rm -f "${AXI_FILE}.bak"

echo "Applied fixes to ${AXI_FILE}"