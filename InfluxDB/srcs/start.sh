#!/bin/sh
rc-service telegraf start
/usr/sbin/influxd -config /etc/influxdb.conf