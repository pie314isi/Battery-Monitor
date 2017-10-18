#!/bin/bash

cd /tmp
python -m SimpleHTTPServer 8080 &
WS_PID=$!
sleep 1

# make a list of all connected devices
check_responding.sh

#and shut them all up for a while
cast.sh Q

grep IPADDRESS /tmp/responses.txt | cut -d, -f3 | sort -u | cut -d" " -f3 > /tmp/iplist.txt

for ip in `cat /tmp/iplist.txt | grep -v IPADDRESS` 
	do
        echo $ip 
        cast.sh Q
        echo I | nc -q1 -u -b $ip 4210; 
        echo U | nc -q1 -u -b $ip 4210; 
	sleep 20
        done

kill $WS_PID

