FROM ubuntu_java

# Get latest stable release of Kafka
RUN wget -q -O - http://apache.mirrors.tds.net/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz \
  | tar -C /opt -xz
RUN mv /opt/kafka_2.9.2-0.8.1.1 /opt/kafka

RUN useradd kafka

# Deploy startup script
ADD config.sh /usr/local/bin/config.sh
RUN chmod 755 /usr/local/bin/config.sh

ADD run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /opt/kafka/
VOLUME /var/lib/kafka
VOLUME /var/log/kafka
EXPOSE 9092
CMD ["run.sh"]
