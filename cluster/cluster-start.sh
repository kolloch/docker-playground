#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

cassandra_start 1
echo -ne "Wating a while: "
sleep 5
echo "Done."
cassandra_start 2
cassandra_start 3

opscenter_start

zookeeper_start

for i in {1..3}; do
    kafka_start "$i"
done

storm_nimbus_start
storm_ui_start

for i in {1..3}; do
    storm_supervisor_start "$i"
done
