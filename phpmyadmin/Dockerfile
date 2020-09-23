FROM alpine:latest

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

RUN apk add lighttpd php7-mbstring php7-session php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
COPY ./srcs/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY ./srcs/mod_fastcgi.conf /etc/lighttpd/mod_fastcgi.conf

RUN rc-update add lighttpd default \
	&& rc-status \
	&& rc-service lighttpd start \
	&& apk add mysql-client php-mysqli \
	&& mkdir -p /usr/share/webapps/ \
	&& cd /usr/share/webapps \
	&& wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
	&& chmod -R 777 /usr/share/webapps/ \
	&& ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin \
	&& rc-update add lighttpd default \
	&& rc-status
EXPOSE 5000
COPY ./srcs/info.php /var/www/localhost/htdocs/phpmyadmin/
COPY ./srcs/config.inc.php /usr/share/webapps/phpmyadmin/config.inc.php
RUN chmod 444 /usr/share/webapps/phpmyadmin/config.inc.php
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
ENTRYPOINT [ "./start.sh" ]