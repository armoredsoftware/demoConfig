#!/bin/bash

ip=$1
executable=$2
app=$3
att=$4
ca=$5

sshpass -p "armored" ssh -oStrictHostKeyChecking=no root@$ip "~/demo/runExec.sh $executable $app $att $ca"

