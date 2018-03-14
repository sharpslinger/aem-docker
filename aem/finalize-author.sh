#!/bin/bash

source aem-config.sh

baseUrl="http://localhost:4502"
password="admin:admin"

curl $baseUrl/etc/replication/agents.author/publish/jcr:content --user $password --data-urlencode "{'transportUri': 'http://publisher:4503/bin/receive?sling:authRequestLogin=1'}"

#echo "checking agent"
curl $baseUrl/etc/replication/agents.author/publish/jcr:content.json --user $password

echo "Switching to Classic UI"
sed -i 's/TOUCH/CLASSIC/' /aem/crx-quickstart/launchpad/config/com/day/cq/wcm/core/impl/AuthoringUIModeServiceImpl.config

echo "if packages exist, install them..."
if [ $INSTALL_PACKAGES == 1 ]; then
for file in /aem/packages/*
do
  curl --user $password -F file=@"$file" -F name="$file" -F force=true -F install=true $baseUrl/crx/packmgr/service.jsp
done
fi