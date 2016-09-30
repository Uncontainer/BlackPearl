#!/bin/bash
set -e

PG_CONFIG=/etc/pgbouncer/pgbouncer.ini
PG_USER=postgres
PG_LOG=/var/log/pgbouncer


echo "Starting pgbouncer..."
exec pgbouncer -u pgbouncer  $PG_CONFIG

