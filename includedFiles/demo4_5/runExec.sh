#!/bin/bash
DIR=~/demo
EXEC=$1
APP=$2
ATT=$3
CA=$4

MEASURE_PORT=3057
APPLICATION=test1.o

DEBUG=1
echo "" > ~/log.1


rm ~/screenlog.0
if [ "$EXEC" == "Attester" ];then
   #Check to see if tpmd is running

   tpmd_running=`ps x| grep -v "grep" | grep tpmd`

   #start tpmd if not running
   if [ "$tpmd_running" == "" ]; then
       tpmd
   fi

   #kill Application and gdb if already running
   if [ ! -z "`pidof $APPLICATION`" ];then
      killall $APPLICATION
      sleep 1
   fi 
   
   if [ ! -z "`pidof gdb`" ];then
       killall gdb
       sleep 1
   fi


  #start Application
   screen -dmS app_session $DIR/$APPLICATION 
   PID=`pidof $APPLICATION`
   echo "$APPLICATION PID: $PID" >> ~/log.1

   #measurer output goes to screenlog.0
   screen -dmLS measurer_screen $DIR/gdb --port=$MEASURE_PORT

   if [ "$PID" == "" ];then
       echo "Error in launching $APPLICATION try again" >> ~/log.1
       exit
   fi

   # give Measurer time to setup
   sleep 1
   
else
  # If we are not an attester kill tpmd
  killall tpmd
fi

if [ "$PID" != "" ];then
   $DIR/$EXEC  $APP $ATT $CA $MEASURE_PORT $PID $DEBUG 2>> ~/log.1 &
else
   $DIR/$EXEC  $APP $ATT $CA &
fi

echo "Successfull launch" >> ~/log.1
