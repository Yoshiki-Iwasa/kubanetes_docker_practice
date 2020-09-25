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
RUN mkdir /etc/vsftpd/ssl \
	&& openssl genrsa -out /etc/vsftpd/ssl/server.key 2048 \
	&& openssl req -new -key /etc/vsftpd/ssl/server.key -out /etc/vsftpd/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=localhost" \
	&& openssl x509 -days 3650 -req -signkey /etc/vsftpd/ssl/server.key -in /etc/vsftpd/ssl/server.csr -out /etc/vsftpd/ssl/server.crt

RUN apk add vsftpd lftp \
	&& adduser -D ftp_user \
	&& echo "ftp_user:ftp_pass" | chpasswd \
	&& rc-update add vsftpd \
	&& rc-status
COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
# ENTRYPOINT [ "./start.sh" ]