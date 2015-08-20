#!/bin/bash

killall $1

if [ "$1" == "Attester" ];then

   killall test1.o
   killall gdb

fi

