#!/bin/bash

source aem-config.sh

baseUrl="http://localhost:4503"
password="admin:admin"

echo "Optional package upload/install"
if [ $INSTALL_PACKAGES == 1 ]; then
for file in /aem/packages/*
do
  curl --user $password -F file=@"$file" -F name="$file" -F force=true -F install=true $baseUrl/crx/packmgr/service.jsp
done
fi