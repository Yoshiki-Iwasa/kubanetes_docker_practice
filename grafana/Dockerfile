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
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add grafana@testing \
	&& rc-update add grafana \
	&& rc-status \
	&& apk add rsyslog \
	&& rc-update add rsyslog\
	&& rc-status \
	&& rc-service rsyslog start \
	&& rc-status
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
COPY ./srcs/grafana.ini /etc/grafana.ini
ENTRYPOINT [ "./start.sh" ]