#!/bin/bash
echo DON\'T BROADCAST AN UPGRADE COMMAND!!!!
echo $1 | nc -q1 -u -b 192.168.1.255 4210 
