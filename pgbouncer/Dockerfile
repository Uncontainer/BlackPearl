FROM        debian:jessie
MAINTAINER  Sandeep <sss@redcarpetup.com>

ENV         DEBIAN_FRONTEND noninteractive

RUN         apt-get update && apt-get install -y aptitude;\
            mkdir -p /opt/nginx/sources \
            /var/lib/nginx/body \
            /usr/share/nginx/html \
            /etc/nginx/ssl \
            /etc/nginx/sites-available \
            /etc/nginx/sites-enabled;\
            aptitude install -y \
            build-essential \
            libtool \
            libevent-dev \
            autotools-dev \ 
            automake \ 
            wget \
            git \
            unzip \
            openssl \
            libpcre3 \
            libpcre3-dev \
            zlib1g \
            zlib1g-dbg \
            zlib1g-dev \
            libgeoip-dev 
RUN         apt-get install -y libc-ares2 \
        libc-ares-dev \
        libev4 \
        libev-dev \
        libevent-2.0-5 \
        libevent-dev \
        libssl1.0.0 \
        libssl-dev \
        libtool \
        pkg-config \
        wget  

RUN         git clone https://github.com/pgbouncer/pgbouncer.git && \  
            cd pgbouncer         && \
	          git submodule init   && \
	          git submodule update && \
	         ./autogen.sh         && \
	         ./configure --prefix=/usr/local --with-libevent=/usr/lib && \
	          make && make install && \ 
            apt-get purge -y --auto-remove && \
            rm -rf /var/lib/apt/lists/*

RUN         mkdir -p /etc/pgbouncer /var/log/pgbouncer /var/run/pgbouncer && \
  adduser --no-create-home --disabled-login --system pgbouncer  && \
  chown pgbouncer /var/run/pgbouncer 


ADD         etc/pgbouncer /etc/pgbouncer

ADD bin /bin

RUN chmod +X /bin/entry.sh

#EXPOSE      6432
ENTRYPOINT /bin/entry.sh