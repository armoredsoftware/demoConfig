#!/bin/sh

# Setup the yum repositorys in a VM that is CentOS.
#
EPEL_RPM_LINK=epel-release-6-8.noarch.rpm

wget http://linux.mirrors.es.net/fedora-epel/6/i386/${EPEL_RPM_LINK}

mv ArmoredConfig.repo /etc/yum.repos.d
mv xen-c6-tweaked.repo /etc/yum.repos.d

rpm -i $EPEL_RPM_LINK
yum -y install xen-devel-4.2.2 xen-runtime-4.2.2

reboot
