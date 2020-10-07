#!bin/zsh
kubectl delete -f ./k8s/mysql
kubectl delete -f ./k8s/nginx
kubectl delete -f ./k8s/wordpress
kubectl delete -f ./k8s/phpmyadmin
kubectl delete -f ./k8s/wordpress
kubectl delete -f ./k8s/grafana
kubectl delete -f ./k8s/InfluxDB
kubectl delete -f ./k8s/ftps
kubectl delete -f ./k8s/MetalLB
docker image rm -f nginx-test mysql-test wp-test pma-test gra-test inf-test ftps-test
export DOCKER_TLS_VERIFY=""
export DOCKER_HOST=""
export DOCKER_CERT_PATH=""
export MINIKUBE_ACTIVE_DOCKERD=""
minikube stop