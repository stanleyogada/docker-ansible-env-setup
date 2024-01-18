#!/bin/bash

# Have the script + sshd server run auto
#script_home_path="$HOME/scripts"

bashrc_path="$HOME/.bashrc";
bashrc_content_path="$HOME/.bootstrap-bashrc-content.txt";
script_path="$1";

if [[ -z $script_path ]]; then 
	echo "No script to inject to $bashrc_path! Pass the name of the script as arg.";
	cd $HOME;
	/bin/bash;
       	exit 128; 
fi;

has_content=`grep "$script_path" $bashrc_path`;
if [[ -z $has_content ]]; then
	cat $bashrc_content_path | sed "s/_SCRIPT_PATH/$script_path/g" >> $bashrc_path;

	echo "$script_path injected to $bashrc_path!";
else
	echo "$script_path already injected $bashrc_path! Skipping...";
fi;

/bin/bash;
