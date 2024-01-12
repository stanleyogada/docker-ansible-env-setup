#!/bin/bash

# Install required server packages


apt update;
apt install -y iproute2 openssh-server;

echo
echo "You can now use 'ip', and 'sshd' packages!"
