#!/bin/bash

# Have the script + sshd server run auto
#script_home_path="$HOME/scripts"

bashrc_path="$HOME/.bashrc";
script_path="$1";

if [[ -z $script_path ]]; then 
	echo "No script to inject to $bashrc_path! Pass the name of the script as arg.";
	cd $HOME;
	/bin/bash;
       	exit 1; 
fi;

has_content=$(grep "$script_path" "$bashrc_path");
if [[ -z $has_content ]]; then
	cat >> "$bashrc_path" <<EOF
cd $HOME;

echo "This is a request to run auto-run script ($script_path) which was injected to this machine's ($HOME/.bashrc)."
echo "You don't have to run if you ran before, type (no)."
echo
echo "Type (yes) for the first time or if your wish to re-run the script."
echo
read -p "Do you want to continue? (yes/no) " ans;

if [[ ! \$ans == "yes" ]]; then
	echo "(no) was assumed!";
else
	$script_path;

	# If SSHD is not running and SSHD is installed
	if [[ -z \$(pgrep sshd) && -e /sbin/sshd ]]; then
		echo "Starting SSH daemon."
		/sbin/sshd -D &
	else
		echo "SSHD already running OR SSHD is not installed yet!"
	fi;
fi;
EOF

	echo "$script_path injected to $bashrc_path!";
else
	echo "$script_path already injected $bashrc_path! Skipping...";
fi;

/bin/bash;
