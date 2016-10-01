#!/bin/bash

if [ -z "$POSTGRES_HOST" ]; then
    echo "Environment variable HOST is not set!!!"
    exit 1
else 
    sed -i 's|POSTGRES_HOST|'"$POSTGRES_HOST"'|' /etc/stunnel.conf
fi

/usr/bin/stunnel4 /etc/stunnel.conf