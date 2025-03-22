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

### Quick Start Sample:
```
Client：
wireguard wg0.conf: Endpoint=[::1]:12740
./udpdeminer -s wgip -p 51820
Server(optional, replace DNAT):
./udpdeminer -l 51821-51830 -s ::1 -p 51820
```
```
  -l, --listen <LISTEN>        Listen port. Can be range:12740-12741 [default: 12740-12741]
  -b, --bind <BIND>            Inbound listen IP [default: ::]
      --outbound <OUTBOUND>    Outbound IP. Can be ifname-index for dynamic IP. e.g. eth0-1 [default: ::]
  -s, --server <SERVER>        Next hop Domain or IP. multiple separate by comma. e.g. localhost,::1,127.0.0.1
      --maxoffset <MAXOFFSET>  Append hourly changing random offset to selected server. IPv6 only. [default: 0]
  -p, --port <PORT>            Next hop Port number. Can be range: 12740-12741
  -i, --idlehop <IDLEHOP>      Seconds to hop when no data recieved [default: 28]
  -f, --forcehop <FORCEHOP>    Senconds to force hop. Can be range for randomization [default: 50-1200]
      --hookpath <HOOKPATH>    Path to external tools. To dynamically create wrapper servers, or handle hop events [default: ]
      --hookip <HOOKIP>        Redirect next hop to this IP, also pass to hookpath as parameter. Leave empty to disable redirect [default: ]
      --hookports <HOOKPORTS>  Redirect next hop port to the one in this range, also pass to hookpath as parameter [default: 12850-12899]
      --loglevel <LOGLEVEL>    Log level  0:no 1:error 2:warn 3:info 4:debug [default: 2]
  -h, --help                   Print help
  -V, --version                Print version
```
#### Compatibility:
Wireguard, OpenVPN, juicity, hysteria, tinyfecVPN, Cloudflare WARP.

#### Tips:
  Passive hop， set keep-alive > idlehop in legacy UDP application, like Wireguard.
  
  Active hop， set app-hop-time < idlehop, like hysteria2.
  
  Force hop, avoid long-time connections being QoS.

  Hook, wrap you UDP package on hop path.
