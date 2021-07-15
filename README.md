*Shadowsocks-libev+Warp(Base-Alpine)*  
Host need 5.4+ kernel  
Centos view [wireguard docment](https://www.wireguard.com/install/#centos-7-module-plus-module-kmod-module-dkms-tools)
  
# How to use:
1.Build image:
```
git clone -b base-alpine https://github.com/Mitsuhaxy/Sarp.git
cd ./Sarp
docker build -t sarp:alpine .
```
  
2.Put ```wgcf.conf``` to ```/etc/wireguard/``` .
  
3.Modify ```docker-compose.yml``` to define your port,password,method,dns.
  
4.Running:
```
docker-compose up -d
```


