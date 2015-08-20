#!/bin/bash

ip=$1
executable=$2
screen -dm sshpass -p "armored" ssh -oStrictHostKeyChecking=no root@$ip "~/demo/killExec.sh $executable"


