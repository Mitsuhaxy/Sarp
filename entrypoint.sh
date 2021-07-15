#!/bin/bash 
  
set -e
ifaddress=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
ifgateway=$(ip route | grep 'default' | awk '{print $3}')
if [ ! -d "/var/etc" ]; then
  mkdir /var/etc
fi
if [ ! -d "/var/etc/wireguard" ]; then
  mkdir /var/etc/wireguard
fi
if [ `grep -c "162.159.192.1 engage.cloudflareclient.com" /etc/hosts` == '0' ]; then
  echo "162.159.192.1 engage.cloudflareclient.com" >> /etc/hosts
fi
ip route add 162.159.192.1 via $ifgateway dev eth0
cp /etc/wireguard/wgcf.conf /var/etc/wireguard/wgcf.conf
sed -i '/MTU = 1280/a\Table = off'  /var/etc/wireguard/wgcf.conf
wg-quick up /var/etc/wireguard/wgcf.conf
if [ `grep -c "252     eth0" /etc/iproute2/rt_tables` == '0' ]; then
  echo "252     eth0" >> /etc/iproute2/rt_tables
fi
ip rule add from $ifaddress lookup eth0
ip route del default
ip route add default dev wgcf
ip route add table eth0 default via $ifgateway dev eth0
ip -6 route add default dev wgcf
ss-server -s $ifaddress -p 8388 -k $key -m $method -u -d $dns
