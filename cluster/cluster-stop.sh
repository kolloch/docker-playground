#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

cassandra_stop 3
cassandra_stop 2
cassandra_stop 1

kill_rm_instance opscenter
