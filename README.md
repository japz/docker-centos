docker-centos
=============

This is the base-image of all our other docker images. It is based on the official centos7 images and adds:

 - supervisord
 - confd

Supervisord is configured to load `/etc/supervisord.d/*.ini`. It also starts `confd` by default. Multitail is used to display the log output on the tty.

