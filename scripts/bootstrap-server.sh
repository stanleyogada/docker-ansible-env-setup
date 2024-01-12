#!/bin/bash

# Install required server packages

apt;
if [[ $? -eq 0 ]]; then
	apt update;
	apt install -y iproute2 openssh-server;
	echo
	echo "Debain detected!"
else
	dnf install -y iproute2 openssh-server;
	echo
	echo "Red-hat detected!"
fi;
echo
echo "You can now use 'ip', and 'sshd' packages!"


# Setup sshd service

ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key;
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key;
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key;
echo
echo "SSHD service default keys is setup in '/etc/ssh'!"


# ReStart the sshd service in the backgroud
pkill -9 sshd; # Stops the service
/sbin/sshd -D &; # Starts the sshd process in the backgroud (Starts the service)
echo
echo "SSH service is started!"

# Create user and switch user
echo
echo "Enter user 'zero' passwd: "
useradd -ms /bin/bash -G sudo zero && passwd zero;
echo
echo "Enter user 'zero' passwd: "
su - zero;
