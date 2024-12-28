# udpdeminer-binary
If you can't connect to your domestic UDP server with some application, bridge this application.
e.g. mobile celluler --> ISP(block) --> domestic UDP server

### Why me?
1. N:1 port forward, with idle-hop, simple anti-block.
2. NO server side modification.

### Quick Start:
  Your UDP server listens on server.com:12345, you want port hop after 28s idle time.
  
0. Download binary from https://github.com/basncy/udpdeminer-binary/releases
1. Start this program ./udpdeminer server.com 12345 28
2. Set the server to [::1]:12741 on your UDP client.

### Network Topology
#### Before:
  UDP client(server.com:12345) >>>> ISP(block) ---- server(:12345)
#### After:
  UDP client([::1]:12741-12749) >>>> udpdeminer(server.com:12345, hop per 28s idle time) >>>> ISP(pass) >>>> server(:12345)

#### NOT Work 1:
  UDP client([::1]:12741-12749) >>>> udpdeminer(vps.com:12345) >>>> Internet(advanced block) ---- vps(:12345)
#### NOT Work 2:
  UDP client(udpdeminder.com:12741-12749) >>>> ISP(block) ---- udpdeminer(vps.com:12345) ---- vps server(:12345)

#### Tips:
  Setting keep-alive > idlehop time could enable port hop for some legacy UDP client.
