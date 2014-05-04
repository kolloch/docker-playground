#!/bin/bash

echo "== Configuring Kafka"

KAFKA_FLAGS="-showversion -server"

IP=`hostname --ip-address`

if [ -z "$EXT_IP" ]; then
    EXT_IP="$IP"
fi

if [ -z "$BROKER_ID" ]; then
    BROKER_ID="1"
fi

if [ -z "$ZOOKEEPER_NODES" ]; then
    if [ -z "$ZOOKEEPER_PORT_2181_TCP_ADDR" ]; then
        echo ZOOKEEPER_NODES not configured >&2
        exit 1
    else 
        ZOOKEEPER_NODES="$ZOOKEEPER_PORT_2181_TCP_ADDR:2181"
    fi
fi

cat <<EOF
IP             =$IP
EXT_IP         =$IP
BROKER_ID      =$BROKER_ID
ZOOKEEPER_NODES=$ZOOKEEPER_NODES
EOF

mkdir -p config
cat <<EOF >config/server.properties
# Kafka configuration for $(hostname)
broker.id=$BROKER_ID
advertised.host.name=$EXT_IP
port=9092

num.network.threads=2
num.io.threads=2

socket.send.buffer.bytes=1048576
socket.receive.buffer.bytes=1048576
socket.request.max.bytes=104857600

log.dirs=/var/lib/kafka/logs
num.partitions=2

log.flush.interval.messages=10000
log.flush.interval.ms=100
log.retention.hours=168
log.segment.bytes=536870912
log.cleanup.interval.mins=1

zookeeper.connect=$ZOOKEEPER_NODES
zookeeper.connection.timeout=1000000

kafka.metrics.polling.interval.secs=5
kafka.metrics.reporters=kafka.metrics.KafkaCSVMetricsReporter
kafka.csv.metrics.dir=/var/lib/kafka/metrics/
kafka.csv.metrics.reporter.enabled=false
EOF

sed -i s%kafka.logs.dir=logs%kafka.logs.dir=/var/log/kafka% \
    config/log4j.properties

mkdir -p /var/{log,lib}/kafka
chown kafka /var/{log,lib}/kafka

ln -s /var/log/kafka /opt/kafka/logs
