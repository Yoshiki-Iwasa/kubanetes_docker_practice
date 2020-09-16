# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yiwasa <yiwasa@student.42tokyo.jp>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/30 08:01:29 by yiwasa            #+#    #+#              #
#    Updated: 2020/08/04 08:46:10 by yiwasa           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

#nginxからやってみよう！！
#mysql のインストール
RUN apt-get update \
	&& apt-get install -y apt-utils nginx vim wget curl procps sudo supervisor \
	&& apt-get install -y php7.3-fpm php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-mbstring php-zip php-gd php-mysql\
	&& apt-get install -y mariadb-server  mariadb-client \
	&& /usr/sbin/service mysql start\
	# && mysql -u root\
	# mysql を起動しなくてもこのコマンドでmysqlに書き込みできる
	&& mysql -e "CREATE DATABASE wpdb;" \
	&& mysql -e "CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';" \
	&& mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';" \
	&& mysql -e "FLUSH PRIVILEGES;" \
	&& mysql -e "exit" \
	#ユーザーとデータベースの作成はできた。
	&& apt-get install php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath unzip wget git -y \
	&& cd /var/www/html \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar -xvzf latest.tar.gz \
	&& cd wordpress \
	&& cp wp-config-sample.php wp-config.php \
	&& chown -R www-data:www-data /var/www/html/wordpress
COPY ./srcs/wp-config.php /var/www/html/wordpress/wp-config.php

#ssl 通信の設定
RUN mkdir /etc/nginx/ssl \
	&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
	&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=localhost/DNS=localhost" \
	&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt

RUN cd /var/www/html \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar -xvzf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin
COPY ./srcs/default.conf /etc/nginx/sites-available/default

RUN wget https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz \
  && tar -xvzf entrykit_0.4.0_Linux_x86_64.tgz \
  && rm entrykit_0.4.0_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

COPY ./srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN  chmod 777 /etc/supervisor/conf.d/supervisord.conf
COPY ./srcs/default.tmpl /etc/nginx/sites-available/default.tmpl
ENTRYPOINT ["render", "/etc/nginx/sites-available/default", "--", "/usr/bin/supervisord"]