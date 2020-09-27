#!/bin/sh
rc-service rsyslog restart
rc-service grafana start
tail -f /dev/null