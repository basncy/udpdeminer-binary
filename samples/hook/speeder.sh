#!/bin/sh
#/path/to/udpdeminer-x86_64-unknown-linux-musl -l 12701 -s 2001::a:1000,2001::b:1000 --maxoffset 1000 -p 5678 --hookip 127.0.0.1 --hookpath /path/to/this_hook.sh
#Download binary from https://github.com/wangyu-/UDPspeeder/releases
EVENT=$1
STREAMID=$2
SRVSTR=$3
LSTR=$4

PIDFILE="/var/run/speeder.pid"

if [ "${EVENT}" = "startpre" ]; then
        kill -9 $(cat "$PIDFILE")
        /path/to/speederv2_amd64 -c "-l${LSTR}" "-r${SRVSTR}" -k "passwd" -f20:10 & echo $! > "${PIDFILE}"
        #wait tunnel establish, optional
        sleep 0.2
fi
