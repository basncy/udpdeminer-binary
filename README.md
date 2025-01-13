# udpdeminer-binary

Maximize UDP application network IO performance.

### Feature:
1. UDP forward on continuous random hop path change.
2. Load balance, multiple next-hop servers.
3. M to N port range forward.
4. Mesh path forward.
5. Apply to most UDP applications, including VPN, without server-side installation.

### Network Topology Example
  Bridge:
  ```
UDP client >> udpdeminer -->> Internet -->> UDP server
```
  Wrapper hook:
  ```
UDP client >> udpdeminer >> wrapper client -->> Internet -->> wrapper server >> UDP server
```
  
  Mesh:
```
                              > udpdeminer --> udpdeminer -->...>
   VPN client --> udpdeminer >>  ( continues random path hop )  >> udpdeminer(or DNAT, or None) -> VPN server
                              > udpdeminer --> udpdeminer -->...>
```

### Quick Start:
```
  -b, --bind <BIND>            Bind listen IP [default: [::]]
  -l, --listen <LISTEN>        Listen port. Can be range:12740-12741 [default: 12740-12741]
  -s, --server <SERVER>        Target Domain or IP. multiple separate by comma. e.g. localhost,::1,127.0.0.1
  -p, --port <PORT>            Target Port number. Can be range: 12740-12741
  -i, --idlehop <IDLEHOP>      Seconds to hop when no data recieved [default: 28]
  -f, --forcehop <FORCEHOP>    Force hop time [default: 1200]
      --hookpath <HOOKPATH>    Path to external tools to handle hop events. Experimental, linux only [default: ]
      --hookip <HOOKIP>        IP that ask hook tools to listen. Experimental, linux only. Usually 127.0.0.1 for wrapper tool [default: ]
      --hookports <HOOKPORTS>  Port that ask hook tools to listen. Experimental, linux only [default: 12850-12899]
      --loglevel <LOGLEVEL>    Log level  0:no 1:error 2:warn 3:info 4:debug [default: 2]
  -h, --help                   Print help
  -V, --version                Print version

```

#### Tips:
  Passive hop， set keep-alive > idlehop in legacy UDP application, like Wireguard.
  
  Active hop， set app-hop-time < idlehop, like hysteria2.
  
  Force hop, avoid long-time connections being QoS.

  Hook, start/stop external tools on event startpre/stoppost.
