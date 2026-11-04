####
# Didactic SoC 
# Baremetal controller SW flow makefile
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
###

TESTCASE ?= blinky
START_TIME=`date +%F_%H:%M`
SHELL = bash
BUILD_DIR ?= ../../build/fpga
CC=riscv32-unknown-elf-gcc
CFLAGS=-mabi=ilp32 -O0 -g -ffunction-sections -fdata-sections -Icommon/

test: env build_test

env:
	mkdir -p $(BUILD_DIR)/sw

build_test:
	$(CC) -march=rv32imc -D__riscv__ $(CFLAGS) -c $(TESTCASE)/$(TESTCASE).c -o $(BUILD_DIR)/sw/$(TESTCASE).o 
	$(CC) -march=rv32imc -D__riscv__ $(CFLAGS) -DLANGUAGE_ASSEBMLY -c common/crt0.S -o $(BUILD_DIR)/sw/crt0.o
	$(CC) -march=rv32imc -Tcommon/link.ld $(BUILD_DIR)/sw/$(TESTCASE).o $(BUILD_DIR)/sw/crt0.o -nostartfiles -nostdlib -Wl,--gc-sections -o $(BUILD_DIR)/sw/$(TESTCASE).elf

