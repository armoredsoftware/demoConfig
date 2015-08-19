#!/bin/bash

sshpass -p "armored" ssh -oStrictHostKeyChecking=no root@$1 "cat log.1"
