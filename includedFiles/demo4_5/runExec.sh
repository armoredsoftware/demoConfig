#!/bin/bash
DIR=~/demo
EXEC=$1
APP=$2
ATT=$3
CA=$4

MEASURE_PORT=3057
APPLICATION=test1.o

DEBUG=1

if [ "$EXEC" == "Attester" ];then
   echo "HERE"
   #Check to see if tpmd is running

   tpmd_running=`ps x| grep -v "grep" | grep tpmd`

   if [ "$tpmd_running" == "" ]; then
       tpmd
   fi

   killall $APPLICATION
   killall gdb

   screen -dmS app_session $DIR/$APPLICATION
   PID=`pidof $APPLICATION`
   echo "Application: $PID"

   screen -dmS measurer_screen $DIR/gdb --port=$MEASURE_PORT > measurer_out

   if [ "$PID" == "" ];then
       echo "Error in launching $APPLICATION"
       exit
   fi

   # give Measurer time to setup
   sleep 1
   
else
  # If we are not an attester kill tpmd
  killall tpmd
fi

if [ "$PID" != "" ];then
   $DIR/$EXEC  $APP $ATT $CA $MEASURE_PORT $PID $DEBUG &
else
   $DIR/$EXEC  $APP $ATT $CA &
fi

