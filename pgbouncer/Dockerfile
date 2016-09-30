FROM debian:jessie

RUN apt-get update && apt-get install -y pgbouncer stunnel4

ADD pgbouncer.ini /pgbouncer.ini

ADD users.txt /users.txt

ENTRYPOINT pgbouncer /pgbouncer.ini
