#!/bin/bash

killall $1

if [ "$1" == "Attester" ];then
   echo "killing test1.o gdb"

   killall test1.o
   killall gdb

fi
if [ -x "/root/running" ];then
   error=`/root/running`
   if [ -z "$error" ];then
     echo "Kill successfull" >> /root/log.1
   else
     echo "$error" >> /root/log.1
   fi
fi

