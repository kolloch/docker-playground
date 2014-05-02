#!/usr/bin/env bash

set -e

. config.sh

# Start Cassandra
echo "=== Starting Cassandra (with supervisord)..."
exec /usr/bin/supervisord
