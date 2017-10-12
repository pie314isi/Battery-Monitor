#!/bin/bash

for file in `ls /tmp/*.gz`
	do 
		nc -z 8.8.8.8 53  >/dev/null 2>&1
		online=$?
		if [ $online -eq 0 ]; then
			echo aws s3 mv $file s3://MorningtonRawData
		fi
	
        done


