FROM alpine:latest

RUN apk update \
	&& apk add vim wget openrc procps\
	&& sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
	&& sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
	&& sed -i'.bak' '/getty/d' /etc/inittab \
	&& sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
	&& sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
	&& sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel

#InflexDB インストール
RUN wget https://dl.influxdata.com/influxdb/releases/influxdb_2.0.0-beta.16_linux_amd64.tar.gz \
	&& tar xvfz influxdb_2.0.0-beta.16_linux_amd64.tar.gz

#Tregraf インストール
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.3_linux_amd64.tar.gz \
	&&tar xf telegraf-1.15.3_linux_amd64.tar.gz
