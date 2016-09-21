FROM debian:jessie
 
MAINTAINER Jonathan Kosgei "jonathan@saharacluster.com"

ADD build.sh  /opt/python/

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /opt/python/sources ;\
    chmod +x /opt/python/build.sh ;\
    ./opt/python/build.sh