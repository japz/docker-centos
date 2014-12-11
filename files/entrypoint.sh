#!/usr/bin/env bash
echo "Container invoked with: $@"
env

# Start with clean logs directory. If logs need to persist they need to be shipped elsewhere.
rm -f /logs/*

if [ "$1" == "/usr/bin/supervisord" ];
then
    supervisor=1
    echo "Starting supervisor with the following configuration files:"
    ls -l /etc/supervisord.d/
fi

$@
pid=$$

echo "pid: $pid"
ps faux

if [ "$supervisor" == "1" ]; then
    multitail -Q 5 '/logs/*.log'
    exitcode=$?
    if [ "$exitcode" == "1" ]; then
        echo 'Multitail failed, try normal tail'
        tail -f /logs/*.log
    fi
    pkill -F /var/run/supervisord.pid
fi


