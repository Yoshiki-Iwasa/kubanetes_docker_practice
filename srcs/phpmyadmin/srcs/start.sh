#!bin/sh
# rc-service lighttpd restart
rc-service telegraf start
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
