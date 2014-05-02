#!/bin/bash

set -e

cd $(dirname "$0")

PWD=$(pwd)

#IP_PREFIX="192.168.33.2"
#INTERFACE="eth1"
#FIRST_IP="${IP_PREFIX}1"

function kill_rm_instance {
    local NODE_NAME="$1"

    docker inspect $NODE_NAME 2>/dev/null >/dev/null && \
        echo -ne "Stopping currently running instance $NODE_NAME: " && \
        ssh-keygen -f "/home/ptr/.ssh/known_hosts" -R $(instance_ip $NODE_NAME) && \
        docker stop $NODE_NAME 2>/dev/null >/dev/null && \
        docker rm $NODE_NAME 2>/dev/null >/dev/null && \
        echo "done." || \
        echo "Not running: $NODE_NAME"
}

function instance_ip {
    local NODE_NAME="$1"

    docker inspect --format '{{ .NetworkSettings.IPAddress }}' $NODE_NAME
}

function cassandra_stop {
    local IDX="$1"
    local NODE_NAME="cass${IDX}"

    kill_rm_instance "$NODE_NAME"
}

function cassandra_start {
    local IDX="$1"
    local NODE_NAME="cass${IDX}"

    #local IP="$IP_PREFIX$IDX"
    #ifconfig $INTERFACE:$IDX $IP 

    mkdir -p logs/$IDX data/$IDX

    chown -R 104:107 logs/$IDX data/$IDX

    local SEEDS=""
    if [ $IDX -ne 1 ]; then
        local FIRST_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' cass1)
        SEEDS="-e SEEDS=$FIRST_IP"
    fi


    echo -ne "Starting $NODE_NAME: "

    local DOCKER_ID=$(docker run \
            -d \
            --name $NODE_NAME \
            -h $NODE_NAME \
            -e MAX_HEAP_SIZE=1G \
            -e HEAP_NEWSIZE=500M \
            -e EXT_IP=$IP \
            $SEEDS \
            -v "$PWD/logs/$IDX:/var/log/cassandra" \
            -v "$PWD/data/$IDX:/var/lib/cassandra" \
            cassandra)


            # -p "$IP:7000:7000" \
            # -p "$IP:7001:7001" \
            # -p "$IP:7199:7199" \
            # -p "$IP:9042:9042" \
            # -p "$IP:9160:9160" \ 

    local IP=$(instance_ip $NODE_NAME)

    echo "$DOCKER_ID at $IP with seeds $SEEDS."
}

function opscenter_start {
    echo -ne "Starting opscenter: "
    local FIRST_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' cass1)
    local SEEDS="-e SEEDS=$FIRST_IP"
    docker run -d --name opscenter $SEEDS -p 8888 cassandra_opscenter >/dev/null
    local IP=$(instance_ip opscenter)
    echo "done, see http://$IP:8888/"   
}

cassandra_stop 3
cassandra_stop 2
cassandra_stop 1

kill_rm_instance opscenter

cassandra_start 1
echo -ne "Wating a while: "
sleep 3
echo "Done."
cassandra_start 2
cassandra_start 3

opscenter_start
