FROM ubuntu_java

RUN wget -q -O - http://dl.bintray.com/sbt/native-packages/sbt/0.13.2/sbt-0.13.2.tgz \
  | tar -C /opt -xz
RUN ln -s /opt/sbt/bin/sbt /usr/local/bin

ADD start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

VOLUME /root/.ivy2/
VOLUME /root/project_source/
VOLUME /root/project/
VOLUME /root/stage/

CMD ["start.sh"]