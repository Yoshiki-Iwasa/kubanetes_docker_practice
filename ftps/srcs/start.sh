#!/bin/sh
rc-service vsftpd restart
rc-service telegraf restart
tail -f /dev/null