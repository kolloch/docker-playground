#!/bin/bash

cd $(dirname $0)

docker inspect IVY_CACHE >/dev/null ||\
    docker run -v /root/.ivy2 --name IVY_CACHE busybox true

PROJECT_SOURCE=$(pwd)/../sample-play-app
STAGE=$(pwd)/stage
docker run \
    --volumes-from IVY_CACHE \
    -v "$PROJECT_SOURCE:/root/project_source" \
    -v "$STAGE:/root/stage" \
    sbt-build

docker build -t sample-play-app .
