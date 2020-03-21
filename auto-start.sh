#!/bin/bash
set -e

echo "=> start"
/usr/local/bin/docker-entrypoint.sh mysqld_safe

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "status" > /dev/null 2>&1
    RET=$?
done
echo "=> mySQL service started"


echo "=> start cron service"
/usr/local/bin/cron-foreground
echo "=> cron service started"

sleep 5
echo "=> start redis-server"
/usr/local/bin/redis-server-foreground
echo "=> redis-server started"

# start mysql server
# echo "Starting MySQL server..."
# /usr/bin/mysqld_safe >/dev/null 2>&1 &

# # wait for mysql server to start (max 30 seconds)
# timeout=30
# while ! /usr/bin/mysqladmin -u root status >/dev/null 2>&1
# do
#     timeout=$(($timeout - 1))
#     if [ $timeout -eq 0 ]; then
#     echo "Could not connect to mysql server. Aborting..."
#     exit 1
#     fi
#     sleep 1
# done

# sleep 5

# echo "=> start cron service"
# service cron start

# sleep 5

# echo "=> start redis server"
# redis-server --daemonize yes >/dev/null 2>&1
