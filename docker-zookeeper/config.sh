#!/bin/bash

JVM_FLAGS="-showversion -server"

IP=`hostname --ip-address`

mkdir -p conf
cat <<EOF >conf/zoo.cfg
tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
EOF