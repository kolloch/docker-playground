#!/bin/bash

set -e

. config.sh

echo "Starting OpsCenter on $IP..."
exec /usr/share/opscenter/bin/opscenter -f