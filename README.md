# Sarp
Shadowsocks-libev+Warp
# Use:
1.put wgcf.conf to /etc/wireguard/ and delete all ipv6 setting.

2.modify sarp.yml to define your port,password,method.

3.then

Build image:
```
docker build -t sarp -< sarp.dockerfile
```
Running:
```
docker-compose -f sarp.yml up -d
```
