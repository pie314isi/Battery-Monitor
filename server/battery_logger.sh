#!/bin/bash
socat UDP-RECV:4120 STDOUT | ts %Y-%m-%dT%T, > /tmp/batteries.log&
