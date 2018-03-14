# aem-docker
A docker implementation of AEM.

Originally sourced from [LexmarkWeb/docker-aem-author](https://github.com/LexmarkWeb/docker-aem-author)

## Requirements
Requires the following files to be present in the /aem directory:
* aem-quickstart-6.1.jar: a JAR file of the AEM installer
* license.properties: a valid AEM license file

## Optional
* zip files with service packs or content to install in /aem/packages
* We use JFrog Artifactory to store assets.  An optional downloadassets.sh script can be added with cURL commands to download any needed files.  Sample syntax:

```
#!/bin/bash
curl -H "X-JFrog-Art-Api:YOUR_ACCESS_TOKEN" -O https://ARTIFACTORY_SERVER/artifactory/list/YOUR_ARTIFACTORY_FOLDER/aem-quickstart-$1.jar
curl -H "X-JFrog-Art-Api:YOUR_ACCESS_TOKEN" -O https://ARTIFACTORY_SERVER/artifactory/list/YOUR_ARTIFACTORY_FOLDER/license.properties
```

Paths and config values can be changed in aem-config.sh.  The $1 in the script above is set as "AEM_VERSION" in that file.

If the downloadassets.sh file is not present, it will be ignored, though note that the JAR and properties file will then need to be manually added to the /aem folder.
