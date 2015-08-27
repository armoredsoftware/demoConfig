#!/bin/bash
DIR=~/demo
EXEC=$1
APP=$2
ATT=$3
CA=$4

if [ "$EXEC" == "Attester" ];then
   #Check to see if tpmd is running

   tpmd_running=`ps x| grep -v "grep" | grep tpmd`

   if [ "$tpmd_running" == "" ]; then
       tpmd
   fi


else
  # If we are not an attester kill tpmd
  killall tpmd
fi

if [ "$PID" != "" ];then
   $DIR/$EXEC  $APP $ATT $CA &
else
   $DIR/$EXEC  $APP $ATT $CA &
fi

