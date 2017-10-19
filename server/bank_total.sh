#!/bin/bash
echo using last 200 packets
tail -n 200  /tmp/batteries.log > /tmp/all_readings.txt

for file in ~/Battery-Monitor/bank?.txt
	do
	cat $file | cut -d' ' -f2 > /tmp/bankids.txt
	cat /tmp/all_readings.txt | grep -f /tmp/bankids.txt > /tmp/bank_readings.txt
	cat /tmp/bank_readings.txt | cut -d, -f2,5 | sort | uniq -w 18 | awk '{sum+=$2;} END { print "Total volts:" sum*2*3.3/1024 }'
        done




