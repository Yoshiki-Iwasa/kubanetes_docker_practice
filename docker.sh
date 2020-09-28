docker build -t nginx_test ./nginx
docker build -t wp_test ./wordpress
docker build -t pma_test ./phpmyadmin
docker build -t mysql_test ./mysql
docker build -t inf_test ./InfluxDB
docker build -t gra_test ./grafana
docker build -t ftps_test ./ftps

cd ./srcs
docker-compose up -d
