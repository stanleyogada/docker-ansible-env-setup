#!/bin/bash

# Set noninteractive for apt and set TimeZone environment for the tzdata pacakage
export DEBIAN_FRONTEND=noninteractive;
export TZ=Africa/Lagos;

# Install all required packages
apt update && apt install -y rsync sudo iproute2 iputils-ping openssh-client openssh-server vim git ansible;

echo 
echo "You can now use, 'rsync', 'sudo', 'ip', 'ping', 'ssh', 'git', 'vim' and 'ansible'"


# Config each server

ansibleHomePath="$HOME/ansible-project"
echo "" > "$ansibleHomePath/inventory";

usern="zero";
pass="\][poiuy";

## touch the hosts file
if [[ ! -f /etc/hosts.bkp ]]; then
       sudo cp /etc/hosts /etc/hosts.bkp;
else
       sudo cp /etc/hosts.bkp /etc/hosts;
fi;

keypath="$HOME/.ssh/ansible-key";
rm $HOME/.ssh/known*;

if [[ ! -f $keypath ]]; then
	ssh-keygen -t ed25519 -C "ANSIBLE KEY" -f $keypath -N "";
fi;

network="172.18.0";
current_host=3;
end_host=6;
n=1;
while [[ $current_host -le $end_host ]];
do
	ipaddr="$network.$current_host"
	hostn="server-$n"

	echo "$ipaddr $hostn" | sudo tee -a /etc/hosts;
	echo
	echo "Edited the hosts config file!"

	sshpass -p "$pass" ssh-copy-id -o StrictHostKeyChecking=no -i "$keypath.pub" "$usern@$hostn";
	echo
	echo "SSH public-key ("$keypath.pub") copied to $usern@$hostn"

	# Add to ansible inventory file
	mkdir -p $ansibleHomePath;
	echo "$usern@$hostn" >> "$ansibleHomePath/inventory";

	let current_host++;
	let n++;
done;


# Configure and test Ansible Servers

echo -e "[defaults]\ninventory=$ansibleHomePath/inventory\nprivate_key_file=$keypath" > $ansibleHomePath/ansible.cfg;

cd $ansibleHomePath
git init;
ansible all -m ping;

echo
echo "SUCCESS! You can configure you $nserver servers with ansible!"
echo
echo "Run 'cd $ansibleHomePath' to start"
echo "Happy hacking!"
echo
echo -e "Note: If any of your server node reported UNREACHABLE, make sure you have input the correct IP for that server node and ensure you ran '/sbin/sshd -D &' on that server node.\nIf you '/sbin/sshd -D &' job is exiting recrete the server node with docker-compose from your host machine using 'docker-compose up -d --force-recrete <service-name e.g node2>'.\n\nThank you."
