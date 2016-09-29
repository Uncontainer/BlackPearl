FROM debian:jessie

RUN apt-get update && apt-get install -y aptitude;\
    aptitude install -y \
    build-essential \
    wget \
    git \
    libtool \
    make ;\
    git clone https://github.com/pgbouncer/pgbouncer.git &&\
    cd pgbouncer &&\
    git submodule init &&\
    git submodule update &&\
    ./autogen.sh &&\
    ./configure ... &&\
    make &&\
    make install

COPY pgbouncer.ini /pgbouncer.ini

COPY users.txt /users.txt

ENTRYPOINT pgbouncer /pgbouncer.ini