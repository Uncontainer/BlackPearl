#!/bin/bash

if [ -z "$POSTGRES_HOST" ]; then
    echo "Environment variable POSTGRES_HOST is not set!!!"
    exit 1
else 
    sed -i 's|POSTGRES_HOST|'"$POSTGRES_HOST"'|' /etc/stunnel.conf
fi

su - stunnel4 -c '/usr/bin/stunnel4 /etc/stunnel.conf'