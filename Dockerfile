FROM ubuntu:18.04

MAINTAINER quyenluu

ENV DEBIAN_FRONTEND=noninteractive

#update ubuntu && install necessary tools
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends --no-install-suggests -y \
            nano \
            curl \
            wget \
            unzip \
			git \
            zip \
            nginx \
            dirmngr \
            apt-transport-https \
            lsb-release \
            ca-certificates \
            build-essential \
			redis-server \
            cron && \
    touch /var/log/cron.log

#install node npm
RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \    
    apt-get install -y nodejs

#install python-pip
RUN apt-get install -y python3-pip python3-dev python3-venv && \
    cd /usr/local/bin && \
    #set python3 is default
    ln -s /usr/bin/python3 python && \ 
    pip3 install --upgrade pip

#install mysql
ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.7.29 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get install -y mysql-server=${MYSQL_VERSION}* \	
	&& rm -rf ${MYSQL_DATA_DIR} \
 	&& rm -rf /var/lib/apt/lists/*	

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

COPY cron-foreground /usr/local/bin/cron-foreground
RUN chmod 755 /usr/local/bin/cron-foreground

COPY redis-server-foreground /usr/local/bin/redis-server-foreground
RUN chmod 755 /usr/local/bin/redis-server-foreground

COPY auto-start.sh /auto-start.sh
RUN chmod a+x /auto-start.sh

EXPOSE 80 3306 6379

CMD ["/auto-start.sh"]