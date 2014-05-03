##
##    Cassandra
##
##

FROM ubuntu_java

# Install Cassandra, and SSH (and other dependencies of opscenter)
RUN echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y dsc20 openssh-server openssh-client supervisor sysstat psmisc

# Configure SSH
RUN mkdir -p /var/run/sshd && chmod -rx /var/run/sshd
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN mkdir -p /root/.ssh/
ADD ssh_key.pub /root/.ssh/authorized_keys
ADD ssh_key.pub /root/.ssh/id_rsa.pub
ADD ssh_key /root/.ssh/id_rsa
RUN chown root:root /root/.ssh/authorized_keys
RUN chmod 0700 /root/.ssh /root/.ssh/*

# Configure Supervisord to startup cassandra and ssh
ADD etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

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
EXPOSE 8012 61620 61621
EXPOSE 22
CMD ["init.sh"] 
