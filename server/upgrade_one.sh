#!/bin/bash
cd /tmp

timeout 20 python -m SimpleHTTPServer 8080 &

echo U | nc -q1 -u -b $1 4210 
