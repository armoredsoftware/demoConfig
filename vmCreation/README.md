Armored Software Compute Node VM Setup
=======================================
This directory contains a script to build a new VM on a Xen compute node.
In order to create a VM run the buildlargecentos65pvm.sh with sudo.
It will then create a directory /xenImages containing the vm images


To create multiple images it is recommended to run the script once
then make a copy of the .img and the run.cfg files. This way you can create multiple 
vms without having to wait for the vms to install.
In the run.cfg file you will need to change the name as well as point to the correct
.img file.

To start a new vm on the Xen compute node run the following command:

*sudo xl create [run.cfg file]* 

e.g. > sudo xl create /xenImages/centos65x86_64_run.cfg

After running the create command you can run
*sudo xl list* in order to view the running vms


