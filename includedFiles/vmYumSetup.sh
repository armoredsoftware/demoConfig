#!/bin/sh

# Setup the yum repositorys in a VM that is CentOS.
#
EPEL_RPM_LINK=epel-release-6-8.noarch.rpm

wget http://linux.mirrors.es.net/fedora-epel/6/i386/${EPEL_RPM_LINK}

mv ArmoredConfig.repo /etc/yum.repos.d
mv xen-c6-tweaked.repo /etc/yum.repos.d

rpm -i $EPEL_RPM_LINK
yum -y install xen-devel-4.2.2 xen-runtime-4.2.2

./emulatorSetup.sh

echo "#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local

modprobe xen_gntalloc
modprobe xen_gntdev
modprobe xen_evtchn
modprobe tpmd_dev
" > /etc/rc.local

reboot
