#!/bin/bash

# Install all required packages
apt update && apt install -y rsync sudo iproute2 iputils-ping openssh-client vim git ansible;

echo 
echo "You can now use, 'rsync', 'sudo', 'ip', 'ping', 'ssh', 'git', 'vim' and 'ansible'"


# Config each server

ansibleHomePath="$HOME/ansible-project"
echo "" > "$ansibleHomePath/inventory"

read -p "NUMBER of servers? " nserver;
usern="zero"


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

	# Add to ansible inventory file
	mkdir -p $ansibleHomePath
	echo "$usern@$hostn" >> "$ansibleHomePath/inventory"

	let i++;	
done;


# Configure and test Ansible Servers

echo -e "[defaults]\ninventory=$ansibleHomePath/inventory\nprivate_key_file=$keypath" > $ansibleHomePath/ansible.cfg

cd $ansibleHomePath
ansible all -m ping

echo
echo "SUCCESS! You can configure you $nserver servers with ansible!"
echo "Run 'cd $ansibleHomePath' to start"
echo "Happy hacking!"

echo -e "Note: If any of your server node reported UNREACHABLE, make user your input the correct IP and ensure you ran '/sbin/sshd -D &' on the server node.\nIf you '/sbin/sshd -D &' job is exiting recrete the server node with docker-compose from your host machine using 'docker-compose up -d --force-recrete <service-name e.g node2>'.\n\nThank you."
