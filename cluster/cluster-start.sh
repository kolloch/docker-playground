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
