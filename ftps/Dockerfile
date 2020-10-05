FROM alpine:latest
#OpenRC のインストール
RUN apk update \
    && apk add vim wget openrc procps openssl\
	&& sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
	&& sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
	&& sed -i'.bak' '/getty/d' /etc/inittab \
	&& sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
	&& sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
	&& sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel


#ftpサーバーのインストール
RUN apk add vsftpd lftp \
	&& adduser -D ftp_user \
	&& echo "ftp_user:ftp_pass" | chpasswd \
	&& rc-update add vsftpd \
	&& rc-status

#ssl通信用の設定
RUN mkdir /etc/vsftpd/ssl \
	&& openssl genrsa -out /etc/vsftpd/ssl/server.key 2048 \
	&& openssl req -new -key /etc/vsftpd/ssl/server.key -out /etc/vsftpd/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=localhost" \
	&& openssl x509 -days 3650 -req -signkey /etc/vsftpd/ssl/server.key -in /etc/vsftpd/ssl/server.csr -out /etc/vsftpd/ssl/server.crt
#Telegrafのインストール
RUN	echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add telegraf@testing \
	&& sed -i -e 's/hostname = ""/hostname = "ftps_test"/g' /etc/telegraf.conf \
	&& sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/inf_test:8086"\]/g' /etc/telegraf.conf
COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/.lftprc .
RUN mv .lftprc ~
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
ENTRYPOINT [ "./start.sh" ]