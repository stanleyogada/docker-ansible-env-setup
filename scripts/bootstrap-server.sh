#!/bin/bash


# Install required server packages


dnf install -y sudo vim rsync;
if [[ ! $? -eq 0 ]]; then 
	apt update && apt install -y iputils-ping iproute2 openssh-server sudo vim rsync;
fi; 




# Setup sshd service

# Creates the /run/sshd dir as it's required to start the sshd service using `/sbin/sshd -D`
if [[ ! -e /run/sshd ]]; then mkdir /run/sshd; fi;

if [[ -f /etc/ssh/ssh_host_ecdsa_key ]]; then
	echo
	echo "Skipping Config already working!"
else

	ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N "";
	ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N "";
	ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "";

	echo
	echo "SSHD service default keys is setup in '/etc/ssh'!";
fi;




# Create user and switch user
usern=zero

useradd -ms /bin/bash -G sudo $usern;
# Handle case for RedHat nodes
if [[ ! $? -eq 0 ]]; then useradd -ms /bin/bash -G wheel $usern; fi; 

# Add default passwd
pass="\][poiuy"
echo -e "$pass\n$pass" | passwd $usern;

echo
echo "A user '$usern' was created with passwd '$pass'"

