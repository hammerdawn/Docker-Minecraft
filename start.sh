#!/bin/ash
sleep 3
CHK_FILE="/home/container/${SERVER_JAR}"

cd /home/container
if [ -f $CHK_FILE ]; then
   echo "A ${SERVER_JAR} file already exists in this location, not downloading a new one."
else
    DL_PATH=https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/${SPONGE_VERSION}/spongevanilla-${SPONGE_VERSION}.jar
    echo "> curl -sSL ${DL_PATH} -o ${SERVER_JARFILE}"
    curl -sSL ${DL_PATH} -o ${SERVER_JARFILE}
fi

MODIFIED_STARTUP=`echo ${STARTUP} | perl -pe 's@\{\{(.*?)\}\}@$ENV{$1}@g'`
echo "$ java ${MODIFIED_STARTUP}"
java ${MODIFIED_STARTUP}
