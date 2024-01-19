# DOCKER ANSIBLE LAB

> Note: \
> This will create 5 nodes in total \
> See the `docker-compose.yaml`


> Note:
> Each of the 4 nodes (each server node) \
> have the following default user credentials on them. \
> username: **_zero_** \
> passwd: **_\][poiuy_**

## Prerequisites 
- Have **Docker** installed
- Have **Docker Compose** installed
- Start the Docker daemon
- You might want to add your user to the `docker` group for Ubuntu

## Usage

1. Git clone the repo and cd to it.
2. Run `docker-compose up -d`.
3. Then view the logs, run `docker-compose logs -f`
4. Wait for about 1-5 minutes for a message like "SUCCESS! ... Happy hacking!"
5. Your lab is ready!

### Usage for the control-host
1. Open a fresh terminal for each one
2. Run `docker container exec -it control-host bash`
3. Then in the container, run `cd ~/ansible-project` as this is your base ansible directory
4. Your lab is ready! You can now control and configure all servers. Run `ansible all -m ping` to test your servers connnections.


### Usage for servers (There are 4 four servers, this is an example for just server-1)
1. Open a fresh terminal for each one
2. Run `docker container exec -it server-1 bash`

