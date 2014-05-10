#!/bin/bash

set -e

cp -apr /root/project_source/* /root/project
cd /root/project
sbt clean stage
rm -rf /root/stage/*
cp -apr target/universal/stage/* /root/stage