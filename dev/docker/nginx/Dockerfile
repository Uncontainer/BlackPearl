FROM debian:jessie
 
MAINTAINER Jonathan Kosgei "jonathan@saharacluster.com"

ADD deploy_rsa /home/deployer/.ssh/id_rsa

ADD build.sh  /opt/nginx/

ENV DEBIAN_FRONTEND noninteractive

RUN set -e;\
    useradd -d /home/deployer -m deployer ;\
    mkdir -p /home/deployer/.ssh ;\
    chown  deployer:deployer -R /home/deployer/.ssh/ ;\
    cd /home/deployer ;\
    chmod 700 /home/deployer/.ssh/id_rsa ;\
    chmod 700 /home/deployer/.ssh  ;\
    touch /home/deployer/.ssh/known_hosts ;\
    ssh-keyscan bitbucket.org > /home/deployer/.ssh/known_hosts

RUN set -e;
    mkdir -p /opt/nginx/sources \
    /var/lib/nginx/body ;\
    apt-get -y update && apt-get -y  install \
    build-essential\
    wget\
    git\   
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dbg \
    zlib1g-dev \
    libgeoip-dev ;\
    chmod +x /opt/nginx/build.sh ;\
    zsh -c /opt/nginx/build.sh ;\
    apt-get -y remove \
    build-essential\
    wget\
    git\   
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dbg \
    zlib1g-dev \
    libgeoip-dev

ADD conf /etc/nginx

CMD nginx -g 'daemon off;'