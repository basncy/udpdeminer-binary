#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin

EVENT=$1
STREAMID=$2
LSTR=$4

N4HOST=11.22.33.44
case $EVENT in
	getsrvstr)
		LPORT=$(echo $LSTR | awk -F':' '{print $NF}')
		MYSTR=$(python3 ./n4.py -c -h $N4HOST -p 12710 -b ${LPORT})
		echo -n $MYSTR
		;;
	stoppost)
		exit 0
		;;
	*)
		echo "unknow event for $STREAMID"
		exit 0
		;;
esac
