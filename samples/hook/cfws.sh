#!/bin/bash
#Caller: udpdeminer -s www.visa.com,www.pcmag.com -p 8080 --hookpath /path/to/me/$0 --hookip 127.0.0.1
#Server: ./wstunnel server --restrict-to localhost:51820 'ws://[::]:8080'
EVENT=$1
STREAMID=$2
SRVSTR=$3
LSTR=$4

STREAM_PIDFILE="/dev/shm/udpdeminder-hook-${STREAMID}.pid"

case $EVENT in
	startpre)
		/path/to/wstunnel client -L "udp://${LSTR}:[::1]:51820?timeout_sec=0" "ws://${SRVSTR}" --http-headers host:myws.doamin.com & echo $! > "${STREAM_PIDFILE}"
		echo "stream $STREAMID started"
		#wait tunnel establish
		sleep 1
		;;
	stoppost)
		kill -9 $(cat "$STREAM_PIDFILE")
		rm "$STREAM_PIDFILE"
		echo "stream $STREAMID terminate"
		;;
	*)
		echo "unknow event for $STREAMID"
		exit 0
		;;
esac
