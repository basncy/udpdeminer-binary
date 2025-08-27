#!/bin/bash
cd $(dirname $0)

start_program() {
        echo "Starting $1..."
        while true; do
                "$@"
                echo "$1 exited. Restarting in 5 seconds..." >&2
                sleep 5
        done
}

start_program /usr/bin/myudpclient client -c config.yaml --log-level error &

start_program ./udpdeminer-x86_64-unknown-linux-musl -l 1234 -s 1.2.3.4 -p 5678 --outbound 0.0.0.0 --hookpath ./hook.sh &

wait
