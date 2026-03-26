from pyuvm import *

from cocotb.triggers import RisingEdge, FallingEdge, ReadOnly

from .cl_gbus_item import cl_gbus_monitor_item
from .gbus_common import ResetType

class cl_gbus_monitor(uvm_monitor):
    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Configuration handle
        self.cfg = None

        # Analysis port for broadcasting of collected transactions
        self.ap = None

        # Monitor process
        self.monitor_loop_process = None

        # Previous bus value
        self.previous_value = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        # Construct the analysis port
        self.ap = uvm_analysis_port("ap", self)

    async def run_phase(self):
        await super().run_phase()

        cocotb.start_soon(self.handle_reset())
        cocotb.start_soon(self.monitor_transaction())

    async def handle_reset(self):
        while True:
            if self.cfg.reset_polarity == ResetType.ACTIVE_HIGH:
                await RisingEdge(self.cfg.vif.rst)
            elif self.cfg.reset_polarity == ResetType.ACTIVE_LOW:
                await FallingEdge(self.cfg.vif.rst)
            else:
                raise UVMFatalError(
                    f"GBUS DRIVER, reset polarity not set in cfg, {self.get_full_name()}")

            if self.monitor_loop_process is not None:
                    self.monitor_loop_process.kill()

    async def monitor_transaction(self):
        while True:
            if self.cfg.reset_polarity == ResetType.ACTIVE_HIGH:
                await FallingEdge(self.cfg.vif.rst)
            elif self.cfg.reset_polarity == ResetType.ACTIVE_LOW:
                await RisingEdge(self.cfg.vif.rst)
            else:
                raise UVMFatalError(
                    f"GBUS DRIVER, reset polarity not set in cfg, {self.get_full_name()}")

            # assigning monitor loop process to handle and awaiting it to finish
            self.monitor_loop_process = cocotb.start_soon(self.monitor_loop())
            await self.monitor_loop_process

    async def monitor_loop(self):
        """ Monitor loop & pin observing """

        item = None

        while True:
            await RisingEdge(self.cfg.vif.clk)
            await ReadOnly()

            # detect changes in bus value and create monitor item
            if self.previous_value != self.cfg.vif.bus.value:
                self.previous_value = self.cfg.vif.bus.value

                item = cl_gbus_monitor_item.create("gbus_monitor_item")
                item.value = self.cfg.vif.bus.value

                self.ap.write(item)
                self.logger.debug(f"Item sent from monitor: {item}")
