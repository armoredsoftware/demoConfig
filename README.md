demoConfig
==========
This repository contains the necessary scripts to run Armored Software Demonstrations


## Demo 4 ##
In order to run Demo 4 the following needs to be in place:

* 3 virtual machines need to be running
* latest web interface needs to be deployed on tuna


See demoConfig/vmCreation/README.md for instructions on 
creating VMs on a Xen compute node.

The web interface can be placed on tuna by doing the following
in the /var/www/html directory

sudo svn export export https://github.com/armoredsoftware/demoConfig/trunk/web armoredWeb

and can then be accessed by opening a web browser at http://tuna.ittc.ku.edu/armoredWeb

You do not have to do any additional setup on the new VMs. The next step is to run
the demo4.sh script. This script will download the appropriate repos for demo4
and compile them, copy the executables over to the vms as well as install the
tpmEmulator and xen-devel and xen-runtime libraries. 

If you would like to do this for all the compute nodes then run:

*> ./demo4.sh all*

or if you would like to just do it to all the vms on a certain compute node
then run the script with the compute node #

*> ./demo4.sh [compute node #]

Note: Fresh VMs (VMs that do not have the xen libraries installed) will be rebooted
as part of the installation process, changing their domain IDs and IP addresses

It is recommended to do a sudo xl console [domain id #] after the script has completed
to see when the reboot has completed

After the VMs have rebooted, the web interface may be used in order to run the demonstration 


## General Provisioning Information ##

All necessary functions reside in Provisioning.hs.  ProvisioningMain has all the necessary function invocations (all but one commented out for each particular desired provisioning activity).

-ekProvision:  Extracts the EK(Endorsement Key) from the currently running TPM Emulator, and exports it to the file "ekpub.txt".  

1) Must be run on the Attester VM while TPM Emulator is running.  
2) Send "ekpub.txt" to the Certificate Authority VM (so that it can use the EK to encrypt the AIK, in accordance with the Privacy CA protocol).

-exportCurrentComp:  Queries the running TPM Emulator and extracts the CURRENT pcr composite(TPM_PCR_COMPOSITE), and exports it to the file "goldenPcrComposite.txt".  

1) Must be run on the Attester VM while TPM Emulator is running.  
2) Send "goldenPcrComposite" to the Appraiser VM (so that it can check this golden composite against the one it receives from the Attester in the protocol).

exportCAKeys:  Exports the CA public key to the file "caPublicKey.txt" and the CA private key to the file "caPrivateKey.txt".  (Note:  A NEW public/private key pair is generated on each invocation, using the system entropy).

1) Can be run anywhere, but makes the most sense to run on the certificate authority VM.
2)  The private key file should remain on the ca VM
3)  Send the public key file to the Appraiser VM (so that it can verify the signature of the data signed with the ca private key).

 
