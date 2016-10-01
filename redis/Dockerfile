FROM redis

COPY redis.conf /usr/local/etc/redis/redis.conf

RUN mkdir -p /redis
RUN chown redis:redis /redis

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
