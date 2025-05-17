#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin

while true; do
        KILLPID=$FWDPID
        MYSTR=$(python3 n4.py -c -h 11.22.33.44 -p 12710 -b $((RANDOM + RANDOM + 1025)))
        (sleep 10 && kill -9 $KILLPID) &
        LPORT=$(echo $MYSTR|cut -d'-' -f2)
        ./udpdeminer-x86_64-unknown-linux-musl -b 0.0.0.0 -l $LPORT --server 8.8.8.8 --port 9999 --outbound 0.0.0.0 & export FWDPID=$!
        #./udpdeminer-aarch64-unknown-linux-musl -b 0.0.0.0 -l $LPORT --server 8.8.8.8 --port 9999 --outbound 0.0.0.0 & FWDPID=$!
        #socat "udp-listen:$LPORT" 'udp6:[2001::8888]:9999' & FWDPID=$!
done
