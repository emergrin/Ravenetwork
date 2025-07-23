#!/bin/bash

iptables -F
iptables -X
iptables -t nat -F
iptables -t mangle -F

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -N LOGDROP
iptables -N DMZ_ACCESS
iptables -N LAN_ACCESS
iptables -N SYN_FLOOD

iptables -A LOGDROP -m limit --limit 5/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
iptables -A LOGDROP -j DROP

iptables -A INPUT -i eth0 -s 10.10.0.0/16 -j LOGDROP

iptables -A INPUT -p tcp --syn -m limit --limit 10/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -p tcp --syn -j LOGDROP

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT


iptables -A INPUT -i eth1 -j LAN_ACCESS

iptables -A LAN_ACCESS -p tcp --dport 22 -j ACCEPT  
iptables -A LAN_ACCESS -p tcp --dport 53 -j ACCEPT  
iptables -A LAN_ACCESS -p udp --dport 53 -j ACCEPT
iptables -A LAN_ACCESS -p tcp --dport 80 -j ACCEPT  
iptables -A LAN_ACCESS -p tcp --dport 443 -j ACCEPT 
iptables -A LAN_ACCESS -j LOGDROP

iptables -A INPUT -i eth2 -j DMZ_ACCESS

iptables -A DMZ_ACCESS -p tcp --dport 25 -j ACCEPT  
iptables -A DMZ_ACCESS -p tcp --dport 80 -j ACCEPT  
iptables -A DMZ_ACCESS -p tcp --dport 443 -j ACCEPT 
iptables -A DMZ_ACCESS -j LOGDROP

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -i eth2 -o eth0 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -o eth2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -A POSTROUTING -o eth0 -s 10.10.0.0/16 -j MASQUERADE

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination 10.10.100.10:80
iptables -A FORWARD -p tcp -d 10.10.100.10 --dport 80 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 25 -j DNAT --to-destination 10.10.100.20:25
iptables -A FORWARD -p tcp -d 10.10.100.20 --dport 25 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT