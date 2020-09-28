#!/bin/sh
rc-service influxdb start
rc-service telegraf start
tail -f /dev/null