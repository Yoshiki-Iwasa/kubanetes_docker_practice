# # # #!bin/zsh
# # # minikube stop
# # # minikube start
# # #wordpress のイメージ以外すべて作成する。
# eval $(minikube docker-env)
# docker build -t nginx-test ./srcs/nginx
# docker build -t ftps-test ./srcs/ftps
# docker build -t gra-test ./srcs/grafana
# docker build -t inf-test ./srcs/InfluxDB
# docker build -t mysql-test ./srcs/mysql
# docker build -t pma-test ./srcs/phpmyadmin
# # # wordpress の イメージ作成と pod の作成は、service を作ってから。
# # #MetalLB のConfigMap を apply
# kubectl apply -f ./srcs/k8s/MetalLB/metallb-config.yaml

# # #InfluxDB の volume と Deployment 作成

# kubectl apply -f ./srcs/k8s/InfluxDB/inf-deployment.yaml

# # # #grafana の Development 作成
# kubectl apply -f ./srcs/k8s/grafana/grafana-deployment.yaml

# # # #nginx の deployment 作成
# kubectl apply -f ./srcs/k8s/nginx/nginx-deployment.yaml

# # # # # vsftp の Deployment 作成
# kubectl apply -f ./srcs/k8s/ftps/ftps-development.yaml

# # # # mysql の volume と Deployment 作成

# kubectl apply -f ./srcs/k8s/mysql/mysql-deployment.yaml

# # # # #phpmyadmin の Deployment 作成
# kubectl apply -f ./srcs/k8s/phpmyadmin/pma-deployment.yaml



# # # # #wordpress の Service 作成
# kubectl apply -f ./srcs/k8s/wordpress/wp-service.yaml

# # # # wordpress の IP を取得して、user.sh の中身を書き換える。
# # # #wordpress の external-ip 取得



# while true
# do
#     kubectl get svc | grep wp-service > /dev/null
#         ret=$?
#         if [ ret = 0 ]
#                 break
# done

# WP_IP=$(kubectl get svc | grep wp-service | tr -s ' ' | cut -d" " -f 4)
# sed -i -e "s/http:\/\/wp-service:5050/http:\/\/${WP_IP}:5050/g" ./srcs/wordpress/srcs/user.sh
# rm -f ./srcs/wordpress/srcs/user.sh-e

# # # # wordpress の イメージ作成
# docker build -t wp-test ./srcs/wordpress

# # # # # #wordpress の Deployment 作成
# kubectl apply -f ./srcs/k8s/wordpress/wp-deployment.yaml

# # # # # #以後、 External_IP のルーティング設定をしていく。

# MINIKUBE_IP=$(minikube node list | awk '{print $2}')
# NGINX_IP=$(kubectl get svc | grep nginx-service | tr -s ' ' | cut -d" " -f 4)
# GRA_IP=$(kubectl get svc | grep gra-service | tr -s ' ' | cut -d" " -f 4)
# PMA_IP=$(kubectl get svc | grep pma-service | tr -s ' ' | cut -d" " -f 4)
# FTPS_IP=$(kubectl get svc | grep ftps-service | tr -s ' ' | cut -d" " -f 4)
# #static route を設定していく
# echo '180563180yI' | sudo -S route add ${NGINX_IP}/32 ${MINIKUBE_IP} 2>/dev/null
# echo '180563180yI' | sudo -S route add ${GRA_IP}/32 ${MINIKUBE_IP} 2>/dev/null
# echo '180563180yI' | sudo -S route add ${PMA_IP}/32 ${MINIKUBE_IP} 2>/dev/null
# echo '180563180yI' | sudo -S route add ${WP_IP}/32 ${MINIKUBE_IP} 2>/dev/null
# echo '180563180yI' | sudo -S route add ${FTPS_IP}/32 ${MINIKUBE_IP} 2>/dev/null

# touch ~/.lftprc
# echo "set ftp:ssl-auth TLS" >> ~/.lftprc
# echo "set ftp:ssl-force true" >> ~/.lftprc
# echo "set ftp:ssl-allow yes" >> ~/.lftprc
# echo "set ftp:ssl-protect-list yes" >> ~/.lftprc
# echo "set ftp:ssl-protect-data yes" >> ~/.lftprc
# echo "set ftp:ssl-protect-fxp yes" >> ~/.lftprc
# echo "set ssl:verify-certificate no" >> ~/.lftprc






 #!bin/zsh
 #minikube stop
sudo chmod -R 777 ~/.minikube
sudo chmod -R 777 ~/.kube
sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535
eval export DOCKER_TLS_VERIFY="";export DOCKER_HOST="";export DOCKER_CERT_PATH="";export MINIKUBE_ACTIVE_DOCKERD=""

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e 's/mode: ""/mode: "ipvs"' | \
kubectl apply -f - -n kube-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
# #wordpress のイメージ以外すべて作成する。


docker build -t nginx-test ./srcs/nginx
docker build -t ftps-test ./srcs/ftps
docker build -t gra-test ./srcs/grafana
docker build -t inf-test ./srcs/InfluxDB
docker build -t mysql-test ./srcs/mysql
docker build -t pma-test ./srcs/phpmyadmin
# wordpress の イメージ作成と pod の作成は、service を作ってから。
#MetalLB のConfigMap を apply
kubectl apply -f ./srcs/k8s/MetalLB/metallb-config.yaml
#InfluxDB の volume と Deployment 作成

kubectl apply -f ./srcs/k8s/InfluxDB/inf-deployment.yaml
#grafana の Development 作成
kubectl apply -f ./srcs/k8s/grafana/grafana-deployment.yaml
#nginx の deployment 作成
kubectl apply -f ./srcs/k8s/nginx/nginx-deployment.yaml
# vsftp の Deployment 作成
kubectl apply -f ./srcs/k8s/ftps/ftps-development.yaml
# mysql の volume と Deployment 作成

kubectl apply -f ./srcs/k8s/mysql/mysql-deployment.yaml
#phpmyadmin の Deployment 作成
kubectl apply -f ./srcs/k8s/phpmyadmin/pma-deployment.yaml
#wordpress の Service 作成
kubectl apply -f ./srcs/k8s/wordpress/wp-service.yaml

# wordpress の IP を取得して、user.sh の中身を書き換える。
#wordpress の external-ip 取得
WP_IP=$(kubectl get svc | grep wp-service | tr -s ' ' | cut -d" " -f 4)
sed -i -e "s/http:\/\/wp-service:5050/http:\/\/${WP_IP}:5050/g" ./srcs/wordpress/srcs/user.sh
rm -f ./srcs/wordpress/srcs/user.sh-e
# wordpress の イメージ作成
docker build -t wp-test ./srcs/wordpress
#wordpress の Deployment 作成
kubectl apply -f ./srcs/k8s/wordpress/wp-deployment.yaml
#以後、 External_IP のルーティング設定をしていく。
# # MINIKUBE_IP=$(minikube node list | awk '{print $2}')
# # NGINX_IP=$(kubectl get svc | grep nginx-service | tr -s ' ' | cut -d" " -f 4)
# # GRA_IP=$(kubectl get svc | grep gra-service | tr -s ' ' | cut -d" " -f 4)
# # PMA_IP=$(kubectl get svc | grep pma-service | tr -s ' ' | cut -d" " -f 4)
# # FTPS_IP=$(kubectl get svc | grep ftps-service | tr -s ' ' | cut -d" " -f 4)
# # #static route を設定していく
# # echo 'user42' | sudo -S route add -host ${NGINX_IP} gw ${MINIKUBE_IP} 2>/dev/null
# # echo 'user42' | sudo -S route add -host ${GRA_IP} gw ${MINIKUBE_IP} 2>/dev/null
# # echo 'user42' | sudo -S route add -host ${PMA_IP} gw ${MINIKUBE_IP} 2>/dev/null
# # echo 'user42' | sudo -S route add -host ${WP_IP} gw ${MINIKUBE_IP} 2>/dev/null
# # echo 'user42' | sudo -S route add -host ${FTPS_IP} gw ${MINIKUBE_IP} 2>/dev/null
touch ~/.lftprc
echo "set ftp:ssl-auth TLS" >> ~/.lftprc
echo "set ftp:ssl-force true" >> ~/.lftprc
echo "set ftp:ssl-allow yes" >> ~/.lftprc
echo "set ftp:ssl-protect-list yes" >> ~/.lftprc
echo "set ftp:ssl-protect-data yes" >> ~/.lftprc
echo "set ftp:ssl-protect-fxp yes" >> ~/.lftprc
echo "set ssl:verify-certificate no" >> ~/.lftprc
apt-get install lftp

# sudo minikube dashboard&
