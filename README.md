# udpdeminer-binary

1. UDP Port forward with idle and force port hop feature.
3. Apply to most UDP applications, including VPN, NO server-side installation.

### Quick Start:
```
Usage: udpdeminer [OPTIONS] --server <SERVER> --port <PORT>

Options:
  -l, --listen <LISTEN>      Listen port. Can be range:12740-12749 [default: 12740-12749]
  -s, --server <SERVER>      Target Domain or IP
  -p, --port <PORT>          Target Port number. Can be range: 12300-12340
  -i, --idlehop <IDLEHOP>    Seconds to hop when no data recieved. Smaller than keep-alive for VPN client [default: 23]
      --loglevel <LOGLEVEL>  Log level  0:no 1:error 2:warn 3:info 4:debug [default: 2]
  -h, --help                 Print help
  -V, --version              Print version

```

### Network Topology
  UDP client(localhost:12740) >>>> udpdeminer(server.com:12345) >>>> Internet >>>> server(:12345)

#### Tips:
  For VPN client, set keep-alive > idlehop time could enable port hop indirectly.
  
  For OpenVPN server, add float and comment duplicate-cn in server.conf to avoid client IP change during hop
  ```
  ###openvpn-server.conf
  float
  #duplicate-cn
````
