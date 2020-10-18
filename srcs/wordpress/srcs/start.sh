#!bin/sh
# rc-service lighttpd restart
rc-service telegraf start
sh user.sh
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
