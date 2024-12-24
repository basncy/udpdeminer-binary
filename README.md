# udpdeminer-binary
If you can't connect to your domestic UDP server with some application, bridge this application.

### Why me?
1. Both single and port hop supported.
1. Does NOT change the server app behavior.

### Quick Start:
  Your UDP server listens on server.com:12345
1. Start this program ./udpdeminer server.com 12345
2. Set the server to localhost:12741 on your UDP client.

### Network Topology
#### Before:
  UDP client -->> ISP(block) -->> UDP server(server.com:12345)
#### After:
  UDP client -->> udpdeminer(localhost:12741-12749) -->> ISP(pass)-->> UDP server(server.com:12345)
#### NOT Work:
  UDP client -->> ISP(block) -->> udpdeminer(server.com:12741-12749) -->> UDP server(localhost:12345)
