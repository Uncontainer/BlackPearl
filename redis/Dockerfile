FROM redis

COPY redis.conf /usr/local/etc/redis/redis.conf

RUN mkdir -p /redis
RUN chown redis:redis /redis

ADD supervisord.conf /
RUN apt-get install supervisor -y &&\
    mkdir -p /var/log/redis

ENTRYPOINT supervisord -c /supervisord.conf
