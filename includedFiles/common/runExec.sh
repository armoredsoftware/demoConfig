#!/bin/bash
DIR=~/demo
MEASURE_PORT=3003
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

   killall test1.o
   $DIR/test1.o &
   PID=`pidof test1.o`
   echo $PID
   killall gdb
   $DIR/gdb --port=$MEASURE_PORT &

else
  # If we are not an attester kill tpmd
  killall tpmd
fi

if [ "$PID" != "" ];then
   $DIR/$EXEC  $APP $ATT $CA $MEASURE_PORT $PID &
else
   $DIR/$EXEC  $APP $ATT $CA &
fi
