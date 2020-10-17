#!bin/sh
# rc-service lighttpd restart
rc-service telegraf start
./user.sh
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
