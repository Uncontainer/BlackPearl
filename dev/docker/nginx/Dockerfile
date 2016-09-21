FROM debian:jessie
 
MAINTAINER Jonathan Kosgei "jonathan@saharacluster.com"

ADD build.sh  /opt/nginx/

RUN chmod +x /opt/nginx/build.sh

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y aptitude;\
    mkdir -p /opt/nginx/sources \
    /var/lib/nginx/body ;\
    aptitude install -y \
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
    ./opt/nginx/build.sh ;\
    aptitude -fy remove \
    build-essential\
    wget\
    git

#ADD conf /etc/nginx

CMD nginx -g 'daemon off;'