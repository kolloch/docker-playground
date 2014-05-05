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
RUN echo "oracle-java8-installer    shared/accepted-oracle-license-v1-1 boolean true" > /tmp/oracle-license-debconf
RUN /usr/bin/debconf-set-selections /tmp/oracle-license-debconf
RUN rm /tmp/oracle-license-debconf

# Install the JDK
RUN apt-get install -y oracle-java8-installer oracle-java8-set-default
RUN apt-get update