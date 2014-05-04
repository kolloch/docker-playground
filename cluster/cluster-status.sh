#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

for i in {1..3}; do
    instance_status "cass$i"
done

instance_status opscenter

instance_status zookeeper1

for i in {1..3}; do
    instance_status "kafka$i"
done

instance_status $STORM_NIMBUS_NODE
instance_status $STORM_UI_NODE
for i in {1..3}; do
    instance_status "storm-supervisor$i"
done
