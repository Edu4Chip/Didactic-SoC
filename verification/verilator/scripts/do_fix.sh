#!/bin/bash

# Determine the path to the AXI directory
AXI_PATH=$(bender path axi)
AXI_FILE="${AXI_PATH}/src/axi_lite_mux.sv"

# Check if the AXI file exists
if [ ! -f "${AXI_FILE}" ]; then
    echo -e "\033[31mError: ${AXI_FILE} does not exist. Please check the path and try again.\033[0m"
    exit 1
fi

# Check if the file has changed by comparing MD5 checksums - this is way to check if the fix is compatible with the current version
KNOWN_CHECKSUM="d97f7e8c938da8ce7477e36d0cae0e60"  # Replace with the actual checksum of the known compatible version
CURRENT_CHECKSUM=$(md5sum "${AXI_FILE}" | awk '{ print $1 }')

# To future maintainers: please update the KNOWN_CHECKSUM variable with the checksum of the original file by running:
# md5sum .bender/git/checkouts/axi-[SHA256]/src/axi_lite_mux.sv;

if [ "${CURRENT_CHECKSUM}" != "${KNOWN_CHECKSUM}" ]; then
    echo -e "\033[31mError: ${AXI_FILE} has changed. The fix may not be compatible with this version.\033[0m"
    echo -e "\033[31mPlease ensure the fix is still compatible and if so update the KNOWN_CHECKSUM variable in the script.\033[0m"
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