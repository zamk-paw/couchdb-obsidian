
#!/bin/bash

# CouchDB URL
COUCHDB_URL="http://$COUCHDB_USER:$COUCHDB_PASSWORD@localhost:$PORT"

# List of databases to create
DATABASES=("_users" "_replicator" "_global_changes") 

# Wait for CouchDB to be ready
until $(curl --output /dev/null --silent --head --fail "$COUCHDB_URL"); do
  echo "Waiting for CouchDB..."
  sleep 5
done

# Create the databases
for db in "${DATABASES[@]}"; do
  echo "Creating database: $db"
  curl -X PUT "$COUCHDB_URL/$db"
done

# Setup obsidian livesync
DEFAULT_ORIGINS="app://obsidian.md,capacitor://localhost,http://localhost"
if [ -n "$MACHINE_IP" ]; then
  DEFAULT_ORIGINS="$DEFAULT_ORIGINS,http://$MACHINE_IP,capacitor://$MACHINE_IP"
fi

curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd_auth/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/httpd/WWW-Authenticate" -H "Content-Type: application/json" -d '"Basic realm=\"couchdb\""' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/httpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/chttpd/max_http_request_size" -H "Content-Type: application/json" -d '"4294967296"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/couchdb/max_document_size" -H "Content-Type: application/json" -d '"50000000"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/cors/credentials" -H "Content-Type: application/json" -d '"true"' --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"
curl -X PUT "$COUCHDB_URL/_node/nonode@nohost/_config/cors/origins" -H "Content-Type: application/json" -d "\"$DEFAULT_ORIGINS\"" --user "${COUCHDB_USER}:${COUCHDB_PASSWORD}"


echo "Databases created successfully."
