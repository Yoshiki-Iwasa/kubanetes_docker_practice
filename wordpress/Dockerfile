FROM alpine:latest

#opnerc の設定
RUN apk update \
    && apk add vim wget openrc procps \
	&& sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
	&& sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
	&& sed -i'.bak' '/getty/d' /etc/inittab \
	&& sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
	&& sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
	&& sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel

# #lightttpd の設定
RUN apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
COPY ./srcs/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY ./srcs/mod_fastcgi.conf /etc/lighttpd/mod_fastcgi.conf
RUN rc-update add lighttpd default \
	&& rc-status \
	&& rc-service lighttpd start \
	&& apk add wget mysql-client \
	&& mkdir -p /usr/share/webapps/ \
	&& cd /usr/share/webapps/ \
	&& wget http://wordpress.org/latest.tar.gz \
	&&  tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz \
	&& chown -R lighttpd /usr/share/webapps/ \
	&& ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress \
	&& rc-status

# Telegraf
RUN	echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add telegraf@testing \
	&& sed -i -e 's/hostname = ""/hostname = "wp_test"/g' /etc/telegraf.conf \
	&& sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/inf_test:8086"\]/g' /etc/telegraf.conf
EXPOSE 5050
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
ENTRYPOINT [ "./start.sh" ]
