#!/bin/bash

echo "=> start mySQL service"
/usr/bin/mysqld_safe

sleep 5

echo "=> start cron service"
service cron start

sleep 5

echo "=> start redis server"
redis-server --daemonize yes
