FROM storm

# Deploy startup script
ADD config.sh /usr/local/bin/config.sh
RUN chmod 755 /usr/local/bin/config.sh

ADD run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /opt/storm/
VOLUME /var/lib/storm
VOLUME /var/log/storm
EXPOSE 6627
CMD ["run.sh"]
