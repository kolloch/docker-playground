#!/bin/bash

set -e

echo "=== Adjusting cassandra configuration"

IP=`hostname --ip-address`

if [ -z "$SEEDS" ]; then
  SEEDS=$IP
fi
if [ -z "$EXT_IP" ]; then
  EXT_IP=$IP
fi

echo "Listening on $IP (external $EXT_IP)"
echo "Found seeds: $SEEDS"

# Setup Cassandra
CONFIG=/etc/cassandra/
sed -i \
    -e "s/{{LISTEN_ADDRESS}}/$IP/" \
    -e "s/{{BROADCAST_ADDRESS}}/$EXT_IP/" \
    -e "s/{{RPC_ADDRESS}}/$EXT_IP/" \
    -e "s/{{SEEDS}}/$SEEDS/" \
    $CONFIG/cassandra.yaml
sed -i \
    -e "s/{{RMI_ADDRESS}}/$IP/" \
    $CONFIG/cassandra-env.sh

chown cassandra:cassandra /var/{log,lib}/cassandra