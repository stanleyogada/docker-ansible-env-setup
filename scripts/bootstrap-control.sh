#!/bin/bash

# Install all required packages
apt update && apt install -y rsync sudo iproute2 iputils-ping openssh-client vim git ansible;

echo 
echo "You can now use, 'rsync', 'sudo', 'ip', 'ping', 'ssh', 'git', 'vim' and 'ansible'"


# Config each server

read -p "NUMBER of servers? " nserver;
usern="zero";


## touch the hosts file
if [[ ! -f /etc/hosts.bkp ]]; then
       sudo cp /etc/hosts /etc/hosts.bkp;
else
       sudo cp /etc/hosts.bkp /etc/hosts;
fi;


keypath="$HOME/.ssh/ansible-key"

if [[ ! -f $keypath ]]; then
	ssh-keygen -t ed25519 -C "ANSIBLE KEY" -f $keypath
fi;

i=0
while [[ $i -lt $nserver ]];
do
	echo "Enter the info of your server number $(expr $1 + 1)! "
	read -p "IP? " ipaddr;
	read -p "HOSTNAME for ($ipaddr)? " hostn;

	echo "$ipaddr $hostn" | sudo tee -a /etc/hosts;
	echo
	echo "Edited the hosts config file!"

	ssh-copy-id -i "$keypath.pub" "$usern@$hostn";
	echo
	echo "Shh into $hostn with public key"

	let i++;	
done;

