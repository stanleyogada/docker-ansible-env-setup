#!/bin/bash

# Have the script + sshd server run auto



script_path="$1";

if [[ -z $script_path ]]; then 
	echo "No script to inject to $bashrc_path! Pass the name of the script as arg.";
	/bin/bash;
       	exit 1; 
fi;

$script_path;

## The following assumes the script installed SSHD
/sbin/sshd -D &


/bin/bash;
