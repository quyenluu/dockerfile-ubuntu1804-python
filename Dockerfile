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
            zip \
            nginx \
            cron && \
    touch /var/log/cron.log

#install git
RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt install git -y

#install node npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-get update && apt-get install -y --no-install-recommends gnupg dirmngr && rm -rf /var/lib/apt/lists/*
