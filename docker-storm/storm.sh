#!/bin/bash

mkdir -p /var/{lib,log}/storm
chown storm:storm /var/{lib,log}/storm

exec sudo -u storm /opt/storm/bin/storm $*