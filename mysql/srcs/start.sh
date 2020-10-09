#!/bin/sh
./mysql_setup.sh
rc-service telegraf start
# tail -f /dev/null
/usr/bin/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=mysql --pid-file=/run/mysqld/mariadb.pid