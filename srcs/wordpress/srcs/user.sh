#!bin/sh
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp cli update
wp core install --url=http://192.168.1.204:5050/wordpress/ --title=test --admin_user=admin --admin_password=admin --admin_email=admin@example.com  --allow-root --path=/usr/share/webapps/wordpress/
wp user create ywake ywake@test.com  --display_name="ywake" --role=editor --user_pass="ywake" --allow-root --path=/usr/share/webapps/wordpress/
wp user create yoshiki yoshiki@test.com  --display_name="yoshiki" --role=editor --user_pass="yoshiki" --allow-root --path=/usr/share/webapps/wordpress/
