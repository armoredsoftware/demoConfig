#!/bin/bash

ip=$1
executable=$2
app=$3
att=$4
ca=$5

ssh root@$ip "~/demo/runExec.sh $executable $app $att $ca"

