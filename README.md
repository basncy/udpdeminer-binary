# udpdeminer-binary
If you can't connect to your domestic UDP server with some application, bridge this application.
e.g. mobile celluler --> ISP(block) --> domestic UDP server

### Why me?
1. Both single and port hop supported.
2. NO server side modification.

### Quick Start:
  Your UDP server listens on server.com:12345
  
0. Download binary from https://github.com/basncy/udpdeminer-binary/releases
1. Start this program ./udpdeminer server.com 12345
2. Set the server to [::1]:12741 on your UDP client.

### Network Topology
#### Before:
  UDP client(server.com:12345) -->> ISP(block) -->> UDP server(:12345)
#### After:
  UDP client([::1]:12741-12749) -->> udpdeminer(server.com:12345) -->> ISP(pass)-->> UDP server(:12345)
#### NOT Work:
  UDP client(server.com:12741-12749) -->> ISP(block) -->> udpdeminer(localhost:12345) -->> UDP server(:12345)
