#!/bin/ash
sleep 3
CHK_FILE="/home/container/${SERVER_JAR}"

cd /home/container
if [ -f $CHK_FILE ]; then
   echo "A ${SERVER_JAR} file already exists in this location, not downloading a new one."
else
    if [ ${BUNGEE_VERSION} == "latest" ]; then
        DL_PATH=http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar
    else
        DL_PATH=http://ci.md-5.net/job/BungeeCord/${BUNGEE_VERSION}/artifact/bootstrap/target/BungeeCord.jar
    fi

    echo "> curl -sSL ${DL_PATH} -o ${SERVER_JAR}"
    curl -sSL ${DL_PATH} -o ${SERVER_JAR}
fi

if [ -z "$STARTUP"  ]; then
    echo "$ java -jar ${SERVER_JAR}"
    java -jar ${SERVER_JAR}
else
    MODIFIED_STARTUP=`echo ${STARTUP} | perl -pe 's@\{\{(.*?)\}\}@$ENV{$1}@g'`
    echo "$ java ${MODIFIED_STARTUP}"
    java ${MODIFIED_STARTUP}
fi
