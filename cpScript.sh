#!/bin/bash

web_url="http://tuna.ittc.ku.edu/dawson"
source_dir=$1
compute_node_start=1
compute_node_end=8


if [ -z "$source_dir" ]; then
   echo "    cpScript.sh takes a source directory as argument to send to all vms in compute cluster"
   exit;
 else
   if [ ! -d "$source_dir" ]; then
     echo "  Directory does not exist: $source_dir"
     exit
   fi  
fi


ip=""

echo -n "Obtaining Ip Addresses from vms"
for i in `seq $compute_node_start $compute_node_end`; do
  echo -n "."
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
echo

echo -n "Copying $source_dir to vms"
for i in $ip; do
  echo -n "."
  ./scp.exp  "$source_dir" "root@"$i":~"
done

echo

