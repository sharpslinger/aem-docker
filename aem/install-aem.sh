#!/bin/bash

# pull in configuration values
source aem-config.sh

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}SETTING UP $1${NC}"
if [ $1 == "publisher" ] ; then
    port=4503
    finalizescript="/aem/finalize-publish.sh"
else
    port=4502
    finalizescript="/aem/finalize-author.sh"
fi

# install everything
java -jar $AEM_PATH -listener-port 25000 -r author nosample -p $port 2>&1 &
aemProcessId=$!

# listen for activity, so we can figure out when done
nc -vklp 25000 > "install.log" 2>&1 &
currentProcessId=$!

# wait (while listening); check every 60s
while sleep 60
do
    if grep --quiet "started" "install.log"
    then
        if [ -f $finalizescript ] ; then { echo "finalizing install"; $finalizescript; } else { echo "no wrap-up script exists"; } fi
        kill $currentProcessId
        kill $aemProcessId
        exit 0
    else
        echo "not done yet.  waiting 60s..."
    fi
done