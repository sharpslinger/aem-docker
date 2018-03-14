#!/bin/bash

AEM_VERSION="6.1"
AEM_PATH="/aem/aem-quickstart-6.1.jar"  # path to AEM quickstart JAR
POST_INSTALL_PATH="/aem/finalize.sh"    # path to the finalize script (shouldn't need to change this)
PACKAGES_PATH="/aem/packages/*"         # folder location of optional packages to install
BASE_URL="http://localhost:4502"        # web URL of instance
LOGIN_INFO="admin:admin"                # user/pass

