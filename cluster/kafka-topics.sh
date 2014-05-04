#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

docker run -i -t --rm=true kafka ./bin/kafka-topics.sh --zookeeper $(zookeeper_address) $*