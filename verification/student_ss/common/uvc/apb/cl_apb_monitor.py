"""APB Monitor
- UVM monitor is responsible for capturing signal activity from the design interface and translates it into transaction level data objects that can be sent to other components."""

from pyuvm import *
from cocotb.triggers import RisingEdge
from .cl_apb_seq_item import *
from .apb_common import *

class cl_apb_monitor(uvm_monitor):
    """APB Monitor
    - Capture pin level signal activity
    - Translate it to transactions
    - Broadcasts transactions via analysis port"""

    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Analysis port for broadcasting of collected transactions
        self.ap = None

        # Handle to the configuration object
        self.cfg = None

        # Monitor process
        self.monitor_loop_process = None

        # Clock cycle counter
        self.clk_cyc_cnt = 0

        # Waitstates counter
        self.waitstates = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        # Construct the analysis port
        self.ap = uvm_analysis_port("ap", self)


    async def run_phase(self):
        await super().run_phase()

        cocotb.start_soon(self.cycle_counter())

        cocotb.start_soon(self.handle_reset())
        cocotb.start_soon(self.monitor_transaction())


    async def cycle_counter(self):
        while True:
            await RisingEdge(self.cfg.vif.clk)
            self.clk_cyc_cnt += 1

    async def handle_reset(self):
        while True:
            # is reset goes low, stop active monitor loop
            if self.cfg.vif.rst.value.binstr == '0':
                if self.monitor_loop_process is not None:
                    self.monitor_loop_process.kill()
            await RisingEdge(self.cfg.vif.clk)

    async def monitor_transaction(self):
        while True:
            while self.cfg.vif.rst.value.binstr != '1':
                await RisingEdge(self.cfg.vif.clk)

            # assigning monitor loop process to handle and awaiting it to finish
            self.monitor_loop_process = cocotb.start_soon(self.monitor_loop())
            await self.monitor_loop_process

    async def monitor_loop(self):
        """ Monitor loop & pin wiggling """

        while True:
            item = cl_apb_seq_item.create("item")

            await self.monitor_observe_pins(item)

            self.ap.write(item)
            self.logger.debug(f"Item sent from monitor: {item}")


    async def monitor_observe_pins(self, item):
        self.waitstates = -1

        while self.cfg.vif.enable.value.binstr != '1' or self.cfg.vif.ready.value.binstr != '1':
            if self.cfg.vif.sel.value.binstr == '1' and self.cfg.vif.ready.value.binstr != '1':
                self.waitstates += 1
            await RisingEdge(self.cfg.vif.clk)

        item.wait_len = self.waitstates

        item.addr = self.cfg.vif.addr
        item.slverr = self.cfg.vif.slverr

        if self.cfg.vif.wr.value == OpType.WR:
            item.op = OpType.WR
            item.data = self.cfg.vif.wdata
        elif self.cfg.vif.wr.value == OpType.RD:
            item.op = OpType.RD
            item.data = self.cfg.vif.rdata
        else:
            self.logger.warning("Operation Type not RD or WR")

        await RisingEdge(self.cfg.vif.clk)
