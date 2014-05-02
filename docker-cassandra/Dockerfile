##
##    Cassandra
##
##

FROM ubuntu

# This image was basically build by:
#
# MAINTAINER Zachary Marcantel, zach@zed.io, zmarcantel@utexas.edu
#
# I just do not want to blame him for all my errors ;)

# Add PPA for the necessary JDK

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update

# Install other packages
RUN apt-get install -y curl

# Preemptively accept the Oracle License
RUN echo "oracle-java7-installer	shared/accepted-oracle-license-v1-1	boolean	true" > /tmp/oracle-license-debconf
RUN /usr/bin/debconf-set-selections /tmp/oracle-license-debconf
RUN rm /tmp/oracle-license-debconf

# Install the JDK
RUN apt-get install -y oracle-java7-installer oracle-java7-set-default
RUN apt-get update

# Install Cassandra
RUN echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y dsc20

# Deploy startup script
ADD config.sh /usr/local/bin/config.sh
RUN chmod 755 /usr/local/bin/config.sh

ADD init.sh /usr/local/bin/init.sh
RUN chmod 755 /usr/local/bin/init.sh

RUN rm -rf /etc/cassandra
ADD etc/cassandra /etc/cassandra

# needed for adjusting configuration on startup
RUN chown -R cassandra:cassandra /etc/cassandra

EXPOSE 7199 7000 7001 9160 9042
USER cassandra
CMD init.sh 
