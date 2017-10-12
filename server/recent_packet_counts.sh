#!/bin/bash
tail -n 500 /tmp/batteries.log | cut -d, -f2 | sort | uniq  -c
