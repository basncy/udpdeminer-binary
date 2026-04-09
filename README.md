# udpdeminer-binary

A TDD(Time Division Delivery) software that continuously delivery UDP package to random paths or customizable tunnels (hook tools), and aggressive on final destination to maximize network IO performance.

### Feature:
1. UDP forward on continuous random hop path change.
2. Load balance, multiple next-hop servers.
3. M to N port range forward.
4. Customize path wrapper.
5. No server-side installation for most UDP applications, including VPN.

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
  NAT Traversal, with [Link2Lan](https://github.com/basncy/link2lan) hook:
  ```
   UDP client --> udpdeminer(NAT/Public IP) >><< NAT/Reverse punching >><< UDP Relay ----> UDP server
  ```
  Expert: Remove down-stream relay-in-the-middle. complex setup with --hookpath, --dummystr, link2lan
  ```
                              <<<< DOWN, raw udp      <<<< UDP server  <----> example.com
   UDP client --> udpdeminer                                ^^^^
                              >>>> UP, via tunnel/CDN >>>> relay
  ```
### Quick Start Sample:
```
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
```
  -l, --listen <LISTEN>        Listen port. Can be range:12740-12741 [default: 12740-12741]
  -b, --bind <BIND>            Inbound listen IP [default: ::]
      --outbound <OUTBOUND>    Outbound IP. Can be ifname-index for dynamic IP. e.g. eth0-1 [default: ::]
  -s, --server <SERVER>        Next hop Domain or IP. multiple separate by comma. e.g. localhost,::1,127.0.0.1
      --maxoffset <MAXOFFSET>  Append hourly changing random offset to selected server. IPv6 only [default: 0]
  -p, --port <PORT>            Next hop Port number. Can be range: 12740-12741
  -i, --idlehop <IDLEHOP>      Seconds to hop when no data recieved [default: 28]
  -f, --forcehop <FORCEHOP>    Seconds to force hop. Can be range for randomization [default: 600-2400]
      --hookpath <HOOKPATH>    Path to external tools. To dynamically create wrapper servers, or handle hop events [default: ]
      --hookip <HOOKIP>        Redirect next hop to this IP, rewrite parameter $3 to hookip:port. (see more with '--help') [default: ]
      --hookports <HOOKPORTS>  Redirect next hop port to the one in this range, rewrite parameter $3 to hookip:port [default: 12850-12899]
      --dummystr <DUMMYSTR>    DIY a random endpoint stored in env UD_DUMMYENDPOINT every hop. can be used in hook scripts [default: ]
      --loglevel <LOGLEVEL>    Log level  0:no 1:error 2:warn 3:info 4:debug [default: 2]
```
#### Compatibility:
Wireguard, OpenVPN, juicity, hysteria, tinyfecVPN, Cloudflare WARP.

#### Tips:
  Idlehop, avoid UDP stream cutting out.

  Force hop, avoid long-time connections being QoS.

  Hook, wrap the raw UDP package.

  Hookip, customize your next hop.

  dummystr, print env in script to get UD_DUMMYENDPOINT instance value.
