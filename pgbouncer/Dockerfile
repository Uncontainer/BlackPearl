FROM debian:jessie

RUN apt-get update && apt-get install -y pgbouncer stunnel4

RUN chown -R stunnel4:stunnel4 /var/run/stunnel4 && touch /var/run/rsyslogd.pid  &&  rm /var/run/rsyslogd.pid

RUN mkdir -p /var/run/pgbouncer

ADD stunnel.conf /etc/stunnel/stunnel-pgbouncer.conf

ADD rds-combined-ca-bundle.pem /etc/stunnel/rds-combined-ca-bundle.pem

ADD pgbouncer-users.txt /etc/pgbouncer/users.txt

ADD pgbouncer.ini /etc/pgbouncer/pgbouncer.ini

ADD pgbouncer-cherry.ini /etc/pgbouncer/pgbouncer-cherry.ini

ENTRYPOINT pgbouncer /pgbouncer.ini
