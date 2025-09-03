#!/bin/bash

patch --strip=1 --directory vendor_ips < verification/verilator/patches/vendor_ips.patch
