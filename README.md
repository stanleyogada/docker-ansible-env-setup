# DOCKER ANSIBLE LAB


> Note: \
> This will create 5 nodes in total \
> 3 Ubuntu and 2 Oracle-Linux machines \
> See the `docker-compose.yaml`


## Prerequisites 
- Have **Docker** installed
- Have **Docker Compose** installed
- Start the Docker daemon
- You might want to add your user to the `docker` group for Ubuntu
- And optionally, install my version (_check the screenshot below_) of higher
![image](https://github.com/stanleyogada/docker-ansible-env-setup/assets/102979724/4bb5d9b6-4818-4a9a-ae61-4366663deedd)


## Usage

1. Git clone the repo and cd to it.
2. Run `docker-compose up -d`.
3. Then view the logs, run `docker-compose logs -f`
4. Wait for about 1-5 minutes for a message like "SUCCESS! ... Happy hacking!"
5. Your lab is ready!

### Usage for the control-host
1. Open a fresh terminal for each one
2. Run `docker container exec -it control-host bash`
3. Stay as root user.
4. Then in the container, run `cd ~/ansible-project` as this is your base ansible directory
5. Your lab is ready! You can now control and configure all servers. Run `ansible all -m ping` to test your servers' connections.


> Note:
> Each of the 4 nodes (each server node) \
> have the following default user credentials on them. \
> username: **_zero_** \
> password: **_\][poiuy_**

### Usage for servers (There are 4 four servers, this is an example for just server-1)
1. Open a fresh terminal for each one
2. Run `docker container exec -it server-1 bash`
3. Then switch to `zero` user, run `su - zero` use `\][poiuy` as the password.


[For more, also check out this blog post:](https://dev.to/stanleyogada/simplifying-ansible-lab-setup-with-docker-888)
