#!/bin/bash

if [ -z $1 ]; then
	echo "[-] usage: ./adduser.sh username"
else	
	adduser $1
	sudo usermod -aG sudo $1
fi
