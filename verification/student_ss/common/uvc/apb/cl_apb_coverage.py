"""APB-UVC Coverage collector"""

import vsc
from pyuvm import uvm_subscriber, ConfigDB

class cl_apb_coverage(uvm_subscriber):
    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Handle to the configuration object
        self.cfg  = None

    def build_phase(self):
        self.logger.info("Start build_phase() -> APB coverage")
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        self.cg_trans_kind = covergroup_trans_kind(f"{self.get_full_name()}.cg_trans_kind", self.cfg)
        self.cg_trans_data = covergroup_trans_data(f"{self.get_full_name()}.cg_trans_data", self.cfg)

        self.logger.info("End build_phase() -> APB coverage")

    def write(self, item):
        if self.cfg.enable_transaction_coverage:
            # sample transaction kind
            self.cg_trans_kind.sample(item.op, item.addr, item.slverr)

            # sample transaction data by bits
            for i in range(self.cfg.DATA_WIDTH):
                data = (item.data >> i) % 2
                self.cg_trans_data.sample(item.op, data, i)


@vsc.covergroup
class covergroup_trans_kind(object):
    def __init__(self, name, cfg):
        self.options.name = name
        self.options.comment = "Operation and address coverage"
        self.options.per_instance = True
        self.options.auto_bin_max = 8

        self.cfg = cfg

        # defining sampling variables
        self.with_sample(
            op = vsc.bit_t(1),
            addr = vsc.bit_t(self.cfg.ADDR_WIDTH),
            slverr = vsc.bit_t(1)
            )

        self.trans_op = vsc.coverpoint(self.op, bins = {
            "RD" :  vsc.bin(0),
            "WR" :  vsc.bin(1)
            })

        self.trans_slverr = vsc.coverpoint(self.slverr, bins = {
            "NO_ERROR"  :  vsc.bin(0),
            "ERROR"     :  vsc.bin(1)
            })

        self.trans_addr = vsc.coverpoint(self.addr, cp_t=vsc.bit_t(self.cfg.ADDR_WIDTH))

        self.cross_op_addr = vsc.cross([self.trans_op, self.trans_addr])
        self.cross_op_slverr = vsc.cross([self.trans_op, self.trans_slverr])

@vsc.covergroup
class covergroup_trans_data(object):
    def __init__(self, name, cfg):
        self.options.name = name
        self.options.per_instance = True

        # configuration object
        self.cfg = cfg
        no_bits = self.cfg.DATA_WIDTH.bit_length() - 1

        self.with_sample(
            op = vsc.bit_t(1),
            data = vsc.bit_t(1),
            bitno = vsc.bit_t(no_bits)
            )

        self.trans_bitno = vsc.coverpoint(self.bitno, cp_t=vsc.bit_t(no_bits))

        self.trans_data = vsc.coverpoint(self.data, bins = {
            "ZERO" : vsc.bin(0),
            "ONE"  : vsc.bin(1)
            })

        self.trans_data_type = vsc.coverpoint(self.op, bins={
            "RD" : vsc.bin(0),
            "WR" : vsc.bin(1)
            })

        self.cross_data_bits_type = vsc.cross([self.trans_bitno, self.trans_data_type, self.trans_data])
