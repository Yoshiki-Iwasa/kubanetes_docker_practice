FROM alpine:latest

#openrcはサービスの起動に必要

RUN apk update \
	&& apk add --no-cache vim procps nginx openrc openssl openssh supervisor\
	&& mkdir -p /run/nginx \
	&& sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
	&& sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
	&& sed -i'.bak' '/getty/d' /etc/inittab \
	&& sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
	&& sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
	&& sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel \
	&& sed -i'.bak' 's/return 404;/root html;\n\t\tindex index.html;/' /etc/nginx/conf.d/default.conf

RUN mkdir /etc/nginx/ssl \
	&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
	&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=localhost/DNS=localhost" \
	&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt \
	&& adduser -D ssh-user \
	&& echo "ssh-user:ssh-pass" | chpasswd \
	&& touch test.txt \
	&& rc-update add sshd \
	&& rc-status

COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
ENTRYPOINT [ "./start.sh" ]

#https://financial-it-engineer.hatenablog.com/entry/20140911/1410450256 を参考に、/var/lib/mysql をvolume に移すべし。