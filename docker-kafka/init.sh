#!/bin/bash

. config.sh

echo "== Starting kafka"

exec sudo -u kafka bin/kafka-server-start.sh config/server.properties