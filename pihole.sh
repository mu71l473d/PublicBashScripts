#!/bin/bash

#enable bionic main / bionic main universe in sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.orig
sudo sed -i 's/bionic main/bionic main universe/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get --no-install-recommends install dialog dhcpcd5 

#download and install pihole
curl -sSL https://install.pi-hole.net | bash

#configure pi-hole
# pihole -a -p
