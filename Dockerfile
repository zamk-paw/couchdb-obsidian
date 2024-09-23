FROM couchdb:latest

# Add a script that will modify the CouchDB configuration with the desired port
COPY set-port.sh create-databases.sh /opt/couchdb/

# Make the script executable
RUN chmod +x /opt/couchdb/set-port.sh

# Run the script as an entrypoint
ENTRYPOINT ["/opt/couchdb/set-port.sh"]
