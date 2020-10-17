#!/bin/sh
rc-service telegraf restart
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
