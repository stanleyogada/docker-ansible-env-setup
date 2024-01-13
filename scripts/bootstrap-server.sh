#!/bin/bash


# Install required server packages


dnf install -y sudo vim rsync;
if [[ ! $? -eq 0 ]]; then 
	apt update && apt install -y iproute2 openssh-server sudo vim rsync;
fi; 

echo
echo "You can now use 'ip', and 'sshd' packages!"





# Setup sshd service

# Creates the /run/sshd dir as it's required to start the sshd service using `/sbin/sshd -D`
if [[ ! -e /run/sshd ]]; then mkdir /run/sshd; fi;

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
if [[ ! $? -eq 0 ]]; then useradd -ms /bin/bash -G wheel zero && passwd zero; fi; 
echo
echo "Enter user 'zero' passwd: "
su - zero;
#!/bin/bash



