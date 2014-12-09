FROM centos:latest

RUN yum install -y epel-release \
    && yum install -y supervisor wget \
    && wget https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 -O /usr/bin/confd \
    && chmod +x /usr/bin/confd

COPY files/supervisord.conf /etc/supervisord.conf

ENTRYPOINT exec /usr/bin/supervisord
