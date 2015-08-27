#!/bin/bash

killall $1

if [ "$1" == "Attester" ];then

   killall test1.o
   killall test2.o
   killall buffer_overflow1.o
   killall buffer_overflow2.o
   killall gdb
  
fi

