#!/bin/ash
LATEST_VERSION=`curl -s https://s3.amazonaws.com/Minecraft.Download/versions/versions.json | grep -o "[[:digit:]]\.[0-9]*\.[0-9]" | head -n 1`

if [ $VERSION ]; then
  REQ_VERSION=$VERSION
else
  REQ_VERSION=$LATEST_VERSION
fi

if [ -a /src/minecraft/minecraft_server.$REQ_VERSION.jar ]; then
        continue
else
    rm /srv/minecraft/minecraft_server.*.jar
    curl https://s3.amazonaws.com/Minecraft.Download/versions/$REQ_VERSION/minecraft_server.$REQ_VERSION.jar -o /srv/minecraft/minecraft_server.$REQ_VERSION.jar
fi