#!/bin/bash

echo fetching from aws
aws s3 sync s3://mornington-rawdata/ mornington-rawdata/


for day in `ls mornington-rawdata/*.gz | cut -d \/ -f2 | cut -c15-22 | sort -u | sed '$d'`
    do
    echo $day
        if [ ! -e mornington-processed/batteries-$day.csv ]; then
            ls mornington-rawdata/batteries.log-$day*.gz
            zcat mornington-rawdata/batteries.log-$day*.gz | grep -v -e IPADD -e BOOT -e ESTAB -e BUTTON | awk '!(NR % 6)' > mornington-processed/batteries-$day.csv
        fi
    echo done
    done
    
echo pushing it up to aws processed folder

aws s3 sync mornington-processed/ s3://mornington-processed/

