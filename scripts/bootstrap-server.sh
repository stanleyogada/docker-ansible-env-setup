#!/bin/bash


# Setup sshd service

if [[ -f /etc/ssh/ssh_host_ecdsa_key ]]; then
	echo
	echo "Skipping Config already working!"
else

	ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key;
	ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key;
	ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key;

	echo
	echo "SSHD service default keys is setup in '/etc/ssh'!"
fi;




# Create user and switch user
echo
echo "Enter user 'zero' passwd: "
useradd -ms /bin/bash -G sudo zero && passwd zero;
echo
echo "Enter user 'zero' passwd: "
su - zero;
