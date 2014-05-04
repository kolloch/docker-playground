#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

for i in {1..3}; do
    instance_kill_rm "kafka$i"
done

cassandra_stop 3
cassandra_stop 2
cassandra_stop 1

instance_kill_rm opscenter

instance_kill_rm zookeeper1

for i in {1..3}; do
    storm_supervisor_stop "$i"
done

instance_kill_rm $STORM_UI_NODE
instance_kill_rm $STORM_NIMBUS_NODE
