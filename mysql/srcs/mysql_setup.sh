#!bin/sh
/etc/init.d/mariadb setup
rc-service mariadb start
mysql -e "CREATE DATABASE dbtest;"
mysql -e "CREATE USER 'dbuser'@'%' identified by 'dbpassword';"
mysql -e "GRANT ALL PRIVILEGES ON dbtest.* TO 'dbuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "create table dbtest.user (id int, name varchar(10));"
mysql -e "exit"
sed -i 's/skip-networking/skip-networking\=0/g' /etc/my.cnf.d/mariadb-server.cnf
