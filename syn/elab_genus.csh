#!/bin/csh
source /opt/soc/eda/cadence/cadence_init_21.csh

cd ../build/

if (-e genus.cmd && -e genus.log) then
    rm genus.cmd genus.log
endif

genus -files ../syn/genus_elaboration.tcl -batch

cd -

