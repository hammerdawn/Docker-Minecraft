# Minimal Minecraft Docker container for Pterodactyl Panel
FROM anapsix/alpine-java:8_server-jre

MAINTAINER Dane Everitt <dane+docker@daneeveritt.com>

RUN apk update
RUN apk upgrade
RUN apk add --update curl ca-certificates openssl git tar perl bash && rm -rf /var/cache/apk/*
RUN adduser -D -h /home/container container

USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
