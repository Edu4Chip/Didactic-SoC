#!/bin/bash

# Determine the path to the AXI directory
AXI_PATH=$(bender path axi)
AXI_FILE="${AXI_PATH}/src/axi_lite_mux.sv"

# Check if the AXI file exists
if [ ! -f "${AXI_FILE}" ]; then
    echo -e "\033[31mError: ${AXI_FILE} does not exist. Please check the path and try again.\033[0m"
    exit 1
fi


# Restore the original file if backup exists
if [ -f "${AXI_FILE}.orig" ]; then
    cp "${AXI_FILE}.orig" "${AXI_FILE}"
    echo "Restored original ${AXI_FILE}"
else
    echo "No backup found for ${AXI_FILE}"
fi

# Check if the file has changed by comparing checksums, again - to ensure that file is actually restored
KNOWN_CHECKSUM="d97f7e8c938da8ce7477e36d0cae0e60"  # Replace with the actual checksum of the known compatible version
CURRENT_CHECKSUM=$(md5sum "${AXI_FILE}" | awk '{ print $1 }')

# To future maintainers: please update the KNOWN_CHECKSUM variable with the checksum of the original file by running:
# md5sum .bender/git/checkouts/axi-[SHA256]/src/axi_lite_mux.sv;

if [ "${CURRENT_CHECKSUM}" != "${KNOWN_CHECKSUM}" ]; then
    echo -e "\033[31mError: ${AXI_FILE} has changed. The undo fix may not be compatible with this version.\033[0m"
    exit 1
fi