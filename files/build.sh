#!/usr/bin/env bash
set -e
set -o pipefail

yum install -y epel-release /build/multitail*.rpm
yum install -y supervisor wget
wget https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 -O /usr/bin/confd
chmod +x /usr/bin/confd

# Supervisor configs
cp /build/supervisord.conf /etc/supervisord.conf
cp /build/supervisor-confd.ini /etc/supervisord.d/confd.ini

# Scripts directory
mkdir /scripts
cp /build/entrypoint.sh /scripts/
cp /build/start-confd.sh /scripts/

# Logs directory (default log output for supervisor)
mkdir /logs
