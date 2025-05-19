#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin
#Envirounment
[ "v$N4HOST" = "v" ] && N4HOST=11.22.33.44
[ "v$N4PORT" = "v" ] && N4PORT=12710
[ "v$DESTIP" = "v" ] && DESTIP=8.8.8.8
[ "v$DESTPORT" = "v" ] && DESTPORT=9999
VERSION=v1.3.0

#Download binary
pkill udpdeminer
if [ ! -x ./udpdeminer ]; then
	curl "https://github.com/basncy/udpdeminer-binary/releases/download/${VERSION}/udpdeminer-x86_64-unknown-linux-musl" --location --retry-connrefused --retry 10 --fail -s -o udpdeminer
	#curl "https://github.com/basncy/udpdeminer-binary/releases/download/${VERSION}/udpdeminer-aarch64-unknown-linux-musl" --location --retry-connrefused --retry 10 --fail -s -o udpdeminer
        chmod +x udpdeminer
fi
if [ ! -x ./n4.py ]; then
	curl "https://raw.githubusercontent.com/basncy/udpdeminer-binary/refs/heads/main/samples/natTraversal/n4.py" --location --retry-connrefused --retry 10 --fail -s -o n4.py
	chmod +x n4.py
fi

while true; do
        KILLPID=$FWDPID
        MYSTR=$(python3 n4.py -c -x -h $N4HOST -p $N4PORT -b $((RANDOM + RANDOM + 1025)))
        (sleep 10 && kill -9 $KILLPID) &
        LPORT=$(echo $MYSTR|cut -d'-' -f2)
        ./udpdeminer -b 0.0.0.0 -l $LPORT --server $DESTIP --port $DESTPORT --outbound 0.0.0.0 & export FWDPID=$!
	#socat "udp-listen:$LPORT" 'udp6:[2603:c020:4:1200::a00:232]:10000' & FWDPID=$!
done
