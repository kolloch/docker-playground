#!/bin/bash

. config.sh

chown zookeeper /var/lib/zookeeper
exec sudo -u zookeeper bin/zkServer.sh start-foreground