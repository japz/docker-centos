#!/usr/bin/env bash
echo "Container invoked with: $@"
env

for x in /scripts/entrypoint-hooks.d/*;
do
    [ -x $x ] && echo "Executing entrypoint hook $x" && $x
done

# Start with clean logs directory. If logs need to persist they need to be shipped elsewhere.
rm -f /logs/*

if [ "$1" == "/usr/bin/supervisord" ];
then
    supervisor=1
    echo
    echo "Starting supervisor with the following configuration files:"
    echo
    ls -l /etc/supervisord.d/
fi

# Execute CMD
$@

# If supervisor was executed, tail its logfiles
if [ "$supervisor" == "1" ]; then
    multitail -Q 5 '/logs/*.log'
    exitcode=$?
    if [ "$exitcode" == "1" ]; then
        echo 'Multitail failed, try normal tail'
        tail -f /logs/*.log
    fi
    pkill -F /var/run/supervisord.pid
fi


