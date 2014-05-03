#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

cassandra_stop 3
cassandra_stop 2
cassandra_stop 1

instance_kill_rm opscenter

instance_kill_rm zookeeper1
