#!/bin/sh
rc-service rsyslog restart
rc-service grafana start
rc-service telegraf start
tail -f /dev/null