
from pyuvm import *
from cocotb.triggers import RisingEdge, FallingEdge, ReadOnly

class cl_student_tb_assertions():
    def __init__(self, clk_signal, rst_signal):
        self.clk = clk_signal
        self.rst = rst_signal

        self.irq = None
        self.irq_en = None
        self.ss_ctrl = None

        self.passed = True

    def connect(self, irq_signal, irq_en_signal, ss_ctrl_signal):
            self.irq        = irq_signal
            self.irq_en     = irq_en_signal
            self.ss_ctrl    = ss_ctrl_signal

            assert self.clk is not None
            assert self.rst is not None
            assert self.irq is not None
            assert self.irq_en is not None
            assert self.ss_ctrl is not None

    async def check_assertions(self):
        while True:
            while self.rst.value == 0:
                await RisingEdge(self.clk)

            as_irq_enable = cocotb.start_soon(self.irq_enable())
            as_irq_pulse = cocotb.start_soon(self.irq_pulse())

            # detecting asynchronous reset and kill assertions
            await FallingEdge(self.rst)
            as_irq_enable.kill()
            as_irq_pulse.kill()

    async def irq_enable(self):
        while True:
            try:
                if self.irq_en.value == 0:
                    assert self.irq.value == 0, f"If IRQ_en = 0 then IRQ can only be 0"

                if self.irq.value == 1:
                    assert self.irq_en.value == 1, f"IRQ can only be 1 when IRQ_en = 1"
            except AssertionError as msg:
                self.passed = False
                print(msg)

            # Wait 1 clk cycle
            await RisingEdge(self.clk)
            await ReadOnly()

    async def irq_pulse(self):
        while True:
            try:
                if self.irq.value == 1:
                    await RisingEdge(self.clk)
                    await ReadOnly()
                    assert self.irq.value == 0, "If IRQ is high, then it must be low at the following clock edge"
            except AssertionError as msg:
                self.passed = False
                print(msg)

            # Wait 1 clk cycle
            await RisingEdge(self.clk)
            await ReadOnly()
