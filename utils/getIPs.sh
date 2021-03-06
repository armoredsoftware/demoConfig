#!/bin/bash

web_url="http://tuna.ittc.ku.edu/armoredWeb"
compute_node_start=$1
compute_node_end=$2

if [ -z "$1" ]; then
   echo "Must specify compute node or start and end of range of compute nodes" 
   exit
fi

if [ -z "$2" ]; then
   compute_node_end=$1
fi


ip=""

for i in `seq $compute_node_start $compute_node_end`; do
  #ask for vms on each compute node. Remove -s flag  or remove pipe for debugging
  vms=`curl -s --data "node=$i" $web_url/nodeStatus.php | sed 's/\r/\n/'`
  count=1;
  # every third item is an ip address
  for j in $vms; do
     if [ $count -eq 0 ]; then
       ip="$ip $j"   
     fi 
     
     let count=$(((count + 1)%3))
  done

done
echo $ip

