#!/bin/bash

set -e

echo "=== Configuring opscenter"

IP=`hostname --ip-address`

sed -i \
    -e "s/{{LISTEN_ADDRESS}}/$IP/" \
    /etc/opscenter/opscenterd.conf

if [ -z "$SEEDS" ]; then
    echo "Sorry, no seeds configured."
    exit 1
fi

sed -i \
    -e "s/{{SEEDS}}/$SEEDS/" \
    /etc/opscenter/clusters/Docker_Cluster.conf