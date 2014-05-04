FROM ubuntu_java

# Get latest stable release
RUN wget -q -O - \
    http://mirrors.ibiblio.org/apache/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.tar.gz \
    | tar -C /opt -xz
RUN mv /opt/apache-storm-0.9.1-incubating /opt/storm

RUN apt-get update
RUN apt-get install -y python

# Install zeromq
RUN sudo apt-get install -y uuid uuid-dev uuid-runtime build-essential gcc g++ pkg-config libtool autoconf automake git debhelper
RUN wget -q -O - \
    http://download.zeromq.org/zeromq-2.1.7.tar.gz \
    | tar -C /opt -xz
RUN cd /opt/zeromq-2.1.7 && ./configure && make && make install

RUN useradd storm

ADD storm.sh /usr/local/bin/storm.sh
RUN chmod 755 /usr/local/bin/storm.sh

RUN ln -s /var/log/storm /opt/storm/logs

WORKDIR /opt/storm/
VOLUME /var/lib/storm
VOLUME /var/log/storm
CMD ["bash", "-l"]
