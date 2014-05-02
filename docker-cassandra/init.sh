#!/usr/bin/env bash

set -e

. config.sh

# Start Cassandra
echo "=== Starting Cassandra..."
exec cassandra -f -p /var/run/cassandra.pid
