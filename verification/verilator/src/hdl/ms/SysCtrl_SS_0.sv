`INCREMENT_CYCLE_COUNT(clk_internal)

always @ (posedge Ibex_Core_clk_i) begin
    StatusImem status_imem;
    StatusDmem status_dmem;
    // Populate status_imem
    status_imem.err_i        = Ibex_Core_instr_err_i;
    status_imem.gnt_i        = Ibex_Core_instr_gnt_i;
    status_imem.rdata_i      = Ibex_Core_instr_rdata_i;
    status_imem.rdata_intg_i = 0;
    status_imem.rvalid_i     = Ibex_Core_instr_rvalid_i;
    status_imem.addr_o       = Ibex_Core_instr_addr_o;
    status_imem.req_o        = Ibex_Core_instr_req_o;
    // Populate status_dmem
    status_dmem.err_i        = Ibex_Core_data_err_i;
    status_dmem.gnt_i        = Ibex_Core_data_gnt_i;
    status_dmem.rdata_i      = Ibex_Core_data_rdata_i;
    status_dmem.rdata_intg_i = 0;
    status_dmem.rvalid_i     = Ibex_Core_data_rvalid_i;
    status_dmem.addr_o       = Ibex_Core_data_addr_o;
    status_dmem.be_o         = Ibex_Core_data_be_o;
    status_dmem.req_o        = Ibex_Core_data_req_o;
    status_dmem.wdata_intg_o = 0;
    status_dmem.wdata_o      = Ibex_Core_data_wdata_o;
    status_dmem.we_o         = Ibex_Core_data_we_o;
    print_core_state($realtime, status_imem, status_dmem);
end
