#!/bin/bash

if [ -z "$POSTGRES_HOST" ]; then
    echo "Environment variable POSTGRES_HOST is not set!!!"
    exit 1
else 
    sed -i 's|POSTGRES_HOST|'"$POSTGRES_HOST"'|' /etc/stunnel.conf
fi

export HOME=/home/stunnel4

/usr/bin/stunnel4 /etc/stunnel.conf