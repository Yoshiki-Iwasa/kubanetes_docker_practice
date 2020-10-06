#!/bin/sh
./mysql_setup.sh
rc-service mariadb restart
rc-service telegraf start
tail -f /dev/null