#!/bin/bash
tail -n 3000 /tmp/batteries.log | cut -d, -f2 | sort | uniq  -c
