#!bin/sh
rc-service lighttpd restart
rc-service telegraf start
./user.sh
tail -f /dev/null
