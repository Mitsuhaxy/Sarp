# Sarp
Shadowsocks-libev+Warp
# Use:
1.put ```wgcf.conf``` to ```/etc/wireguard/``` 

2.modify ```docker-compose.yml``` to define your port,password,method,dns.

3.then

Build image:
```
docker build -t sarp .
```
Running:
```
docker-compose up -d
```
