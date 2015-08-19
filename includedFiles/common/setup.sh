#!/bin/bash

cd ~/demo

if [ -f caPrivateKey.txt ];then
  mv caPrivateKey.txt caPublicKey.txt ekpub.txt goldenPcrComposite.txt ..
fi
./measurerSetup.sh 2>&1 &
disown

#Set up so modprobes get executed on reboot, and tpm emulator gets installed
# if not already there

rc_update=`grep xen_gntalloc /etc/rc.local`

if [ "$rc_update" == "" ]; then

     cat rcSegment >> /etc/rc.d/rc.local
 
fi

xen_tpmd=`modprobe xen_gntalloc 2>&1; modprobe xen_gntdev 2>&1; modprobe xen_evtchn; modprobe tpmd_dev 2>&1;`

if [ "$xen_tpmd" != "" ];then
   ./vmYumSetup.sh 2>&1 &
   disown
fi

