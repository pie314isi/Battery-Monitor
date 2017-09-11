#!/bin/bash

cd /tmp
python -m SimpleHTTPServer 8080 &
WS_PID=$!

for ip in `cat /var/lib/misc/dnsmasq.leases | cut -d" " -f3`
	do
        echo U | nc -q1 -u -b $ip 4210; 
	sleep 10
        done

kill $WS_PID

