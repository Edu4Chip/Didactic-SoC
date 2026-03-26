import vsc
from pyuvm import *
from .cl_gbus_item import cl_gbus_seq_item
from .gbus_common import CmdType

#######################################################################
### Class: base_sequence
### Base sequence for gbus sequences. Empty for now.
#######################################################################
@vsc.randobj
class cl_gbus_base_seq(uvm_sequence, object):
    """ Base sequence for the GBus agent
    body method should be overwritten in new classes to define sequence."""

    def __init__(self, name = "gbus_base_seq"):
        uvm_sequence.__init__(self, name)
        object.__init__(self)

        # Sequence item
        self.s_item = vsc.rand_attr(cl_gbus_seq_item.create(name + ".gbus_item"))

        # Response item
        self.rsp_item = None


#######################################################################
### Do a single GBus transaction. The body of the sequence
### starts the item, followed by randomization of the item.
#######################################################################
@vsc.randobj
class cl_gbus_do_seq(cl_gbus_base_seq):
    def __init__(self, name="do_sequence"):
        super().__init__(name)

    async def body(self):
        await super().body()

        if self.s_item is None:
            # Create sequence item
            self.s_item = vsc.rand_attr(cl_gbus_seq_item.create(self.name + ".gbus_item"))
            await self.start_item(self.s_item)
            self.s_item.randomize()
        else:
            await self.start_item(self.s_item)

        await self.finish_item(self.s_item)
        self.rsp_item = await self.get_response()


#######################################################################
### Drive a single GBus transaction. The body of the sequence
### starts the randomized item.
#######################################################################
@vsc.randobj
class cl_gbus_drive_seq(cl_gbus_do_seq):
    def __init__(self, name="drive_sequence"):
        super().__init__(name)

    @vsc.constraint
    def c_drive_only(self):
        self.s_item.cmd == CmdType.DRIVE

#######################################################################
### Sample a single GBus transaction. The body of the sequence
### starts the randomized item.
#######################################################################
@vsc.randobj
class cl_gbus_sample_seq(cl_gbus_do_seq):
    def __init__(self, name="sample_sequence"):
        super().__init__(name)

    @vsc.constraint
    def c_sample_only(self):
        self.s_item.cmd == CmdType.SAMPLE
