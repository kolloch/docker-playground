#!/bin/bash

set -e

cd $(dirname "$0")

. lib.sh

for i in {1..3}; do
    instance_status "cass$i"
done

instance_status opscenter
