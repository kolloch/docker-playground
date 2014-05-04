FROM storm

# Deploy startup script
ADD config.sh /usr/local/bin/config.sh
RUN chmod 755 /usr/local/bin/config.sh

ADD init.sh /usr/local/bin/init.sh
RUN chmod 755 /usr/local/bin/init.sh

WORKDIR /opt/storm/
VOLUME /var/lib/storm
VOLUME /var/log/storm
EXPOSE 8080
CMD ["init.sh"]
