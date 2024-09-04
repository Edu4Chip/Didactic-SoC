####
# Didactic SoC 
# sw flow makefile
# 
###

TEST_CASE ?= blink
START_TIME=`date +%F_%H:%M`
SHELL = bash
BUILD_DIR ?= ../build



build_test:
	riscv32-unknown-elf-gcc -march=rv32imc -D__riscv__ -O3 $(TEST_CASE)/$(TEST_CASE).c -lm -lgcc -static -c