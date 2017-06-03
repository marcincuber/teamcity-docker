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
Once your TCS is up and running, make sure you created your first user account and you configurated your data directory and DB. For the DB part you can use internal and no need to change it. There is no need to change data directory either for TCS.

### Start TCA
To spin up TCA, simply execute the following;

```sh
sh teamcity_launch_config.sh add_agent_1
//or
./teamcity_launch_config.sh add_agent_1
```
