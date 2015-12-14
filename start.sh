#!/bin/ash
LATEST_VERSION=`curl -s https://s3.amazonaws.com/Minecraft.Download/versions/versions.json | grep -o "[[:digit:]]\.[0-9]*\.[0-9]" | head -n 1`

if [ $VERSION ]; then
  REQ_VERSION=$VERSION
else
  REQ_VERSION=$LATEST_VERSION
fi

FILE=/srv/minecraft/minecraft_server.$REQ_VERSION.jar

if [ -f $FILE ]; then
   echo "Already minecraft_server version $REQ_VERSION no change needed"
else
   rm /srv/minecraft/minecraft_server.*.jar
   curl https://s3.amazonaws.com/Minecraft.Download/versions/$REQ_VERSION/minecraft_server.$REQ_VERSION.jar -o /srv/minecraft/minecraft_server.$REQ_VERSION.jar
fi

if [ $OPTS  ]; then
   OPTS=`echo $OPTS | sed -e 's/__/ /g'`
   java -jar $OPTS /srv/minecraft/minecraft_server.$REQ_VERSION.jar
else
   java -jar /srv/minecraft/minecraft_server.$REQ_VERSION.jar
fi