#!/bin/ash
LATEST_VERSION=`curl -s https://s3.amazonaws.com/Minecraft.Download/versions/versions.json | grep -o "[[:digit:]]\.[0-9]*\.[0-9]" | head -n 1`

if [ $VERSION ]; then
  REQ_VERSION=$VERSION
else
  REQ_VERSION=$LATEST_VERSION
fi

FILE=/home/container/server.jar

if [ -f $FILE ]; then
   echo "A server.jar file already exists in this location, not downloading a new one."
else
   curl https://s3.amazonaws.com/Minecraft.Download/versions/$REQ_VERSION/minecraft_server.$REQ_VERSION.jar -o server.jar
fi

cd /home/container

if [ -z "$STARTUP"  ]; then
    echo "$ java -jar server.jar"
    java -jar server.jar
else
    MODIFIED_STARTUP=`echo $STARTUP | perl -pe 's@{{(.*?)}}@$ENV{$1}@g'`
    echo "$ java $MODIFIED_STARTUP"
    java $MODIFIED_STARTUP
fi
