# udpdeminer-binary

### Feature:
1. UDP Port forward with idle and force source port change.
2. M to N port range forward.
3. Chain forward.
4. Apply to most UDP applications, including VPN, with NO server-side installation.

### Network Topology
  Bridge Mode: UDP client >> udpdeminer >> UDP server
  
  Chain Mode: UDP client >> udpdeminer >> udpdeminer >> ... >> udpdeminer>> UDP server

### Quick Start:
```
Usage: udpdeminer [OPTIONS] --server <SERVER> --port <PORT>

Options:
  -l, --listen <LISTEN>      Listen port. Can be range:12740-12749 [default: 12740-12742]
  -s, --server <SERVER>      Target Domain or IP
  -p, --port <PORT>          Target Port number. Can be range: 12300-12340
  -i, --idlehop <IDLEHOP>    Seconds to hop when no data recieved. Smaller than keep-alive for VPN client [default: 28]
  -f, --forcehop <FORCEHOP>  Force hop time [default: 1200]
      --loglevel <LOGLEVEL>  Log level  0:no 1:error 2:warn 3:info 4:debug [default: 2]
  -h, --help                 Print help
  -V, --version              Print version

```

#### Tips:
  Passive hop， set keep-alive > idlehop in legacy UDP application, like OpenVPN.
  
  Active hop， set app-hop-time < idlehop in hysteria2.
  
  Force hop, avoid long-time connections being QoS.



  ```
  ###openvpn-server.conf sample
  float
  #duplicate-cn
````
