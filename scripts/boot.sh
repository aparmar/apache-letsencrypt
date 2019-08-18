#!/bin/bash

echo "Creating necessary folders"
mkdir -p $DATA/letsencrypt/accounts
mkdir -p $DATA/letsencrypt/archive
mkdir -p $DATA/letsencrypt/csr
mkdir -p $DATA/letsencrypt/keys
mkdir -p $DATA/letsencrypt/live
mkdir -p $DATA/log
mkdir -p $DATA/sites-available

echo "Add executable permission to developer script files"
chmod a+x $DATA/scripts/*.sh

echo "Check if developer enable modules file exists"
FILE=$DATA/scripts/enable-mods.sh
if test -f "$FILE"; then
    echo "Run developer enable modules file"
    source $FILE
fi

echo "Install the certbot and timers"
certbot -n --expand --apache --agree-tos --email $EMAIL -d $DOMAIN
certbot renew --dry-run

echo "Check if developer enable sites exists"
FILE=$DATA/scripts/enable-sites.sh
if test -f "$FILE"; then
    echo "Run developer enable sites file"
    source $FILE
fi

echo "Restart apache"
service apache2 restart

tail -f /var/log/apache2/*.log