#!bin/sh
rc-service lighttpd restart
rc-service telegraf start
tail -f /dev/null
