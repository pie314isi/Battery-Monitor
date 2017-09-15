#!/bin/bash
export PATH=~/.local/bin:$PATH
export AWS_CONFIG_FILE="/root/.aws/config"
export AWS_PROFILE=user2
export HOME=/root

cd /tmp

wget http://ipecho.net/plain
online=$?
	if [ $online -eq 0 ]; then
		/root/.local/bin/aws s3 mv plain s3://mornington-admin
	fi


