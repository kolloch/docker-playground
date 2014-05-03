FROM ubuntu_java

# Get latest stable release of ZooKeeper
RUN wget -q -O - http://mirrors.sonic.net/apache/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz \
  | tar -C /opt -xz
RUN mv /opt/zookeeper-3.4.5 /opt/zookeeper

RUN useradd zookeeper
RUN mkdir -p /opt/zookeeper/conf
RUN chown zookeeper /opt/zookeeper/conf
RUN mkdir -p /var/lib/zookeeper
RUN chown zookeeper /var/lib/zookeeper

# Deploy startup script
ADD config.sh /usr/local/bin/config.sh
RUN chmod 755 /usr/local/bin/config.sh

ADD init.sh /usr/local/bin/init.sh
RUN chmod 755 /usr/local/bin/init.sh

WORKDIR /opt/zookeeper/
VOLUME /var/lib/zookeeper
VOLUME /var/log/zookeeper
EXPOSE 2181
CMD ["init.sh"]
