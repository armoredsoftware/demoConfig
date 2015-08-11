#!/bin/bash

source_dir=$1
compute_node_start=1
compute_node_end=8


if [ -z "$source_dir" ]; then
   echo "    cpScript.sh takes a source directory as argument to send to all vms in compute cluster"
   exit;
 else
   if [ ! -e "$source_dir" ]; then
     echo "  Directory does not exist: $source_dir"
     exit
   fi  
fi

if [ ! -z "$2" ]; then
     compute_node_start=$2
     compute_node_end=$2
fi


echo -n "Obtaining Ip Addresses from vms"
ip=`utils/getIPs.exp $compute_node_start $compute_node_end`

echo -n "Copying $source_dir to vms"
for i in $ip; do
  echo -n "."
  utils/scp.exp  "$source_dir" "$i" 
done

echo

