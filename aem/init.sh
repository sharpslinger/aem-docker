#!/bin/bash

source /aem/aem-config.sh

# download files if the script exists to do so
echo -n "Checking for download assets script..."

if [ -f /aem/downloadassets.sh ]; then
    sed -i 's/\r$//' /aem/downloadassets.sh
    echo "Found! Downloading assets..."
    /aem/downloadassets.sh $AEM_VERSION
else
    echo "Not found. Moving on..."
fi