FROM jetbrains/teamcity-minimal-agent:latest

MAINTAINER marcin cuber

LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

RUN apt-get update && \
    apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && apt-get update && \
    apt-get install -y ant binutils curl git mercurial sudo openjdk-8-jdk apt-transport-https ca-certificates && \
    \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
    \
    apt-cache policy docker-engine && \
    apt-get update && \
    apt-get install -y docker-engine=1.13.0-0~ubuntu-xenial && \
    \
    apt-get install -y build-essential libssl-dev && \
    \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get install -y nodejs nano vim && \
    apt-get install -y python python-pip default-jdk crudini ruby ruby-dev rubygems unzip jq && \
    npm install -g gulp nsp grunt && \
    npm install npm@latest -g && \
    \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    \
    apt-get clean all && \
    \
    usermod -aG docker buildagent

COPY run-docker.sh /services/run-docker.sh
