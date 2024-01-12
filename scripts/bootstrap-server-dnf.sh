#!/bin/bash

# Install required server packages

	
dnf install -y iproute2 openssh-server;

echo
echo "You can now use 'ip', and 'sshd' packages!"


