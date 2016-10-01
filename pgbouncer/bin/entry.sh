#!/bin/bash

if [ -z "$DBNAME" ]; then
    echo "Environment variable DBNAME is not set!!!"
    exit 1
else 
    sed -i 's|DBNAME|'"$DBNAME"'|' /etc/pgbouncer/pgbouncer.ini
fi

if [ -z "$USER" ]; then
    echo "Environment variable USER is not set!!!"
    exit 1
else
    sed -i 's|USER|'"$USER"'|' /etc/pgbouncer/pgbouncer.ini
fi

if [ -z "$PASSWORD" ]; then
    echo "Environment variable PASSWORD is not set!!!"
    exit 1
else 
    sed -i 's|PASSWORD|'"$PASSWORD"'|' /etc/pgbouncer/pgbouncer.ini
fi

pgbouncer -u pgbouncer /etc/pgbouncer/pgbouncer.ini