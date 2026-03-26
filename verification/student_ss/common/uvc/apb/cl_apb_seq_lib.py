""" APB-UVC sequence library
- The UVM Sequence is composed of several sequence items which can be put together in different ways to generate various scenarios.
- They are executed by an assigned sequencer which then sends data items to the driver. Hence, sequences make up the core stimuli of any verification plan."""

from pyuvm import uvm_sequence
import vsc
from cocotb.triggers import Timer

from .cl_apb_seq_item import *
from .apb_common import *

@vsc.randobj
class cl_apb_base_seq(uvm_sequence, object):
    """ Base sequence for the APB agent

    body method should be overwritten in new classes to define sequence."""

    def __init__(self, name = "apb_base_seq"):
        uvm_sequence.__init__(self, name)
        object.__init__(self)

        # Sequence item
        self.s_item = vsc.rand_attr(cl_apb_seq_item.create(name + ".apb_item"))

        # Delay before transaction
        self.delay_before_transaction = vsc.rand_uint32_t()

        # Delay before response
        self.delay_before_response = vsc.rand_uint32_t()

    @vsc.constraint
    def c_delay_before_transaction(self):
        self.delay_before_transaction in vsc.rangelist(vsc.rng(0, 15))

    @vsc.constraint
    def c_delay_before_response(self):
        self.delay_before_response in vsc.rangelist(vsc.rng(0, 30))

    async def delay_transaction(self):
        if self.delay_before_transaction != 0:
            await Timer(self.delay_before_transaction * 1, 'ns')

    async def delay_response(self):
        if self.delay_before_response != 0:
            await Timer(self.delay_before_response * 1, 'ns')


class cl_apb_single_seq(cl_apb_base_seq):
    """Sequence generating one random item"""
    def __init__(self, name = "apb_single_seq"):
        super().__init__(name)

    async def body(self):
        if self.sequencer.cfg.driver == DriverType.PRODUCER:
            await self.delay_transaction()
        elif self.sequencer.cfg.driver == DriverType.CONSUMER:
            await self.delay_response()

        await self.start_item(self.s_item)

        # Send transaction to driver
        await self.finish_item(self.s_item)


class cl_apb_single_zd_seq(cl_apb_single_seq):
    """Sequence generating one random zero delay item"""
    def __init__(self, name = "apb_single_zd_seq"):
        super().__init__(name)

    @vsc.constraint
    def c_zero_delay_transaction(self):
        self.delay_before_transaction == 0

    @vsc.constraint
    def c_zero_delay_response(self):
        self.delay_before_response == 0
