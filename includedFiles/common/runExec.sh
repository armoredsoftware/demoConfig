#!/bin/bash
DIR=~/demo
EXEC=$1
APP=$2
ATT=$3
CA=$4

if [ "$EXEC" == "Attester" ];then
   echo "HERE"
   #Check to see if tpmd is running

   tpmd_running=`ps x| grep -v "grep" | grep tpmd`

   if [ "$tpmd_running" == "" ]; then
       tpmd
   fi

   screen -X -S screen_app quit
   killall test1.o
   screen -dmS screen_app $DIR/test1.o
   
   PID=`pidof test1.o`
   echo $PID
   killall gdb
   $DIR/gdb --port=3000 &

else
  # If we are not an attester kill tpmd
  killall tpmd
fi

if [ "$PID" != "" ];then
   $DIR/$EXEC  $APP $ATT $CA $PID &
else
   $DIR/$EXEC  $APP $ATT $CA &
fi

