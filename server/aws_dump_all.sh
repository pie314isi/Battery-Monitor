#!/bin/bash
export PATH=~/.local/bin:$PATH
export AWS_CONFIG_FILE="/root/.aws/config"
export AWS_PROFILE=user2
export HOME=/root

for file in `ls /tmp/*.gz`
	do 
		nc -z 8.8.8.8 53  >/dev/null 2>&1
		online=$?
		if [ $online -eq 0 ]; then
			/root/.local/bin/aws s3 mv $file s3://mornington-rawdata
		fi
	
        done


