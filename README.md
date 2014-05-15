docker-env
==========

This project provides a local development/test environment including:

* zookeeper (1 node)
* cassandra (including Datastax opscenter) (3 nodes)
* kafka (3 nodes)
* storm (1 nimbus/ui node, 3 supervisor nodes)
* and rudimentary scala play framework app

I currently consider extending it maybe with the following components:

* elastic search
* logstash
* kibana
* riemann.io or statsd
* graphite
* some graphite frontend
* extend zookeeper nodes (to test zookeeper fail-over)

but that might never happen or soon ;)

Credits
-------

I took my first version of the cassandra from zmarcantel/cassandra.

Scripts
-------

<code>./build-all.sh</code> builds all necesarry images. The image
names do not include repository prefixes so be careful with
name clashes.

<code>./cluster/cluster-start.sh</code> starts all services,
<code>./cluster/cluster-stop.sh</code> stops them.

URLs to cassandra opscenter and the storm ui are shown on startup.
You will have to use the cassandra opscenter to install the
agents on the cassandra nodes, since I was not easily able to
automate that.

<code>./cluster/cluster-status.sh</code> shows what's up and 
running.

<code>./cluster/cassandra-cqlsh.sh</code> provides a cqlsh 
shell to the cassandra nodes.

<code>./cluster/cassandra-nodetool.sh</code> executes cassandra
nodetool with an appropriate -h (host) argument.

<code>./cluster/kafka-topics.sh</code> starts kafka-topics.sh with
the appripate --zookeeper argument.

Conventions for the docker images
---------------------------------

Most of the docker images in this repository include:

* a copy of the relevant configuration files with {{placeholders}}
* a config.sh script which appropriately replaces the {{placeholders}}
* a run.sh script that actually starts the appropriate processes

This setup makes it easy to look at the configuration templates and
introduce new placeholders. You can also peak at the configuration
without executing anything by starting the images with 
<code>docker run -i -t image bash -l</code>, execute 
<code>config.sh</code> and verify the configuration files.

Security
--------

None. There is a ssh key in this repository, the Dockerfiles do not 
verify checksums of downloaded artifacts. Do I need to say more?
