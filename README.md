# udpdeminer-binary
1. N:1(multiple to one) Port forward with idle port hop feature
2. Simple anti-block from cellular to domestic UDP server.
3. Apply to most UDP applications, NO server-side installation.

### Quick Start:
```
Usage: udpdeminer [OPTIONS]

Options:
  -l, --listen <LISTEN>    Listen port. Can be range:12740-12749 [default: 12740-12749]
  -s, --server <SERVER>    Server String: domainname:port [default: localhost:12345]
  -i, --idlehop <IDLEHOP>  Seconds to hop when no data recieved. Smaller than keep-alive for VPN client [default: 23]
      --trydemine          Enable when failed to connect home server from cellular. Default: disabled
```

### Network Topology
  UDP client >>>> udpdeminer(server.com:12345, do port hop if idles on "idlehop" seconds) >>>> Internet >>>> server(:12345)

#### Tips:
  Setting keep-alive > idlehop time could enable port hop indirectly for some legacy UDP VPN clients.
  Hysteria itself could force changing port if enabled porthop  feature itself.
