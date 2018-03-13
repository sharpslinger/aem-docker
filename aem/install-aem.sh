#!/bin/bash

# pull in configuration values
source aem-config.sh

# install everything
java -jar $AEM_PATH -listener-port 25000 -r author nosample -p 4502 2>&1 &
aemProcessId=$!

# listen for activity, so we can figure out when done
nc -vklp 25000 > "install.log" 2>&1 &
currentProcessId=$!

# wait (while listening); check every 60s
while sleep 60
do
    if grep --quiet "started" "install.log"
    then
        if [ -f $POST_INSTALL_PATH ] ; then { echo "finalizing install"; $POST_INSTALL_PATH; } else { echo "no wrap-up script exists"; } fi
        kill $currentProcessId
        kill $aemProcessId
        exit 0
    else
        echo "not done yet.  waiting 60s..."
    fi
done