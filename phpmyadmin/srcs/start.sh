#!bin/sh
# rc-service lighttpd restart
rc-service telegraf start
/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf
tail -f /dev/null
