#!/bin/bash

for file in `ls /tmp/*.gz`
	do echo $file
	aws s3 mv $file s3://MorningtonRawData
        done
