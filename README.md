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

### Docker Hub repository link
[To access my Docker Hub Repository Click Me](https://hub.docker.com/r/marcincuber/teamcity-agent/)
`
### TCA-node6 Under The Hood
Image available to be pulled from my docker hub. To do so run;
```
docker pull marcincuber/teamcity-agent:node6
```
Dockerfile for this agent can be found in `build_dck_agent_node6` folder.
This image is built on top of TeamCity base image which includes:

1. ubuntu:xenial (16.04)
2. Oracle JRE 8 Update 121, 64 bit
3. ant, binutils, curl, git, mercurial, sudo, unzip
4. ca-certificates
5. build-essential libssl-dev
6. Node 6-latest
7. nano vim
8. python, python-pip, default-jdk, crudini, ruby, ruby-dev, rubygems, jq
9. npm with gulp, nsp, grunt
10. nvm, rvm
11. docker-engine v.1.10.3 (TeamCity agent 10.0)

### TCA-k8s_aws Under The Hood
Image available to be pulled from my docker hub. To do so run;
```
docker pull marcincuber/teamcity-agent:k8s-aws-full
```
Dockerfile for this agent can be found in `build_dck_agent_k8s_aws` folder. This is an extension of the node6 agent with support for 'Kubernetes (k8s)' and cloud.
Additionall list of packages;

1. zlib1g-dev, libreadline-dev, libyaml-dev, libsqlite3-dev
2. sqlite3, libxml2-dev, libxslt1-dev, libcurl4-openssl-dev 
3. python-software-properties, libffi-dev, libgdbm-dev 
4. libncurses5-dev, automake, libtool, bison, libffi-dev
5. mysql-client-core-5.7, postgresql-client postgresql-contrib libpq-dev pgadmin3
6. `AWS` cli
7. `Kubectl` cli for Kubernetes cluster manipulation
8. `Kops` tool to create and deploy ready clusters in AWS account 

Base pack;

1. ubuntu:xenial (16.04)
2. Oracle JRE 8 Update 121, 64 bit
3. ant, binutils, curl, git, mercurial, sudo, unzip
4. ca-certificates
5. build-essential libssl-dev
6. Node 6-latest
7. nano vim
8. python, python-pip, default-jdk, crudini, ruby, ruby-dev, rubygems, jq
9. npm with gulp, nsp, grunt
10. nvm, rvm
11. docker-engine v.1.10.3 (TeamCity agent 10.0)

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
