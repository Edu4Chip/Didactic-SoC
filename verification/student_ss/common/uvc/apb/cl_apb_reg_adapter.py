from pyuvm import *
from . import apb_common
from .cl_apb_seq_item import cl_apb_seq_item

class cl_apb_reg_adapter(uvm_reg_adapter):
    def __init__(self, name = "cl_reg_adapter"):
        super().__init__(name)
        self.parent_sequence = uvm_sequence()


    def reg2bus(self, rw):
        apb = cl_apb_seq_item.create("apb_item")

        if rw.kind == access_e.UVM_READ:
            apb.op = apb_common.OpType.RD
        elif rw.kind == access_e.UVM_WRITE:
            apb.op = apb_common.OpType.WR

        apb.addr = int(rw.addr.replace("0x", ""))
        apb.data = rw.data
        apb.strb = 0xf

        return apb

    def bus2reg(self, bus_item, rw):
        assert isinstance(bus_item, cl_apb_seq_item), {
            "Bus item is not of type APB item"}

        apb = bus_item

        if apb.op == apb_common.OpType.RD:
            rw.kind = access_e.UVM_READ
        elif apb.op == apb_common.OpType.WR:
            rw.kind = access_e.UVM_WRITE

        rw.addr = apb.addr
        rw.data = apb.data

        if apb.slverr == 0:
            rw.status = status_t.IS_OK
        else:
            rw.status = status_t.IS_NOT_OK
