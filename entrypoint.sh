#!/bin/sh 

set -e
ifaddress=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
ifgateway=$(ip route | grep 'default' | awk '{print $3}')
cp /etc/wireguard/wgcf.conf /etc/wireguard/sarp.conf
sed -i '/MTU = 1280/a\Table = off'  /etc/wireguard/sarp.conf
ip route add 162.159.192.1 via $ifgateway
wg-quick up /etc/wireguard/sarp.conf
echo "252     eth0" >> /etc/iproute2/rt_tables
ip rule add from $ifaddress lookup eth0
ip route del default
ip route add default dev wgcf
ip route add table eth0 default via $ifgateway dev eth0
ip -6 route add default dev wgcf 
ss-server -s $ifaddress -p 8388 -k $key -m $method -u -d $dns
