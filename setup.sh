#!bin/zsh
minikube stop
minikube start
#wordpress のイメージ以外すべて作成する。
eval $(minikube docker-env)
docker build -t nginx-test ./nginx
docker build -t ftps-test ./ftps
docker build -t gra-test ./grafana
docker build -t inf-test ./InfluxDB
docker build -t mysql-test ./mysql
docker build -t pma-test ./phpmyadmin
# wordpress の イメージ作成と pod の作成は、service を作ってから。
#MetalLB のConfigMap を apply
kubectl apply -f ./k8s/MetalLB/metallb-config.yaml

#InfluxDB の volume と Deployment 作成
kubectl apply -f ./k8s/InfluxDB/inf-pv.yaml
kubectl apply -f ./k8s/InfluxDB/inf-pvc.yaml
kubectl apply -f ./k8s/InfluxDB/inf-deployment.yaml

#grafana の Development 作成
kubectl apply -f ./k8s/grafana/grafana-deployment.yaml

#nginx の deployment 作成
kubectl apply -f ./k8s/nginx/nginx-deployment.yaml

# vsftp の Deployment 作成
kubectl apply -f ./k8s/ftps/ftps-development.yaml

# mysql の volume と Deployment 作成
kubectl apply -f ./k8s/mysql/mysql-pv.yaml
kubectl apply -f ./k8s/mysql/mysql-pvc.yaml
kubectl apply -f ./k8s/mysql/mysql-deployment.yaml

#phpmyadmin の Deployment 作成
kubectl apply -f ./k8s/phpmyadmin/pma-deployment.yaml


#wordpress の Service 作成
kubectl apply -f ./k8s/wordpress/wp-service.yaml

# wordpress の IP を取得して、user.sh の中身を書き換える。
#wordpress の external-ip 取得
WP_IP=$(kubectl get svc | grep wp-service | tr -s ' ' | cut -d" " -f 4)
sed -i -e "s/http:\/\/wp-service:5050/http:\/\/${WP_IP}:5050/g" ./wordpress/srcs/user.sh
rm -f ./wordpress/srcs/user.sh-e

# wordpress の イメージ作成
docker build -t wp-test ./wordpress

#wordpress の Deployment 作成
kubectl apply -f ./k8s/wordpress/wp-deployment.yaml

#以後、 External_IP のルーティング設定をしていく。

MINIKUBE_IP=$(minikube node list | awk '{print $2}')
NGINX_IP=$(kubectl get svc | grep nginx-service | tr -s ' ' | cut -d" " -f 4)
GRA_IP=$(kubectl get svc | grep gra-service | tr -s ' ' | cut -d" " -f 4)
PMA_IP=$(kubectl get svc | grep pma-service | tr -s ' ' | cut -d" " -f 4)

#static route を設定していく
echo '180563180yI' | sudo -S route add ${NGINX_IP}/32 ${MINIKUBE_IP} 2>/dev/null
echo '180563180yI' | sudo -S route add ${GRA_IP}/32 ${MINIKUBE_IP} 2>/dev/null
echo '180563180yI' | sudo -S route add ${PMA_IP}/32 ${MINIKUBE_IP} 2>/dev/null
echo '180563180yI' | sudo -S route add ${WP_IP}/32 ${MINIKUBE_IP} 2>/dev/null
