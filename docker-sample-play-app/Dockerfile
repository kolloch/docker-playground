FROM ubuntu_java

RUN useradd app
ADD stage /stage

EXPOSE 9000

CMD ["/stage/bin/my-first-application"]