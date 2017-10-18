#!/bin/bash

cast.sh Q
echo logging packets
timeout 5 tail -f /tmp/batteries.log | grep BUILT > /tmp/build_dates.txt &


echo sending broadcast ID
cast.sh V

echo wait
sleep 5 
cast.sh q

cut -d, -f3 /tmp/build_dates.txt | sort -u
wc /tmp/build_dates.txt

