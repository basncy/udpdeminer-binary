# udpdeminer-binary

A TDD(Time Division Delivery) software that continuously delivery UDP package to random paths or customizable tunnels (hook tools), and aggressive on final destination to maximize network IO performance.

### Feature:
1. UDP forward on continuous random hop path change.
2. Load balance, multiple next-hop servers.
3. M to N port range forward.
4. Hook event for external program calling.
5. No server-side installation for most UDP applications, including VPN.
6. Continues dns resolving for DDNS domain.

### Network Topology Example
  Bridge:
  ```
UDP client >> udpdeminer -->> Internet -->> UDP server
  ```
Wrapper hook:
  ```
                              > wrapper c1 --> ISP --> wrapper s1 >>
   VPN client --> udpdeminer >> raw UDP package ( TDD path hop )  >> (DNAT, or None) -> VPN server
                              > wrapper c2 --> ISP --> wrapper s2 >>
  ```
IP rotation with independent TX/RX paths, buildin hook feature. version 1.6.0+:
  ```
                              <<<< DOWN   <<<< UDP server  <----> example.com
   UDP client --> udpdeminer                    ^^^^
                              >>>> UP     >>>> forward
  ```
  Continues DNS updating (NOT onetime resolve on startup), version 1.5.2+:
```
./udpdeminer -l 12740 -s myip.iloveyou.null -p 51820 --dnsresolver 104.3.2.1:5353 --dnsinterval 300
On 104.3.2.1, dnsmasq --port=5353 --host-record=myip.iloveyou.null,2001:db8::123
```
  hookpath heartbeat event, e.g. ddns update. version 1.5.2+:
```
./udpdeminer -s 1.2.3.4 -p 5678 --hookpath echo --hookheartbeat 2 --loglevel 4
```
### Quick Start Sample:
```
./udpdeminer --help

Client：
wireguard wg0.conf: Endpoint=[::1]:12740
./udpdeminer -s wgip -p 51820
Server(optional, replace DNAT):
./udpdeminer -l 51821-51830 -s ::1 -p 51820
```
### More Start Options:
#### Windows bat
```
chcp 65001
::WIN CR LF UTF-8
cd /d "%~dp0"

for /f "usebackq eol=# tokens=1,* delims==" %%A in ("env.ini") do (
    set "%%A=%%B"
)

taskkill /F /IM udpdeminer-x86_64-pc-windows-gnu.exe
start /min udpdeminer-x86_64-pc-windows-gnu.exe -b 0.0.0.0 -l 12740 -s %SRVIP% -p %SRVPORT% --outbound 0.0.0.0 -i 15 --hookpath "winhook.bat"
```
#### Linux supervisor
```
[program:udpdeminer]
environment=MYKEYA="myvalue_a",
        MYKEYB="myvalue_b"
command=/path/to/udpdeminer-x86_64-unknown-linux-musl -l 12740 -s 2001:db8::1000 --maxoffset 10000 -p 1234 --outbound :: -i 15 --hookpath /path/to/hook6.sh
autostart=true
autorestart=true
```
#### Android/Linux shell
cat action.sh
```
#!/system/bin/sh
cd $(dirname $0)
. "./vars.sh"

watchdog_alive() {
    [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null
}

if watchdog_alive; then
        rm -f "$FLAG"
        [ -f "$ALICEPIDFILE" ] && kill "$(cat "$ALICEPIDFILE")" 2>/dev/null
        [ -f "$BOBPIDFILE" ] && kill "$(cat "$BOBDFILE")" 2>/dev/null
else
        chmod +x ./*.so
        touch "$FLAG"
        nohup sh "./watchdog.sh" 2>/dev/null &
        sleep 1
fi

```
cat watchdog.sh
```
#!/system/bin/sh
cd $(dirname $0)
. "./vars.sh"

echo $$ > "$PIDFILE"

run_alice(){
        while [ -f "$FLAG" ]; do
                #./libudpdeminer.so -l 12740 -s myip.iloveyou.null -p 51820 --dnsresolver 104.3.2.1:5353 --dnsinterval 30 --hookpath ./myscript.sh --hookheartbeat 60 &
                ./libudpdeminer.so -l 12740 -s myip.iloveyou.null -p 51820 --dnsresolver 104.3.2.1:5353 --dnsinterval 30 &
                ALICEPID=$!
                echo "$ALICEPID" > "$ALICEPIDFILE"
                wait "$ALICEPID"

                [ -f "$FLAG" ] || break
                sleep 5
        done
}

run_bob(){
        while [ -f "$FLAG" ]; do
                ./libwireproxy.so --config ./wireproxy.conf &
                BOBPID=$!
                echo "$BOBPID" > "$BOBPIDFILE"
                wait "$BOBPID"

                [ -f "$FLAG" ] || break
                sleep 5
        done
}

run_alice &
run_bob
```
cat vars.sh
```
cd $(dirname $0)
MODDIR=$(pwd)
PIDFILE="$MODDIR/app_watchdog.pid"
FLAG="$MODDIR/apps.enable"
ALICEPIDFILE="$MODDIR/app_alice.pid"
BOBPIDFILE="$MODDIR/app_bob.pid"
```
### Hook event examples:
```
#### Replace "--hookpath echo" to your script path
# startpre: execute before connect to server. e.g. customize path wrapper, route setting.
trigger parameter: --hookip 127.0.0.1 --hookpath echo
# getsrvstr: redirect to new target, like DNAT --to-destination. e.g. for NAT punch, or customize server choice between daytime and nightime
trigger parameter: --hookip customize --hookpath myscript
# stoppost: do clean work for different client. BUT I encourage do cleaning work on startpre/getsrvstr event.
trigger parameter: --hookpath echo
# heartbeat: do some regular tasks, like cron job. e.g. DDNS, status checking/updating/reporting
trigger parameter: --hookpath echo --hookheartbeat 60
```
#### Compatibility:
Wireguard, OpenVPN, juicity, hysteria, tinyfecVPN, Cloudflare WARP.

#### Tips:
  Idlehop, avoid UDP stream cutting out.

  Force hop, avoid long-time connections being QoS.

  Hook, wrap the raw UDP package.

  Hookip, customize your next hop.

  dummystr, print env in script to get UD_DUMMYENDPOINT instance value.
