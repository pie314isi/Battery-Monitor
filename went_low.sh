#!/bin/bash

for file in mornington-processed/*.csv
	do
	echo $file
	grep ", 1, 1, 0" $file | cut -d, -f2 | sort -u > /tmp/low_batt.txt
	grep -f /tmp/low_batt.txt bank?.txt  -no
	done
	
