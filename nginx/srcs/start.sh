#!/bin/sh
rc-status
rc-service telegraf start
/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
/etc/init.d/sshd start
tail -f /dev/null