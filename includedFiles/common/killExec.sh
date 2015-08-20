#!/bin/bash

pid=`ps -e | grep $1 | awk '{print $1}'`
kill $pid

