#!/bin/bash
echo using last 200 packets
tail -n 200  /tmp/batteries.log > /tmp/all_readings.txt

cat ~/Battery-Monitor/Isense.txt | cut -d' ' -f2 > /tmp/Isenseids.txt
cat /tmp/all_readings.txt | grep -f /tmp/Isenseids.txt > /tmp/I_readings.txt
cat /tmp/I_readings.txt | cut -d, -f2,5 | awk '{print $1 ,((($2*3.3/1024)-1.24)/11)/0.0005 }'









