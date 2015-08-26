#!/bin/bash

ip=$1
executable=$2
app=$3
att=$4
ca=$5

if[ "$executable" == "Attester" ]; then
   kill -9 `pidof shellinaboxd`
   screen -dm shellinaboxd --disable-ssl -s /:apache:apache:HOME:"sshpass -p "armored" ssh -oStrictHostKeyChecking=no -t root@$ip screen -r -S app_session"
fi
screen -dm sshpass -p "armored" ssh -oStrictHostKeyChecking=no root@$ip "~/demo/runExec.sh $executable $app $att $ca"

