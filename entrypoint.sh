#!/bin/sh 

set -e 
ifaddress=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
ifgateway=$(route -n | grep eth0 | grep UG | awk '{print $2}')
wg-quick up /etc/wireguard/wgcf.conf
echo "252     eth0" >> /etc/iproute2/rt_tables
ip rule add from $ifaddress lookup eth0
ip route add table eth0 default via $ifgateway
ss-server -s $ifaddress -p 8388 -k $key -m $method -u -d $dns
