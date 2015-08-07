#!/bin/bash

pid=`ps x | grep -v "grep" | grep $1 | awk '{print $1}'`
kill $pid

