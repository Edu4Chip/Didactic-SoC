####
# Didactic SoC 
# Baremetal controller SW flow makefile
# Contributor(s):
#   -Matti Käyrä (matti.kayra@tuni.fi)
###

TEST_CASE ?= blink
START_TIME=`date +%F_%H:%M`
SHELL = bash
BUILD_DIR ?= ../build

env:
	mkdir -p $(BUILD_DIR)/sw
	echo "prerequisite: local install of RISCV32 toolchain"

build_test:
	riscv32-unknown-elf-gcc -march=rv32imc -mabi=ilp32 -D__riscv__ -O3 -ffunction-sections -fdata-sections -c -g $(TEST_CASE)/$(TEST_CASE).c -lm -lgcc -static -o $(BUILD_DIR)/sw/test.o

link_test:
	riscv32-unknown-elf-gcc -march=rv32imc -mabi=ilp32 -Tcommon/link.ld -nostartfiles $(BUILD_DIR)/sw/test.o -o $(BUILD_DIR)/sw/test.elf

test: env build_test link_test