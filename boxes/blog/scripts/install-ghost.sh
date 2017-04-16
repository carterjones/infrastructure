#!/bin/bash
set -eux -o pipefail

# Grab the latest version of Ghost from Ghost.org.
#curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip

# Unzip Ghost into the folder /var/www/ghost (recommended install location).
#sudo mkdir /var/www
#sudo unzip -uo ghost.zip -d /var/www/ghost

# Create new group.
#sudo groupadd nodegrp

# Add user to group.
#sudo usermod -a -G nodegrp www-data

# Change group of directories to new group.
#sudo chgrp -R nodegrp /usr/lib/node_modules/
#sudo chgrp nodegrp /usr/bin/node
#sudo chgrp nodegrp /usr/bin/npm
#sudo chgrp -R nodegrp /var/www/ghost

# Move to the new ghost directory, and install Ghost (production dependencies only).
#cd /var/www/ghost
#sudo npm install --production

# Lock down permissions.
#sudo chown -R www-data:www-data /var/www/ghost/


# Just use this:
https://bitnami.com/redirect/to/144062/bitnami-ghost-0.11.7-0-linux-x64-installer.run

#and/or maybe this
https://github.com/bitnami/bitnami-docker-ghost
