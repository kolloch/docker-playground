#!/bin/bash

set -x

. config.sh

echo "== Starting storm ui"

exec storm.sh ui

