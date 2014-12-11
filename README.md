# docker-centos

This is the base-image of all our other docker images. It is based on the official centos7 images and adds:

 - supervisord
 - confd

Supervisord is configured to load `/etc/supervisord.d/*.ini`. It also starts `confd` by default. Multitail is used to display the log output on the tty.

On startup, this container will execute `/scripts/entrypoint.sh` and execute any start-up hooks if present. It will then execute `CMD` (default: `/usr/bin/supervisord`).

# Hooks
If your container needs to do something before executing `CMD`, you can do so
by placing a script in `/scripts/entrypoint-hooks.d`. Make sure you `chmod +x`
it.
