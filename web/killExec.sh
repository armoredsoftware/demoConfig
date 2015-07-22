#!/bin/bash

ip=$1
executable=$2
ssh root@$ip "~/demo/killExec.sh $executable"

