#!/bin/bash

sshpass -p "armored" ssh -oStrictHostKeyChecking=no armored@compute$1 "./getVmIp.exp"
