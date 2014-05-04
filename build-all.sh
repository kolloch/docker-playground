#!/bin/bash

set -e

cd $(dirname "$0")

MYDIR=$(pwd)

for docker in docker-*; do
    cd "$MYDIR"

    if ! [ -d $docker ]; then
        echo continue $docker
        continue
    fi

    echo -ne "Bulding $docker: "
    cd $docker && \
        (./build.sh $* >build.log 2>&1 && \
        echo done.)|| \
        (echo ERROR. && \
        cat build.log)
done

cd $MYDIR