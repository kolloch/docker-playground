#!/bin/bash

set -x

. config.sh

echo "== Starting storm supervisor"

exec storm.sh supervisor

