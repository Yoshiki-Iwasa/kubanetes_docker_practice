#!/bin/sh
/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
/etc/init.d/sshd start
tail -f /dev/null