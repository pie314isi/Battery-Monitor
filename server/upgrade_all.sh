#!/bin/bash

cd /tmp
python -m SimpleHTTPServer 8080 &
WS_PID=$!
sleep 1

# make a list of all connected devices
check_responding.sh

#and shut them all up for a while
echo Q | nc -q1 -u -b 192.168.1.255 4210; 

grep IPADDRESS /tmp/responses.txt | cut -d, -f3 | sort -u | cut -d" " -f3 > /tmp/iplist.txt

for ip in `cat /tmp/iplist.txt | grep -v IPADDRESS` 
	do
        echo $ip 
	echo Q | nc -q1 -u -b 192.168.1.255 4210; 
        echo I | nc -q1 -u -b $ip 4210; 
        echo U | nc -q1 -u -b $ip 4210; 
	sleep 20
        done

kill $WS_PID

