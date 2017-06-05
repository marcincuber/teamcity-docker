FROM jetbrains/teamcity-minimal-agent:latest

MAINTAINER marcin cuber

LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

RUN apt-get update && \
    apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && apt-get update && \
    apt-get install -y ant binutils curl git git-core mercurial nginx sudo openjdk-8-jdk wget apt-transport-https ca-certificates && \
    \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
    \
    apt-cache policy docker-engine && \
    apt-get update && \
    apt-get install -y docker-engine=1.13.0-0~ubuntu-xenial && \
    apt-get install -y python python-pip default-jdk crudini ruby ruby-dev rubygems unzip jq && \
    \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    \
    apt-get install -y build-essential libssl-dev zlib1g-dev libreadline-dev libyaml-dev libsqlite3-dev && \
    apt-get install -y sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev && \
    apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev && \
    apt-get install -y mysql-client-core-5.7 postgresql-client postgresql-contrib libpq-dev pgadmin3 && \
    \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get install -y nodejs nano vim && \
    npm install -g gulp nsp grunt && \
    npm install npm@latest -g && \
    \
    pip install --upgrade pip && \
    pip install awscli && \
    \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    \
    wget https://github.com/kubernetes/kops/releases/download/1.5.3/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/local/bin/kops && \
    \
    apt-get clean all && \
    \
    usermod -aG docker buildagent

COPY run-docker.sh /services/run-docker.sh
