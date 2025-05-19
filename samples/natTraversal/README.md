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
### Connection boot up progress:

  ```
0. UDP server start. e.g. hysteria server start.
1-nat33server.sh (Public IP) Start punch server. 
2-nat33relay.sh (NAT IP) Relay vps/container -> Punch server. 
3-udpnat33.sh (NAT IP) local client -> Punch server.
4. punching processing.
5. UDP client connection. e.g. hysteria client start.
  ```

### Patch n4.py:
0. If you trust me, use the patched n4.py from this repo [here](https://github.com/basncy/udpdeminer-binary/blob/main/samples/natTraversal/n4.py), then skip this step.

1. Download https://github.com/MikeWang000000/n4/blob/main/n4.py

2. Insert bellow [this line](https://github.com/MikeWang000000/n4/blob/f25eb71e9425c7a115afc7174cfa64ddf4767048/n4.py#L393), before "break":

```
print("{}:{}-{}".format(peer_ip, peer_port, src_port))
```

Then it looks like:

  ```
logging.info("> nc -u -p %d %s %d" % (src_port, peer_ip, peer_port))
print("{}:{}-{}".format(peer_ip, peer_port, src_port))
break
  ```
3. Change wait=10 into wait=2 [this line](https://github.com/MikeWang000000/n4/blob/f25eb71e9425c7a115afc7174cfa64ddf4767048/n4.py#L385)


### Tips:

Don't hop too quickly, or you will exceed limits very soon, e.g. udp connection, other network resource.

2-nat33relay.sh works on some free cloud services: cloud shell, vscode, container.

This feature requires version >= 1.3.0
