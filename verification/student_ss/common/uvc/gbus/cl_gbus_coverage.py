import vsc
from pyuvm import uvm_subscriber, ConfigDB
from .gbus_common import CmdType

class cl_gbus_coverage(uvm_subscriber):
    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Handle to the configuration object
        self.cfg  = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        self.cg_trans_value = covergroup_trans_value(f"{self.get_full_name()}.cg_trans_value", self.cfg)

    def write(self, item):
        if item.cmd == CmdType.DRIVE:
            # sample transaction value by bits
            for i in range(self.cfg.BUS_WIDTH):
                value = (item.value >> i) % 2
                self.cg_trans_value.sample(value, i)

@vsc.covergroup
class covergroup_trans_value(object):
    def __init__(self, name, cfg):
        self.options.name = name
        self.options.per_instance = True

        # configuration object
        self.cfg = cfg
        no_bits = self.cfg.BUS_WIDTH.bit_length() - 1

        self.with_sample(
            value = vsc.bit_t(1),
            bitno = vsc.bit_t(no_bits)
            )

        self.trans_bitno = vsc.coverpoint(self.bitno, cp_t=vsc.bit_t(no_bits))

        self.trans_value = vsc.coverpoint(self.value, bins = {
            "ZERO" : vsc.bin(0),
            "ONE"  : vsc.bin(1)
            })

        self.cross_value_bits = vsc.cross([self.trans_bitno, self.trans_value])
