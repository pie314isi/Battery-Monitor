#!/bin/bash

echo Q | nc -q1 -u -b 192.168.1.255 4210
echo logging packets
timeout 5 tail -f /tmp/batteries.log | grep BUILT > /tmp/build_dates.txt &


echo sending broadcast ID
echo V | nc -q1 -u -b 192.168.1.255 4210

echo wait
sleep 5 
echo q | nc -q1 -u -b 192.168.1.255 4210

cut -d, -f3 /tmp/build_dates.txt | sort -u
wc /tmp/build_dates.txt

