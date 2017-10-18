#!/bin/bash

echo logging packets
timeout 10 tail -f /tmp/batteries.log | grep IPADDRESS > /tmp/responses.txt &


echo sending broadcast ID
cast.sh I

echo wait
sleep 10 
wc /tmp/responses.txt

