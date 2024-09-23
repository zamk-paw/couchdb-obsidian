#!/bin/bash

# Modify the CouchDB configuration to use the specified port
sed -i "s/;port = 5984/port = $PORT/" /opt/couchdb/etc/local.ini
sed -i "s/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/" /opt/couchdb/etc/local.ini

# Add admin user and password to the configuration
# echo "[admins]" >> /opt/couchdb/etc/local.ini
echo "$COUCHDB_USER = $COUCHDB_PASSWORD" >> /opt/couchdb/etc/local.ini

echo
cat /opt/couchdb/etc/local.ini
echo

# Start CouchDB
/opt/couchdb/bin/couchdb &

sleep 15

/opt/couchdb/create-databases.sh

tail -f /dev/null
