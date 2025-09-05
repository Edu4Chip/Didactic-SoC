puts "#### Running src_files.tcl ####"

set BENDER_TARGETS "-t fpga \
                    -t xilinx \
                    -t tech_cells_generic_exclude_deprecated \
                    -t rtl \
                    -t vendor \
                    -t didactic_obi \
                    -t synthesis"

set BENDER_CMD "bender script flist $BENDER_TARGETS"

set filelist [exec sh -c $BENDER_CMD]

set APB_DIR          [exec bender path apb]
set AXI_DIR          [exec bender path axi]
set COMMON_CELLS_DIR [exec bender path common_cells]
set OBI_DIR          [exec bender path obi]
set REGIF_DIR        [exec bender path register_interface]
set IBEX_DIR         $DIR/../vendor_ips/ibex

set INCLUDE_DIRS  [list \
                    $APB_DIR/include \
                    $AXI_DIR/include \
                    $COMMON_CELLS_DIR/include \
                    $REGIF_DIR/include \
                    $OBI_DIR/include \
	                $IBEX_DIR/vendor/lowrisc_ip/dv/sv/dv_utils \
	                $IBEX_DIR/vendor/lowrisc_ip/ip/prim/rtl \
	                $IBEX_DIR/rtl \
                  ]

set_property include_dirs $INCLUDE_DIRS [get_filesets [list sim_1 sources_1]]

add_files -norecurse -scan_for_includes $filelist
