set -e

cd $(dirname "$0")

. lib.sh

if ! instance_running cass1; then
    echo "Cassandra instance 1 is not running"
    exit 1
fi

docker run --rm=true -i -t cassandra cqlsh $(instance_ip cass1) $*