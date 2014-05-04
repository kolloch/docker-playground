#!/bin/bash

echo "== Configuring Storm Nimbus"

IP=`hostname --ip-address`

if [ -z "$EXT_IP" ]; then
    EXT_IP="$IP"
fi

if [ -z "$ZOOKEEPER_PORT_2181_TCP_ADDR" ]; then
    echo ZOOKEEPER_PORT_2181_TCP_ADDR not configured >&2
    exit 1
fi

cat <<EOF
IP                          =$IP
EXT_IP                      =$IP
ZOOKEEPER_PORT_2181_TCP_ADDR=$ZOOKEEPER_PORT_2181_TCP_ADDR
EOF

mkdir -p config
cat <<EOF >conf/storm.yaml
storm.zookeeper.servers:
    - "$ZOOKEEPER_PORT_2181_TCP_ADDR"
nimbus.host: $EXT_IP
nimbus.thrift.port: 6627
storm.local.dir: /var/lib/storm
nimbus.childopts: "-Xmx1024m -Djava.net.preferIPv4Stack=true"
ui.port: 8080
ui.childopts: "-Xmx768m"
EOF
