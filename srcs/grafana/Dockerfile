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
	&& mkdir -p /var/lib/grafana/provisioning/dashboards \
	&& mkdir -p /var/lib/grafana/provisioning/datasources \
	&& rc-update add grafana \
	&& rc-status \
	&& apk add rsyslog \
	&& rc-update add rsyslog\
	&& rc-status \
	&& rc-service rsyslog start \
	&& rc-status

#Tregraf インストール
RUN	echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add telegraf@testing
RUN sed -i -e 's/hostname = ""/hostname = "influxDB"/g' /etc/telegraf.conf
RUN sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/127.0.0.1:8086"\]/g' /etc/telegraf.conf
COPY ./srcs/start.sh .
RUN chmod 777 ./start.sh
EXPOSE 3000
COPY ./srcs/provisioning/dashboard.yaml /var/lib/grafana/provisioning/dashboards
COPY ./srcs/provisioning/datasource.yaml /var/lib/grafana/provisioning/datasources/datasource.yaml
COPY ./srcs/dashboard_json/grafana-1602932849342.json /var/lib/grafana/provisioning/dashboards
COPY ./srcs/dashboard_json/ftps-1602934415893.json /var/lib/grafana/provisioning/dashboards
# COPY ./srcs/dashboard_json/nfluxdb-1602934591659.json /var/lib/grafana/provisioning/dashboards
COPY ./srcs/dashboard_json/mysql-1602934454123.json /var/lib/grafana/provisioning/dashboards
COPY ./srcs/dashboard_json/phpmyadmin-1602934759970.json /var/lib/grafana/provisioning/dashboards
COPY ./srcs/dashboard_json/wordpress-1602934546084.json /var/lib/grafana/provisioning/dashboards
COPY ./srcs/dashboard_json/nginx-1602934484577.json /var/lib/grafana/provisioning/dashboards

COPY ./srcs/grafana /etc/conf.d/grafana
ENTRYPOINT [ "./start.sh" ]
