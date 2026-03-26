
from common.register_model.cl_reg_dynamic_seq import cl_reg_dynamic_seq
from common.cl_student_base_seq import cl_student_tb_base_seq

class cl_student_random_vseq (cl_student_tb_base_seq):
    """
    A virtual sequence consisting of three randomized sequences.

    First, driving the GPIO pins to random values.
    Then running three randomized dynamic sequences i.e. a read or write to a random register.
    """

    def __init__(self, name="cl_student_random_seq"):
        super().__init__(name)

    async def body(self):
        pmod0_gpi, pmod1_gpi = await self.drive_gpi_pins()

        seq = cl_reg_dynamic_seq.create("dynamic_seq")
        seq.randomize()
        await seq.start(self.sequencer)

        seq = cl_reg_dynamic_seq.create("dynamic_seq")
        seq.randomize()
        await seq.start(self.sequencer)

        seq = cl_reg_dynamic_seq.create("dynamic_seq")
        seq.randomize()
        await seq.start(self.sequencer)
