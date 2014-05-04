#####################
# DOCKER
#####################

#
# Kill and remove a docker instance if it exists
#
function instance_kill_rm {
    local NODE_NAME="$1"

    docker inspect $NODE_NAME 2>/dev/null >/dev/null && \
        echo -ne "Stopping currently running instance $NODE_NAME: " && \
        docker stop $NODE_NAME 2>/dev/null >/dev/null && \
        docker rm $NODE_NAME 2>/dev/null >/dev/null && \
        echo "done." || \
        echo "Not running: $NODE_NAME"
}

#
# Output the IP of the given docker instance
#
function instance_ip {
    local NODE_NAME="$1"

    docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$NODE_NAME"
}

function instance_running {
    local NODE_NAME="$1"

    local OUT=$(docker inspect --format '{{ .State.Running }}' "$NODE_NAME")

    test "$OUT" =  "true"
}

#
# Print status of the instance with the given name.
#
function instance_status {
    local NODE_NAME="$1"

    if instance_running "$NODE_NAME"; then
        local IP=$(instance_ip $NODE_NAME)
        echo "Status $NODE_NAME: running at $IP"
    else
        echo "Status $NODE_NAME: not running"
    fi
}

######################
# CASSANDRA
######################

#
# Stop the cassandra instance with the given ID (e.g. 1,2,3)
#
function cassandra_stop {
    local IDX="$1"
    local NODE_NAME="cass${IDX}"

    instance_kill_rm "$NODE_NAME"
}

#
# Start the cassandra instance with the given index.
#
# "cass1" will be used as seed node.
#
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

    # privileged is unfortunately necessary
    # to allow opscenter agent installation
    local DOCKER_ID=$(docker run \
            --privileged \
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

#
# Start the cassandra opscenter.
#
function opscenter_start {
    echo -ne "Starting opscenter: "
    local FIRST_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' cass1)
    local SEEDS="-e SEEDS=$FIRST_IP"
    docker run -d --name opscenter $SEEDS -p 8888 cassandra_opscenter >/dev/null
    local IP=$(instance_ip opscenter)
    echo "done, see http://$IP:8888/"   
}

#############
# zookeeper
#############

function zookeeper_start {
    local NODE_NAME="zookeeper1"

    echo -ne "Starting $NODE_NAME: "

    local DOCKER_ID=$(docker run \
            -d \
            --name $NODE_NAME \
            -h $NODE_NAME \
            zookeeper)

    local IP=$(instance_ip $NODE_NAME)

    echo "at $IP"   
}

function zookeeper_address {
    local NODE_NAME="zookeeper1"
    echo $(instance_ip $NODE_NAME):2181
}

#############
# kafka
#############

function kafka_start {
    local IDX="$1"
    local NODE_NAME="kafka$IDX"

    local ZOOKEEPER_ADDRESS=$(zookeeper_address)

    echo -ne "Starting $NODE_NAME: "

    local DOCKER_ID=$(docker run \
            -d \
            --name $NODE_NAME \
            -h $NODE_NAME \
            -e ZOOKEEPER_NODES=$ZOOKEEPER_ADDRESS \
            -e BROKER_ID=$IDX \
            kafka)

    local IP=$(instance_ip $NODE_NAME)

    echo "at $IP"   
}

function kafka_stop {
    local IDX="$1"
    local NODE_NAME="kafka$IDX"

    instance_kill_rm $NODE_NAME
}