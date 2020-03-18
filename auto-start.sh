#!/bin/bash
#get env MYSQL_ROOT_PASSWORD when docker run
# echo "=> update App source"
# /usr/local/bin/docker-entrypoint.sh --character-set-server=utf8 --collation-server=utf8_unicode_ci --sql_mode="" & 

# RET=1
# while [[ RET -ne 0 ]]; do
#     echo "=> Waiting for confirmation of MySQL service startup"
#     sleep 5
#     mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "status" > /dev/null 2>&1
#     RET=$?
# done
# echo "=> mySQL service started"

#start cron
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for start cron"
    sleep 5
    service cron start > /dev/null 2>&1
    RET=$?
done
echo "=> cron service started"


# /usr/bin/redis-server --daemonize yes

RET2=1
while [[ RET2 -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    /usr/bin/mysqld_safe >/dev/null 2>&1 &
    RET2=$?
done
echo "=> mySQL service started"

#start redis-server
# /usr/local/bin/redis-server --daemonize yes
# systemctl restart redis.service

#Start Apache2 in foreground mode
#/usr/local/bin/apache2-foreground

# /etc/init.d/{service} {stop|start|restart}