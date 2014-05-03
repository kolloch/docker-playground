##
##    Cassandra
##
##

FROM ubuntu_java

# Install Cassandra
RUN echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y libssl0.9.8 opscenter openssh-client openssh-server supervisor

# configure ssh
RUN mkdir -p /root/.ssh/
ADD ssh_key.pub /root/.ssh/authorized_keys
ADD ssh_key.pub /root/.ssh/id_rsa.pub
ADD ssh_key /root/.ssh/id_rsa
RUN chown root:root /root/.ssh/authorized_keys
RUN chmod 0700 /root/.ssh /root/.ssh/*

# Use our config
RUN rm -rf /etc/opscenter
ADD etc/opscenter /etc/opscenter

# Deploy startup script
ADD config.sh /usr/local/bin/config.sh
RUN chmod 755 /usr/local/bin/config.sh

ADD init.sh /usr/local/bin/init.sh
RUN chmod 755 /usr/local/bin/init.sh

EXPOSE 8888
USER root
CMD ["init.sh"]
