#!/bin/sh
rc-status
rc-service telegraf start
rc-status
rc-service sshd start
/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf