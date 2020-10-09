#!/bin/sh
rc-service rsyslog restart
rc-service telegraf start
/usr/sbin/grafana-server -config /etc/grafana.ini -homepath /usr/share/grafana cfg:paths.data=/var/lib/grafana/data cfg:paths.plugins=/var/lib/grafana/plugins cfg:paths.provisioning=/var/lib/grafana/provisioning cfg:log.mode=syslog
# supervise-daemon grafana --start --user grafana grafana /usr/sbin/grafana-server -- -config /etc/grafana.ini -homepath /usr/share/grafana cfg:paths.data=/var/lib/grafana/data cfg:paths.plugins=/var/lib/grafana/plugins cfg:paths.provisioning=/var/lib/grafana/provisioning cfg:log.mode=syslog