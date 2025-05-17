#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin

EVENT=$1
STREAMID=$2
LSTR=$4

N4HOST=35.212.161.24
case $EVENT in
	test)
		python3 ./n4.py -c -h $SRVIP -p 12710 -b $((RANDOM + 20000))
		;;
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
