#!/bin/csh

# TC217 ASIC-VM specific path
source /opt/soc/cadence/cadence_init.csh

cd ../build/

if (-e genus.cmd && -e genus.log) then
    rm genus.cmd genus.log
endif

genus -files ../syn/genus_elaboration.tcl -batch

cd -

