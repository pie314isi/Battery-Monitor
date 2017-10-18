#!/bin/bash

echo logging packets... wait
timeout 12 tail -f /tmp/batteries.log > /tmp/tensecondlog.txt 

cat /tmp/tensecondlog.txt | cut -d, -f2 | sort | uniq  -c

