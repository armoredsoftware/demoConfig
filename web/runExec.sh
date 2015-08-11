#!/bin/bash

ip=$1
executable=$2
app=$3
att=$4
ca=$5

kill -9 `pidof shellinaboxd`
shellinaboxd --disable-ssl -s /:root:root:HOME:"sshpass -p "armored" ssh -t root@$ip screen -r -S somethingelse"

ssh root@$ip "~/demo/runExec.sh $executable $app $att $ca"

