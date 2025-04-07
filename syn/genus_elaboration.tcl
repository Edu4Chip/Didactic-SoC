try {

	puts "Lab 3 synthesis script"
	puts "TODO: implement tasks described in comments."
	
	#T3.1:  Reading the design
	#       The synthesis flow starts with setting the technology library,
	#       setting the top design instance name, reading the source 
	#       files, and elaborating the design.
	#
	#       T3.1.1
	#       Set the "dut_top" tcl variable as a string with the name of
	#       the top module of your accelerator.
	#
	#       T3.1.2
	#       Set the "filelist" tcl variable as a list of the source files
	#       required by the accelerator.
	#
	#       With the variables set use the following commands:
	#       ```
	#       set_db library tutorial.lib
	#       read_hdl -language sv $filelist
	#       elaborate $dut_top
	#       ```
	

	#T3.2:  Setting constraints
	#	Next you will define synthesis contstraints to direct
	#	optimizations of the tool.
	#
	#	T3.2.1: Set "clk_per" to "6" (nanoseconds), then define the 
	#	main clock with
	#	```
	#	create_clock -name main_clock -period $clk_per clk_in -add	
	#	```
	#
	#	T3.2.2: Apply I/O path constraints with
	#       set_input_delay  -clock main_clock -max 1 [all_inputs]
	#       set_input_delay  -clock main_clock -min 0 [all_inputs]
	#	set_output_delay -clock main_clock -max 1 [all_outputs]
	#
	#	T3.2.3: Preserve design hierarchy (for now) by disabling 
	#	ungrouping:
	#	``` 
	#	set_db auto_ungroup none
	#       ```
	
	#T3.3:  Synthesis
	#	Run a set of generic synthesis targets with
	#	```
	#	syn_generic
	#	syn_map
	#	syn_opt
	#	```
	#
	#	If we would use our synthesized design for further physical design 
	#	we would write the artifacts to a db- or netlist file with:
	#	```
	#	write_db -to_file design.db #, or
	#	write_hdl > netlist.v
	#	```
	#	However, in the context of this exercise we are only concerned with
	#	the synthesis reports, therefore we can skip this step.
	

	#T3.4:  Reporting
	#       Report the synthesis-based timing, gate count and power estimates of
	#       the tool with:
	#       ```
	#       report_timing
	#       report_gates
	#       report_power
	#       ```
	#       
	#       These commands print the reports in the terminal, thus you should
	#       pipe these to dedicated .log/.txt files when invoking them.


} on error {} {
	exit 1
}

exit 0
