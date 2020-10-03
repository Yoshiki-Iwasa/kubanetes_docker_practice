FROM alpine:latest

#OpneRC インストール
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
#Grafanaをインストール
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add grafana@testing \
	&& rc-update add grafana \
	&& rc-status \
	&& apk add rsyslog \
	&& rc-update add rsyslog\
	&& rc-status \
	&& rc-service rsyslog start \
	&& rc-status

#Tregraf インストール
RUN	echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add telegraf@testing \
	&& sed -i -e 's/hostname = ""/hostname = "gra-service"/g' /etc/telegraf.conf \
	&& sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/inf-service:8086"\]/g' /etc/telegraf.conf
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
EXPOSE 3000
COPY ./srcs/grafana /etc/conf.d/grafana
ENTRYPOINT [ "./start.sh" ]