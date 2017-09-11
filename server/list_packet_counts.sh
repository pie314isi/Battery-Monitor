#!/bin/bash

for file in `ls /tmp/*.gz`
	do echo $file
	zcat $file | cut -d, -f2 | sort | uniq  -c
        done
