#!/bin/bash

set -e

cd $(dirname "$0")

(cd docker-java && ./build.sh $*)
(cd docker-cassandra && ./build.sh $*)
(cd docker-cassandra-opscenter && ./build.sh $*)