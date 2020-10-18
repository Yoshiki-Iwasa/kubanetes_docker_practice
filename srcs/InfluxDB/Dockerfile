# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yiwasa <yiwasa@student.42tokyo.jp>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/25 22:26:11 by yiwasa            #+#    #+#              #
#    Updated: 2020/10/19 02:50:16 by yiwasa           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

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

#Tregraf インストール
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add telegraf@testing
RUN sed -i -e 's/hostname = ""/hostname = "influxDB"/g' /etc/telegraf.conf
RUN sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/127.0.0.1:8086"\]/g' /etc/telegraf.conf
#InflexDB インストール
RUN apk add influxdb \
	&& rc-update add influxdb \
	&& rc-status

COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
ENTRYPOINT [ "./start.sh" ]