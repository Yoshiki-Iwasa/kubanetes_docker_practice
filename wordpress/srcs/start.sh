#!bin/sh
rc-service php-fpm7 restart
/etc/init.d/lighttpd restart
tail -f /dev/null
