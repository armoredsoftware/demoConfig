#!/bin/bash

yum install gmp
yum install gcc
yum install cmake
yum install wget
yum install tar

wget sourceforge.net/projects/tpm-emulator.berlios/files/tpm_emulator-0.7.4.tar.gz

tar -xvzf tpm_emulator-0.7.4.tar.gz
cd tpm_emulator-0.7.4
mkdir build
cd build
cmake ../
make
make install
