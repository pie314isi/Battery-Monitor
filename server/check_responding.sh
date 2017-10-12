#!/bin/bash

echo logging packets
timeout 10 tail -f /tmp/batteries.log | grep IPADDRESS > /tmp/responses.txt &


echo sending broadcast ID
echo I | nc -q1 -u -b 192.168.1.255 4210

echo wait
sleep 10 
wc /tmp/responses.txt

