FROM alpine:latest

#OpenRC インストール
RUN apk update \
    && apk add openrc vim curl\
    && sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
	&& sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
	&& sed -i'.bak' '/getty/d' /etc/inittab \
	&& sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
	&& sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
	&& sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel

#Mysql インストール
RUN apk add mysql mysql-client \
    && rc-update add mariadb \
    && rc-status
    # && /etc/init.d/mariadb setup \
    # && rc-service mariadb start \
    # && mysql -e "CREATE DATABASE dbtest;" \
	# && mysql -e "CREATE USER 'dbuser'@'%' identified by 'dbpassword';" \
	# && mysql -e "GRANT ALL PRIVILEGES ON dbtest.* TO 'dbuser'@'%';" \
	# && mysql -e "FLUSH PRIVILEGES;" \
    # && mysql -e "create table dbtest.user (id int, name varchar(10));" \
	# && mysql -e "exit" \
	## && sed -i 's/skip-networking/skip-networking\=0/g' /etc/my.cnf.d/mariadb-server.cnf

# Telegraf インストール
RUN	echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add telegraf@testing \
	&& sed -i -e 's/hostname = ""/hostname = "mysql-service"/g' /etc/telegraf.conf \
	&& sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/inf-service:8086"\]/g' /etc/telegraf.conf
COPY ./srcs/start.sh .
COPY ./srcs/mysql_setup.sh .
RUN chmod 777 ./mysql_setup.sh
RUN chmod 777 ./start.sh
ENTRYPOINT [ "./start.sh" ]