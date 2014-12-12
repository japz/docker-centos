# docker-centos

This is the base-image of all our other docker images. It is based on the
official centos7 images and adds:

 - supervisord
 - confd

Supervisord is configured to load `/etc/supervisord.d/*.ini`. It also starts
`confd` by default. Multitail is used to display the log output on the tty.

On startup, this container will execute `/scripts/entrypoint.sh` and execute
any start-up hooks if present. It will then execute `CMD` (default:
`/usr/bin/supervisord`).

# Hooks
If your container needs to do something before executing `CMD`, you can do so
by placing a script in `/scripts/entrypoint-hooks.d`. Make sure you `chmod +x`
it.

# How to use

Example `Dockerfile`:

        FROM spilgames/centos
        RUN yum install -y my-software
        COPY my-supervisor-file.ini /etc/supervisord.d/

For more information on supervisord, see: http://supervisord.org/configuration.html#program-x-section-settings


# ToDo

A list of features I would like to add in the future:

 - Allow more control over how multitail is executed using environment
   variables (e.g. for running the container in dev, split screen may be
   better than merge-all).
 - Detect presence of consul / etcd and start confd with the appropriate
   parameters.

# License

This code is distributed under the Apache License 2.0

# Contributing

Contributions welcome, just open a PR.


