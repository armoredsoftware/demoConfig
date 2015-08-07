#!/bin/bash

yum -y install gmp-devel gcc cmake wget tar kernel-devel

wget sourceforge.net/projects/tpm-emulator.berlios/files/tpm_emulator-0.7.4.tar.gz

tar -xvzf tpm_emulator-0.7.4.tar.gz
cd tpm_emulator-0.7.4
mkdir build
cd build
cmake ../
make
make install

modprobe tpmd_dev
