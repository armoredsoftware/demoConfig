Armored Software Compute Node VM Setup
=======================================
This directory contains a script to build a new VM on a Xen compute node.
In order to create a VM run the buildlargecentos65pvm.sh with sudo.
It will then create a directory /xenImages containing the vm images and 
run configuration files. After the script has run and the VM has been installed,
the VM can be run by executing the following command:

*sudo xl create [run.cfg file]*

e.g. *> sudo xl create /xenImages/centos65x86_64_run.cfg*

After running the create command you can run
*sudo xl list* in order to view the running vms

In order to login to running vm you can use the following command

*>sudo xl console [domain id #]*

The credentials are as follows:

username: root
password: armored

in order to exit type Ctrl+]

It is recommended that you use the web interface or sudo
xl console and ifconfig to obtain the ip address and then
ssh to the ip address. Multiple sessions of xl console have
unexpected results when run on the same VM.
 

## Creating Multiple VMs
To create multiple images it is recommended to run the script once
then make a copy of the .img and the run.cfg files. This way you can create multiple 
vms without having to wait for the vms to install.
In the run.cfg file you will need to change the name as well as point to the correct
.img file. Xen will not allow running VMs to share a name.

After copying the .img and run.cfg files you can run the *xl create* command
on each vm to start them.


