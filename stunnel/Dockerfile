FROM        debian:jessie
MAINTAINER  Sandeep <sss@redcarpetup.com>

ENV         DEBIAN_FRONTEND noninteractive

RUN         mkdir -p /var/log/stunnel /var/run/stunnel && \
  addgroup stunnel4 && \
  adduser  --no-create-home --disabled-login --system stunnel4 --ingroup stunnel4 && \
  chown stunnel4 /var/run/stunnel 

RUN apt-get update && apt-get install -y stunnel4 && rm -rf /var/lib/apt/lists/*

USER stunnel4

ADD         etc/stunnel.conf /etc/

# The following flags have to be specified when starting this container:
# -network
# Refer to -help for documentation on them.
ENTRYPOINT ["/usr/bin/stunnel4", "/etc/stunnel.conf"]
