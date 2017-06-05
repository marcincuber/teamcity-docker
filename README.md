# TeamCity Server and Agent dockerized

## Running TeamCity Server(TCS) as a docker daemon
To spin up your TeamCity Server make sure you have the required docker images.

You can simply run;

```sh
chmod +x teamcity_launch_config.sh
./teamcity_launch_config.sh download
```

### Start TCS
To start your TCS run;

```sh
sh teamcity_launch_config.sh start
//or
./teamcity_launch_config.sh start
```

### Restart TCS
To restart your TCS;

```sh
./teamcity_launch_config.sh restart
```

### Backup TCS
To backup TCS project configuration execute;

```sh
./teamcity_launch_config.sh backup
```

It will spin a production quality TCS and will spit out the IP address at which you can access your server.

## TeamCity Agent(TCA) as a docker daemon
Agent mainly created for Node applications.

Once your TCS is up and running, make sure you created your first user account and you configurated your data directory and DB. For the DB part you can use internal and no need to change it. There is no need to change data directory either for TCS.

### Start TCA
To spin up TCA, simply execute the following;

```sh
sh teamcity_launch_config.sh add_agent_1
//or
./teamcity_launch_config.sh add_agent_1
```

### TCA Under The Hood
This image is built on top of TeamCity base image which includes:

ubuntu:xenial (16.04)
Oracle JRE 8 Update 121, 64 bit
ant, binutils, curl, git, mercurial, sudo, unzip
ca-certificates
build-essential libssl-dev
Node 6
nano vim
python, python-pip, default-jdk, crudini, ruby, ruby-dev, rubygems, jq
npm with gulp, nsp, grunt
nvm, rvm
docker-engine v.1.10.3 (TeamCity agent 10.0)

### Customise your TCA
You can customise the image in the usual way and like and other Docker image:

When you have a running container for your agent you can simply;
```sh
docker exec -it <name-of-the-running-container-tobe-customised-agent> bash
//Edit/Install/Remove/Amend anything
//Exit container
```

After you exitted your edited container simply modify your image by running;

```sh
docker commit <name-of-the-running-container-tobe-customised-agent> <the registry where you what to store the image>
```
