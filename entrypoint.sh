#!/bin/ash
LATEST_VERSION=`curl -s https://s3.amazonaws.com/Minecraft.Download/versions/versions.json | grep -o "[[:digit:]]\.[0-9]*\.[0-9]" | head -n 1`

if [ $VERSION ]; then
  REQ_VERSION=$VERSION
else
  REQ_VERSION=$LATEST_VERSION
fi

WGET="wget -q --no-check-certificate"

MINECRAFT_DL=`$WGET -O - https://minecraft.net/download | grep -o "https://[A-Za-z0-9\._/~%\-\+\#\?!=\(\)@]*minecraft_server\.[[:digit:]]\.[0-9]*\.[0-9]*\.jar"`

MINECRAFT_DL=`echo $MINECRAFT_DL | sed s/$LATEST_VERSION/$REQ_VERSION/g`

MINECRAFT_FILE=`echo $MINECRAFT_DL | grep -o "minecraft_server[\.0-9]*\.jar"`

wget $MINECRAFT_DL

java -jar $MINECRAFT_FILE