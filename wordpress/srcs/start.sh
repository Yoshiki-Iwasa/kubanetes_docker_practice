#!bin/sh
rc-service lighttpd restart
rc-service telegraf start
./user.sh
rc-service lighttpd stop
/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf
