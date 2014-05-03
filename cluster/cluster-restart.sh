#!/bin/bash

set -e

cd $(dirname "$0")

./cluster-stop.sh
./cluster-start.sh