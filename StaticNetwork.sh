#!/bin/bash

#this script should be replaced by one that uses ip address instead of iface and ifdown/ifup


ADAPTER=eth0
IPADDRESS=192.168.1.233
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNSNAMESERVER=192.168.1.1  #separate these with a whitespace

# turn off networking
ifdown $ADAPTER

# modify the /etc/network/interfaces file
cat >/etc/network/interfaces <<-__END__
iface $ADAPTER inet static
    address $IPADDRESS
    gateway $GATEWAY
    netmask $NETMASK
    dns-nameservers $DNSNAMESERVER
__END__

# start networking back up again.
ifup $ADAPTER

# possible other restart
# /etc/init.d/networking restart
# sudo systemctl networking.service restart
