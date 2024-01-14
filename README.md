# DOCKER ANSIBLE LAB

> Note: \
> This will create 5 nodes in total \
> See the `docker-compose.yaml` and edit to your taste

> Note:
> Each of the 4 nodes (each server node) \
> have the following default user credentials on them. \
> username: **_zero_** \
> passwd: **_\][poiuy_**


## Prerequisites 
- Have **Docker** installed
- Have **Docker Compose** installed
- Start the Docker daemon

## Usage (FIRST)

1. Git clone the repo and cd to it.
2. Run `docker-compose up -d`.
3. For each node open a new terminal (open 5 more terminals)

## Usage for servers (SECOND)
1. Open a fresh terminal for each one
2. Run `docker container exec -it server-1 bash`
3. Then to make sure a user (_zero_) and SSH daemon are setup correctly, run `bash ~/scripts/bootstrap-server.sh`
   - The above script might prompt you for the following:
   - SSH default keys: just hit enter about 6 times for this.
4. Lastly to start the SSH daemon, run `/sbin/sshd -D &`

> Note: \
> The Above Usage assumes for server-1 \
> Repeat them for any other servers you have. \
> If you leave the docker-compose.yaml as it is, \
> then repeat 3 more times for `server-2`, `server-3`, and `server-4`.
> Eg. `docker container exec -it server-2 bash`
> Only **_Step 2_** will change then  **_Step 1_**, **_Step 3_**, and **_Step 4_** stays the same


## Usage for the control-host (THIRD)
1. Open a fresh terminal for each one
2. Run `docker container exec -it control-host bash`
3. To make sure all packages required to use ansible are installed and configure hostnames, run `bash ~/scripts/bootstrap-control.sh`
   - The above script might prompt you for the following:
   - Select your Geographical Area by typing the corresponding number.
   - NUMBER of servers: type 4 if you left the docker-compose untouched, otherwise type the number of servers you wish to control.
   - SSH keys: just hit enter about 2 times for this.
   - In about 4 four reps, Provide the _IP_ (You may need to run `ip a` in the server node to see the ip), any _HOSTNAME_, and user _zero_'s _PASSWORD_ which is **_\][poiuy_** to configure SSH keys for each of your server nodes.
4. Lastly enter the projects dir to start experimenting with ansible (configure your servers), run `cd ~/ansible-project`.
5. Happy hacking!
