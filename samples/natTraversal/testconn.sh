#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin
cd `dirname $0`

python3 n4.py -c -x -h 11.22.33.44 -p 12710 -b $((RANDOM + RANDOM + 1025))
