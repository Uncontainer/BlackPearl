FROM debian:jessie
 
MAINTAINER Jonathan Kosgei "jonathan@saharacluster.com"

ADD build.sh  /opt/nginx/

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /opt/nginx/sources \
    /var/lib/nginx/body ;\
    apt-get update && apt-get -y  install \
    build-essential \
    wget \
    git \
    unzip \
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dbg \
    zlib1g-dev \
    libgeoip-dev ;\
    chmod +x /opt/nginx/build.sh ;\
    ./opt/nginx/build.sh ;\
    apt-get -y remove \
    build-essential\
    wget\
    git\
    unzip\
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dbg \
    zlib1g-dev \
    libgeoip-dev

ADD conf /etc/nginx

CMD nginx -g 'daemon off;'