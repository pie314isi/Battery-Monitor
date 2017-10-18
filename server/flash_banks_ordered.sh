#!/bin/bash
cast.sh Q

#for ip in `cat ../bank1.txt ../bank2.txt ../bank3.txt ../bank4.txt | cut -d" " -f5`
for ip in `cat  ../bank4.txt | cut -d" " -f5`
	do 
	echo $ip
	echo F | nc -q1 -u -b $ip 4210
sleep 1
	done

