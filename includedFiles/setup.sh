#!/bin/bash

cd ~/demo

mv *.txt ..

xen_tpmd=`modprobe xen_gntalloc 2>&1; modprobe xen_gntdev 2>&1; modprobe xen_evtchn; modprobe tpmd_dev 2>&1;`

if [ "$xen_tpmd" != "" ];then
   ./vmYumSetup.sh &
   disown
fi
