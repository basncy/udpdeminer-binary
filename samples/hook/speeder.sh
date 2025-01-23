#!/bin/bash
#Download binary from https://github.com/wangyu-/UDPspeeder/releases
EVENT=$1
STREAMID=$2
SRVSTR=$3
LSTR=$4

STREAM_PIDFILE="/dev/shm/udpdeminder-hook-${STREAMID}.pid"

case $EVENT in
	startpre)
		/path/to/speederv2_amd64 -c "-l${LSTR}" "-r${SRVSTR}" -f20:10 -k "passwd" & echo $! > "${STREAM_PIDFILE}"	
		echo "stream $STREAMID started"
		#wait tunnel establish, optional
		sleep 0.2
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
