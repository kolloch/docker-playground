#/bin/bash

set -e

. config.sh

echo "Starting OpsCenter on $IP..."
service opscenterd start
service ssh start
tail -f /var/log/opscenter/opscenterd.log