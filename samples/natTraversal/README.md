### Features:
  ```
  1. Protocoless. No UDP header added.
  2. Reverse connection. From PUB to NAT connection.
  3. Anti QoS. TDD based hopping algorithm.
  4. Performance. RAW UDP package forwarding after success punching.
  ```
  Connection flow:
  ```
  UDP client --> udpdeminer(NAT IP) >>> NAT hole punching >>> UDP Relay(NAT IP) ----> UDP server(8.8.8.8:9999)
  ```
### Boot up steps:

Moved to [Link2Lan](https://github.com/basncy/link2lan)/cookbook/[natpunch](https://github.com/basncy/link2lan/tree/main/cookbook/natpunch).

### Tips:

Don't hop too quickly, or you will exceed limits very soon, e.g. udp connection, other network resource.

This feature requires version >= 1.3.0
