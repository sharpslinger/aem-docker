#!/bin/bash

# pull in configuration values
source aem-config.sh

port=4503
finalizescript="/aem/finalize-publish.sh"

# install everything
java -jar $AEM_PATH -listener-port 25005 -r publish -p $port 2>&1 &
aemProcessId=$!

# listen for activity, so we can figure out when done
nc -vklp 25005 > "install.log" 2>&1 &
currentProcessId=$!

# wait (while listening); check every 60s
while sleep 60
do
    if grep --quiet "started" "install.log"
    then
        if [ -f $finalizescript ] ; then { echo "finalizing install using $finalizescript"; $finalizescript; } else { echo "no wrap-up script exists"; } fi
        kill $currentProcessId
        kill $aemProcessId
        exit 0
    else
        echo "not done yet.  waiting 60s..."
    fi
done