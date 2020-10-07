#!/bin/sh
rc-status
rc-service telegraf start
/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
rc-status
rc-service sshd start
tail -f /dev/null