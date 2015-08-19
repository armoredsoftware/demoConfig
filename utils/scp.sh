#!/bin/bash
DIR=$1
IP=$2

sshpass -p "armored" scp -r $DIR  root@$IP:~
sshpass -p "armored" ssh root@$IP "~/demo/setup.sh"
