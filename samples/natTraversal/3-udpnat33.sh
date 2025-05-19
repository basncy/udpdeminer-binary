#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin
#1.2.3.4:5678 is placeholder, not used.
./udpdeminer-x86_64-unknown-linux-musl -l 12740 -s 1.2.3.4 -p 5678 --outbound 0.0.0.0 --idlehop 40 --forcehop 1200-2400 --hookpath ./nat33hook.sh --hookip customize
