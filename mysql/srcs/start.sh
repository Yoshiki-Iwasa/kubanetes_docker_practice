#!/bin/sh
rc-service mariadb restart
rc-service telegraf start
tail -f /dev/null